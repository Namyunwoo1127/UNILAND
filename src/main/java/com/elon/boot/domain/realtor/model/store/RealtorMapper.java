package com.elon.boot.domain.realtor.model.store;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.domain.realtor.model.vo.Realtor;
import java.util.Map; // Map 타입을 사용하기 위해 추가

@Mapper
public interface RealtorMapper {
    int countByBusinessNum(@Param("businessNum") String businessNum);
    
    // ⭐ 추가: 중개사 등록번호 중복 확인
    /**
     * 중개사 등록번호가 DB에 존재하는지 개수를 셉니다.
     * @param realtorRegNum 확인할 중개사 등록번호
     * @return 개수 (0이면 중복 아님)
     */
    int countByRealtorRegNum(@Param("realtorRegNum") String realtorRegNum);

    int insertRealtor(Realtor realtor);
    Realtor findByLoginInfo(@Param("realtorId") String realtorId,
                            @Param("password") String password,
                            @Param("businessNumber") String businessNumber);

    // ✅ 중개사 ID로 정보 조회 (마이페이지에서 최신 정보 로드용)
    /**
     * 중개사 ID를 기준으로 회원 정보를 조회합니다.
     * @param realtorId 조회할 중개사의 ID
     * @return 해당 ID의 Realtor 객체
     */
    Realtor findById(@Param("realtorId") String realtorId);

    // ✅ 회원 정보 수정
    /**
     * 중개사 정보를 수정합니다.
     * @param realtor 수정할 정보(ID 포함)가 담긴 VO
     * @return 성공적으로 수정된 행의 개수 (1이면 성공)
     */
    int updateRealtor(Realtor realtor);

    // ✅ 회원 탈퇴 (삭제 또는 비활성화)
    /**
     * 중개사 계정을 DB에서 삭제(또는 상태 변경)합니다.
     * @param realtorId 삭제할 중개사 ID
     * @return 성공적으로 삭제(또는 변경)된 행의 개수 (1이면 성공)
     */
    int deleteRealtor(@Param("realtorId") String realtorId);
    
    // ⭐ 프로필 이미지 파일명 업데이트
    /**
     * 중개사의 프로필 이미지 파일명을 업데이트합니다.
     * @param params realtorId와 realtorImage 파일명을 담은 Map
     * @return 성공적으로 업데이트된 행의 개수 (1이면 성공)
     */
    int updateRealtorImage(Map<String, Object> params);
}