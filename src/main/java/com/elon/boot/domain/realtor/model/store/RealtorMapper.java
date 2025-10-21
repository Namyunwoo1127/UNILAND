package com.elon.boot.domain.realtor.model.store;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.domain.realtor.model.vo.Realtor;

@Mapper
public interface RealtorMapper {
    int countByBusinessNum(@Param("businessNum") String businessNum);
    int insertRealtor(Realtor realtor);
    Realtor findByLoginInfo(@Param("realtorId") String realtorId,
                            @Param("password") String password,
                            @Param("businessNumber") String businessNumber);
}
