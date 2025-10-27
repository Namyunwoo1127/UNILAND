package com.elon.boot.domain.property.model.service.impl;

import com.elon.boot.controller.dto.property.OptionAddRequest;
import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.store.OptionMapper;
import com.elon.boot.domain.property.model.store.PropertyMapper;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.realtor.model.vo.Realtor;
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
    public Long register(PropertyAddRequest pReq,
            OptionAddRequest oReq,
            List<MultipartFile> images,
            String realtorId) {

// 1) 세션값 주입 후 매물 INSERT (selectKey가 DTO pReq.propertyNo에 꽂힘)
pReq.setRealtorId(realtorId);
propertyMapper.insertProperty(pReq);

// 2) PK는 INSERT "직후" 꺼내고, 메서드 전체에서 쓸 수 있도록 같은 스코프에 선언
final Long propNo = pReq.getPropertyNo();
if (propNo == null) {
throw new IllegalStateException("propertyNo null (selectKey 매핑/parameterType 확인)");
}

// 3) 옵션 INSERT (FK 세팅)
oReq.setPropertyNo(propNo);
optionMapper.insertOption(oReq);

// 4) 이미지 INSERT (FK 세팅 + 파일 저장)
if (images != null && !images.isEmpty()) {
// uploadRoot 설정 확인
if (uploadRoot == null || uploadRoot.trim().isEmpty()) {
   throw new IllegalStateException("file.upload-dir 설정이 없습니다. application.properties를 확인하세요.");
}

// 업로드 디렉토리 생성 및 확인
File uploadDir = new File(uploadRoot, "property");
if (!uploadDir.exists()) {
   boolean created = uploadDir.mkdirs();
   if (!created) {
       throw new RuntimeException("업로드 디렉토리 생성 실패: " + uploadDir.getAbsolutePath());
   }
}

List<PropertyImg> imgList = new ArrayList<>();
for (int i = 0; i < images.size(); i++) {
   MultipartFile image = images.get(i);
   if (image == null || image.isEmpty()) continue;

   String original = image.getOriginalFilename();
   String rename   = Util.fileRename(original);

   PropertyImg img = new PropertyImg();
   img.setPropertyNo(propNo);                     // ★ 같은 스코프의 propNo 사용
   img.setImgOrder(i);
   img.setImgOriginalName(original);
   img.setImgRename(rename);
   img.setImgPath("/images/property/" + rename);  // 리소스 매핑 경로와 일치시키기
   imgList.add(img);

   File target = new File(uploadDir, rename);
   try {
       image.transferTo(target);
   } catch (IOException | IllegalStateException e) {
       throw new RuntimeException("이미지 저장 실패: " + original + " (경로: " + target.getAbsolutePath() + ")", e);
   }
}
if (!imgList.isEmpty()) {
   propertyMapper.insertPropertyImages(imgList);
}
}

// 5) 반환도 propNo 사용 (new Property().getPropertyNo() 사용 금지)
return propNo;
}

	@Override
	public Property selectOneByNo(Long id) {
		return propertyMapper.selectOneByNo(id);
		
	}

	@Override
	public PropertyOption selectOnesOption(Long id) {
		return optionMapper.selectOnesOption(id);
	}

	@Override
	public List<PropertyImg> selectOnesImgs(Long id) {
		List<PropertyImg> imgs = propertyMapper.selectImagesByPropertyNo(id);
		return imgs;
	}

	@Override
	public Realtor selectRealtorById(String rId) {
		return propertyMapper.selectRealtorById(rId);
	}

	@Override
	public List<Property> getAllProperties() {
		return propertyMapper.selectAllProperties();
	}

}
