package com.elon.boot.domain.community.guide.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuideComment {
    private int commentId; 
    private int guideNo;   
    private String userId;  
    private String content;   
    private Date createdAt; 
    private String deleteYn;
}
