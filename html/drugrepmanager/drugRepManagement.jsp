<%@include file="/html/drugrepmanager/init.jsp" %>

<%
DrugRepModel manager = DrugRepUtil.buildByUserId(themeDisplay.getUserId());
AdminAbstract admin = AdminFactory.build(manager);

session.removeAttribute("filterChart");

%>

<liferay-util:include page="/html/drugrepmanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
	<liferay-util:param name="subordinatesTitle" value="<%=admin.getSubordinatesTitle() %>" />
</liferay-util:include>

<br />
<%@include file="/html/drugrepmanager/myDrugRepresentatives.jsp" %>
<br />
<%@include file="/html/drugrepmanager/companyDrugRepresentatives.jsp" %>