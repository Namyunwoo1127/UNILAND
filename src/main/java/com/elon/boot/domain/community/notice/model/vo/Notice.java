package com.elon.boot.domain.community.notice.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	private int noticeNo;
    private String userId;
    private String noticeSubject;
    private String noticeContent;
    private String noticeWriter;
    private Timestamp noticeCreateAt;
    private String noticeImportant;
    private String noticeIsNew;
    private int viewCount;
    private String deleteYn;
    
    // JSP에서 사용하는 computed 속성들
    public boolean isImportant() {
        return "Y".equals(this.noticeImportant);
    }
    
    public boolean isNew() {
        return "Y".equals(this.noticeIsNew);
    }
}
