<%@page import="com.segmax.drugrep.service.Doctor_work_SurgeryLocalServiceUtil"%>
<%@page import="com.segmax.drugrep.model.Doctor_work_Surgery"%>
<%@page import="com.segmax.drugrep.model.Doctor"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ page import="com.segmax.drugrep.service.persistence.Doctor_work_SurgeryPK" %>

<%@ include file="/html/surgerymanager/init.jsp" %>

<portlet:actionURL name="viewDoctorInfo" var="viewDoctorInfoURL" />

<%
	ResultRow docRow = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	SurgeryModel surgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());
	Doctor unDoctor = (Doctor) docRow.getObject();
	Doctor_work_Surgery dws = Doctor_work_SurgeryLocalServiceUtil.getDoctor_work_Surgery(new Doctor_work_SurgeryPK(surgery.getId(),unDoctor.getId_doctor()));
	boolean allowIndividual = dws.getAccept_individual_appoiment();
	String displayDIAClass = "hidden";
	String displayAIAClass = "";
	if (allowIndividual) {
		displayDIAClass = "";
		displayAIAClass = "hidden";
	}
	//long groupId = themeDisplay.getLayout().getGroupId();
	String name = Doctor.class.getName();
	String doctorId = String.valueOf(unDoctor.getId_doctor());

	String showDoctorInfoId = "showDoctorInfoId" + String.valueOf(unDoctor.getId_doctor());
	
	String callInfoDoctorJS = "javascript:getDoctorInfo('" +viewDoctorInfoURL.toString()+ "','"+doctorId+"');";
	
	String disableIndividualAppointmentLinkId = "disableIndividualAppointmentLink" + docRow.getRowId();
	String allowIndividualAppointmentLinkId = "allowIndividualAppointmentLink" + docRow.getRowId();
	
	String removeDoctorFromSurgeryLinkId = "removeDoctorFromSurgeryLinkId" + docRow.getRowId();
	
	String rowId = "rowId"+docRow.getRowId();
%>

<liferay-ui:icon-menu id="<%=rowId %>">
	
	<liferay-ui:icon cssClass="<%=displayDIAClass%>" id="<%=disableIndividualAppointmentLinkId %>" image="share" message="Disable Individual Appointment " url="javascript:;" />
	
	<liferay-ui:icon cssClass="<%=displayAIAClass%>" id="<%=allowIndividualAppointmentLinkId %>" image="share" message="Allow Individual Appointment " url="javascript:;" />

	<liferay-ui:icon id="<%= showDoctorInfoId %>" image="page" message="View info" url="javascript:;" />

	<portlet:actionURL name="showEditDoctorInfo" var="showEditDoctorInfoURL">
		<portlet:param name="doctorId" value="<%= doctorId %>"></portlet:param>
	</portlet:actionURL>
	<liferay-ui:icon image="edit" message="Edit Staff info" url="<%= showEditDoctorInfoURL.toString() %>" />

	<portlet:actionURL name="removeDoctorFromSurgery" var="removeDoctorFromSurgery2URL">
		<portlet:param name="doctorPrimKey" value="<%= doctorId %>"></portlet:param>
	</portlet:actionURL>

	<liferay-ui:icon id="<%=removeDoctorFromSurgeryLinkId %>" image="delete" message="Remove from clinic" url="javascript:;" />
</liferay-ui:icon-menu>

<portlet:resourceURL id="showDoctorInfo" var="showDoctorInfoURL" />
<portlet:resourceURL id="disableIndividualApp" var="disableIndividualAppURL" />
<portlet:resourceURL id="allowIndividualApp" var="allowIndividualAppURL" />
<portlet:resourceURL id="removeDoctorFromSurgery" var="removeDoctorFromSurgeryURL" />
<script>
var showDoctorInfoButton = document.getElementById('<portlet:namespace /><%= showDoctorInfoId %>');
if (showDoctorInfoButton != null) {
	addEvent('click', showDoctorInfoButton, function () {
		showDoctorInfo('<%= showDoctorInfoURL.toString() %>', '<%=unDoctor.getId_doctor() %>');
	});
}

var disableIndividualAppointmentButton = document.getElementById('<portlet:namespace /><%=disableIndividualAppointmentLinkId%>');
if (disableIndividualAppointmentButton != null) {
	addEvent('click', disableIndividualAppointmentButton, function () {
		disableIndividualApp('<%=disableIndividualAppURL.toString() %>', '<%=unDoctor.getId_doctor() %>', '<portlet:namespace /><%=disableIndividualAppointmentLinkId%>', '<portlet:namespace /><%=allowIndividualAppointmentLinkId%>');
	});
}

var allowIndividualAppointmentButton = document.getElementById('<portlet:namespace /><%=allowIndividualAppointmentLinkId%>');
if (allowIndividualAppointmentButton != null) {
	addEvent('click', allowIndividualAppointmentButton, function () {
		allowIndividualApp('<%=allowIndividualAppURL.toString()%>', '<%=unDoctor.getId_doctor() %>', '<portlet:namespace /><%=allowIndividualAppointmentLinkId%>', '<portlet:namespace /><%=disableIndividualAppointmentLinkId%>');
	});
}

var removeDoctorFromSurgeryButton = document.getElementById('<portlet:namespace /><%=removeDoctorFromSurgeryLinkId %>')
if (removeDoctorFromSurgeryButton != null) {
	addEvent('click', removeDoctorFromSurgeryButton, function () {
		removeDoctorFromSurgery('<%=removeDoctorFromSurgeryURL.toString() %>', '<%=unDoctor.getId_doctor() %>', '<portlet:namespace /><%=rowId %>');
	});
}

</script>