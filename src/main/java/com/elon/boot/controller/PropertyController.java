package com.elon.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/property")
public class PropertyController {



    // 매물 상세 페이지
    @GetMapping("/{id}")
    public String propertyDetail(@PathVariable Long id, Model model) {
        // TODO: 실제 데이터베이스에서 매물 정보 가져오기
        // Property property = propertyService.getPropertyById(id);
        // List<Property> similarProperties = propertyService.getSimilarProperties(id);

        // model.addAttribute("property", property);
        // model.addAttribute("similarProperties", similarProperties);

        return "property/detail";
    }
}
