<%@include file="/html/territorymanager/init.jsp" %>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="60" />
</liferay-util:include>

<%@include file="/html/territorymanager/company/changeCompanyForm.jsp" %>

