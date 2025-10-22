package com.elon.boot.domain.property.model.service.impl;

import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.store.OptionMapper;
import com.elon.boot.domain.property.model.store.PropertyMapper;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

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
    public Long register(PropertyAddRequest r, String realtorId) {
        // ===============================
        // 1️⃣ PROPERTY_TBL 매물 저장
        // ===============================
        Property p = new Property();
        p.setRealtorId(realtorId);
        p.setPropertyName(r.getPropertyName());
        p.setPropertyType(r.getPropertyType());
        p.setPriceType(r.getPriceType());
        p.setDeposit(r.getDeposit());
        p.setMonthlyRent(r.getMonthlyRent());
        p.setMaintenanceFee(r.getMaintenanceFee());
        p.setMaintenanceIncl(r.getMaintenanceIncl());
        p.setRoadAddress(r.getRoadAddress());
        p.setAddressDetail(r.getAddressDetail());
        p.setProvince(r.getProvince());
        p.setDistrict(r.getDistrict());
        p.setLatitude(r.getLatitude());
        p.setLongitude(r.getLongitude());
        p.setContractArea(r.getContractArea());
        p.setRoom(r.getRoom());
        p.setBathroom(r.getBathroom());
        p.setFloor(r.getFloor());
        p.setTotalFloor(r.getTotalFloor());
        p.setConstructionYear(r.getConstructionYear());
        p.setAvailableDate(r.getAvailableDate());
        p.setStudentPref(yn(r.getStudentPref()));
        p.setShortCont(yn(r.getShortCont()));
        p.setDescription(r.getDescription());
        p.setStatus("ACTIVE");

        propertyMapper.insertProperty(p); // selectKey로 PK 채움

        // ===============================
        // 2️⃣ OPTION_TBL 옵션 저장
        // ===============================
        PropertyOption o = new PropertyOption();
        o.setPropertyNo(p.getPropertyNo());
        // 냉난방
        o.setAirConditioner(yn(r.getOptAc()));
        o.setHeater(yn(r.getOptHeater()));
        // 주방
        o.setRefrigerator(yn(r.getOptFridge()));
        o.setMicrowave(yn(r.getOptMicrowave()));
        o.setInduction(yn(r.getOptInduction()));
        o.setGasStove(yn(r.getOptGasRange()));
        // 가구/가전
        o.setWasher(yn(r.getOptWasher()));
        o.setDryer(yn(r.getOptDryer()));
        o.setBed(yn(r.getOptBed()));
        o.setDesk(yn(r.getOptDesk()));
        o.setWardrobe(yn(r.getOptWardrobe()));
        o.setShoeRack(yn(r.getOptShoecloset()));
        o.setTv(yn(r.getOptTv()));
        // 시설
        o.setParking(yn(r.getFacParking()));
        o.setElevator(yn(r.getFacElevator()));
        o.setSecurity(yn(r.getFacSecurity()));
        o.setPetAllowed(yn(r.getFacPet()));

        optionMapper.insertOption(o);

        // ===============================
        // 3️⃣ PROPERTIES_IMG_TBL 이미지 저장 추가
        // ===============================
        if (r.getImages() != null && !r.getImages().isEmpty()) {
            saveImages(p.getPropertyNo(), r.getImages());
        }

        return p.getPropertyNo();
    }

    // ===================================
    // 🖼 이미지 저장 로직
    // ===================================
    private void saveImages(Long propertyNo, List<MultipartFile> images) {
        String dateFolder = LocalDate.now().toString().replace("-", "");
        Path dir = Paths.get(uploadRoot, "property", dateFolder);

        try {
            Files.createDirectories(dir);
        } catch (IOException e) {
            throw new RuntimeException("이미지 저장 폴더 생성 실패: " + dir, e);
        }

        List<Map<String, Object>> rows = new ArrayList<>();
        int order = 0;

        for (MultipartFile file : images) {
            if (file.isEmpty()) continue;

            String original = file.getOriginalFilename();
            String ext = original != null && original.contains(".")
                    ? original.substring(original.lastIndexOf("."))
                    : "";

            String rename = System.currentTimeMillis() + "_" + UUID.randomUUID() + ext;
            Path savePath = dir.resolve(rename);

            try {
                file.transferTo(savePath.toFile());
            } catch (IOException e) {
                throw new RuntimeException("이미지 저장 실패: " + savePath, e);
            }

            String webPath = "/images/property/" + dateFolder + "/" + rename;

            Map<String, Object> imgData = new HashMap<>();
            imgData.put("propertyNo", propertyNo);
            imgData.put("imgPath", webPath);
            imgData.put("imgRename", rename);
            imgData.put("imgOriginalName", original);
            imgData.put("imgOrder", order++);
            rows.add(imgData);
        }

        if (!rows.isEmpty()) {
            propertyMapper.insertPropertyImages(rows);
        }
    }
}
