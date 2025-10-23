package com.elon.boot.domain.property.model.service.impl;

import com.elon.boot.controller.dto.property.OptionAddRequest;
import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.store.OptionMapper;
import com.elon.boot.domain.property.model.store.PropertyMapper;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.util.Util;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDate;
import java.util.*;

@Service
@RequiredArgsConstructor
public class PropertyServiceImpl implements PropertyService {

    private final PropertyMapper propertyMapper;
    private final OptionMapper optionMapper;

    @Value("${file.upload-dir}")
    private String uploadRoot; // C:/UploadImage

    private String yn(String v) {
        return (v != null && v.equalsIgnoreCase("Y")) ? "Y" : "N";
    }

    @Transactional
    @Override
    public Long register(PropertyAddRequest pReq, OptionAddRequest oReq,List<MultipartFile> images,String realtorId) {
    	
    	Property p = new Property();
    	pReq.setRealtorId(realtorId);
    	int result = propertyMapper.insertProperty(pReq);
    	result += optionMapper.insertOption(oReq);
//    	//register 코드가 비효율적인듯해서 추후 수정 예정
//    	
//        // ===============================
//        // 1️ PROPERTY_TBL 매물 저장
//        // ===============================
//        p.setRealtorId(realtorId);
//        p.setPropertyName(r.getPropertyName());
//        p.setPropertyType(r.getPropertyType());
//        p.setPriceType(r.getPriceType());
//        p.setDeposit(r.getDeposit());
//        p.setMonthlyRent(r.getMonthlyRent());
//        p.setMaintenanceFee(r.getMaintenanceFee());
//        p.setMaintenanceIncl(r.getMaintenanceIncl());
//        p.setRoadAddress(r.getRoadAddress());
//        p.setAddressDetail(r.getAddressDetail());
//        p.setProvince(r.getProvince());
//        p.setDistrict(r.getDistrict());
//        p.setLatitude(r.getLatitude());
//        p.setLongitude(r.getLongitude());
//        p.setContractArea(r.getContractArea());
//        p.setRoom(r.getRoom());
//        p.setBathroom(r.getBathroom());
//        p.setFloor(r.getFloor());
//        p.setTotalFloor(r.getTotalFloor());
//        p.setConstructionYear(r.getConstructionYear());
//        p.setAvailableDate(r.getAvailableDate());
//        p.setStudentPref(yn(r.getStudentPref()));
//        p.setShortCont(yn(r.getShortCont()));
//        p.setDescription(r.getDescription());
//        p.setStatus("ACTIVE");
//
//        propertyMapper.insertProperty(p); // selectKey로 PK 채움
//
//        // ===============================
//        // 2️ OPTION_TBL 옵션 저장
//        // ===============================
//        PropertyOption o = new PropertyOption();
//        o.setPropertyNo(p.getPropertyNo());
//        // 냉난방
//        o.setAirConditioner(yn(r.getOptAc()));
//        o.setHeater(yn(r.getOptHeater()));
//        // 주방
//        o.setRefrigerator(yn(r.getOptFridge()));
//        o.setMicrowave(yn(r.getOptMicrowave()));
//        o.setInduction(yn(r.getOptInduction()));
//        o.setGasStove(yn(r.getOptGasRange()));
//        // 가구/가전
//        o.setWasher(yn(r.getOptWasher()));
//        o.setDryer(yn(r.getOptDryer()));
//        o.setBed(yn(r.getOptBed()));
//        o.setDesk(yn(r.getOptDesk()));
//        o.setWardrobe(yn(r.getOptWardrobe()));
//        o.setShoeRack(yn(r.getOptShoecloset()));
//        o.setTv(yn(r.getOptTv()));
//        // 시설
//        o.setParking(yn(r.getFacParking()));
//        o.setElevator(yn(r.getFacElevator()));
//        o.setSecurity(yn(r.getFacSecurity()));
//        o.setPetAllowed(yn(r.getFacPet()));
//
//        optionMapper.insertOption(o);

        // ===============================
        // 3️ PROPERTIES_IMG_TBL 이미지 저장 추가
        // ===============================
        List<PropertyImg> imgList = new ArrayList<PropertyImg>();
        Long propNo = p.getPropertyNo();
        for(int i = 0; i < images.size(); i++) {
        	if(images.get(i).getSize() >0) {
        		PropertyImg img = new PropertyImg();
        		img.setImgOrder(i);
        		MultipartFile image = images.get(i);
        		String fileName = image.getOriginalFilename();
        		String fileRename = Util.fileRename(fileName);
        		String filePath ="/image/property/";
				img.setImgOriginalName(fileName);
				img.setImgRename(fileRename);
				img.setImgPath(filePath+fileRename);
				img.setImgeFile(image);
				img.setPropertyNo(propNo);
				imgList.add(img);
        	}
        }
        if(!imgList.isEmpty()) {
        	result +=  propertyMapper.insertPropertyImages(imgList);
        	for(PropertyImg img : imgList) {
        		try {
					img.getImgeFile().transferTo(new File("C:/UploadImage/property/"+img.getImgRename()));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        	}
        }
//        	필요에 따라 getPropertyNo 반환 or result 반환 해야함
        return p.getPropertyNo();
    }

	@Override
	public Property selectOneByNo(Long id) {
		return propertyMapper.selectOneByNo(id);
		
	}

	@Override
	public PropertyOption selectOnesOption(Long id) {
		return propertyMapper.selectOnesOption(id);
	}

	@Override
	public PropertyImg selectOnesImg(Long id) {
		return propertyMapper.selectOnesImg(id);
	}

}
