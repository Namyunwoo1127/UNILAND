package com.elon.boot.domain.inquiry.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.elon.boot.domain.inquiry.model.store.InquiryMapper;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;

import lombok.RequiredArgsConstructor;

/**
 * 문의 서비스 구현
 */
@Service
@RequiredArgsConstructor
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper;

    // TODO: 서비스 메서드 구현

}
