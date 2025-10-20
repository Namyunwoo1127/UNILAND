package com.elon.boot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.elon.boot.domain.community.guide.model.service.GuideService;
import com.elon.boot.domain.community.guide.model.vo.Guide;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class CommunityController {

   private final GuideService gService;

    // 가이드 목록
    @GetMapping("/guide")
    public String guideList(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false, defaultValue = "all") String category,
            @RequestParam(required = false, defaultValue = "1") int page,
            Model model) {
       try {
          // 카테고리 처리 ('all'이면 null로)
          String searchCategory = (category != null && !"all".equals(category)) ? category : null;
          
           int boardLimit = 3;
           int pageLimit = 5;
           int totalCount = gService.getGuideCount(keyword, searchCategory);
           int maxPage = (int) Math.ceil((double) totalCount / boardLimit);
           int startPage = ((page-1)/pageLimit) * pageLimit + 1; // 시작페이지(1, 6, 11, 16 ...)
           int endPage = startPage + pageLimit - 1;
           if(endPage > maxPage) {
        	   endPage = maxPage;
           }
           
           int offset = (page - 1) * boardLimit;
           
           List<Guide> guideList = gService.getGuideList(keyword, searchCategory, offset, boardLimit);
           
           List<Guide> popularGuides = gService.getPopularGuides();
          
          // List
          model.addAttribute("guideList", guideList);
          model.addAttribute("popularGuides", popularGuides);
          model.addAttribute("keyword", keyword);
          model.addAttribute("category", category);
          
          // 페이징
          model.addAttribute("currentPage", page);
          model.addAttribute("maxPage", maxPage);
          model.addAttribute("startPage", startPage);
          model.addAttribute("endPage", endPage);
          model.addAttribute("totalCount", totalCount);
          
      } catch (Exception e) {
         e.printStackTrace();
           model.addAttribute("errorMessage", "게시글 목록을 불러오는데 실패했습니다.");
      }
       
        // TODO: 실제 데이터베이스에서 가이드 목록 가져오기
        // List<Guide> guideList = guideService.getGuideList(keyword, category, page);
        // int totalCount = guideService.getGuideCount(keyword, category);
        // int totalPages = (int) Math.ceil((double) totalCount / 10);

        // model.addAttribute("guideList", guideList);
        // model.addAttribute("totalCount", totalCount);
        // model.addAttribute("currentPage", page);
        // model.addAttribute("totalPages", totalPages);
        // model.addAttribute("keyword", keyword);
        // model.addAttribute("category", category);

        return "community/guide";
    }

    // 가이드 상세
    @GetMapping("/guide/{id}")
    public String guideDetail(@PathVariable("id") int guideNo, 
            HttpSession session,
            Model model) {
		try {
			// 세션에서 현재 사용자 ID 가져오기
			String currentUserId = null;
			Object userObj = session.getAttribute("loginUser");
		if (userObj != null) {
			// User 클래스에 userId getter를 저장
			currentUserId = ((com.elon.boot.domain.user.model.vo.User) userObj).getUserId();
		}
		
		// 가이드 상세 정보 조회 (조회수 증가 포함)
		Guide guide = gService.getGuideDetail(guideNo, currentUserId);
		
		if (guide == null) {
			model.addAttribute("errorMessage", "존재하지 않는 게시글입니다.");
			return "redirect:/community/guide";
		}
		
		// 이전/다음 글 조회
		Guide prevGuide = gService.getPrevGuide(guideNo);
		Guide nextGuide = gService.getNextGuide(guideNo);
		
		// 댓글 목록 조회 (나중에 추가)
		// List<Comment> comments = commentService.getCommentsByGuideNo(guideNo);
		
		model.addAttribute("guide", guide);
		model.addAttribute("prevGuide", prevGuide);
		model.addAttribute("nextGuide", nextGuide);
		// model.addAttribute("comments", comments);
		
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "게시글을 불러오는데 실패했습니다.");
			return "redirect:/community/guide";
		}
    	
        // TODO: 실제 데이터베이스에서 가이드 상세 정보 가져오기
        // Guide guide = guideService.getGuideById(id);
        // guideService.increaseViewCount(id);
        // List<Comment> comments = commentService.getCommentsByGuideId(id);
        // Guide prevGuide = guideService.getPrevGuide(id);
        // Guide nextGuide = guideService.getNextGuide(id);

        // model.addAttribute("guide", guide);
        // model.addAttribute("comments", comments);
        // model.addAttribute("prevGuide", prevGuide);
        // model.addAttribute("nextGuide", nextGuide);

        return "community/guide-detail";
    }

    // 가이드 좋아요
    @PostMapping("/guide/{id}/like")
    @ResponseBody
    public String likeGuide(@PathVariable Long id, HttpSession session) {
        // TODO: 좋아요 처리
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "{\"success\": false, \"message\": \"로그인이 필요합니다.\"}";
        // }

        // boolean isLiked = likeService.toggleLike(userId, id);
        // int likeCount = likeService.getLikeCount(id);

        // return String.format("{\"success\": true, \"isLiked\": %b, \"likeCount\": %d}", isLiked, likeCount);

        return "{\"success\": true, \"isLiked\": true, \"likeCount\": 90}";
    }

    // 댓글 작성
    @PostMapping("/guide/{id}/comment")
    public String addComment(
            @PathVariable Long id,
            @RequestParam String content,
            HttpSession session) {

        // TODO: 댓글 작성
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "redirect:/login";
        // }

        // commentService.addComment(id, userId, content);

        return "redirect:/community/guide/" + id;
    }

    // 댓글 삭제
    @DeleteMapping("/guide/{guideId}/comment/{commentId}")
    @ResponseBody
    public String deleteComment(
            @PathVariable Long guideId,
            @PathVariable Long commentId,
            HttpSession session) {

        // TODO: 댓글 삭제
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "{\"success\": false, \"message\": \"로그인이 필요합니다.\"}";
        // }

        // boolean result = commentService.deleteComment(commentId, userId);

        // return String.format("{\"success\": %b}", result);

        return "{\"success\": true}";
    }
}