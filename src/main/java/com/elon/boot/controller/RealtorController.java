package com.elon.boot.controller;

import com.elon.boot.domain.realtor.model.service.RealtorService;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/realtor")
@RequiredArgsConstructor
@Slf4j
public class RealtorController {

    private final RealtorService realtorService;

    // ========================================
    // 페이지 이동 (View 반환)
    // ========================================

    @GetMapping("/realtor-dashboard")
    public String realtorDashboard(HttpSession session, Model model) {
        return "realtor/realtor-dashboard";
    }

    @GetMapping("/property-management")
    public String propertyManagement(HttpSession session, Model model) {
        return "realtor/property-management";
    }

    @GetMapping("/property-register")
    public String propertyRegister(HttpSession session, Model model) {
        return "realtor/property-register";
    }

    @GetMapping("/inquiry-management")
    public String inquiryManagement(HttpSession session, Model model) {
        return "realtor/inquiry-management";
    }

    // ========================================
    // API 엔드포인트 (JSON 응답)
    // ========================================

    /** 사업자 등록번호 중복 확인 */
    @PostMapping("/api/check-business-num")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkBusinessNum(@RequestBody Map<String, String> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            String businessNum = request.get("businessNum");

            if (businessNum == null || businessNum.trim().isEmpty()) {
                response.put("success", false);
                response.put("isDuplicate", false);
                response.put("message", "사업자 등록번호가 입력되지 않았습니다.");
                return ResponseEntity.badRequest().body(response);
            }

            if (!businessNum.matches("\\d{10}")) {
                response.put("success", false);
                response.put("isDuplicate", false);
                response.put("message", "사업자 등록번호는 10자리 숫자여야 합니다.");
                return ResponseEntity.badRequest().body(response);
            }

            boolean isDuplicate = realtorService.isBusinessNumDuplicate(businessNum);

            response.put("success", true);
            response.put("isDuplicate", isDuplicate);
            response.put("message", isDuplicate ? "이미 등록된 사업자 등록번호입니다." : "사용 가능한 사업자 등록번호입니다.");

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("사업자 등록번호 확인 중 오류 발생", e);
            response.put("success", false);
            response.put("isDuplicate", false);
            response.put("message", "사업자 등록번호 확인 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /** 중개사 회원가입 */
    @PostMapping("/api/register")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> registerRealtor(@RequestBody Realtor realtor) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 필수 입력값 체크
            if (!validateRealtorData(realtor)) {
                response.put("success", false);
                response.put("message", "필수 입력값이 누락되었습니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 아이디 형식 체크 (영문, 숫자, 4~20자리)
            if (!realtor.getRealtorId().matches("^[a-zA-Z0-9]{4,20}$")) {
                response.put("success", false);
                response.put("message", "아이디는 영문/숫자 4~20자리여야 합니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 사업자등록번호 10자리 체크
            if (!realtor.getBusinessNum().matches("\\d{10}")) {
                response.put("success", false);
                response.put("message", "사업자 등록번호 형식이 올바르지 않습니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 전화번호 체크
            if (!realtor.getRealtorPhone().matches("\\d{10,11}")) {
                response.put("success", false);
                response.put("message", "전화번호 형식이 올바르지 않습니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 이메일 체크
            if (!realtor.getRealtorEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                response.put("success", false);
                response.put("message", "이메일 형식이 올바르지 않습니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 회원가입 처리
            boolean isRegistered = realtorService.registerRealtor(realtor);

            if (isRegistered) {
                response.put("success", true);
                response.put("message", "중개사 회원가입이 완료되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "중개사 회원가입에 실패했습니다.");
                return ResponseEntity.internalServerError().body(response);
            }

        } catch (IllegalArgumentException e) {
            log.error("중개사 등록 중 유효성 검사 실패", e);
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        } catch (Exception e) {
            log.error("중개사 등록 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "중개사 등록 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /** ID로 중개사 정보 조회 */
    @GetMapping("/api/{realtorId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getRealtorInfo(@PathVariable String realtorId) {
        Map<String, Object> response = new HashMap<>();

        try {
            Realtor realtor = realtorService.getRealtorById(realtorId);

            if (realtor == null) {
                response.put("success", false);
                response.put("message", "중개사 정보를 찾을 수 없습니다.");
                return ResponseEntity.status(404).body(response);
            }

            response.put("success", true);
            response.put("data", realtor);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("중개사 정보 조회 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "중개사 정보 조회 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /** ID 기반 정보 수정 */
    @PutMapping("/api/{realtorId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateRealtorInfo(
            @PathVariable String realtorId,
            @RequestBody Realtor realtor) {
        Map<String, Object> response = new HashMap<>();

        try {
            realtor.setRealtorId(realtorId);

            if (!validateRealtorData(realtor)) {
                response.put("success", false);
                response.put("message", "필수 입력값이 누락되었습니다.");
                return ResponseEntity.badRequest().body(response);
            }

            boolean isUpdated = realtorService.updateRealtorInfo(realtor);

            if (isUpdated) {
                response.put("success", true);
                response.put("message", "중개사 정보가 수정되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "중개사 정보 수정에 실패했습니다.");
                return ResponseEntity.internalServerError().body(response);
            }

        } catch (Exception e) {
            log.error("중개사 정보 수정 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "중개사 정보 수정 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /** ID 기반 정보 삭제 */
    @DeleteMapping("/api/{realtorId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteRealtorInfo(@PathVariable String realtorId) {
        Map<String, Object> response = new HashMap<>();

        try {
            boolean isDeleted = realtorService.deleteRealtorInfo(realtorId);

            if (isDeleted) {
                response.put("success", true);
                response.put("message", "중개사 정보가 삭제되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "중개사 정보 삭제에 실패했습니다.");
                return ResponseEntity.internalServerError().body(response);
            }

        } catch (Exception e) {
            log.error("중개사 정보 삭제 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "중개사 정보 삭제 중 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }

    // ========================================
    // 유틸리티
    // ========================================

    /** 필수 입력값 검증 */
    private boolean validateRealtorData(Realtor realtor) {
        return realtor.getRealtorId() != null && !realtor.getRealtorId().trim().isEmpty() &&
               realtor.getOfficeName() != null && !realtor.getOfficeName().trim().isEmpty() &&
               realtor.getRealtorName() != null && !realtor.getRealtorName().trim().isEmpty() &&
               realtor.getRealtorAddress() != null && !realtor.getRealtorAddress().trim().isEmpty() &&
               realtor.getRealtorPhone() != null && !realtor.getRealtorPhone().trim().isEmpty() &&
               realtor.getRealtorEmail() != null && !realtor.getRealtorEmail().trim().isEmpty() &&
               realtor.getBusinessNum() != null && !realtor.getBusinessNum().trim().isEmpty();
    }
}
