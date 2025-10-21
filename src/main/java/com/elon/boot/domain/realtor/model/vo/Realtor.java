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
    private Timestamp createdAt;
    private String status;
    private String approvalStatus;
}
