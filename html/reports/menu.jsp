<%@ include file="/html/reports/init.jsp" %>

<portlet:renderURL var="viewReportURL">
	<portlet:param name="jspPage" value="/html/reports/view.jsp" />
</portlet:renderURL>
<portlet:actionURL name="showReportCharts" var="showReportChartsURL" />

<c:choose>
	<c:when test="${param.menuId == 10}">
		<c:set var="active10" value="active" />
	</c:when>
	<c:when test="${param.menuId == 20}">
		<c:set var="active20" value="active" />
	</c:when>
</c:choose>

<ul class="nav nav-pills">
	<li role="presentation" class="${active10}">
		<a href="<%= viewReportURL.toString() %>" id="menuSelectedA">Reports</a>
	</li>
	<li role="presentation" class="${active20}">
		<a href="<%= showReportChartsURL.toString() %>" id="menuSelectedB">View Report Charts</a>
	</li>
</ul>

