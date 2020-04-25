<%@ include file="/html/clinics/init.jsp" %>

<liferay-util:include page="/html/clinics/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<%@include file="/html/clinics/details.jsp" %>