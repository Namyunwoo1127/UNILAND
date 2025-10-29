package com.elon.boot.domain.admin.model.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.user.model.vo.User;

@Mapper
public interface AdminMapper {

	List<Notice> selectAllNotices();

	List<User> selectAllUsers();

	List<Realtor> selectAllRealtors();

	int deleteUser(String userId);

	int deleteRealtor(String realtorId);

	int countTotalUsers();

	int countTotalProperties();

	List<Map<String, Object>> selectDailyUserStats(int i);

	int countPendingInquiries();

	List<Notice> selectRecentNotices(int i);

	int countTotalRealtors();

	List<Realtor> selectRealtorsByStatus(String string);

	int updateRealtorApprovalStatus(Map<String, Object> params);

	Realtor selectRealtorById(String realtorId);

}
