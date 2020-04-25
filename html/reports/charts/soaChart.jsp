<%@ include file="/html/reports/init.jsp" %>

<div class="" id="loading-mark-container">
	<div class="loading-mark"></div>
</div>
<liferay-portlet:resourceURL var="showChartFilterPopupUrl">
	<portlet:param name="reportType" value="11"></portlet:param>
</liferay-portlet:resourceURL>
<div class="container">
	<button type="button" class="btn btn-default" onclick="openChartFilterPopUp('<%=showChartFilterPopupUrl.toString() %>', 'chartFilterForm', '${fromDate}', '${toDate}', '${aggregateId}', '${companyRank}', '${managerId}', '${selectedStateCode}', '${selectedATCCode}', '', '')" >Filters</button>
	<div class="row">
		<div class="col-md-12">
			<h2 class="text-info text-center">${atc.description}</h2>
			<h5 class="text-info text-center">${aggregateId} ${fromDate} to ${toDate}</h5>
		</div>
	</div>
	<button id="hideLEgend">Hide/Show Legend</button>
	<div class="row">
		<div class="col-md-12">
			<div>
				<canvas id="canvas"></canvas>
			</div>
		</div>
	</div>
</div>

<c:set var="managerLabel" value="All Managers" />
<c:if test="${not empty manager}">
	<c:set var="managerLabel" value="${manager.name}" />
</c:if>

<script>
var datasetsValue = [];
</script>

<c:forEach items="${soaResult.dataByCompany}" var="data" varStatus="status">
	<script>
	datasetsValue.push({
			type: 'line',
			label: '${data.key}',
			borderColor: chartSeriesColors[${status.index}],
			backgroundColor: chartSeriesColors[${status.index}],
			borderWith: 2,
			fill: false,
			data: [${data.value}]
		});
	</script>
</c:forEach>

<script> 
datasetsValue.push({
 	type: 'bar',
 	label: '',
 	borderColor: window.chartColors.darkgrey,
 	backgroundColor: window.chartColors.lightgrey,
 	borderWith: 1,
 	data: [${soaResult.barChartData}]
 });

var chartData = {
	labels: [${soaResult.yearMonths}],
	datasets: datasetsValue
};

YUI().ready(function(A) {
	var ctx = document.getElementById('canvas').getContext('2d');
	window.myMixedChart = new Chart(ctx, {
		type: 'bar',
		data: chartData,
		options: {
			responsive: true,
			legend: {
				position: 'right',
				labels: {
					filter: function (legendItem, chartData) {
						// return false to hide the label
						if (legendItem.text == '') {
							return false;
						} else {
							return true;
						}
					}
				},
				onClick : function(e, legendItem) {
					var dataset = this.chart.data.datasets[legendItem.datasetIndex];
                   	var ci = this.chart;
                   	dataset.hidden = !dataset.hidden;
                   	var maxSov = 0.0;
                       Chart.helpers.each(this.chart.data.datasets.forEach(function (dataset, i) {
                       	if (dataset.label != "" && (dataset.hidden == null || dataset.hidden == false)) {
                       		var meta = ci.getDatasetMeta(i);
                       		Chart.helpers.each(meta.data.forEach(function (bar, j) {
                       			if (maxSov < parseFloat(dataset.data[j])) {
                       				maxSov = parseFloat(dataset.data[j]);
                       			}
                       		}), this);
                       	} else if (ci.currentMonthIndex == null && dataset.label == "") {
                       		var meta = ci.getDatasetMeta(i);
                       		Chart.helpers.each(meta.data.forEach(function (bar, j) {
                       			if (dataset.data[j] != '0' ) {
                       				ci.currentMonthIndex = j;
                               	}
                       		}), this);
                       	}
                       }), this);
                       Chart.helpers.each(this.chart.data.datasets.forEach(function (dataset, i) {
                       	if (dataset.label == "") {
                       		if (ci.currentMonthIndex != null) {
                       			dataset.data[ci.currentMonthIndex] = maxSov;
                       		}
                       	}
                       }), this);
					this.chart.update();
				}
			},
			title: {
                display: true,
                text: '${managerLabel} - ${selectedStateCode}'
            },
            tooltips: {
                mode: 'index',
                intersect: true,
                filter: function (tooltipItem) {
                    //console.log(tooltipItem);
                    return (tooltipItem.datasetIndex == ${companyRank} ? false : true);
                }
            },
            scales: {
                xAxes: [{
                    ticks: {},
                	scaleLabel: {
                    	display: true,
                    	labelString: "Year-Month"
                	}
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        //stepSize: 500000,
                        userCallback: function (value, index, values) {
                        	var n = value.toFixed(2);
                            //value = value.toString();
                            //value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                            return n + '%';
                        }
                    },
                    scaleLabel: {
                        display: true,
                        labelString: "Share of Total RxTro Appointments"
                    }
                }]
            },
//             animation: {
//                 onComplete: function () {
                	
//                     var chartInstance = this.chart;
//                     var ctx = chartInstance.ctx;
//                     console.log(chartInstance);
//                     var height = chartInstance.controller.boxes[0].bottom;
//                     ctx.textAlign = "center";
//                     //ctx.
//                     var maxSov = 0.0;
//                     Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
//                     	console.log(dataset.label);
//                     	console.log(dataset._meta[0].hidden);
//                     	var meta = chartInstance.controller.getDatasetMeta(i);
//                     	console.log(meta.hidden);
//                     	if (dataset.label != "" && dataset._meta[0].hidden != true) {
//                     		Chart.helpers.each(meta.data.forEach(function (bar, index) {
//                     			if (maxSov < parseFloat(dataset.data[index])) {
//                     				maxSov = parseFloat(dataset.data[index]);
//                     			}
//                     		}), this);
//                     	}
//                         if (dataset.label == "") {
//                             Chart.helpers.each(meta.data.forEach(function (bar, index) {
//                             	console.log(dataset.data[index]);
//                             	if (dataset.data[index] != '0') {
//                             		dataset.data[index] = maxSov;
//                             	}
//                             	//chartInstance.update();
//                                 //ctx.fillText((dataset.data[index] > 0 ? "CURRENT MONTH" : ""), bar._model.x, height - ((height - bar._model.y) / 2));
//                             }), this);
//                         }
//                     }), this);
//                 }
//             }
		}
	});
});

document.getElementById('hideLEgend').addEventListener('click', function () {
    window.myMixedChart.options.legend.display = !window.myMixedChart.options.legend.display;
    window.myMixedChart.update();
});

</script>



<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
	</div>
</div>