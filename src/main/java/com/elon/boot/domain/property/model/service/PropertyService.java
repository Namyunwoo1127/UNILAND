package com.elon.boot.domain.property.model.service;

import com.elon.boot.controller.dto.property.PropertyAddRequest;

public interface PropertyService {
    Long register(PropertyAddRequest req, String realtorId);
	
}