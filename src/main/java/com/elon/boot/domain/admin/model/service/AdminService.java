package com.elon.boot.domain.admin.model.service;

import java.util.List;

import com.elon.boot.controller.dto.admin.Dashboard;
import com.elon.boot.controller.dto.admin.RealtorApproval;
import com.elon.boot.controller.dto.admin.UserManagement;
import com.elon.boot.domain.community.notice.model.vo.Notice;

public interface AdminService {

	List<Notice> getAllNotices();

	int deleteUser(String userId);

	UserManagement getUserManagementData();

	int deleteRealtor(String realtorId);

	Dashboard getDashboardData();

	RealtorApproval getRealtorApprovalData();

	int approveRealtor(String realtorId);

	int rejectRealtor(String realtorId);

	int cancelApproval(String realtorId);

}
