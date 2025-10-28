package com.elon.boot.domain.property.model.service;

import java.util.List;
import java.util.Map; // Map 사용을 위해 추가

import org.springframework.web.multipart.MultipartFile;

import com.elon.boot.controller.dto.property.OptionAddRequest;
import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.controller.dto.property.PropertyFilterRequest;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.realtor.model.vo.Pagination; // Pagination 사용을 위해 추가 (가정)

public interface PropertyService {

    Long register(PropertyAddRequest req,OptionAddRequest oReq,List<MultipartFile> images, String realtorId);

	Property selectOneByNo(Long id);

	PropertyOption selectOnesOption(Long id);

	public List<PropertyImg> selectOnesImgs(Long id);

	Realtor selectRealtorById(String rId);

	List<Property> getAllProperties();

	List<Property> getFilteredProperties(PropertyFilterRequest filter);

    // =========================================================================
    // ⭐ RealtorController 매물 관리를 위해 추가된 메소드
    // =========================================================================

    /**
     * 중개사 ID 기준으로 매물 상태별 통계를 조회합니다.
     * (예: {ALL_COUNT: 10, ACTIVE_COUNT: 5, RESERVED_COUNT: 3, COMPLETED_COUNT: 2})
     * @param realtorId 중개사 ID
     * @return 상태별 카운트가 담긴 Map
     */
    Map<String, Integer> getPropertyStatsByRealtor(String realtorId);

    /**
     * 중개사의 필터/검색 조건에 맞는 전체 매물 개수를 조회합니다. (페이징을 위해 필요)
     * @param filterParams 필터/검색 조건 (realtorId 포함)
     * @return 매물 총 개수
     */
    int getPropertyCount(Map<String, String> filterParams);
    
    /**
     * 중개사의 필터/검색 조건 및 페이징 정보에 맞는 매물 목록을 조회합니다.
     * @param filterParams 필터/검색 조건 (realtorId 포함)
     * @param pager 페이징 정보
     * @return 매물 목록
     */
    List<Property> selectPropertyList(Map<String, String> filterParams, Pagination pager);

    /**
     * 특정 매물의 상태를 변경합니다.
     * @param propertyNo 변경할 매물 번호
     * @param newStatus 새로운 상태 코드 (ACTIVE, RESERVED, COMPLETED)
     * @return 성공 여부 (1: 성공, 0: 실패)
     */
    int updatePropertyStatus(int propertyNo, String newStatus);

    /**
     * 특정 매물을 삭제합니다. (중개사 소유권 확인 로직 포함)
     * @param propertyNo 삭제할 매물 번호
     * @param realtorId 매물을 삭제하려는 중개사 ID (소유권 확인용)
     * @return 성공 여부 (1: 성공, 0: 실패)
     */
    int deleteProperty(int propertyNo, String realtorId);

    /**
     * 매물 번호로 특정 매물 정보를 조회합니다.
     * @param propertyNo 매물 번호
     * @return 매물 정보
     */
    Property selectPropertyById(int propertyNo);

    /**
     * 매물 번호로 해당 매물의 옵션 목록을 조회합니다.
     * @param propertyNo 매물 번호
     * @return 옵션 목록
     */
    List<PropertyOption> selectPropertyOptions(int propertyNo);

    /**
     * 매물 번호로 해당 매물의 이미지 목록을 조회합니다.
     * @param propertyNo 매물 번호
     * @return 이미지 목록
     */
    List<PropertyImg> selectPropertyImages(int propertyNo);

    /**
     * 매물 정보를 수정합니다.
     * @param params 수정할 매물 정보 (propertyNo, status, propertyName, deposit, monthlyRent, maintenanceFee, availableDate, description, realtorId 포함)
     * @return 성공 여부 (1: 성공, 0: 실패)
     */
    int updateProperty(Map<String, Object> params);

}