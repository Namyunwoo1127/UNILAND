package com.elon.boot.domain.community.guide.model.store;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.domain.community.guide.model.vo.Guide;

@Mapper
public interface GuideMapper {

	 List<Guide> selectGuideList(@Param("keyword") String keyword, @Param("category") String searchCategory);

	 List<Guide> selectPopularGuides();
}