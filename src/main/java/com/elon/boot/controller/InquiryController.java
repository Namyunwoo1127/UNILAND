package com.elon.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elon.boot.domain.inquiry.model.service.InquiryService;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 문의 컨트롤러
 */
@Controller
@RequestMapping("/inquiries")
@RequiredArgsConstructor
@Slf4j
public class InquiryController {

    private final InquiryService inquiryService;
    
    // 문의 작성 페이지
    @GetMapping("/write")
    public String inquiryWriteForm(HttpSession session, RedirectAttributes redirectAttributes) {
        
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        return "inquiry/inquiry-write";
    }
    
    // 문의 등록
    @PostMapping("/write")
    public String inquiryWrite(@ModelAttribute Inquiry inquiry,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        try {
            inquiry.setUserId(loginUser.getUserId());
            inquiry.setUserName(loginUser.getUserName());
            
            int result = inquiryService.createInquiry(inquiry);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "문의가 등록되었습니다.");
                return "redirect:/mypage";
            } else {
                redirectAttributes.addFlashAttribute("error", "문의 등록에 실패했습니다.");
                return "redirect:/inquiries/write";
            }
            
        } catch (Exception e) {
            log.error("문의 등록 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
            return "redirect:/inquiries/write";
        }
    }
    
    // 문의 상세
    @GetMapping("/{inquiryId}")
    public String inquiryDetail(@PathVariable Integer inquiryId,
                               Model model,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        try {
            Inquiry inquiry = inquiryService.getInquiryById(inquiryId);
            
            // 본인 문의만 조회 가능
            if (!inquiry.getUserId().equals(loginUser.getUserId())) {
                redirectAttributes.addFlashAttribute("error", "접근 권한이 없습니다.");
                return "redirect:/mypage";
            }
            
            model.addAttribute("inquiry", inquiry);
            
        } catch (Exception e) {
            log.error("문의 조회 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "문의를 불러올 수 없습니다.");
            return "redirect:/mypage";
        }
        
        return "inquiry/inquiry-detail";
    }
    
    // 문의 삭제
    @PostMapping("/delete/{inquiryId}")
    public String deleteInquiry(@PathVariable Integer inquiryId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        try {
            Inquiry inquiry = inquiryService.getInquiryById(inquiryId);
            
            // 본인 문의만 삭제 가능
            if (!inquiry.getUserId().equals(loginUser.getUserId())) {
                redirectAttributes.addFlashAttribute("error", "접근 권한이 없습니다.");
                return "redirect:/mypage";
            }
            
            int result = inquiryService.deleteInquiry(inquiryId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "문의가 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "문의 삭제에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("문의 삭제 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/mypage";
    }
}
