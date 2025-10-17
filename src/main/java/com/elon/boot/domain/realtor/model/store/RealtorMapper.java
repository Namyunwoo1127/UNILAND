package com.elon.boot.domain.realtor.model.store;

import com.elon.boot.domain.realtor.model.vo.Realtor;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RealtorMapper {
    int insertRealtor(Realtor realtor);
    Realtor selectRealtorById(String realtorId);
    Realtor selectRealtorByBusinessNum(String businessNum);
    int updateRealtor(Realtor realtor);
    int deleteRealtor(String realtorId);
}
