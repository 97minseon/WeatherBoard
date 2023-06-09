package com.project.WeatherBoard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.WeatherBoard.domain.ForecastDTO;
import com.project.WeatherBoard.service.ForecastPointService;

import lombok.Setter;

@Controller
public class ForecastController {
	
	@Setter(onMethod_=@Autowired)
	private ForecastPointService f_service;
	
	@GetMapping("/main")
	public void main() {
		
	}
    
	//단기예보 예보발표 3시간주기 "0500"기준
	@GetMapping(value="/getWeatherData",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String getWeatherData(ForecastDTO dto){
		return f_service.getForecastData(dto);	
	}
}