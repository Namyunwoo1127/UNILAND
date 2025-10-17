package com.elon.boot.domain.community.guide.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.elon.boot.domain.community.guide.model.service.GuideService;
import com.elon.boot.domain.community.guide.model.store.GuideMapper;
import com.elon.boot.domain.community.guide.model.vo.Guide;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GuideServiceImpl implements GuideService {
	
	private final GuideMapper gStore;

	@Override
	public List<Guide> getGuideList(String keyword, String searchCategory) {
		return gStore.selectGuideList(keyword, searchCategory);
	}

	@Override
	public List<Guide> getPopularGuides() {
		return gStore.selectPopularGuides();
	}

}
