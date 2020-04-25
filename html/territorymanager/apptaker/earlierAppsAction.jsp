<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.enums.AppointmentStatus"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>


<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	AppModel app = (AppModel) row.getObject();
%>

<liferay-ui:icon-menu>
	<%if (!AppointmentStatus.APP_STATE_SWAPPED.equals(app.getStatus())) { %>
		<portlet:actionURL name="swapAppoinment" var="swapAppoinmentURL">
			<portlet:param name="appId" value="<%= app.getId().toString() %>"></portlet:param>
			<portlet:param name="surgeryId" value="<%= app.getSurgeryId().toString() %>"></portlet:param>
			<portlet:param name="drugRepId" value="<%= app.getDrugRepId().toString() %>"></portlet:param>
			<portlet:param name="appDate" value="<%= FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_YYYY_MM_DD_HH_MM) %>"></portlet:param>
		</portlet:actionURL>
		<liferay-ui:icon image="post" message="Swap Appointment" url="<%= swapAppoinmentURL.toString() %>" />
	<%} %>
</liferay-ui:icon-menu>