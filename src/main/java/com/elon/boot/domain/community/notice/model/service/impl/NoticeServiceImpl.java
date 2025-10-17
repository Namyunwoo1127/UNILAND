package com.elon.boot.domain.community.notice.model.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.controller.dto.notice.NoticeInsertRequest;
import com.elon.boot.controller.dto.notice.NoticeUpdateRequest;
import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.store.NoticeMapper;
import com.elon.boot.domain.community.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	
	private final NoticeMapper nMapper;
    
	@Override
    public int getTotalCount() {
        int totalCount = nMapper.getTotalCount();
        return totalCount;
    }

    @Override
    public List<Notice> selectList(int currentPage, int boardCountPerPage) {
        int offset = (currentPage - 1) * boardCountPerPage;
        RowBounds rowBounds = new RowBounds(offset, boardCountPerPage);
        List<Notice> nList = nMapper.selectNoticeList(rowBounds);
        return nList;
    }

    @Override
    public int getTotalCount(Map<String, Object> searchMap) {
        int totalCount = nMapper.getSearchTotalCount(searchMap);
        return totalCount;
    }

    @Override
    public List<Notice> selectSearchList(Map<String, Object> searchMap) {
        int currentPage = (int) searchMap.get("currentPage");
        int boardLimit = (int) searchMap.get("boardLimit");
        int offset = (currentPage - 1) * boardLimit;
        RowBounds rowBounds = new RowBounds(offset, boardLimit);
        List<Notice> searchList = nMapper.selectSearchList(searchMap, rowBounds);
        return searchList;
    }

    @Override
    @Transactional
    public Notice selectOneByNo(int noticeNo) {
        // 조회수 증가
        nMapper.updateViewCount(noticeNo);
        // 공지사항 조회
        Notice notice = nMapper.selectOneByNo(noticeNo);
        return notice;
    }

    @Override
    public int insertNotice(NoticeInsertRequest notice) {
        int result = nMapper.insertNotice(notice);
        return result;
    }

    @Override
    public int updateNotice(NoticeUpdateRequest notice) {
        int result = nMapper.updateNotice(notice);
        return result;
    }

    @Override
    public int deleteNotice(int noticeNo) {
        int result = nMapper.deleteNotice(noticeNo);
        return result;
    }
}
