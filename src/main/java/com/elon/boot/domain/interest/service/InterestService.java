package com.elon.boot.domain.interest.service;

import com.elon.boot.domain.interest.vo.Interest;

public interface InterestService {

	int countFavorites(Long propertyNo);

	boolean isFavorited(Interest interest);

	boolean toggle(Interest interest);

}
