<%@page import="com.rxtro.core.rep.management.AdminAbstract"%>
<%@page import="com.rxtro.core.rep.management.AdminFactory"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@ include file="/html/drugrepmanager/init.jsp" %>

<div class="" id="loading-mark-container">
	<div class="loading-mark"></div>
</div>

<%
DrugRepModel manager = DrugRepUtil.buildByUser(themeDisplay.getUser());
AdminAbstract admin = AdminFactory.build(manager);
%>
<liferay-util:include page="/html/drugrepmanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="40" />
	<liferay-util:param name="subordinatesTitle" value="<%=admin.getSubordinatesTitle() %>" />
</liferay-util:include>

<liferay-portlet:resourceURL var="showChartFilterPopupUrl" id="showReqchFilters"  />

<div class="container">
	<button type="button" class="btn btn-default" onclick="openChartFilterPopUp('<%=showChartFilterPopupUrl.toString() %>', 'chartFilterForm', '${chartFilters.from}', '${chartFilters.to}', '${chartFilters.aggregateId}', '${chartFilters.rank}', '${chartFilters.managerId}', '${chartFilters.stateCode}', '${chartFilters.atcCode}', ${chartFilters.drugRepUserId}, '${chartFilters.targetName}')" >Filters</button>
	<div class="row">
		<div class="col-md-12">
			<h2 class="text-info text-center">${chartFilters.atcDescription}</h2>
			<h5 class="text-info text-center">${chartFilters.aggregateId} <c:if test="${not empty chartFilters.from and not empty chartFilters.to}">${chartFilters.from} to ${chartFilters.to}</c:if></h5>
		</div>
	</div>
	<button id="hideLEgend">Hide/Show Legend</button>
	<div class="row">
		<div class="col-md-12">
			<h3 class="text-info text-center">Reach</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div>
				<canvas id="sovWithReach"></canvas>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<h2 class="text-info text-center">${chartFilters.atcDescription}</h2>
			<h5 class="text-info text-center">${chartFilters.aggregateId} <c:if test="${not empty chartFilters.from and not empty chartFilters.to}">${chartFilters.from} to ${chartFilters.to}</c:if></h5>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<h3 class="text-info text-center">Frequency</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div>
				<canvas id="sovWithFrequency"></canvas>
			</div>
		</div>
	</div>
</div>

<c:set var="companyRankValue" value="0" />
<c:if test="${not empty companyRank}">
	<c:set var="companyRankValue" value="${companyRank}" />
</c:if>

<script> 

var chartReachData = {
	labels: [${soaReachResult.labels}],
	datasets: ${soaReachResult.data}
};

var chartFrequencyData = {
	labels: [${soaFrequencyResult.labels}],
	datasets: ${soaFrequencyResult.data}
};

YUI().ready(function(A) {
	window.myMixedChart = [];
	loadSOVChart(window.myMixedChart, 0, 'sovWithReach', '${chartTitle}', ${companyRankValue}, chartReachData, 'Year-Month', 'Reach', '%', 0, 0);
	loadSOVChart(window.myMixedChart, 1, 'sovWithFrequency', '${chartTitle}', ${companyRankValue}, chartFrequencyData, 'Year-Month', 'Frequency', '', 1, 1);
});

document.getElementById('hideLEgend').addEventListener('click', function () {
	window.myMixedChart[0].options.legend.display = !window.myMixedChart[0].options.legend.display;
	window.myMixedChart[0].update();
    
	window.myMixedChart[1].options.legend.display = ! window.myMixedChart[1].options.legend.display;
	window.myMixedChart[1].update();
});

</script>

<c:if test="${param.initCharts}">
	<portlet:actionURL name="showReachAndFreqReportCharts" var="showReachAndFreqReportChartsURL" />
	<form action="<%=showReachAndFreqReportChartsURL.toString() %>" method="POST" id="defaultChartFormId"></form>
	<script>
	YUI().ready(function(A) {
		loadDefaultChart('defaultChartFormId');
	});
	</script>
</c:if>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
	</div>
</div>
