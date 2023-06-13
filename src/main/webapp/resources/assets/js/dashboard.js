
	// const brandPrimary = '#20a8d8'
const brandSuccess = '#4dbd74'
const brandInfo = '#63c2de'
const brandDanger = '#f86c6b'

function convertHex (hex, opacity) {
  hex = hex.replace('#', '')
  const r = parseInt(hex.substring(0, 2), 16)
  const g = parseInt(hex.substring(2, 4), 16)
  const b = parseInt(hex.substring(4, 6), 16)

  const result = 'rgba(' + r + ',' + g + ',' + b + ',' + opacity / 100 + ')'
  return result
}

function makeDashBoard(fcstTime, tmpData, rehData, pcpData){


    //Traffic Chart
    var ctx = document.getElementById( "trafficChart" );
    //ctx.height = 50;
    var myChart = new Chart( ctx, {
        type: 'line',
        data: {
            labels: fcstTime,
            datasets: [
            {
              label: '온도',
              backgroundColor: convertHex(brandInfo, 10),
              borderColor: brandInfo,
              pointHoverBackgroundColor: '#fff',
              borderWidth: 2,
              yAxisID: 'left-y-axis',
              data: tmpData
          },
          {
              label: '습도',
              backgroundColor: 'transparent',
              borderColor: brandSuccess,
              pointHoverBackgroundColor: '#fff',
              borderWidth: 2,
              yAxisID: 'right-y-axis',
              data: rehData
          },
          {
              label: '강수량',
              backgroundColor: 'transparent',
              borderColor: brandDanger,
              pointHoverBackgroundColor: '#fff',
              borderWidth: 1,
              borderDash: [8, 5],
              yAxisID: 'right-y-axis',
              data: pcpData
          }
          ]
        },
        options: {
        
            maintainAspectRatio: true,
            legend: {
                display: true,
                labels: {
                	position: top,
                	fontSize:15
                	
                }
            },
            responsive: true,
            scales: {
                xAxes: [{
                  gridLines: {
                    drawOnChartArea: false
                  }
                }],
                yAxes: [ {
                      id: 'left-y-axis',
                      position: 'left',
                      ticks: {
                        beginAtZero: true,
                        maxTicksLimit: 5,
                        stepSize: Math.ceil(50 / 10),
                        max: 50,
                        callback: function(value) {
			              return value + '°C';
			            }
                      },
                      gridLines: {
                        display: true 
                      }
                },
                {
                 id: 'right-y-axis',
		         position: 'right',
		         ticks: {
			         beginAtZero: true,
			         maxTicksLimit: 5,
			         stepSize: Math.ceil(100 / 10),
			         max: 100,
			         callback: function(value) {
		              return value + '%';
		            }
		         },
		         gridLines: {
           			display: false
          		}
                }]
            },
            elements: {
                point: {
                  radius: 0,
                  hitRadius: 10,
                  hoverRadius: 4,
                  hoverBorderWidth: 3
              }
          }


        }
    } );


}
