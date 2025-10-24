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

import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.property.model.vo.PropertyOption;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/inquiries")
@RequiredArgsConstructor
@Slf4j
public class InquiryController {

    private final InquiryService inquiryService;
    
    private final PropertyService propertyService;

    // TODO: 중개사 문의 페이지
    @GetMapping("/realtor")
    public String realtorInquiryPage(@RequestParam("propertyId") int propertyId, Model model) {
        
        // --- 매물 정보/옵션/썸네일 조회 로직 추가 ---
        try {
            // (참고: int를 Long으로 형변환)
            long id = (long) propertyId; 

            // 1. 기본 매물 정보 조회
            Property property = propertyService.selectOneByNo(id);
            
            // 2. 옵션 정보 조회
            PropertyOption options = propertyService.selectOnesOption(id);

            // 3. 썸네일 이미지 조회 (selectOnesImg가 썸네일(order=0)을 가져온다고 가정)
            PropertyImg thumbnail = propertyService.selectOnesImg(id);
            
            // 4. Model에 3개 객체를 각각 담아서 JSP로 전달
            model.addAttribute("property", property);
            model.addAttribute("options", options);     // ★ ${options} 라는 이름으로 전달
            model.addAttribute("thumbnail", thumbnail); // ★ ${thumbnail} 이라는 이름으로 전달

        } catch (Exception e) {
            e.printStackTrace(); // 서버 로그에 에러 출력
            // 여기서 model.addAttribute를 안하면,
            // JSP의 <c:if test="${empty property}">에 걸려서
            // "매물 정보를 불러올 수 없습니다."가 정상적으로 뜹니다.
        }
        // --- ▲▲▲ 3. 조회 로직 끝 ▲▲▲ ---

        return "inquiry/contact-realtor";
    }

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
