<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<link rel="stylesheet" href="/resources/assets/css/style.css">

<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
<script src="https://kit.fontawesome.com/f4f7b7924c.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-sm navbar-default">
<div class="navbar-header">
	<a class="navbar-brand" href="./"><img src="/resources/images/weatherlogo.png" alt="Logo"></a>
</div>
</nav>
	<div class="content">
		<div>
			<div class="col-sm-6 col-lg-3">
				<div class="card text-white bg-flat-color-4">
					<div class="card-body pb-20">
						<p class="text-light">기온/체감온도</p>
						<h4 class="mb-0">
							<span class="count">10468</span>°C
							<span>/</span>
							<span class="count">20</span>°C
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
	                        <span class="count">10468</span>%
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
	                	<p class="text-light">바람</p>
	                    <h4 class="mb-0">
	                        <span class="count">30</span>m/s
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
	                	 <p class="text-light">강수량</p>
	                     <h4 class="mb-0">
	                         <span class="count">18</span>mm
	                     </h4>
						<div class="watherIcons">
	                   		<i class="fa-solid fa-wind fa-fade fa-2xl"  id="watherIcon"></i>
	                 	</div>
	                    <div class="chart-wrapper px-0" style="height:70px;">
	                        <canvas id="widgetChart2"></canvas>
	                    </div>
					</div>
	            </div>
	        </div>
		</div>
		<div class="weatherstatus" >
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
					<p class="weather-text">겁나 추운 온도</p>
				</div>
			</div>
			<div class="weather_space">
				<div class="weather-header">
					<strong class="weather-title">최고 기온</strong>
					<hr>
				</div>
				<div class="weather-body">
					<p class="weather-text">겁나 더운 온도</p>
				</div>
			</div> 
			
			<div class="donut">
				<div class="donutChart">
					<span class="donut" data-peity='{ "fill": ["#99D683", "#fafafa"]}'>2,6</span>
					<p id="donut-name">초미세먼지</p>
				</div>
				<div class="donutChart">
	                <span class="donut" data-peity='{ "fill": ["#99D683", "#fafafa"]}'>0.52,1.041</span>
	                <p id="donut-name">미세먼지</p>
	            </div>
			</div>
		</div>
		
		
		
      <div class="col-xl-8">
          <div class="card">
              <div class="card-body">
                  <div class="row">
                      <div class="col-sm-4">
                          <h4 class="card-title mb-0">Weather Chart</h4>
                          <div class="small text-muted">Korea</div>
                      </div>
                      <!--/.col-->
                      <div class="col-sm-8 hidden-sm-down">
                          <button type="button" class="btn btn-primary float-right bg-flat-color-1"><i class="fa fa-cloud-download"></i></button>
                          <div class="btn-toolbar float-right" role="toolbar" aria-label="Toolbar with button groups">
                              <div class="btn-group mr-3" data-toggle="buttons" aria-label="First group">
                                  <label class="btn btn-outline-secondary">
                                      <input type="radio" name="options" id="option1"> 기온
                                  </label>
                                  <label class="btn btn-outline-secondary active">
                                      <input type="radio" name="options" id="option2"> 자외선
                                  </label>
                                  <label class="btn btn-outline-secondary">
                                      <input type="radio" name="options" id="option3"> 강수량
                                  </label>
                                  <label class="btn btn-outline-secondary">
                                      <input type="radio" name="options" id="option4"> 습도
                                  </label>
                              </div>
                          </div>
                      </div>
                      <!--/.col-->


                  </div>
                  <!--/.row-->
                  <div class="chart-wrapper mt-4">
                      <canvas id="trafficChart" style="height:200px;"></canvas>
                  </div>

              </div>
              <div class="card-footer">
                  <ul>
                  	 <li class="hidden-sm-down">
                          <div class="text-muted">기온</div>
                          <strong>22.123 Users (80%)</strong>
                          <div class="progress progress-xs mt-2" style="height: 5px;">
                              <div class="progress-bar bg-danger" role="progressbar" style="width: 80%;" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                      </li>
                      <li>
                          <div class="text-muted">Visits</div>
                          <strong>29.703 Users (40%)</strong>
                          <div class="progress progress-xs mt-2" style="height: 5px;">
                              <div class="progress-bar bg-success" role="progressbar" style="width: 40%;" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                      </li>
                      <li class="hidden-sm-down">
                          <div class="text-muted">Unique</div>
                          <strong>24.093 Users (20%)</strong>
                          <div class="progress progress-xs mt-2" style="height: 5px;">
                              <div class="progress-bar bg-info" role="progressbar" style="width: 20%;" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                      </li>
                      <li>
                          <div class="text-muted">Pageviews</div>
                          <strong>78.706 Views (60%)</strong>
                          <div class="progress progress-xs mt-2" style="height: 5px;">
                              <div class="progress-bar bg-warning" role="progressbar" style="width: 60%;" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                      </li>
                     
                      <li class="hidden-sm-down">
                          <div class="text-muted">Bounce Rate</div>
                          <strong>40.15%</strong>
                          <div class="progress progress-xs mt-2" style="height: 5px;">
                              <div class="progress-bar" role="progressbar" style="width: 40%;" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                      </li>
                  </ul>
              </div>
          </div>
      </div>
      <div class="col-xl-12">
          <div class="card">
              <div class="card-header">
                  <h4>World</h4>
              </div>
              <div class="Vector-map-js">
                  <div id="vmap" class="vmap" style="height: 700px;"></div>
              </div>
          </div>
          <!-- /# card -->
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