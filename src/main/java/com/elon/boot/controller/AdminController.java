package com.elon.boot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {
	
	private final NoticeService noticeService;

    // 대시보드
    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
    }

    // 회원관리
    @GetMapping("/user-management")
    public String userManagement() {
        return "admin/user-management";
    }

    // 매물관리
    @GetMapping("/property-management")
    public String propertyManagement() {
        return "admin/property-management";
    }

    // 공지사항관리
    @GetMapping("/content-management")
    public String contentManagement(Model model) {
    	List<Notice> noticeList = noticeService.getAllNotices(); // DB에서 공지 가져오기
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
