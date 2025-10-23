package com.elon.boot.domain.admin.model.store;

import java.util.List;

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


}
