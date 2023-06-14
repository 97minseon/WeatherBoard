<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>weather board</title>
        <meta name="description" content="Sufee Admin - HTML5 Admin Template" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <link rel="apple-touch-icon" href="apple-icon.png" />
        <link rel="shortcut icon" href="favicon.ico" />
        <link
            rel="stylesheet"
            href="/resources/vendors/bootstrap/dist/css/bootstrap.min.css"
        />
        <link
            rel="stylesheet"
            href="/resources/vendors/font-awesome/css/font-awesome.min.css"
        />
        <!-- 확인 후 삭제 -->
        <link
            rel="stylesheet"
            href="/resources/vendors/themify-icons/css/themify-icons.css"
        />
        <link
            rel="stylesheet"
            href="/resources/vendors/flag-icon-css/css/flag-icon.min.css"
        />
        <link
            rel="stylesheet"
            href="/resources/vendors/selectFX/css/cs-skin-elastic.css"
        />
        <link
            rel="stylesheet"
            href="/resources/vendors/jqvmap/dist/jqvmap.min.css"
        />
        <link rel="stylesheet" href="/resources/assets/css/style.css" />
        <link
            href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800"
            rel="stylesheet"
            type="text/css"
        />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script
            src="https://kit.fontawesome.com/f4f7b7924c.js"
            crossorigin="anonymous"
        ></script>
    </head>
    <script>
        $(document).ready(function () {
            $("select[class='address']").change(function () {
                $.ajax({
                    url: '/address?address=' + $(this).val(),
                    type: 'get',
                    dateType: 'json',
                    success: function (result) {
                        $('.address_detail').empty();
                        $('.address_detail').append(
                            "<option selected='selected'>시/군 선택</option>"
                        );
                        result.forEach((element) => {
                            if (element == null) element = '전체';
                            $('.address_detail').append(
                                "<option value='" +
                                    element +
                                    "'>" +
                                    element +
                                    '</option>'
                            );
                        });
                    },
                });
            }); //

            //대기오염 api에서 가져온 데이터를 저장할 변수
            var pm10Data = []; //미세먼지
            var pm25Data = []; //초미세먼지
            var o3Data = []; //오존

            /* 최초 날씨정보 로드시 전달할 데이터 */
            const formData = {
                address: '서울특별시',
                address_detail: '',
            };

            dataInit(formData, []);
            getTwilight(formData);

            //최초 로드시 대기오염 정보 가져오기
            $.ajax({
                url: '/getAtmosphere',
                type: 'GET',
                data: formData,
                success: function (result) {
                    pm10Data.push(result.pm10Value);
                    pm25Data.push(result.pm25Value);
                    o3Data.push(result.o3Value);
                    makeDonut(pm10Data, pm25Data, o3Data);
                },
            }); //getAtmosphere

            $('#data1').click(function () {}); //data1 click

            setInterval(() => {
                var d = new Date();
                var hur = d.getHours();
                var min = d.getMinutes();
                var sec = d.getSeconds();
                var time =
                    '현재 시간 : ' + hur + '시 ' + min + '분 ' + sec + '초';
                $('#time').text(time);
            }, 1000); //setInterval
            

        }); //document 끝 @@@@@@
        
        //기상정보 api에서 가져온 데이터를 저장할 변수
        var chartDataList = {};
        var fcstTime = []; //시간
        var tmpData = []; //온도
        var rehData = []; //습도
        var pcpData = []; //강수
        var wsdData = []; //풍속
        var vecData = []; //풍향
        var popData = []; //강수확률
        var ptyData = []; //강수형태
        var skyData = []; //하늘상태
              
        function getTwilight(rsp) {
            //박명시간 api에서 가져온 데이터를 저장할 변수
            var data = [];

            $.ajax({
                url: '/getTwilight',
                type: 'GET',
                data: rsp,
                success: function (result) {
                    //조회 데이터 변수저장
                    data.push(
                        result.getElementsByTagName('civilm').item(0).firstChild
                            .nodeValue
                    );
                    data.push(
                        result.getElementsByTagName('civile').item(0).firstChild
                            .nodeValue
                    );
                    data.push(
                        result.getElementsByTagName('sunrise').item(0)
                            .firstChild.nodeValue
                    );
                    data.push(
                        result.getElementsByTagName('sunset').item(0).firstChild
                            .nodeValue
                    );
                },
            }); //getTwilight(ajax)
            console.log(data);
            return data;
        } //getTwilight

        function dataInit(formData, tlData) {
        	
            $.ajax({
                url: '/getWeatherData',
                type: 'GET',
                data: formData,
                success: function (result) {
                    if (result != '기상청 api 오류발생') {
                        let items = result.response.body.items.item;
                        $.each(items, function (idx, data) {
                            if (data.category == 'TMP') {
                                fcstTime.push(data.fcstTime); //시간데이터저장
                                tmpData.push(data.fcstValue); //기온데이터저장
                            } else if (data.category == 'REH') {
                                rehData.push(data.fcstValue); //습도데이터저장
                            } else if (data.category == 'PCP') {
                                if (data.fcstValue == '강수없음') {
                                    pcpData.push(0); //강수없음저장
                                } else {
                                    pcpData.push(data.fcstValue); //강수데이터저장
                                }
                            } else if (data.category == 'WSD') {
                                wsdData.push(data.fcstValue); //풍속데이터저장
                            } else if (data.category == 'VEC'){
          						vecData.push(data.fcstValue); //풍향데이터저장
                            } else if (data.category == 'POP') {
                                popData.push(data.fcstValue); //강수확률데이터저장
                            } else if (data.category == 'PTY') {
                                ptyData.push(data.fcstValue); //강수형태데이터저장
                            } else if (data.category == 'SKY') {
                            	skyData.push(data.fcstValue); //하늘형태데이터저장
                            }
                        });

                        chartDataList = {
                            fcstTime,
                            tmpData,
                            rehData,
                            pcpData,
                            wsdData,
                            popData,
                            ptyData,
                            vecData,
                            skyData,
                        };

                        $('.TMPcount').text(tmpData[0] + '°C'); //온도차트 현재온도표기
                        $('.REHcount').text(rehData[0] + '%'); //습도차트 현재습도표기
                        if (pcpData[0] == 0) {
                            //강수차트 현재강수표기
                            $('.PCPcount').text('강수없음');
                        } else {
                            $('.PCPcount').text(pcpData[0] + 'mm');
                        }
                        $('.WSDcount').text(wsdData[0] + 'm/s'); //풍속차트 현재온도표기
                    } else {
                        alert('데이터를 불러오지 못했습니다.'); //api에서 데이터 못불러온경우
                    }
                    //대쉬보드 데이터 삽입
                    drawWithCheck(chartDataList);
                    //위젯 데이터 삽입
                    makeWidget(
                        fcstTime.slice(0, 9),
                        tmpData.slice(0, 9),
                        rehData.slice(0, 9),
                        pcpData.slice(0, 9),
                        wsdData.slice(0, 9)
                    );
                },
            }); //getWeatherData
           
        }

        function drawWithCheck(chartDataList) {
           
                $('input[name=status]').each(function () {
                    if (!$(this).prop('checked')) {
                        if ($(this).attr('id') == 'temperature') {
                            chartDataList.tmpData = [];
                        } else if ($(this).attr('id') == 'humidity') {
                            chartDataList.rehData = [];
                        } else if ($(this).attr('id') == 'precipitation') {
                            chartDataList.pcpData = [];
                        } else if ($(this).attr('id') == 'windSpeed') {
                            chartDataList.wsdData = [];
                        } else if (
                            $(this).attr('id') == 'probabilityOfPrecipitation'
                        ) {
                            chartDataList.popData = [];
                        }
                    }
                });
                $('#trafficDiv').html(
                    "<canvas id='trafficChart' height='100%'></canvas>"
                );
                makeDashBoard(chartDataList);
        }
       
    </script>

    <body>
        <nav class="navbar navbar-expand-sm navbar-default">
            <div class="navbar-header">
                <a class="navbar-brand" href="./"
                    ><img src="/resources/images/다운로드.jpg" alt="Logo"
                /></a>
            </div>
        </nav>

        <div class="wrap">
            <div class="content">
                <p id="time"></p>
                <div class="search_boxes">
                    <div class="address_box">
                        <select class="address">
                            <c:forEach
                                var="mainAddress"
                                items="${mainAddressList}"
                            >
                                <c:choose>
                                    <c:when
                                        test="${mainAddress == '서울특별시'}"
                                    >
                                        <option selected value="${mainAddress}">
                                            ${mainAddress}
                                        </option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${mainAddress}">
                                            ${mainAddress}
                                        </option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                        <select class="address_detail">
                            <option selected="selected">시/군 선택</option>
                        </select>
                        <a href="#" id="search">검색하기</a>
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
                                    <i
                                        class="fa-solid fa-temperature-high fa-2xl"
                                        id="weatherIcon"
                                    ></i>
                                </div>
                                <div
                                    class="chart-wrapper px-0"
                                    style="height: 70px"
                                >
                                    <canvas id="TMPChart"></canvas>
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
                                    <i
                                        class="fa-regular fa-sun fa-2xl"
                                        id="weatherIcon"
                                    ></i>
                                </div>
                                <div
                                    class="chart-wrapper px-0"
                                    style="height: 70px"
                                >
                                    <canvas id="REHChart"></canvas>
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
                                    <i
                                        class="fa-solid fa-cloud-showers-heavy fa-2xl"
                                        id="weatherIcon"
                                    ></i>
                                </div>
                                <div
                                    class="chart-wrapper px-0"
                                    style="height: 70px"
                                >
                                    <canvas id="PCPChart"></canvas>
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
                                    <i
                                        class="fa-solid fa-wind fa-2xl"
                                        id="weatherIcon"
                                    ></i>
                                </div>
                                <div
                                    class="chart-wrapper px-0"
                                    style="height: 70px"
                                >
                                    <canvas id="WSDChart"></canvas>
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
                        <div id="map" style="width: 840px; height: 800px"></div>
                    </div>
                </div>
                <script
                    type="text/javascript"
                    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ddbd7e25ba9f7024f41f738666e3630a"
                ></script>
                <script>
                    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
                    var options = {
                        //지도를 생성할 때 필요한 기본 옵션
                        draggable: false,
                        center: new kakao.maps.LatLng(
                            36.347119444444445,
                            127.38656666666667
                        ), //지도의 중심좌표.
                        level: 13, //지도의 레벨(확대, 축소 정도)
                    };

                    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
                </script>

                <div class="weather col-lg-6">
                    <div class="now_weather">
                        <div class="TMP_space">
                            <div class="TMP-header">
                                <strong id="TMP-title">현재 온도</strong>
                            </div>
                            <div class="TMP-body">
                                <p id="TMP-text">22</p>
                            </div>
                        </div>
                        <hr />
                        <div class="weather_space">
                            <div class="weather-header">
                                <strong class="weather-title">습도</strong>
                            </div>
                            <div class="weather-body">
                                <p class="weather-text">15°C</p>
                            </div>
                        </div>
                        <div class="weather_space">
                            <div class="weather-header">
                                <strong class="weather-title">바람</strong>
                            </div>
                            <div class="weather-body">
                                <p class="weather-text">27°C</p>
                            </div>
                        </div>
                        <div class="weather_space">
                            <div class="weather-header">
                                <strong class="weather-title"
                                    >1시간 강수량</strong
                                >
                            </div>
                            <div class="weather-body">
                                <p class="weather-text">27°C</p>
                            </div>
                        </div>
                    </div>

                    <div class="donut">
                        <div class="donutChart">
                            <canvas id="PM10Chart"></canvas>
                        </div>
                        <div class="donutChart">
                            <canvas id="PM25Chart"></canvas>
                        </div>
                        <div class="donutChart">
                            <canvas id="O3Chart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h4 class="card-title mb-0">
                                        Weather Chart
                                    </h4>
                                    <div class="small text-muted">Korea</div>
                                </div>
                                <div class="col-sm-6 hidden-sm-down">
                                    <div
                                        class="btn-toolbar float-right"
                                        role="toolbar"
                                        aria-label="Toolbar with button groups"
                                    >
                                        <div
                                            class="btn-group mr-3"
                                            data-toggle="buttons"
                                            aria-label="First group"
                                            id="data1"
                                        >
                                            <label
                                                class="btn btn-outline-secondary active"
                                            >
                                                <input
                                                    type="checkbox"
                                                    name="status"
                                                    id="temperature"
                                                    checked="checked"
                                                />
                                                기온
                                            </label>
                                            <label
                                                class="btn btn-outline-secondary active"
                                            >
                                                <input
                                                    type="checkbox"
                                                    name="status"
                                                    id="precipitation"
                                                    checked="checked"
                                                />
                                                강수량
                                            </label>
                                            <label
                                                class="btn btn-outline-secondary active"
                                            >
                                                <input
                                                    type="checkbox"
                                                    name="status"
                                                    id="humidity"
                                                    checked="checked"
                                                />
                                                습도
                                            </label>
                                            <label
                                                class="btn btn-outline-secondary active"
                                            >
                                                <input
                                                    type="checkbox"
                                                    name="status"
                                                    id="windSpeed"
                                                    checked="checked"
                                                />
                                                풍속
                                            </label>
                                            <label
                                                class="btn btn-outline-secondary active"
                                            >
                                                <input
                                                    type="checkbox"
                                                    name="status"
                                                    id="probabilityOfPrecipitation"
                                                    checked="checked"
                                                />
                                                강수확률
                                            </label>
                                        </div>
                                    </div>
                                    <div
                                        class="btn-toolbar float-right"
                                        role="toolbar"
                                        aria-label="Toolbar with button groups"
                                    >
                                        <div
                                            class="btn-group mr-3"
                                            data-toggle="buttons"
                                            aria-label="First group"
                                            id="data2"
                                        >
                                            <label
                                                class="btn btn-outline-secondary active"
                                            >
                                                <input
                                                    type="radio"
                                                    name="day"
                                                    id="today"
                                                    checked="checked"
                                                />
                                                오늘
                                            </label>
                                            <label
                                                class="btn btn-outline-secondary"
                                            >
                                                <input
                                                    type="radio"
                                                    name="day"
                                                    id="yesterday"
                                                />
                                                내일
                                            </label>
                                            <label
                                                class="btn btn-outline-secondary"
                                            >
                                                <input
                                                    type="radio"
                                                    name="day"
                                                    id="DAtomorrow"
                                                />
                                                모레
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div
                                class="trafficChart-wrapper mt-2"
                                id="trafficDiv"
                            >
                                <canvas
                                    id="trafficChart"
                                    height="100%"
                                ></canvas>
                            </div>
                            <div class="precipitation">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>강수형태</th>
                                            <th>강수확률</th>
                                            <th>바람</th>
                                        </tr>
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
                                    <i
                                        class="fa-solid fa-arrow-trend-up fa-2xl"
                                        style="color: #ff0000"
                                    ></i>
                                </li>
                                <li class="hidden-sm-down">
                                    <div class="text_muted">강수량</div>
                                    <i
                                        class="fa-solid fa-arrow-trend-up fa-2xl"
                                        style="color: #002aff"
                                    ></i>
                                </li>
                                <li>
                                    <div class="text_muted">습도</div>
                                    <i
                                        class="fa-solid fa-arrow-trend-up fa-2xl"
                                        style="color: #9ad8fe"
                                    ></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer>
            <div class="footer_box">
                <img src="" id="footer_logo" />
                <div id="address">
                    <ul class="li-group">
                        <li>경기도 수원시 팔달구 어디게</li>
                        <li>TEL : 031-123-1234 Email:carrotcarrot@gmail.com</li>
                        <li>COPYRIGHT (C) 당근 ALL RIGHTS RESERVED</li>
                    </ul>
                </div>
            </div>
            <i
                class="fa-solid fa-carrot fa-shake fa-2xl"
                style="color: #ff9500"
            ></i>
        </footer>
        <script src="/resources/vendors/peity/jquery.peity.min.js"></script>
        <script src="/resources/assets/js/init-scripts/peitychart/peitychart.init.js"></script>
        <script src="/resources/vendors/jquery/dist/jquery.min.js"></script>
        <script src="/resources/vendors/popper.js/dist/umd/popper.min.js"></script>
        <script src="/resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="/resources/assets/js/main.js"></script>
        <script src="/resources/vendors/chart.js/dist/Chart.bundle.min.js"></script>
        <script src="/resources/assets/js/dashboard.js"></script>
        <script src="/resources/assets/js/widgets.js"></script>
        <script src="/resources/assets/js/donuts.js"></script>
    </body>
</html>
