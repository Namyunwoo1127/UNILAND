package com.elon.boot.domain.inquiry.model.store;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.domain.inquiry.model.vo.Inquiry;

/**
 * 문의 MyBatis Mapper 인터페이스
 */
@Mapper
public interface InquiryMapper {

    // TODO: 문의 등록
    // int insertInquiry(Inquiry inquiry);

    // TODO: 사용자별 문의 조회
    // List<Inquiry> selectInquiriesByUserId(String userId);

    // TODO: 사용자별 + 타입별 문의 조회
    // List<Inquiry> selectInquiriesByType(@Param("userId") String userId,
    //                                     @Param("inquiryType") String inquiryType);

    // TODO: 문의 상세 조회
    // Inquiry selectInquiryById(int inquiryId);

    // TODO: 문의 답변 등록
    // int updateInquiryAnswer(@Param("inquiryId") int inquiryId,
    //                         @Param("answer") String answer);

    // TODO: 중개사별 문의 조회
    // List<Inquiry> selectInquiriesByRealtorId(String realtorId);

    // TODO: 관리자 문의 전체 조회
    // List<Inquiry> selectAdminInquiries();
}
