package com.elon.boot.domain.community.notice.model.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.elon.boot.controller.dto.notice.NoticeInsertRequest;
import com.elon.boot.controller.dto.notice.NoticeUpdateRequest;
import com.elon.boot.domain.community.notice.model.vo.Notice;

@Mapper
public interface NoticeMapper {
	/**
     * 전체 공지사항 개수 조회
     */
    int getTotalCount();
    
    /**
     * 공지사항 목록 조회 (페이징)
     */
    List<Notice> selectNoticeList(RowBounds rowBounds);
    
    /**
     * 검색 결과 전체 개수 조회
     */
    int getSearchTotalCount(Map<String, Object> searchMap);
    
    /**
     * 공지사항 검색 목록 조회
     */
    List<Notice> selectSearchList(Map<String, Object> searchMap, RowBounds rowBounds);
    
    /**
     * 공지사항 상세 조회
     */
    Notice selectOneByNo(int noticeNo);
    
    /**
     * 조회수 증가
     */
    int updateViewCount(int noticeNo);
    
    /**
     * 공지사항 등록
     */
    int insertNotice(NoticeInsertRequest notice);
    
    /**
     * 공지사항 수정
     */
    int updateNotice(NoticeUpdateRequest notice);
    
    /**
     * 공지사항 삭제 (DELETE_YN = 'Y')
     */
    int deleteNotice(int noticeNo);
}
