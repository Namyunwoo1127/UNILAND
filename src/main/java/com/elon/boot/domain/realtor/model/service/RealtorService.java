package com.elon.boot.domain.realtor.model.service;

import com.elon.boot.domain.realtor.model.vo.Realtor;

public interface RealtorService {
    boolean registerRealtor(Realtor realtor);
    Realtor getRealtorById(String realtorId);
    Realtor getRealtorByBusinessNum(String businessNum);
    boolean updateRealtorInfo(Realtor realtor);
    boolean deleteRealtorInfo(String realtorId);
    boolean isBusinessNumDuplicate(String businessNum);
}
