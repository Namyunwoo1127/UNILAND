package com.elon.boot.domain.realtor.model.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.elon.boot.domain.realtor.model.store.RealtorMapper;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.realtor.model.service.RealtorService;

@Service
public class RealtorServiceImpl implements RealtorService {

    @Autowired
    private RealtorMapper realtorMapper;

    @Override
    public boolean isBusinessNumDuplicate(String businessNum) {
        return realtorMapper.countByBusinessNum(businessNum) > 0;
    }

    @Override
    public boolean registerRealtor(Realtor realtor) {
        return realtorMapper.insertRealtor(realtor) > 0;
    }

    @Override
    public Realtor getRealtorByLogin(String realtorId, String password, String businessNumber) {
        return realtorMapper.findByLoginInfo(realtorId, password, businessNumber);
    }
}
