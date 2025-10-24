package com.elon.boot.domain.inquiry.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.domain.inquiry.model.store.InquiryMapper;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 문의 서비스 구현
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper;
    
    @Override
    public List<Inquiry> getMyInquiries(String userId) {
        return inquiryMapper.selectInquiriesByUserId(userId);
    }

	@Override
	@Transactional
	public int createInquiry(Inquiry inquiry) {
		return inquiryMapper.insertInquiry(inquiry);
	}

	@Override
	public Inquiry getInquiryById(Integer inquiryId) {
		return inquiryMapper.selectInquiryById(inquiryId);
	}

	@Override
    @Transactional
    public int deleteInquiry(Integer inquiryId) {
        return inquiryMapper.deleteInquiry(inquiryId);
    }

	@Override
    public List<Inquiry> getAllInquiries() {
        return inquiryMapper.selectAllInquiriesForAdmin();
    }
	
	@Override
    @Transactional
    public int answerInquiry(Integer inquiryId, String answer) {
        Map<String, Object> params = new HashMap<>();
        params.put("inquiryId", inquiryId);
        params.put("answer", answer);
        
        return inquiryMapper.updateInquiryAnswer(params);
    }
}
