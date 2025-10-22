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

    // ✅ 중개사 ID로 정보 조회 (마이페이지에서 최신 정보 로드용)
    /**
     * 중개사 ID를 기준으로 회원 정보를 조회합니다.
     * @param realtorId 조회할 중개사의 ID
     * @return 해당 ID의 Realtor 객체
     */
    Realtor findById(@Param("realtorId") String realtorId); // 메서드 이름은 findById로 가정

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
}