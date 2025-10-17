package com.elon.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

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
    public String contentManagement() {
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
