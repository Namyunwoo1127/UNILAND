package com.elon.boot.domain.admin.model.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.controller.dto.admin.Dashboard;
import com.elon.boot.controller.dto.admin.RealtorApproval;
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

	@Override
	public Dashboard getDashboardData() {
		Dashboard dashboard = new Dashboard();
        
        try {
            // 총 일반 회원 수
        	dashboard.setTotalUsers(adminMapper.countTotalUsers());
        	
        	// 총 중개사 회원 수
        	dashboard.setTotalRealtors(adminMapper.countTotalRealtors());
            
            // 총 매물 수 (PROPERTY_TBL이 없으면 0으로 설정)
            try {
                dashboard.setTotalProperties(adminMapper.countTotalProperties());
            } catch (Exception e) {
                log.warn("매물 테이블이 존재하지 않습니다: {}", e.getMessage());
                dashboard.setTotalProperties(0);
            }
            
            // 미처리 문의 수 (INQUIRY_TBL이 없으면 0으로 설정)
            try {
                dashboard.setPendingInquiries(adminMapper.countPendingInquiries());
            } catch (Exception e) {
                log.warn("문의 테이블이 존재하지 않습니다: {}", e.getMessage());
                dashboard.setPendingInquiries(0);
            }
            
            // 일별 신규 회원 통계 (최근 한 달)
            List<Map<String, Object>> dailyStats = adminMapper.selectDailyUserStats(30);
            List<String> labels = new ArrayList<>();
            List<Integer> data = new ArrayList<>();
            
            for (Map<String, Object> stat : dailyStats) {
                labels.add((String) stat.get("DATE"));
                data.add(((Number) stat.get("COUNT")).intValue());
            }
            
            dashboard.setDailyLabels(labels);
            dashboard.setDailyUserData(data);
            
            // 최근 공지사항 5개
            dashboard.setRecentNotices(adminMapper.selectRecentNotices(5));
            
            log.debug("대시보드 데이터 조회 완료");
            
        } catch (Exception e) {
            log.error("대시보드 데이터 조회 실패: ", e);
        }
        
        return dashboard;
    }

	@Override
	public RealtorApproval getRealtorApprovalData() {
		List<Realtor> pendingRealtors = adminMapper.selectRealtorsByStatus("PENDING");
        List<Realtor> approvedRealtors = adminMapper.selectRealtorsByStatus("APPROVAL");
        List<Realtor> rejectedRealtors = adminMapper.selectRealtorsByStatus("REJECTED");
        
        log.debug("중개사 승인 데이터 조회: 대기 {} 건, 승인 {} 건, 거부 {} 건",
            pendingRealtors.size(), approvedRealtors.size(), rejectedRealtors.size());
        
        return new RealtorApproval(pendingRealtors, approvedRealtors, rejectedRealtors);
	}

	@Override
	public int approveRealtor(String realtorId) {
		Map<String, Object> params = new HashMap<>();
        params.put("realtorId", realtorId);
        params.put("approvalStatus", "APPROVAL");
        params.put("status", "ACTIVE");
        
        log.debug("중개사 승인 처리: {}", realtorId);
        return adminMapper.updateRealtorApprovalStatus(params);
	}

	@Override
	public int rejectRealtor(String realtorId) {
		Map<String, Object> params = new HashMap<>();
        params.put("realtorId", realtorId);
        params.put("approvalStatus", "REJECTED");
        params.put("status", "INACTIVE");
        
        log.debug("중개사 거부 처리: {}", realtorId);
        return adminMapper.updateRealtorApprovalStatus(params);
	}

	@Override
	public int cancelApproval(String realtorId) {
		Map<String, Object> params = new HashMap<>();
        params.put("realtorId", realtorId);
        params.put("approvalStatus", "PENDING");
        params.put("status", "INACTIVE");
        
        log.debug("중개사 승인 취소: {}", realtorId);
        return adminMapper.updateRealtorApprovalStatus(params);
	}

	@Override
	public Realtor getRealtorById(String realtorId) {
		return adminMapper.selectRealtorById(realtorId);
	}

}
