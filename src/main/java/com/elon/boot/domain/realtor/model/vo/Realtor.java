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
    
    // private String profileImage; // 주석 처리 유지

    private Timestamp createdAt;
    private Timestamp updatedAt;
    // private String status; // ⚠️ 삭제
    private String deleteYn;       // ✅ 추가: DELETE_YN 컬럼 매핑
    private String approvalStatus;
}