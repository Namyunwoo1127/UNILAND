package com.elon.boot.domain.property.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.elon.boot.controller.dto.property.PropertyAddRequest;

public interface PropertyService {
    Long register(PropertyAddRequest req,List<MultipartFile> images, String realtorId);
	
}