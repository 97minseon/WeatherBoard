package com.project.WeatherBoard.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.WeatherBoard.domain.ForecastDTO;
import com.project.WeatherBoard.mapper.ForecastPointMapper;

import lombok.Setter;

@Service
public class ForecastPointServiceImpl implements ForecastPointService {

	@Setter(onMethod_=@Autowired)
	ForecastPointMapper f_mapper;
	
	@Override
	public List<String> searchByMainAddress() {
		return f_mapper.searchByMainAddress();
	}

	@Override
	public List<String> searchByMiddleAddress(String address) {
		return f_mapper.searchByMiddleAddress(address);
	}
	
	public String getWeatherData(ForecastDTO dto) {
		
		//날짜설정
		LocalDate nowDay = LocalDate.now();
		DateTimeFormatter dtfd = DateTimeFormatter.ofPattern("yyyyMMdd");
		String forecast_day = dtfd.format(nowDay);
		dto.setForecast_day(forecast_day);
		
		//시간설정
		LocalTime nowTime = LocalTime.now();
		
		if(nowTime.isAfter(LocalTime.of(2,0,0)) && nowTime.isBefore(LocalTime.of(5,0,0))) {
			dto.setForecast_time("0200");
		}else if(nowTime.isAfter(LocalTime.of(5,0,0)) && nowTime.isBefore(LocalTime.of(8,0,0))) {
			dto.setForecast_time("0500");
		}else if(nowTime.isAfter(LocalTime.of(8,0,0)) && nowTime.isBefore(LocalTime.of(11,0,0))) {
			dto.setForecast_time("0800");
		}else if(nowTime.isAfter(LocalTime.of(11,0,0)) && nowTime.isBefore(LocalTime.of(14,0,0))) {
			dto.setForecast_time("1100");
		}else if(nowTime.isAfter(LocalTime.of(14,0,0)) && nowTime.isBefore(LocalTime.of(17,0,0))) {
			dto.setForecast_time("1400");
		}else if(nowTime.isAfter(LocalTime.of(17,0,0)) && nowTime.isBefore(LocalTime.of(20,0,0))) {
			dto.setForecast_time("1700");
		}else if(nowTime.isAfter(LocalTime.of(20,0,0)) && nowTime.isBefore(LocalTime.of(23,0,0))) {
			dto.setForecast_time("2000");
		}else {
			dto.setForecast_time("2300");
		}
		
		try {
			StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
		    urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=gENxVbgt5rfdsK9z71GmdcHPzVcOc7BNuu7ZRXwo2bRzaixy7CHzML78MD%2FzFw0uU0pF1RNCrsTkm0c32uY5mA%3D%3D"); /*Service Key*/
		    urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		    urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); /*한 페이지 결과 수*/
		    urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
		    urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(dto.getForecast_day(), "UTF-8")); /*발표 날짜*/
		    urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(dto.getForecast_time(), "UTF-8")); /*발표 시각*/
		    urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(dto.getX_point(), "UTF-8")); /*예보지점의 X 좌표값*/
		    urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(dto.getY_point(), "UTF-8")); /*예보지점의 Y 좌표값*/
		    URL url = new URL(urlBuilder.toString());
		    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		    conn.setRequestMethod("GET");
		    conn.setRequestProperty("Content-type", "application/json");
		    System.out.println("Response code: " + conn.getResponseCode());
		    BufferedReader rd;
		    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		    } else {
		        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		    }
		    StringBuilder sb = new StringBuilder();
		    String line;
		    while ((line = rd.readLine()) != null) {
		        sb.append(line);
		    }
		    rd.close();
		    conn.disconnect();
		    return sb.toString();
		}catch(Exception e) {
			e.printStackTrace();
			return "기상청 api 오류발생";
		}
	}
	
	@Override
	public String getForecastData(ForecastDTO dto) {
		
		return getWeatherData(f_mapper.getForecastData(dto));
		
	}

}
