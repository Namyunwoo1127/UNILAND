package com.elon.boot.domain.community.guide.model.service;

import java.util.List;

import com.elon.boot.domain.community.guide.model.vo.GuideComment;

public interface GuideCommentService {

	List<GuideComment> getCommentsByGuideNo(int guideNo);

	int addComment(GuideComment comment);

	int deleteComment(int commentId, String userId);

}
