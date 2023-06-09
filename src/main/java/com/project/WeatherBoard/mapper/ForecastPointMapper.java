package com.project.WeatherBoard.mapper;

import java.util.List;

public interface ForecastPointMapper {

	public List<String> searchByMainAddress();		// 지역 대분류
	public List<String> searchByMiddleAddress(String address);	// 지역 중분류
}
