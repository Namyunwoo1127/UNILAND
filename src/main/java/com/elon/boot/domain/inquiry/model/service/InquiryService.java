package com.elon.boot.domain.inquiry.model.service;

import java.util.List;

import com.elon.boot.domain.inquiry.model.vo.Inquiry;

/**
 * 문의 서비스 인터페이스
 */
public interface InquiryService {
	
	List<Inquiry> getMyInquiries(String userId);

	int createInquiry(Inquiry inquiry);

	Inquiry getInquiryById(Integer inquiryId);

	int deleteInquiry(Integer inquiryId);
	
	// 관리자용
    List<Inquiry> getAllInquiries();
    
    int answerInquiry(Integer inquiryId, String answer);

    // TODO: 중개사 문의 생성
    // int createRealtorInquiry(Inquiry inquiry);

    // TODO: 관리자 문의 생성
    // int createAdminInquiry(Inquiry inquiry);

    // TODO: 사용자별 문의 내역 조회
    // List<Inquiry> getUserInquiries(String userId);

    // TODO: 사용자별 + 타입별 문의 조회
    // List<Inquiry> getInquiriesByType(String userId, String inquiryType);

    // TODO: 문의 상세 조회
    // Inquiry getInquiryById(int inquiryId);

    // TODO: 문의 답변 등록 (관리자/중개사용)
    // int answerInquiry(int inquiryId, String answer);

    // TODO: 중개사가 받은 문의 조회
    // List<Inquiry> getRealtorInquiries(String realtorId);

    // TODO: 관리자가 받은 문의 조회
    // List<Inquiry> getAdminInquiries();
}
