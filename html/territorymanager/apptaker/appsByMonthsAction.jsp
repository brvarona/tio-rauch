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
	String individual = "false";
	Long individualId = 0L;
	if (app.getType().equals(AppointmentType.DOCTOR)) {
		individual = "true";
		individualId = app.getAttendants().get(0).getId();
	}
%>

<liferay-ui:icon-menu>
	<portlet:actionURL name="updateAppoiment" var="updateAppoimentURL">
		<portlet:param name="surgeryId" value="<%= app.getSurgeryId().toString() %>"></portlet:param>
		<portlet:param name="drugRepId" value="<%= app.getDrugRepId().toString() %>"></portlet:param>
		<portlet:param name="appDate" value="<%= FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_YYYY_MM_DD_HH_MM) %>"></portlet:param>
		<portlet:param name="individualId" value="<%= individualId.toString() %>"></portlet:param>
		<portlet:param name="isIndividual" value="<%= individual %>"></portlet:param>
	</portlet:actionURL>
	<liferay-ui:icon image="add" message="Take Appointment" url="<%= updateAppoimentURL.toString() %>" />

</liferay-ui:icon-menu>