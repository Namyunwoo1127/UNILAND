package com.elon.boot.domain.community.notice.model.service;

import java.util.List;
import java.util.Map;

import com.elon.boot.controller.dto.notice.NoticeInsertRequest;
import com.elon.boot.controller.dto.notice.NoticeUpdateRequest;
import com.elon.boot.domain.community.notice.model.vo.Notice;

public interface NoticeService {
	/**
     * 전체 공지사항 개수 조회
     */
    int getTotalCount();
    
    /**
     * 공지사항 목록 조회 (페이징)
     */
    List<Notice> selectList(int currentPage, int boardCountPerPage);
    
    /**
     * 검색 결과 전체 개수 조회
     */
    int getTotalCount(Map<String, Object> searchMap);
    
    /**
     * 공지사항 검색 목록 조회
     */
    List<Notice> selectSearchList(Map<String, Object> searchMap);
    
    /**
     * 공지사항 상세 조회 (조회수 증가)
     */
    Notice selectOneByNo(int noticeNo);
    
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
