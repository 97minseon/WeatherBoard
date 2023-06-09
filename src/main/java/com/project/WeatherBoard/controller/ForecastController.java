package com.project.WeatherBoard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.WeatherBoard.domain.ForecastDTO;
import com.project.WeatherBoard.mapper.ForecastPointMapper;
import com.project.WeatherBoard.service.ForecastPointService;

import lombok.Setter;

@Controller
public class ForecastController {
	
	@Setter(onMethod_=@Autowired)
	private ForecastPointMapper f_mapper;
	@Setter(onMethod_=@Autowired)
	private ForecastPointService f_service;
	
	@GetMapping("/main")
	public void main(Model model) {
		List<String>mainAddressList = f_mapper.searchByMainAddress();
		System.out.println(mainAddressList);
		model.addAttribute("mainAddressList", mainAddressList);
	}
	
	@GetMapping(value = "address",produces = "application/json")
	public ResponseEntity<List<String>> addr(String address){
		List<String> midddleAddeerssList = f_mapper.searchByMiddleAddress(address);
		System.out.println(address);
		return new ResponseEntity<List<String>>(midddleAddeerssList,HttpStatus.OK);
	}

	

    
	//기상 데이터 가져오기
	@GetMapping(value="/getWeatherData",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String getWeatherData(ForecastDTO dto){
		return f_service.getForecastData(dto);	
	}
}