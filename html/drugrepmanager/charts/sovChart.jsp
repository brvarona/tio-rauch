<%@ include file="/html/drugrepmanager/init.jsp" %>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.rep.management.AdminAbstract"%>
<%@page import="com.rxtro.core.rep.management.AdminFactory"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>

<div class="" id="loading-mark-container">
	<div class="loading-mark"></div>
</div>

<%
DrugRepModel manager = DrugRepUtil.buildByUser(themeDisplay.getUser());
AdminAbstract admin = AdminFactory.build(manager);
%>
<liferay-util:include page="/html/drugrepmanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="30" />
	<liferay-util:param name="subordinatesTitle" value="<%=admin.getSubordinatesTitle() %>" />
</liferay-util:include>

<liferay-portlet:resourceURL var="showChartFilterPopupUrl" id="showSOVFilters" />

<!-- Start SOV Chart -->

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
			<h3 class="text-info text-center">Share of Appointments</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div>
				<canvas id="sov"></canvas>
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
			<h3 class="text-info text-center">No. of Reps</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div>
				<canvas id="sovWithNoReps"></canvas>
			</div>
		</div>
	</div>
</div>

<c:set var="companyRankValue" value="0" />
<c:if test="${not empty chartFilters.rank}">
	<c:set var="companyRankValue" value="${chartFilters.rank}" />
</c:if>

<script> 

var chartSovData = {
	labels: [${soaSovResult.labels}],
	datasets: ${soaSovResult.data}
};

var chartNoRepsData = {
		labels: [${soaNoRepsResult.labels}],
		datasets: ${soaNoRepsResult.data}
};
	
YUI().ready(function(A) {
	window.myMixedChart = [];
	loadSOVChart(window.myMixedChart, 0,'sov', '${chartTitle}', ${companyRankValue}, chartSovData, 'Year-Month', 'Share of Appointments', '%', 1, 0);
	loadSOVChart(window.myMixedChart, 1, 'sovWithNoReps', '${chartTitle}', ${companyRankValue}, chartNoRepsData, 'Year-Month', 'No Reps', '', 0, 0);
	
});

document.getElementById('hideLEgend').addEventListener('click', function () {
	window.myMixedChart[0].options.legend.display = !window.myMixedChart[0].options.legend.display;
	window.myMixedChart[0].update();
	
	window.myMixedChart[1].options.legend.display = ! window.myMixedChart[1].options.legend.display;
	window.myMixedChart[1].update();
});

</script>

<!-- End SOV Chart -->

<c:if test="${param.initCharts}">
	<portlet:actionURL name="showSovReportCharts" var="showSovReportChartsURL" />
	<form action="<%=showSovReportChartsURL.toString() %>" method="POST" id="defaultChartFormId"></form>
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

