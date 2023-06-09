<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>weather board</title>
<meta name="description" content="Sufee Admin - HTML5 Admin Template">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="apple-touch-icon" href="apple-icon.png">
<link rel="shortcut icon" href="favicon.ico">
<link rel="stylesheet" href="/resources/vendors/bootstrap/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/vendors/font-awesome/css/font-awesome.min.css"><!-- 확인 후 삭제 -->
<link rel="stylesheet" href="/resources/vendors/themify-icons/css/themify-icons.css">
<link rel="stylesheet" href="/resources/vendors/flag-icon-css/css/flag-icon.min.css">
<link rel="stylesheet" href="/resources/vendors/selectFX/css/cs-skin-elastic.css">
<link rel="stylesheet" href="/resources/vendors/jqvmap/dist/jqvmap.min.css">
<link rel="stylesheet" href="/resources/assets/css/style.css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet'	type='text/css'>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://kit.fontawesome.com/f4f7b7924c.js" crossorigin="anonymous"></script>
</head>
<script>
	$(document).ready(function () {
		$("select[class='address']").change(function () {
			$.ajax({
				url: "/address?address=" + $(this).val(),
				type: "get",
				dateType: "json",
				success: function (result) {
					$(".address_detail").empty();
					$(".address_detail").append("<option selected='selected'>시/군 선택</option>")
					result.forEach(element => {
						if (element == null) element = '전체';
						$(".address_detail").append("<option value='" + element + "'>" + element + "</option>")
					});
				}
			})
		})
	})
    /* x표 y표 시간 */
    const formData = {
      address: "서울특별시",
      address_detail: "",
    };
    $.ajax({
      url: "/getWeatherData",
      type: "GET",
      data: formData,
      success: function (result) {
    	  if(result != "기상청 api 오류발생"){
    		  let items = result.response.body.items.item;
    	        var fcstTime = []; //시간
    	        var tmpData = []; //온도
    	        var rehData = []; //습도
    	        var pcpData = []; //강수
    	        var wsdData = []; //풍속
    	        $.each(items, function (idx, data) {
    	          if (fcstTime.length < 8 || tmpData.length < 8 || rehData.length < 8 || pcpData.length < 8 || wsdData.length < 8) {
    	            if (data.category == "TMP") {
    	              fcstTime.push(data.fcstTime);
    	              tmpData.push(data.fcstValue);
    	            } else if (data.category == "REH") {
    	              rehData.push(data.fcstValue);
    	            } else if (data.category == "PCP") {
    	            	if(data.fcstValue == "강수없음"){
    	            		pcpData.push(0);
    	            	}else{
    	            		pcpData.push(data.fcstValue);
    	            	}
    	            } else if (data.category == "WSD"){
    	          	wsdData.push(data.fcstValue);
    	            }
    	          }
    	        });
    	        makeWidget(fcstTime, tmpData, rehData, pcpData, wsdData);
    	        $(".TMPcount").text(tmpData[0]+"°C");  //온도차트 현재온도표기
    	        $(".REHcount").text(rehData[0]+"%");   //습도차트 현재습도표기
    	        if(pcpData[0] == 0){ 				   //강수차트 현재강수표기
    	        	$(".PCPcount").text("강수없음"); 
    	        }else{
    	        	$(".PCPcount").text(pcpData[0]+"mm");
    	        }
    	        $(".WSDcount").text(wsdData[0]+"m/s"); //풍속차트 현재온도표기
    	  }else{
    		  alert("데이터를 불러오지 못했습니다."); //api에서 데이터 못불러온경우
    	  }
      },
    });
