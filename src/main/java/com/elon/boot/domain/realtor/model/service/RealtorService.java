package com.elon.boot.domain.realtor.model.service;

import com.elon.boot.domain.realtor.model.vo.Realtor;

public interface RealtorService {
    boolean isBusinessNumDuplicate(String businessNum);
    
    // ⭐ 추가: 중개사 등록번호 중복 확인 메서드
    /**
     * 중개사 등록번호의 중복 여부를 확인합니다.
     * @param realtorRegNum 확인할 중개사 등록번호
     * @return 중복되면 true, 아니면 false
     */
    boolean isRealtorRegNumDuplicate(String realtorRegNum);

    boolean registerRealtor(Realtor realtor);
    Realtor getRealtorByLogin(String realtorId, String password, String businessNumber);

    // ✅ 회원 정보 수정 메서드 추가
    /**
     * 중개사 회원 정보를 수정합니다.
     * @param realtor 수정할 정보가 담긴 Realtor VO 객체 (ID 포함)
     * @return 수정 성공 여부 (true/false)
     */
    boolean updateRealtor(Realtor realtor);

    // ✅ 회원 탈퇴 메서드 추가
    /**
     * 중개사 계정을 탈퇴(삭제 또는 비활성화) 처리합니다.
     * @param realtorId 탈퇴할 중개사의 ID
     * @return 탈퇴 성공 여부 (true/false)
     */
    boolean deleteRealtor(String realtorId);
    
    // ✅ 마이페이지 조회 시 최신 정보 가져오기 위한 메서드 추가 (Controller에서 사용)
    /**
     * 중개사 ID로 전체 회원 정보를 조회합니다.
     * @param realtorId 조회할 중개사의 ID
     * @return 해당 ID의 Realtor 객체
     */
    Realtor getRealtorById(String realtorId); 
    
    // ⭐ 추가: 프로필 이미지 파일명 업데이트 메서드
    /**
     * 중개사의 프로필 이미지 파일명을 업데이트합니다.
     * @param realtorId 중개사 ID
     * @param savedFileName 서버에 저장된 새 파일명
     * @return 업데이트 성공 여부 (true/false)
     */
    boolean updateRealtorImage(String realtorId, String savedFileName); // 반환 타입을 boolean으로 가정
}