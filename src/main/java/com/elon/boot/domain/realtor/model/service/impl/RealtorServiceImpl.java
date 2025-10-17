package com.elon.boot.domain.realtor.model.service.impl;

import com.elon.boot.domain.realtor.model.service.RealtorService;
import com.elon.boot.domain.realtor.model.store.RealtorMapper;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class RealtorServiceImpl implements RealtorService {

    private final RealtorMapper realtorMapper;

    @Override
    public boolean registerRealtor(Realtor realtor) {
        // 아이디 중복 확인
        if (getRealtorById(realtor.getRealtorId()) != null) {
            throw new IllegalArgumentException("이미 등록된 아이디입니다.");
        }

        // 사업자등록번호 중복 확인
        if (isBusinessNumDuplicate(realtor.getBusinessNum())) {
            throw new IllegalArgumentException("이미 등록된 사업자 등록번호입니다.");
        }

        // CREATED_AT / UPDATED_AT 은 DB SYSDATE 사용
        return realtorMapper.insertRealtor(realtor) > 0;
    }

    @Override
    @Transactional(readOnly = true)
    public Realtor getRealtorById(String realtorId) {
        return realtorMapper.selectRealtorById(realtorId);
    }

    @Override
    @Transactional(readOnly = true)
    public Realtor getRealtorByBusinessNum(String businessNum) {
        return realtorMapper.selectRealtorByBusinessNum(businessNum);
    }

    @Override
    public boolean updateRealtorInfo(Realtor realtor) {
        return realtorMapper.updateRealtor(realtor) > 0;
    }

    @Override
    public boolean deleteRealtorInfo(String realtorId) {
        return realtorMapper.deleteRealtor(realtorId) > 0;
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isBusinessNumDuplicate(String businessNum) {
        return realtorMapper.selectRealtorByBusinessNum(businessNum) != null;
    }
}
