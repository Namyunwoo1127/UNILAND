package com.elon.boot.domain.property.model.store;

import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.realtor.model.vo.Realtor;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface PropertyMapper {
    int insertProperty(PropertyAddRequest pReq);
    int insertPropertyImages(@Param("list") List<PropertyImg> imgList);
	Property selectOneByNo(Long id);
	List<PropertyImg> selectImagesByPropertyNo(Long id);
	Realtor selectRealtorById(String rId);
}
