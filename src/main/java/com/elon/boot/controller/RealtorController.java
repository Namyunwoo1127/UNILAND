package com.elon.boot.controller;

import com.elon.boot.domain.realtor.model.service.RealtorService;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/realtor") // ✅ 모든 중개사 관련 경로는 /realtor 하위
public class RealtorController {

    // 필요한 서비스 (RealtorService는 이미 주입되어 있음)
    @Autowired
    private RealtorService realtorService;
    // // TODO: PropertyService, InquiryService 등 추가 주입 (필요시)

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
    
    /** ✅ 매물 수정 페이지 */
    @GetMapping("/property-edit")
    public String showPropertyEdit() {
        return "realtor/property-edit";
    }

    /** ✅ 로그아웃 */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/?logout=true";
    }
    
    // =========================================================================
    // 중개사 마이페이지 기능 통합
    // =========================================================================

    /** * ✅ 중개사 마이페이지 조회 (realtor/realtor-mypage)
     * 세션에 저장된 중개사 정보를 가져와 마이페이지에 필요한 데이터를 모델에 담습니다.
     */
    @GetMapping("/realtor-mypage")
    public String showRealtorMypage(HttpSession session, Model model) {
        // 세션에서 중개사 정보 가져오기 (로그인 시 저장된 "loginRealtor" 사용)
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        // 로그인 체크
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login"; 
        }

        // 최신 사용자 정보를 다시 조회 (업데이트 후 세션 갱신을 위해 필요)
        Realtor currentRealtor = realtorService.getRealtorById(loginRealtor.getRealtorId());
        
        // 🚨 최신 정보를 다시 세션에 저장
        session.setAttribute("loginRealtor", currentRealtor);
        
        // 마이페이지에 필요한 데이터 조회
        // TODO: 등록 매물 현황, 받은 문의 내역 등 데이터 조회 후 모델에 추가
        
        model.addAttribute("realtor", currentRealtor);
        // model.addAttribute("registeredProperties", propertyService.getPropertiesByRealtorId(loginRealtor.getRealtorId()));

        return "realtor/realtor-mypage";
    }
    
    /** * ✅ 중개사 회원정보 수정 처리 (realtor/mypage/update)
     */
    @PostMapping("/mypage/update")
    public String updateRealtorProfile(
            HttpSession session, 
            RedirectAttributes ra,
            @RequestParam String officeName,    // 중개사무소 상호명
            @RequestParam String realtorName,    // 대표 중개인 이름
            @RequestParam String realtorAddress, // 사무소 주소
            @RequestParam String realtorPhone,   // 연락처
            @RequestParam String realtorEmail) {  // 이메일

        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        // 로그인 체크
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login"; 
        }

        String realtorId = loginRealtor.getRealtorId();
        String businessNum = loginRealtor.getBusinessNum(); // 수정 불가 필드는 세션에서 가져옴

        // 1. VO 객체에 수정할 정보 및 PK/BusinessNum 담기
        Realtor updatedRealtor = new Realtor();
        updatedRealtor.setRealtorId(realtorId); 
        updatedRealtor.setBusinessNum(businessNum); 
        updatedRealtor.setOfficeName(officeName);
        updatedRealtor.setRealtorName(realtorName);
        updatedRealtor.setRealtorAddress(realtorAddress);
        updatedRealtor.setRealtorPhone(realtorPhone);
        updatedRealtor.setRealtorEmail(realtorEmail);

        // 2. 서비스 호출하여 DB 업데이트
        boolean success = realtorService.updateRealtor(updatedRealtor);

        // 3. DB 업데이트 성공 시 세션 정보 갱신 및 메시지 전달
        if (success) {
             // 최신 정보를 다시 조회하여 세션 갱신
             Realtor currentRealtor = realtorService.getRealtorById(realtorId);
             session.setAttribute("loginRealtor", currentRealtor);
             ra.addFlashAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
        } else {
             ra.addFlashAttribute("message", "회원 정보 수정에 실패했습니다.");
        }

        return "redirect:/realtor/realtor-mypage";
    }

    /** * ✅ 중개사 회원 탈퇴 처리 (realtor/mypage/delete)
     * 실제로는 POST로 처리하고 비밀번호 확인이 필요하지만, 여기서는 GET 요청 그대로 사용합니다.
     */
    @GetMapping("/mypage/delete")
    public String deleteRealtorAccount(HttpSession session, RedirectAttributes ra) {
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        // 로그인 체크
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login"; 
        }
        
        String realtorId = loginRealtor.getRealtorId();

        // 회원 탈퇴 처리
        boolean success = realtorService.deleteRealtor(realtorId);

        if (success) {
            session.invalidate(); // 세션 무효화
            ra.addFlashAttribute("message", "성공적으로 탈퇴되었습니다. UNILAND를 이용해주셔서 감사합니다.");
            return "redirect:/"; // 메인 페이지로 리다이렉트
        } else {
            ra.addFlashAttribute("message", "탈퇴 처리 중 오류가 발생했습니다. 고객센터에 문의해주세요.");
            // 탈퇴 실패 시는 세션을 유지하고 마이페이지로 복귀 (원래는 POST/비번확인 후 처리)
            return "redirect:/realtor/realtor-mypage"; 
        }
    }
}