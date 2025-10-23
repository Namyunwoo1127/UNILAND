package com.elon.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.elon.boot.domain.inquiry.model.service.InquiryService;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;

import lombok.RequiredArgsConstructor;

/**
 * 문의 컨트롤러
 */
@Controller
@RequestMapping("/inquiry")
@RequiredArgsConstructor
public class InquiryController {

    private final InquiryService inquiryService;

    // TODO: 중개사 문의 페이지
    // @GetMapping("/realtor")
    // public String realtorInquiryPage(@RequestParam("propertyId") int propertyId, Model model) {
    //     return "inquiry/contact-realtor";
    // }

    // TODO: 중개사 문의 제출
    // @PostMapping("/realtor")
    // public String submitRealtorInquiry(Inquiry inquiry) {
    //     return "redirect:/mypage?tab=inquiries";
    // }

    // TODO: 관리자 문의 페이지
    // @GetMapping("/admin")
    // public String adminInquiryPage(Model model) {
    //     return "inquiry/contact-admin";
    // }

    // TODO: 관리자 문의 제출
    // @PostMapping("/admin")
    // public String submitAdminInquiry(Inquiry inquiry) {
    //     return "redirect:/mypage?tab=inquiries";
    // }

    // TODO: 내 문의 내역 조회 (AJAX)
    // @GetMapping("/list")
    // @ResponseBody
    // public List<Inquiry> getMyInquiries(HttpSession session) {
    //     return inquiryService.getUserInquiries(userId);
    // }
}
