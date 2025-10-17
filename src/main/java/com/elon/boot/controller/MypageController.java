package com.elon.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class MypageController {

    // 일반 사용자 마이페이지
    @GetMapping
    public String mypage(HttpSession session, Model model) {
        // 세션에서 사용자 정보 가져오기
        Object user = session.getAttribute("user");

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

        return "mypage/real-estate-mypage";
    }

    // 회원정보 수정
    @PostMapping("/update")
    public String updateProfile(
            @RequestParam String name,
            @RequestParam Integer age,
            @RequestParam String gender,
            @RequestParam String phone,
            @RequestParam String email,
            HttpSession session) {

        // TODO: 사용자 정보 업데이트
        // userService.updateUser(userId, name, age, gender, phone, email);

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
}