</script>
<body>
	<nav class="navbar navbar-expand-sm navbar-default">
		<div class="navbar-header">
			<a class="navbar-brand" href="./"><img src="/resources/images/다운로드.jpg" alt="Logo"></a>
		</div>
	</nav>
	<div class="content">
		<div class="search_boxes">
			<div class="address_box">
				<select class="address">
					<c:forEach var="mainAddress" items="${mainAddressList}">
						<c:choose>
							<c:when test="${mainAddress == '서울특별시'}">
								<option selected value="${mainAddress}">${mainAddress}</option>
							</c:when>
							<c:otherwise>
								<option value="${mainAddress}">${mainAddress}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<select class="address_detail">
					<option selected="selected">시/군 선택</option>
				</select>
				<a href="#">검색하기</a>
			</div>
		</div>
		
		<div>
			<div class="col-sm-6 col-lg-3">
				<div class="card text-white bg-flat-color-4">
					<div class="card-body pb-20">
						<p class="text-light">기온</p>
						<h4 class="mb-0">
							<span class="TMPcount"></span>
						</h4>
						<div class="watherIcons">
							<i class="fa-solid fa-temperature-high fa-shake fa-2xl" id="watherIcon"></i>
						</div>
						<div class="chart-wrapper px-3" style="height:70px;">
							<canvas id="widgetChart4"></canvas>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-6 col-lg-3">
				<div class="card text-white bg-flat-color-3">
					<div class="card-body pb-20">
						<p class="text-light">습도</p>
						<h4 class="mb-0">
							<span class="REHcount"></span>
						</h4>
						<div class="watherIcons">
							<i class="fa-regular fa-sun fa-bounce fa-2xl " id="watherIcon"></i>
						</div>
						<div class="chart-wrapper px-0" style="height:70px;">
							<canvas id="widgetChart3"></canvas>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-6 col-lg-3">
				<div class="card text-white bg-flat-color-1">
					<div class="card-body pb-20">
						<p class="text-light">강수량</p>
						<h4 class="mb-0">
							<span class="PCPcount"></span>
						</h4>
						<div class="watherIcons">
							<i class="fa-solid fa-cloud-showers-heavy fa-beat fa-2xl" id="watherIcon"></i>
						</div>
						<div class="chart-wrapper px-0" style="height:70px;">
							<canvas id="widgetChart1"></canvas>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-6 col-lg-3">
				<div class="card text-white bg-flat-color-2">
					<div class="card-body pb-20">
						<p class="text-light">바람</p>
						<h4 class="mb-0">
							<span class="WSDcount"></span>
						</h4>
						<div class="watherIcons">
							<i class="fa-solid fa-wind fa-fade fa-2xl" id="watherIcon"></i>
						</div>
						<div class="chart-wrapper px-0" style="height:70px;">
							<canvas id="widgetChart2"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-lg-6">
			<div class="card">
				<div class="card-header">
					<h4>Map</h4>
				</div>
				<div id="map" style="width:840px;height:800px;"></div>
			</div>
		</div>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ddbd7e25ba9f7024f41f738666e3630a"></script>
		<script>
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
				draggable: false,
				center: new kakao.maps.LatLng(36.347119444444445, 127.38656666666667), //지도의 중심좌표.
				level: 13 //지도의 레벨(확대, 축소 정도)
			};

			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		</script>

		<div class="weatherstatus">
			<div class="weather_space">
				<div class="weather-header">
					<strong class="weather-title">하늘 상태</strong>
					<hr>
				</div>
				<div class="weather-body">
					<p class="weather-text">흐림</p>
				</div>
			</div>
			<div class="weather_space">
				<div class="weather-header">
					<strong class="weather-title">최저 기온</strong>
					<hr>
				</div>
				<div class="weather-body">
					<p class="weather-text">15°C</p>
				</div>
			</div>
			<div class="weather_space">
				<div class="weather-header">
					<strong class="weather-title">최고 기온</strong>
					<hr>
				</div>
				<div class="weather-body">
					<p class="weather-text">27°C</p>
				</div>
			</div>

			<div class="donut">
				<div class="donutChart">
					<span class="donut" data-peity='{ "fill": ["#99D683", "#fafafa"]}'>2,6</span>
					<p id="donut-name">초미세먼지</p>
					<p id="donut-status">보통</p>
				</div>
				<div class="donutChart">
					<span class="donut" data-peity='{ "fill": ["#99D683", "#fafafa"]}'>0.52,1.041</span>
					<p id="donut-name">미세먼지</p>
					<p id="donut-status">나가면 뒤짐</p>
				</div>
			</div>
		</div>

		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-sm-3">
							<h4 class="card-title mb-0">Weather Chart</h4>
							<div class="small text-muted">Korea</div>
						</div>
						<!--/.col-->
						<div class="col-sm-6 hidden-sm-down">
							<div class="btn-toolbar float-right" role="toolbar"
								aria-label="Toolbar with button groups">
								<div class="btn-group mr-3" data-toggle="buttons" aria-label="First group">
									<label class="btn btn-outline-secondary">
										<input type="checkbox" name="temperature" id="temperature"> 기온
									</label>
									<label class="btn btn-outline-secondary active">
										<input type="checkbox" name="uv" id="uv"> 자외선
									</label>
									<label class="btn btn-outline-secondary">
										<input type="checkbox" name="raun" id="rain"> 강수량
									</label>
									<label class="btn btn-outline-secondary">
										<input type="checkbox" name="humidity" id="humidity"> 습도
									</label>
								</div>
							</div>
							<div class="btn-toolbar float-right" role="toolbar"
								aria-label="Toolbar with button groups">
								<div class="btn-group mr-3" data-toggle="buttons" aria-label="First group">
									<label class="btn btn-outline-secondary">
										<input type="radio" name="yesterday" id="yesterday"> 오늘
									</label>
									<label class="btn btn-outline-secondary active">
										<input type="radio" name="today" id="today"> 내일
									</label>
									<label class="btn btn-outline-secondary">
										<input type="radio" name="tomorrow" id="tomorrow"> 모레
									</label>
								</div>
							</div>
						</div>
					</div>
					<div class="chart-wrapper mt-2" >
						<canvas id="trafficChart" style="width:100"></canvas>
					</div>
				<div class="precipitation">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>강수형태</th>
							<th>강수확률</th>
							<th>바람</th>
					</thead>
					<tbody>
						<tr>
							<td>눙물</td>
							<td>100%</td>
							<td>태풍</td>
						</tr>
					</tbody>
				</table>
			</div>
				</div>
				<div class="card-footer">
					<ul>
						<li class="hidden-sm-down">
							<div class="text_muted">기온</div>
							<i class="fa-solid fa-arrow-trend-up fa-2xl" style="color: #ff0000;"></i>
						</li>
						<li>
							<div class="text_muted">자외선</div>
							<i class="fa-solid fa-arrow-trend-up fa-2xl" style="color: #ffcd1a;"></i>
						</li>
						<li class="hidden-sm-down">
							<div class="text_muted">강수량</div>
							<i class="fa-solid fa-arrow-trend-up fa-2xl" style="color: #002aff;"></i>
						</li>
						<li>
							<div class="text_muted">습도</div>
							<i class="fa-solid fa-arrow-trend-up fa-2xl" style="color: #9ad8fe;"></i>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<script src="/resources/vendors/peity/jquery.peity.min.js"></script>
	<script src="/resources/assets/js/init-scripts/peitychart/peitychart.init.js"></script>
	<script src="/resources/vendors/jquery/dist/jquery.min.js"></script>
	<script src="/resources/vendors/popper.js/dist/umd/popper.min.js"></script>
	<script src="/resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="/resources/assets/js/main.js"></script>
	<script src="/resources/vendors/chart.js/dist/Chart.bundle.min.js"></script>
	<script src="/resources/assets/js/dashboard.js"></script>
	<script src="/resources/assets/js/widgets.js"></script>
	<script src="/resources/vendors/jqvmap/dist/jquery.vmap.min.js"></script>
	<script src="/resources/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
	<script src="/resources/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
</body>
</html>