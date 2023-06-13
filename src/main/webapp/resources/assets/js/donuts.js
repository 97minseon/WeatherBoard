function makeDonut(pm10Data, pm25Data, o3Data){
	
	function colorSelect(data){
		if(data <= 30){
			return '#1787FF';
		}else if(data <= 80){
			return '#4DBD78';
		}else if(data <= 150){
			return '#F29D52';
		}else {
			return '#E52B27';
		}
		
	}
	var ctx = document.getElementById( "PM10Chart" );
	var myDoughnutChart = new Chart(ctx, {
    type: 'doughnut',
    data : {
    labels: ['미세먼지'],
     datasets: [ {
                data: pm10Data,
                label : '미세먼지',
                backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(0, 0, 0, 0)'],
         		 borderColor: ['rgba(255, 99, 132, 1)', 'rgba(255, 99, 132, 1)'],
         		 borderWidth: 1
            }, ]
            },
     options: {
        cutoutPercentage: 70,
        rotation: -0.5 * Math.PI,
        circumference: 2 * Math.PI,
        scales: {
          y: {
            suggestedMax: 100,
            suggestedMin: 0,
            beginAtZero: true,
            display: false
          }
        }
      }
});
}