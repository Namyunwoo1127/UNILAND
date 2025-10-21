package com.elon.boot.domain.community.guide.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.elon.boot.domain.community.guide.model.service.GuideCommentService;
import com.elon.boot.domain.community.guide.model.store.GuideCommentMapper;
import com.elon.boot.domain.community.guide.model.vo.GuideComment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GuideCommentImpl implements GuideCommentService{
	
	private final GuideCommentMapper cStore;

	@Override
	public List<GuideComment> getCommentsByGuideNo(int guideNo) {
		return cStore.selectCommentsByGuideNo(guideNo);
	}

	@Override
	public int addComment(GuideComment comment) {
		int result = cStore.insertComment(comment);
	    
	    // 댓글 작성 성공 시 가이드의 댓글 수 증가
	    if (result > 0) {
	        cStore.updateCommentCount(comment.getGuideNo(), 1);
	    }
	    
	    return result;
		
	}

	@Override
	public int deleteComment(int commentId, String userId) {
		// 댓글 정보 먼저 조회
	    GuideComment comment = cStore.selectCommentById(commentId);
	    
	    // 댓글 삭제
	    int result = cStore.deleteComment(commentId, userId);
	    
	    // 댓글 삭제 성공 시 가이드의 댓글 수 감소
	    if (result > 0 && comment != null) {
	        cStore.updateCommentCount(comment.getGuideNo(), -1);
	    }
	    
	    return result;
	}

}
