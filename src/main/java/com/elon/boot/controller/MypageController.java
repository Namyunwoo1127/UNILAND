package com.elon.boot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.elon.boot.controller.dto.user.UserModRequest;
import com.elon.boot.domain.inquiry.model.service.InquiryService;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;
import com.elon.boot.domain.user.model.service.UserService;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MypageController {

	private final UserService uService;
	private final InquiryService inquiryService;
	
    // 일반 사용자 마이페이지
    @GetMapping
    public String mypage(HttpSession session, Model model) {
    	
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/auth/login"; // 미로그인 시 로그인 페이지로
        }
//        User userInfo = uService.getUserById(loginUser.getUserId());
        model.addAttribute("user" ,uService.getUserById(loginUser.getUserId()));
        
        return "mypage/real-estate-mypage";
    }
    // 임시: 로그인 체크 비활성화 (개발용)
    // if (user == null) {
    //     return "redirect:/auth/login";
    // }
    
    // TODO: 실제 데이터베이스에서 사용자 정보, 계약현황, 찜매물 등 가져오기
    // model.addAttribute("user", user);
    // model.addAttribute("contracts", contractService.getContractsByUserId(userId));
    // model.addAttribute("wishlist", wishlistService.getWishlistByUserId(userId));
    // model.addAttribute("recentProperties", propertyService.getRecentViewsByUserId(userId));
    // model.addAttribute("inquiries", inquiryService.getInquiriesByUserId(userId));

    // 회원정보 수정
    @PostMapping("/update")
    public String updateProfile(
            @ModelAttribute UserModRequest userModiReq,
            HttpSession session) {
    	int result = uService.updateUser(userModiReq);


        return "redirect:/mypage";
    }

    // 회원 탈퇴
    @GetMapping("/delete")
    public String deleteAccount(HttpSession session) {
        // TODO: 회원 탈퇴 처리
        // userService.deleteUser(userId);

        session.invalidate();
        return "redirect:/";
    }
    
    @GetMapping("/inquiries")
    public String CheckInquiry(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        // 문의내역 조회
        List<Inquiry> inquiries = inquiryService.getInquiriesByUserId(user.getUserId());
        System.out.println(inquiries);
        model.addAttribute("inquiries", inquiries);
        model.addAttribute("user", user);
        
        return "mypage/realtor-mypage";
    }
}
