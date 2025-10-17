package com.elon.boot.controller;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elon.boot.domain.user.model.service.UserService;
import com.elon.boot.domain.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;

    // 로그인 페이지
    @GetMapping("/login")
    public String loginPage() {
        return "auth/login";
    }

    // 로그인 처리
    @PostMapping("/login")
    public String login(@RequestParam String userId,
                       @RequestParam String userPassword,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        User user = userService.login(userId, userPassword);

        if (user != null) {
            // 로그인 성공
            session.setAttribute("loginUser", user);
            return "redirect:/";
        } else {
            // 로그인 실패
            redirectAttributes.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "redirect:/auth/login";
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // 회원가입 페이지
    @GetMapping("/signup")
    public String signupPage() {
        return "auth/signup";
    }

    // 회원가입 처리
    @PostMapping("/signup")
    public String signup(User user, RedirectAttributes redirectAttributes) {
        try {
            // ID 중복 체크
            if (userService.checkDuplicateId(user.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMsg", "이미 사용 중인 아이디입니다.");
                return "redirect:/auth/signup";
            }

            // 생년월일로부터 나이 계산
            if (user.getBirthDate() != null) {
                java.time.LocalDate birthDate = user.getBirthDate().toLocalDate();
                java.time.LocalDate now = java.time.LocalDate.now();
                int age = now.getYear() - birthDate.getYear();

                // 생일이 지나지 않았으면 1살 빼기
                if (now.getMonthValue() < birthDate.getMonthValue() ||
                    (now.getMonthValue() == birthDate.getMonthValue() && now.getDayOfMonth() < birthDate.getDayOfMonth())) {
                    age--;
                }

                user.setUserAge(age);
            }

            // 회원가입 처리
            int result = userService.signUp(user);

            if (result > 0) {
                redirectAttributes.addFlashAttribute("successMsg", "회원가입이 완료되었습니다.");
                return "redirect:/auth/login";
            } else {
                redirectAttributes.addFlashAttribute("errorMsg", "회원가입에 실패했습니다.");
                return "redirect:/auth/signup";
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMsg", "오류가 발생했습니다: " + e.getMessage());
            return "redirect:/auth/signup";
        }
    }

    // 비밀번호 찾기 페이지
    @GetMapping("/find-password")
    public String findPasswordPage() {
        return "auth/find-password";
    }

    // 비밀번호 찾기 처리
    @PostMapping("/find-password")
    public String findPassword(@RequestParam String userId,
                               @RequestParam String userName,
                               @RequestParam(required = false) String userEmail,
                               @RequestParam(required = false) String userPhone,
                               @RequestParam String searchType,
                               Model model) {
        User user = null;

        if ("email".equals(searchType)) {
            user = userService.getUserByEmail(userEmail);
            if (user != null) {
                // 아이디와 이름이 일치하는지 확인
                if (!user.getUserId().equals(userId) || !user.getUserName().equals(userName)) {
                    user = null;
                    model.addAttribute("errorMsg", "입력하신 정보와 일치하는 회원이 없습니다.");
                }
            } else {
                model.addAttribute("errorMsg", "해당 이메일로 가입된 회원이 없습니다.");
            }
        } else if ("phone".equals(searchType)) {
            user = userService.getUserByPhone(userPhone);
            if (user != null) {
                // 아이디와 이름이 일치하는지 확인
                if (!user.getUserId().equals(userId) || !user.getUserName().equals(userName)) {
                    user = null;
                    model.addAttribute("errorMsg", "입력하신 정보와 일치하는 회원이 없습니다.");
                }
            } else {
                model.addAttribute("errorMsg", "해당 전화번호로 가입된 회원이 없습니다.");
            }
        }

        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("successMsg", "회원 정보를 찾았습니다.");
        }

        model.addAttribute("searchType", searchType);
        return "auth/find-password";
    }

    // 중개사 회원가입 페이지
    @GetMapping("/signup-realtor")
    public String signupRealtorPage() {
        return "auth/signup-realtor"; 
    }

    // 중개사 회원가입 처리
    @PostMapping("/signup-realtor")
    public String signupRealtor() {
        // TODO: 중개사 회원가입 로직 구현
        return "redirect:/auth/login";
    }
	@GetMapping("/realtor-login")
	public String realtorLogin() {
	    return "auth/realtor-login";
	}
}
