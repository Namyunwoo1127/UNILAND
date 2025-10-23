package com.elon.boot.domain.realtor.model.vo;

import java.sql.Timestamp;
import lombok.Data;
import lombok.NoArgsConstructor; // ⭐ 추가
import lombok.AllArgsConstructor; // ⭐ 추가

@Data
@NoArgsConstructor // ⭐ 기본 생성자 자동 생성
@AllArgsConstructor // ⭐ 모든 필드를 포함하는 생성자 자동 생성
public class Realtor {
    private String realtorId;
    private String realtorPassword;
    private String officeName;
    private String realtorName;
    private String realtorAddress;
    private String realtorPhone;
    private String realtorEmail;
    private String businessNum;
    
    // ✅ 추가: 프로필 이미지 파일명을 저장할 필드
    private String realtorImage; 
    
    // ⭐ 추가: 중개사 등록번호 필드
    private String realtorRegNum; 

    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    private String deleteYn;
    
    // ⭐ 이미 APPROVAL_STATUS 컬럼에 매핑되는 필드가 존재
    private String approvalStatus; 
}