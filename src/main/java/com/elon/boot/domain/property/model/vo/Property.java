package com.elon.boot.domain.property.model.vo;

import lombok.*;
import java.sql.Timestamp;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Property {
    private Long propertyNo;
    private String realtorId;
    private String userId;

    private String propertyName;
    private String propertyType;

    private Integer room;
    private Integer bathroom;
    private Integer floor;
    private Integer totalFloor;
    private String studentPref;     // Y/N
    private String shortCont;       // Y/N
    private String constructionYear;
    private String availableDate;
    
    private String priceType;
    private Integer deposit;
    private Integer monthlyRent;
    private Integer maintenanceFee;
    private String maintenanceIncl; // Y/N

    private String roadAddress;
    private String parcelAddress;
    private String addressDetail;
    private String province;
    private String district;

    private Double latitude;
    private Double longitude;

    private Double contractArea;

    private String description;
    private String contractStatus;
    private Timestamp contractAt;

    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp deletedAt;
}