package com.elon.boot.domain.realtor.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Realtor {
    private String realtorId;        // VARCHAR2 PK, 로그인용 ID
    private String realtorPassword;  // VARCHAR2, 로그인용 비밀번호
    private String officeName;       // 사무실 이름
    private String realtorName;      // 이름
    private String realtorAddress;   // 주소
    private String realtorPhone;     // 전화번호
    private String realtorEmail;     // 이메일
    private String businessNum;      // 사업자등록번호
    private LocalDateTime createdAt; // 생성일
    private LocalDateTime updatedAt; // 수정일
}
