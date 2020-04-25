<%@include file="/html/drugrepmanager/init.jsp" %>

<portlet:renderURL var="drugRepManagement">
	<portlet:param name="jspPage" value="/html/drugrepmanager/drugRepManagement.jsp" />
</portlet:renderURL>
<portlet:renderURL var="futureAppointments">
	<portlet:param name="jspPage" value="/html/drugrepmanager/futureAppointments.jsp" />
</portlet:renderURL>

<portlet:actionURL var="getFutureAppsByDrugRepURL" name="getFutureAppsByDrugRep">
	<portlet:param name="drugRepId" value="0" />
</portlet:actionURL>

<portlet:renderURL var="sovChartUrl">
	<portlet:param name="jspPage" value="/html/drugrepmanager/charts/sovChart.jsp" />
	<portlet:param name="initCharts" value="true" />
</portlet:renderURL>

<portlet:renderURL var="reachAndFreqChartUrl">
	<portlet:param name="jspPage" value="/html/drugrepmanager/charts/reachAndFreqChart.jsp" />
	<portlet:param name="initCharts" value="true" />
</portlet:renderURL>

<c:choose>
	<c:when test="${param.menuId == 10}">
		<c:set var="active10" value="active" />
	</c:when>
	<c:when test="${param.menuId == 20}">
		<c:set var="active20" value="active" />
	</c:when>
	<c:when test="${param.menuId == 30}">
		<c:set var="active30" value="active" />
	</c:when>
	<c:when test="${param.menuId == 40}">
		<c:set var="active40" value="active" />
	</c:when>
</c:choose>

<ul class="nav nav-pills">
	<li role="presentation" class="${active10}">
		<a href="<%= drugRepManagement.toString() %>" id="menuSelectedA">${param.subordinatesTitle}</a>
	</li>
	<li role="presentation" class="${active20}">
		<a href="<%= getFutureAppsByDrugRepURL.toString() %>" id="menuSelectedB">Future Appointments</a>
	</li>
	<li role="presentation" class="${active30}">
		<a href="<%= sovChartUrl.toString() %>" id="menuSelectedB">Share of Visits</a>
	</li>
	<li role="presentation" class="${active40}">
		<a href="<%= reachAndFreqChartUrl.toString() %>" id="menuSelectedB">Reach & Freq</a>
	</li>
</ul>
