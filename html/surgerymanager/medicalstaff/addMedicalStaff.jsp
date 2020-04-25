<%@page import="com.liferay.portal.security.permission.ActionKeys"%>
<%@page import="com.liferay.portal.service.permission.PortletPermissionUtil"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="20" />
</liferay-util:include>

<%@ include file="/html/surgerymanager/medicalstaff/doctors/searchDoctors.jsp" %>

<%if (PortletPermissionUtil.contains(permissionChecker, plid, portletDisplay.getId(), ActionKeys.ADD_USER)) { %>
	<br />
	<%@ include file="/html/surgerymanager/medicalstaff/nurse/nurseView.jsp" %>
<%} %>