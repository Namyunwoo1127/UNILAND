package com.elon.boot.domain.realtor.model.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
        // 기존 메서드: 로그인 정보로 조회 (Mapper 메서드 이름은 예시입니다. 실제 이름에 맞게 수정 필요)
        return realtorMapper.findByLoginInfo(realtorId, password, businessNumber);
    }
    
    // ------------------------------------------------------------------------
    // ✅ 새로 추가된 마이페이지 관련 메서드 구현
    // ------------------------------------------------------------------------

    @Override
    public Realtor getRealtorById(String realtorId) {
        // 중개사 ID로 정보를 조회하는 메서드 구현 (Mapper 메서드 이름은 예시입니다. 실제 이름에 맞게 수정 필요)
        return realtorMapper.findById(realtorId);
    }

    @Override
    @Transactional // DB 변경 작업이므로 트랜잭션 처리 적용
    public boolean updateRealtor(Realtor realtor) {
        // Mapper의 updateRealtor 메서드를 호출하여 수정된 행의 개수를 반환받음
        int result = realtorMapper.updateRealtor(realtor);
        return result > 0; // 1개 이상의 행이 수정되었다면 true 반환
    }

    @Override
    @Transactional // DB 변경 작업이므로 트랜잭션 처리 적용
    public boolean deleteRealtor(String realtorId) {
        // Mapper의 deleteRealtor 메서드를 호출하여 삭제(또는 상태 변경)된 행의 개수를 반환받음
        int result = realtorMapper.deleteRealtor(realtorId);
        return result > 0; // 1개 이상의 행이 처리되었다면 true 반환
    }
}