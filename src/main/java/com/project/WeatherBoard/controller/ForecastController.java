package com.project.WeatherBoard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.WeatherBoard.mapper.ForecastPointMapper;

import lombok.Setter;

@Controller
public class ForecastController {
	
	@Setter(onMethod_=@Autowired)
	ForecastPointMapper f_mapper;
	
	@GetMapping("main")
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
	
	
    

}
