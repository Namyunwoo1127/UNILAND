package com.elon.boot.domain.realtor.model.service;

import com.elon.boot.domain.realtor.model.vo.Realtor;

public interface RealtorService {
    boolean isBusinessNumDuplicate(String businessNum);
    boolean registerRealtor(Realtor realtor);
    Realtor getRealtorByLogin(String realtorId, String password, String businessNumber);
}
