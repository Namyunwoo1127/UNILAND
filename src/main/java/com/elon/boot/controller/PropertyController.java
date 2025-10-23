package com.elon.boot.controller;

import com.elon.boot.controller.dto.property.OptionAddRequest;
import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/property")
@RequiredArgsConstructor
public class PropertyController {

    private final PropertyService pService;

    // 매물 상세 페이지
    @GetMapping("/{id}")
    public String propertyDetail(@PathVariable Long id, Model model) {
    	System.out.println(id);
    	Property property = pService.selectOneByNo(id);
    	PropertyOption option = pService.selectOnesOption(id);
    	List<PropertyImg> imgs = new ArrayList<PropertyImg> ();
    	imgs = pService.selectOnesImgs(id);
    	
    	
         model.addAttribute("property", property);
         model.addAttribute("option", option);
         model.addAttribute("imgs", imgs);
         
        return "property/detail";
    }
    
    @PostMapping("/register")
    public String register(PropertyAddRequest req
    		, OptionAddRequest oReq
    		, HttpSession session
    		,@RequestParam (value="images",required=false)List<MultipartFile> images) {
        Realtor realtor = (Realtor) session.getAttribute("loginRealtor");
        if (realtor == null || realtor.getRealtorId() == null || realtor.getRealtorId().isBlank()) {
            return "redirect:/realtor/realtor-dashboard";
        }

        pService.register(req,oReq,images, realtor.getRealtorId());
        
        return "redirect:/realtor/property-management";
    }
    
//    임시로 사용할 테스트용 하드코딩 / 중개사 회원 로그인 기능 완성되면 지우고 위의 코딩을 사용해야함 
//    @PostMapping("/regiset")
//    public String register(PropertyAddRequest propReq, HttpSession session) {
//        String realtorId = "realtor_0001";
//
//        
//        propertyService.register(propReq, realtorId);
//
//        return "redirect:/realtor/property-management";
//    }
}