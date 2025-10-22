package com.elon.boot.domain.realtor.model.vo;

import java.sql.Timestamp;
import lombok.Data;

@Data
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
    private String approvalStatus;
}