<%@page import="com.segmax.drugrep.service.SuburbLocalServiceUtil"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.segmax.drugrep.model.Suburb"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>

<%@ page import="com.segmax.drugrep.model.Appointment" %>
<%@ page import="com.segmax.drugrep.model.Surgery" %>
<%@ page import="com.segmax.drugrep.service.SurgeryLocalServiceUtil" %>

<%@ page import="java.util.Calendar" %>

<%
	ResultRow row3 = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	Appointment appointment = (Appointment)row3.getObject();
	SurgeryModel surgery = SurgeryUtil.buildFromOrgId(appointment.getSurgeryId());
	Suburb surgerySuburb = SuburbLocalServiceUtil.getSuburb(surgery.getSuburbId());
	Calendar fila = Calendar.getInstance();
	fila.setTime(appointment.getAppointmentDate());
	Integer calMonth = fila.get(Calendar.MONTH);
	Integer calYear = fila.get(Calendar.YEAR);
	
	String suburbIdStr = surgery.getSuburbId().toString();
	Long actualSuburb = (Long) request.getAttribute("idSuburb");
	if (actualSuburb != null && actualSuburb != 0) {
		suburbIdStr = "0";
	}
%>

<liferay-ui:icon-menu>
	<portlet:actionURL name="showMonthAppoiment" var="showMonthAppoimentURL">
		<portlet:param name="month" value="<%= calMonth.toString() %>"></portlet:param>
		<portlet:param name="year" value="<%= calYear.toString() %>"></portlet:param>
		<portlet:param name="idSuburb" value="<%= suburbIdStr %>"></portlet:param>
	</portlet:actionURL>
	<liferay-ui:icon image="attributes" message="<%= surgerySuburb.getName() %>" url="<%= showMonthAppoimentURL.toString() %>" />
</liferay-ui:icon-menu>