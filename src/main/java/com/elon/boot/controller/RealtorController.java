package com.elon.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/realtor")
public class RealtorController {

    // 중개사 대시보드
    @GetMapping("/realtor-dashboard")
    public String realtorDashboard(HttpSession session, Model model) {
        // TODO: 중개사 세션 체크
        // Object realtor = session.getAttribute("realtor");
        // if (realtor == null) {
        //     return "redirect:/auth/login";
        // }

        // TODO: 대시보드 데이터 가져오기
        // model.addAttribute("totalProperties", propertyService.getRealtorPropertyCount(realtorId));
        // model.addAttribute("activeProperties", propertyService.getActivePropertyCount(realtorId));
        // model.addAttribute("totalInquiries", inquiryService.getInquiryCount(realtorId));
        // model.addAttribute("recentInquiries", inquiryService.getRecentInquiries(realtorId));

        return "realtor/realtor-dashboard";
    }

    // 매물 관리
    @GetMapping("/property-management")
    public String propertyManagement(HttpSession session, Model model) {
        // TODO: 중개사 세션 체크
        // Object realtor = session.getAttribute("realtor");
        // if (realtor == null) {
        //     return "redirect:/auth/login";
        // }

        // TODO: 중개사의 매물 목록 가져오기
        // List<Property> properties = propertyService.getPropertiesByRealtorId(realtorId);
        // model.addAttribute("properties", properties);

        return "realtor/property-management";
    }

    // 매물 등록
    @GetMapping("/property-register")
    public String propertyRegister(HttpSession session, Model model) {
        // TODO: 중개사 세션 체크
        // Object realtor = session.getAttribute("realtor");
        // if (realtor == null) {
        //     return "redirect:/auth/login";
        // }

        return "realtor/property-register";
    }

    // 받은 문의 관리
    @GetMapping("/inquiry-management")
    public String inquiryManagement(HttpSession session, Model model) {
        // TODO: 중개사 세션 체크
        // Object realtor = session.getAttribute("realtor");
        // if (realtor == null) {
        //     return "redirect:/auth/login";
        // }

        // TODO: 중개사에게 온 문의 목록 가져오기
        // List<Inquiry> inquiries = inquiryService.getInquiriesByRealtorId(realtorId);
        // model.addAttribute("inquiries", inquiries);

        return "realtor/inquiry-management";
    }
}
