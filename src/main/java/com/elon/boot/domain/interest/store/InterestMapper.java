package com.elon.boot.domain.interest.store;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.domain.interest.vo.Interest;

@Mapper
public interface InterestMapper {

    Interest findByUserAndProperty(Interest interest);
    int insertFavorite(Interest interest);
    int toggleFavorite(Interest interest);
    int updateSetFavorite(Interest interest);
    int countFavoritesOfProperty(Long propertyNo);
}
