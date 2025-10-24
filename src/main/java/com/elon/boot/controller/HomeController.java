package com.elon.boot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.elon.boot.domain.community.guide.model.service.GuideService;
import com.elon.boot.domain.community.guide.model.vo.Guide;
import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {

	private final NoticeService noticeService;
	private final GuideService guideService;
	
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
        try {
            // 최근 공지사항 5개 조회
            List<Notice> noticeList = noticeService.getRecentNotices(5);
            model.addAttribute("noticeList", noticeList);

            log.debug("메인 페이지 공지사항 조회: {} 건", noticeList != null ? noticeList.size() : 0);

        } catch (Exception e) {
            log.error("메인 페이지 공지사항 조회 실패: ", e);
            // 에러가 발생해도 페이지는 표시되도록 함
        }

        try {
            // 인기 가이드 5개 조회
            List<Guide> guideList = guideService.getPopularGuides();
            model.addAttribute("guideList", guideList);

            log.debug("메인 페이지 가이드 조회: {} 건", guideList != null ? guideList.size() : 0);

        } catch (Exception e) {
            log.error("메인 페이지 가이드 조회 실패: ", e);
            // 에러가 발생해도 페이지는 표시되도록 함
        }

        return "uniland";
    }
}
