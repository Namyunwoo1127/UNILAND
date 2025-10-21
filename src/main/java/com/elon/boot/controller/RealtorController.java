package com.elon.boot.controller;

import com.elon.boot.domain.realtor.model.service.RealtorService;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/realtor") // ✅ 모든 중개사 관련 경로는 /realtor 하위
public class RealtorController {

    @Autowired
    private RealtorService realtorService;

    /** ✅ 사업자등록번호 중복 확인 (AJAX) */
    @PostMapping("/check-business-num")
    @ResponseBody
    public Map<String, Object> checkBusinessNum(@RequestBody Map<String, String> req) {
        String businessNum = req.get("businessNum");
        boolean isDuplicate = realtorService.isBusinessNumDuplicate(businessNum);

        Map<String, Object> res = new HashMap<>();
        res.put("isDuplicate", isDuplicate);
        res.put("message", isDuplicate ? "이미 등록된 사업자등록번호입니다." : "사용 가능한 사업자등록번호입니다.");
        return res;
    }

    /** ✅ 회원가입 폼 제출 처리 */
    @PostMapping("/register")
    @ResponseBody
    public Map<String, Object> registerRealtor(@RequestBody Realtor realtor) {
        Map<String, Object> res = new HashMap<>();

        // 중복 체크
        if (realtorService.isBusinessNumDuplicate(realtor.getBusinessNum())) {
            res.put("success", false);
            res.put("message", "이미 등록된 사업자등록번호입니다.");
            return res;
        }

        // 회원가입 처리
        boolean success = realtorService.registerRealtor(realtor);
        if (success) {
            res.put("success", true);
            res.put("message", "회원가입이 완료되었습니다. 로그인해주세요.");
        } else {
            res.put("success", false);
            res.put("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
        }

        return res;
    }

//    /** ✅ 로그인 페이지 이동 */
//    @GetMapping("/realtor-login")
//    public String showLoginPage() {
//    		return "redirect:/auth/realtor-login"; // /WEB-INF/views/realtor/realtor-login.jsp
//    }

    /** ✅ 로그인 처리 */
    @PostMapping("/realtor-login")
    public String realtorLogin(@RequestParam("realtorId") String realtorId,
                               @RequestParam("password") String password,
                               @RequestParam("businessNumber") String businessNumber,
                               HttpSession session,
                               Model model) {

        Realtor realtor = realtorService.getRealtorByLogin(realtorId, password, businessNumber);

        if (realtor != null) {
            // 로그인 성공 → 세션 저장 및 대시보드로 이동
            session.setAttribute("loginRealtor", realtor);
            return "redirect:/realtor/realtor-dashboard";
        } else {
            // 로그인 실패 → 에러 메시지를 모델에 담아 같은 페이지로 유지
            model.addAttribute("loginError", "아이디, 비밀번호 또는 사업자등록번호가 올바르지 않습니다.");
            return "auth/realtor-login";
        }
    }

    /** ✅ 대시보드 페이지 */
    @GetMapping("/realtor-dashboard")
    public String showRealtorDashboard() {
        return "realtor/realtor-dashboard";
    }

    /** ✅ 매물 관리 페이지 */
    @GetMapping("/property-management")
    public String propertyManagementPage() {
        return "realtor/property-management";
    }

    /** ✅ 매물 등록 페이지 */
    @GetMapping("/property-register")
    public String propertyRegisterPage() {
        return "realtor/property-register";
    }

    /** ✅ 문의 관리 페이지 */
    @GetMapping("/inquiry-management")
    public String inquiryManagementPage() {
        return "realtor/inquiry-management";
    }

    /** ✅ 로그아웃 */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/?logout=true";
    }
}
