<%@page import="com.rxtro.core.util.enums.AppointmentStatus"%>
<%@page import="com.rxtro.core.util.enums.AppointmentType"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>

<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="java.util.Date" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
AppModel app = (AppModel) row.getObject();

Long appIdToBeSwapped = (Long) row.getParameter("appIdToBeSwapped");
Long currentRepId = (Long) row.getParameter("currentRepId");

if (app.getDrugRepId() == null && !AppointmentStatus.APP_STATE_SWAPPED.equals(app.getStatus())) {
%>
	<liferay-ui:icon-menu>
		<portlet:actionURL name="swapAppoinment" var="swapAppoinmentURL">
			<portlet:param name="appId" value="<%= appIdToBeSwapped.toString() %>"></portlet:param>
			<portlet:param name="surgeryId" value="<%= app.getSurgeryId().toString() %>"></portlet:param>
			<portlet:param name="appDate" value="<%= FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_YYYY_MM_DD_HH_MM) %>"></portlet:param>
		</portlet:actionURL>
		<liferay-ui:icon image="post" message="Swap Appointment" url="<%= swapAppoinmentURL.toString() %>" />
	</liferay-ui:icon-menu>
<%} %>