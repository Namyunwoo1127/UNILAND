package com.elon.boot.domain.inquiry.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 문의 VO
 * - 중개사 문의 (INQUIRY_TYPE = 'REALTOR')
 * - 관리자 문의 (INQUIRY_TYPE = 'ADMIN')
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Inquiry {

    private int inquiryId;              // 문의 ID (PK)
    private String userId;              // 문의자 ID
    private String inquiryType;         // 문의 타입: 'REALTOR' 또는 'ADMIN'
    private String category;            // 관리자 문의 카테고리: '일반문의', '건의사항', '허위매물신고', '기타'
    private Integer propertyId;         // 매물 ID (중개사 문의 또는 허위매물 신고 시 필수)
    private String realtorId;           // 중개사 ID (중개사 문의 시 필수)
    private String title;               // 문의 제목
    private String content;             // 문의 내용
    private String status;              // 문의 상태: 'PENDING', 'ANSWERED'
    private String answer;              // 답변 내용
    private Date createdAt;             // 문의 작성일
    private Date answeredAt;            // 답변 작성일
    private String userName;			// 문의자 이름
    private String deleteYn;            // 삭제 여부 (Y/N)
    private String usersPhone;		   	// 문의자 휴대폰 번호

    // TODO: 필요시 추가 필드 정의
    // - userName (조인용)
    // - propertyTitle (조인용)
    // - realtorName (조인용)
}
