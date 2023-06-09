package com.project.WeatherBoard.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.WeatherBoard.domain.ForecastDTO;
import com.project.WeatherBoard.service.ForecastPointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ForecastTest {
	
	@Setter(onMethod_=@Autowired)
	private ForecastPointService service;
	
		@Test
		public void getForecastTest() {
			ForecastDTO dto = new ForecastDTO();
			
			dto.setAddress("서울특별시");
			dto.setAddress_detail("용산구");
			service.getForecastData(dto);
		}
		
}
