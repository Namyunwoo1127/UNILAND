package com.elon.boot.domain.property.model.store;

import com.elon.boot.domain.property.model.vo.PropertyOption;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OptionMapper {
    int insertOption(PropertyOption option);
}