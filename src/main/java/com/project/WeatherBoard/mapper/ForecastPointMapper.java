package com.project.WeatherBoard.mapper;

import java.util.List;

public interface ForecastPointMapper {

	public List<String> searchByMainAddress();		// ���� ��з�
	public List<String> searchByMiddleAddress(String address);	// ���� �ߺз�
}
