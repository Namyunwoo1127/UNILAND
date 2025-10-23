package com.elon.boot.domain.property.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.elon.boot.controller.dto.property.OptionAddRequest;
import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.property.model.vo.PropertyOption;

public interface PropertyService {
	
    Long register(PropertyAddRequest req,OptionAddRequest oReq,List<MultipartFile> images, String realtorId);

	Property selectOneByNo(Long id);

	PropertyOption selectOnesOption(Long id);

	public List<PropertyImg> selectOnesImgs(Long id);
	
}