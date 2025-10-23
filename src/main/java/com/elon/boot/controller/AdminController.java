package com.elon.boot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elon.boot.controller.dto.admin.UserManagement;
import com.elon.boot.domain.admin.model.service.AdminService;
import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.user.model.service.UserService;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class AdminController {
	
	private final AdminService adminService;

    // 대시보드
    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
    }

    // 회원관리
    @GetMapping("/user-management")
    public String userManagement(Model model) {
    	UserManagement data = adminService.getUserManagementData();
    	
    	model.addAttribute("userList", data.getUserList());
        model.addAttribute("realtorList", data.getRealtorList());
        
        return "admin/user-management";
    }
    
    // 회원 탈퇴 처리
    @PostMapping("/user-delete/{userId}")
    public String userDelete(@PathVariable String userId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            int result = adminService.deleteUser(userId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "회원이 탈퇴 처리되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "회원 탈퇴 처리에 실패했습니다.");
            }
        } catch (Exception e) {
            log.error("회원 탈퇴 처리 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/user-management";
    }
    
    // 중개사 탈퇴 처리
    @PostMapping("/realtor-delete/{realtorId}")
    public String realtorDelete(@PathVariable String realtorId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            int result = adminService.deleteRealtor(realtorId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "중개사 탈퇴 처리되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "중개사 탈퇴 처리에 실패했습니다.");
            }
        } catch (Exception e) {
            log.error("회원 탈퇴 처리 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/user-management";
    }

    // 매물관리
    @GetMapping("/property-management")
    public String propertyManagement() {
        return "admin/property-management";
    }

    // 공지사항관리
    @GetMapping("/content-management")
    public String contentManagement(Model model) {
    	List<Notice> noticeList = adminService.getAllNotices(); // DB에서 공지 가져오기
        model.addAttribute("noticeList", noticeList);
        return "admin/content-management";
    }

    // 문의관리
    @GetMapping("/inquiry-management")
    public String inquiryManagement() {
        return "admin/inquiry-management";
    }

    // 중개사 승인
    @GetMapping("/realtor-approval")
    public String realtorApproval() {
        return "admin/realtor-approval";
    }

    // 통계
    @GetMapping("/statistics")
    public String statistics() {
        return "admin/statistics";
    }
}
