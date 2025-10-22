package com.elon.boot.domain.admin.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.controller.dto.admin.UserManagement;
import com.elon.boot.domain.admin.model.service.AdminService;
import com.elon.boot.domain.admin.model.store.AdminMapper;
import com.elon.boot.domain.community.notice.model.service.impl.NoticeServiceImpl;
import com.elon.boot.domain.community.notice.model.store.NoticeMapper;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class AdminServiceImpl implements AdminService {
	
	private final AdminMapper adminMapper;


	@Override
	public List<Notice> getAllNotices() {
		try {
            List<Notice> noticeList = adminMapper.selectAllNotices();
            log.debug("공지사항 조회 성공: {} 건", noticeList != null ? noticeList.size() : 0);
            return noticeList;
        } catch (Exception e) {
            log.error("공지사항 조회 실패: ", e);
            throw e;
        }
	}

	@Override
	public UserManagement getUserManagementData() {
		List<User> userList = adminMapper.selectAllUsers();
        List<Realtor> realtorList = adminMapper.selectAllRealtors();
        
        log.debug("회원 목록 조회: {} 건", userList.size());
        log.debug("중개사 목록 조회: {} 건", realtorList.size());
        
        return new UserManagement(userList, realtorList);
	}

	@Override
	public int deleteUser(String userId) {
		return adminMapper.deleteUser(userId);
	}

	@Override
	public int deleteRealtor(String realtorId) {
		return adminMapper.deleteRealtor(realtorId);
	}

}
