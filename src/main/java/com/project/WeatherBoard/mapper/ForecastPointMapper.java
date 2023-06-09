package com.project.WeatherBoard.mapper;

import java.util.List;
import com.project.WeatherBoard.domain.ForecastDTO;

public interface ForecastPointMapper {
	
	public ForecastDTO getForecastData(ForecastDTO dto);

	public List<String> searchByMainAddress();		// ���� ��з�
	public List<String> searchByMiddleAddress(String address);	// ���� �ߺз�
}
