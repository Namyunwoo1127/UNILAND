package com.elon.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    // 지도 검색 페이지
    @GetMapping("/map")
    public String propertyMap(Model model) {
        // TODO: 지도에 표시할 매물 목록 가져오기
        // List<Property> properties = propertyService.getAllProperties();
        // model.addAttribute("properties", properties);

        return "unilandmap";
    }
    
    // 메인 페이지
    @GetMapping({"/", "/uniland"})
    public String index(Model model) {
        // TODO: 메인 페이지에 필요한 데이터 추가
        // model.addAttribute("featuredProperties", propertyService.getFeaturedProperties());
        // model.addAttribute("recentNotices", noticeService.getRecentNotices());

        return "uniland";
        
        
        
    }
}
