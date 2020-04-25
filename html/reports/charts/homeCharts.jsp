<%@ include file="/html/reports/menu.jsp" %>

<liferay-util:include page="/html/reports/charts/soaChart.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="contextId" value="10" />
</liferay-util:include>