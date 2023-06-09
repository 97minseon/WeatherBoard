package com.project.WeatherBoard.mapper;

import com.project.WeatherBoard.domain.ForecastDTO;

public interface ForecastPointMapper {
	
	public ForecastDTO getForecastData(ForecastDTO dto);

}
