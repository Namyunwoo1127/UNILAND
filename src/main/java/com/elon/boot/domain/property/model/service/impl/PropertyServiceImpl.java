package com.elon.boot.domain.property.model.service.impl;

import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.store.OptionMapper;
import com.elon.boot.domain.property.model.store.PropertyMapper;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class PropertyServiceImpl implements PropertyService {

    private final PropertyMapper propertyMapper;
    private final OptionMapper optionMapper;

    private String yn(String v) { return (v != null && v.equalsIgnoreCase("Y")) ? "Y" : "N"; }

    @Transactional
    @Override
    public Long register(PropertyAddRequest r, String realtorId) {
        // PROPERTY_TBL
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

        // OPTION_TBL
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
        return p.getPropertyNo();
    }
}