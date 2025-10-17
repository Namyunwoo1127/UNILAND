package com.elon.boot.domain.community.guide.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Guide {
	private int guideNo;
//	private String userId;
	private String guideCategory;
	private String guideTitle;
	private String guideContent;
	private int viewCount;
	private int likeCount;
	private int commentCount;
	private String isHot;
	private Timestamp writeDate;
	private Timestamp updateDate;
	private String deleteYn;
}
