package com.elon.boot.domain.property.model.store;

import com.elon.boot.domain.property.model.vo.Property;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface PropertyMapper {
    void insertProperty(Property property);
    void insertPropertyImages(@Param("list") List<Map<String, Object>> list);
}
