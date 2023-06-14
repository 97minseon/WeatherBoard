function makeDonut(pm10Data, pm25Data, o3Data){
	
	
	var ctx = document.getElementById( "PM10Chart" );
	var myDoughnutChart = new Chart(ctx, {
    type: 'doughnut',
    data : {
    labels: ['미세먼지'],
     datasets: [ {
                data: pm10Data,
                label : '미세먼지',
                backgroundColor: ['blue'],
         		 borderColor: ['blue'],
         		 borderWidth: 1
            }, ]
            },
     options: {}
	});

	var ctx = document.getElementById( "PM25Chart" );
	var myDoughnutChart = new Chart(ctx, {
    type: 'doughnut',
    data : {
    labels: ['초미세먼지'],
     datasets: [ {
                data: pm25Data,
                label : '초미세먼지',
                backgroundColor: ['green'],
         		 borderColor: ['green'],
         		 borderWidth: 1
            }, ]
            },
     options: {}
	});
	
	var ctx = document.getElementById( "O3Chart" );
	var myDoughnutChart = new Chart(ctx, {
    type: 'doughnut',
    data : {
    labels: ['오존'],
     datasets: [ {
                data: o3Data,
                label : '오존',
                backgroundColor: ['red'],
         		 borderColor: ['red'],
         		 borderWidth: 1
            }, ]
            },
     options: {}
	});
}