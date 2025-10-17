package com.elon.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.elon.boot.controller.dto.notice.NoticeInsertRequest;
import com.elon.boot.controller.dto.notice.NoticeUpdateRequest;
import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/community/notice")
@RequiredArgsConstructor
public class NoticeController {
   
   private final NoticeService nService;
    
   /**
     * 공지사항 목록 조회
     * URL: /community/notice
     */
    @GetMapping
    public String showNoticeList(
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {
        try {
            int boardCountPerPage = 10;  // 한 페이지당 게시물 수
            int naviCountPerPage = 5;    // 한 페이징당 페이지 수
            
            List<Notice> noticeList;
            int totalCount;
            
            // 검색어가 있는 경우
            if (keyword != null && !keyword.trim().isEmpty()) {
                Map<String, Object> searchMap = new HashMap<>();
                searchMap.put("searchCondition", "title");  // 제목으로 검색
                searchMap.put("searchKeyword", keyword);
                searchMap.put("currentPage", currentPage);
                searchMap.put("boardLimit", boardCountPerPage);
                
                noticeList = nService.selectSearchList(searchMap);
                totalCount = nService.getTotalCount(searchMap);
                model.addAttribute("keyword", keyword);
            } else {
                // 전체 목록 조회
                noticeList = nService.selectList(currentPage, boardCountPerPage);
                totalCount = nService.getTotalCount();
            }
            
            // 페이징 계산
            int totalPages = (int) Math.ceil((double) totalCount / boardCountPerPage);
            int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
            int endNavi = Math.min(startNavi + naviCountPerPage - 1, totalPages);
            
            model.addAttribute("noticeList", noticeList);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            
            return "community/notice";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
    
    /**
     * 공지사항 상세 조회
     * URL: /community/notice/{noticeNo}
     */
    @GetMapping("/{noticeNo}")
    public String showNoticeDetail(
            @PathVariable("noticeNo") int noticeNo,
            Model model) {
        try {
            Notice notice = nService.selectOneByNo(noticeNo);
            if (notice == null) {
                model.addAttribute("errorMsg", "존재하지 않는 공지사항입니다.");
                return "common/error";
            }
            model.addAttribute("notice", notice);
            return "community/notice-detail";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
    
    /**
     * 공지사항 작성 폼
     * URL: /community/notice/insert (GET)
     */
    @GetMapping("/insert")
    public String showInsertForm(HttpSession session, Model model) {
        try {
            // 관리자 체크
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
                model.addAttribute("errorMsg", "관리자만 공지사항을 작성할 수 있습니다.");
                return "common/error";
            }
            return "community/notice-insert";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
    
    /**
     * 공지사항 작성 처리
     * URL: /community/notice/insert (POST)
     */
    @PostMapping("/insert")
    public String insertNotice(
            @ModelAttribute NoticeInsertRequest notice,
            HttpSession session,
            Model model) {
        try {
            // 관리자 체크
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
                model.addAttribute("errorMsg", "관리자만 공지사항을 작성할 수 있습니다.");
                return "common/error";
            }
            
            // 사용자 정보 설정
            notice.setUserId(loginUser.getUserId());
            notice.setNoticeWriter(loginUser.getUserName());
            
            // 공지사항 등록
            int result = nService.insertNotice(notice);
            
            if (result > 0) {
                return "redirect:/community/notice";
            } else {
                model.addAttribute("errorMsg", "공지사항 등록에 실패했습니다.");
                return "common/error";
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
    
    /**
     * 공지사항 수정 폼
     * URL: /community/notice/modify?noticeNo=1
     */
    @GetMapping("/modify")
    public String showModifyForm(
            @RequestParam("noticeNo") int noticeNo,
            HttpSession session,
            Model model) {
        try {
            // 관리자 체크
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
                model.addAttribute("errorMsg", "관리자만 공지사항을 수정할 수 있습니다.");
                return "common/error";
            }
            
            Notice notice = nService.selectOneByNo(noticeNo);
            if (notice == null) {
                model.addAttribute("errorMsg", "존재하지 않는 공지사항입니다.");
                return "common/error";
            }
            
            model.addAttribute("notice", notice);
            return "community/notice-modify";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
    
    /**
     * 공지사항 수정 처리
     * URL: /community/notice/modify (POST)
     */
    @PostMapping("/modify")
    public String updateNotice(
            @ModelAttribute NoticeUpdateRequest notice,
            HttpSession session,
            Model model) {
        try {
            // 관리자 체크
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
                model.addAttribute("errorMsg", "관리자만 공지사항을 수정할 수 있습니다.");
                return "common/error";
            }
            
            // 공지사항 수정
            int result = nService.updateNotice(notice);
            
            if (result > 0) {
                return "redirect:/community/notice/" + notice.getNoticeNo();
            } else {
                model.addAttribute("errorMsg", "공지사항 수정에 실패했습니다.");
                return "common/error";
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
    
    /**
     * 공지사항 삭제
     * URL: /community/notice/delete?noticeNo=1
     */
    @GetMapping("/delete")
    public String deleteNotice(
            @RequestParam("noticeNo") int noticeNo,
            HttpSession session,
            Model model) {
        try {
            // 관리자 체크
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
                model.addAttribute("errorMsg", "관리자만 공지사항을 삭제할 수 있습니다.");
                return "common/error";
            }
            
            // 공지사항 삭제
            int result = nService.deleteNotice(noticeNo);
            
            if (result > 0) {
                return "redirect:/community/notice";
            } else {
                model.addAttribute("errorMsg", "공지사항 삭제에 실패했습니다.");
                return "common/error";
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
}
