package com.elon.boot.domain.community.guide.model.service;

import java.util.List;

import com.elon.boot.domain.community.guide.model.vo.Guide;

public interface GuideService {

	List<Guide> getGuideList(String keyword, String searchCategory);

	List<Guide> getPopularGuides();

}
