package com.elon.boot.controller;

import com.elon.boot.domain.realtor.model.service.FileStorageService;
import com.elon.boot.domain.realtor.model.service.RealtorService;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/realtor") 
public class RealtorController {

    @Autowired
    private RealtorService realtorService;
    
    // ⭐ FileStorageService가 주입된 상태로 유지
    @Autowired
    private FileStorageService fileStorageService; 

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
    
    // ⭐ 추가: 중개사 등록번호 중복 확인 (AJAX)
    /** 중개사 등록번호 중복 여부를 확인합니다. (AJAX) */
    @PostMapping("/check-realtor-reg-num")
    @ResponseBody
    public Map<String, Object> checkRealtorRegNum(@RequestBody Map<String, String> req) {
        String realtorRegNum = req.get("realtorRegNum");
        boolean isDuplicate = realtorService.isRealtorRegNumDuplicate(realtorRegNum);

        Map<String, Object> res = new HashMap<>();
        res.put("isDuplicate", isDuplicate);
        res.put("message", isDuplicate ? "이미 등록된 중개사 등록번호입니다." : "사용 가능한 중개사 등록번호입니다.");
        return res;
    }


    /** ✅ 회원가입 폼 제출 처리 */
    @PostMapping("/register")
    @ResponseBody
    public Map<String, Object> registerRealtor(@RequestBody Realtor realtor) {
        Map<String, Object> res = new HashMap<>();

        // 1. 사업자 등록번호 중복 체크
        if (realtorService.isBusinessNumDuplicate(realtor.getBusinessNum())) {
            res.put("success", false);
            res.put("message", "이미 등록된 사업자등록번호입니다.");
            return res;
        }
        
        // 2. ⭐ 중개사 등록번호 중복 체크
        if (realtorService.isRealtorRegNumDuplicate(realtor.getRealtorRegNum())) {
             res.put("success", false);
             res.put("message", "이미 등록된 중개사 등록번호입니다.");
             return res;
        }


        // 회원가입 처리
        boolean success = realtorService.registerRealtor(realtor);
        if (success) {
            // ⭐ 문구 수정: 관리자 승인 대기 상태임을 명시
            res.put("success", true);
            res.put("message", "회원가입 신청이 완료되었습니다. 관리자 승인을 기다려주세요.");
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
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login"; 
        }

        // 최신 사용자 정보를 다시 조회 
        Realtor currentRealtor = realtorService.getRealtorById(loginRealtor.getRealtorId());
        
        session.setAttribute("loginRealtor", currentRealtor);
        model.addAttribute("realtor", currentRealtor);

        return "realtor/realtor-mypage";
    }
    
    /** * ✅ 중개사 회원정보 수정 처리 (realtor/mypage/update) */
    @PostMapping("/mypage/update")
    public String updateRealtorProfile(
            HttpSession session, 
            RedirectAttributes ra,
            @RequestParam String officeName,
            @RequestParam String realtorName,
            @RequestParam String realtorAddress,
            @RequestParam String realtorPhone,
            @RequestParam String realtorEmail) {

        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login"; 
        }

        String realtorId = loginRealtor.getRealtorId();
        String businessNum = loginRealtor.getBusinessNum();
        // ⭐ realtorRegNum 필드 추가
        String realtorRegNum = loginRealtor.getRealtorRegNum(); 


        Realtor updatedRealtor = new Realtor();
        updatedRealtor.setRealtorId(realtorId); 
        updatedRealtor.setBusinessNum(businessNum); 
        // ⭐ realtorRegNum 설정
        updatedRealtor.setRealtorRegNum(realtorRegNum); 
        updatedRealtor.setOfficeName(officeName);
        updatedRealtor.setRealtorName(realtorName);
        updatedRealtor.setRealtorAddress(realtorAddress);
        updatedRealtor.setRealtorPhone(realtorPhone);
        updatedRealtor.setRealtorEmail(realtorEmail);

        boolean success = realtorService.updateRealtor(updatedRealtor);

        if (success) {
             Realtor currentRealtor = realtorService.getRealtorById(realtorId);
             session.setAttribute("loginRealtor", currentRealtor);
             ra.addFlashAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
        } else {
             ra.addFlashAttribute("message", "회원 정보 수정에 실패했습니다.");
        }

        return "redirect:/realtor/realtor-mypage";
    }

    /** * ✅ 중개사 회원 탈퇴 처리 (realtor/mypage/delete) */
    @GetMapping("/mypage/delete")
    public String deleteRealtorAccount(HttpSession session, RedirectAttributes ra) {
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login"; 
        }
        
        String realtorId = loginRealtor.getRealtorId();

        boolean success = realtorService.deleteRealtor(realtorId);

        if (success) {
            session.invalidate();
            ra.addFlashAttribute("message", "성공적으로 탈퇴되었습니다. UNILAND를 이용해주셔서 감사합니다.");
            return "redirect:/";
        } else {
            ra.addFlashAttribute("message", "탈퇴 처리 중 오류가 발생했습니다. 고객센터에 문의해주세요.");
            return "redirect:/realtor/realtor-mypage"; 
        }
    }
    
    /** * ⭐ 수정/통합: 프로필 이미지 업데이트 처리 (realtor/profile/updateImage) */
    @PostMapping("/profile/updateImage")
    public String updateRealtorImage(
        HttpSession session, // 세션 갱신을 위해 추가
        @RequestParam("realtorImage") MultipartFile file,
        RedirectAttributes ra) {
        
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        if (loginRealtor == null) {
            ra.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/realtor/realtor-login"; 
        }
        
        String realtorId = loginRealtor.getRealtorId();
        
        if (file.isEmpty()) {
             ra.addFlashAttribute("errorMessage", "업로드할 이미지를 선택해주세요.");
             return "redirect:/realtor/realtor-mypage";
        }
        
        try {
            // 1. 파일 저장 처리 및 새 파일명 생성
            String savedFileName = fileStorageService.saveProfileImage(file);
            
            // 2. DB에 파일명 업데이트
            boolean success = realtorService.updateRealtorImage(realtorId, savedFileName);

            if (success) {
                // 3. ⭐ 세션 갱신: 최신 정보를 DB에서 다시 가져와 세션을 업데이트
                Realtor currentRealtor = realtorService.getRealtorById(realtorId);
                session.setAttribute("loginRealtor", currentRealtor);
                
                ra.addFlashAttribute("message", "프로필 이미지가 성공적으로 변경되었습니다.");
            } else {
                ra.addFlashAttribute("errorMessage", "DB 업데이트에 실패했습니다.");
            }
        } catch (Exception e) {
            // 파일 저장/DB 업데이트 중 발생한 예외 처리
            ra.addFlashAttribute("errorMessage", "이미지 업로드 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return "redirect:/realtor/realtor-mypage";
    }
}