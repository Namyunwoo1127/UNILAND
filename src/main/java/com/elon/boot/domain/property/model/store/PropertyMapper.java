package com.elon.boot.domain.property.model.store;

import com.elon.boot.domain.property.model.vo.Property;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PropertyMapper {
    int insertProperty(Property property);
}