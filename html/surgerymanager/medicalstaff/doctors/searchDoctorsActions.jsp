<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.model.MedicalStaff"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<%
	ResultRow doctorRow = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	MedicalStaff doctor = (MedicalStaff) doctorRow.getObject();
	String doctorIdStr = String.valueOf(doctor.getId());
	
	String showDoctorInfoId = "showDoctorInfoId" + doctorIdStr;
%>

<liferay-ui:icon-menu>
	<portlet:actionURL name="addDoctorToSurgeryStaff" var="addDoctorToSurgeryStaffURL">
		<portlet:param name="resourcePrimKey" value="<%= doctorIdStr %>"></portlet:param>
	</portlet:actionURL>
	<liferay-ui:icon image="edit" message="Add to Clinic" url="<%= addDoctorToSurgeryStaffURL.toString() %>" />

	<liferay-ui:icon id="<%= showDoctorInfoId %>" image="page" message="View info" url="javascript:;" />
	
</liferay-ui:icon-menu>
	
<portlet:resourceURL id="showDoctorInfo" var="showDoctorInfoURL" />
<script>
var showDoctorInfoButton = document.getElementById('<portlet:namespace /><%= showDoctorInfoId %>');
addEvent('click', showDoctorInfoButton, function () {
	showDoctorInfo('<%= showDoctorInfoURL.toString() %>', '<%=doctor.getId() %>');
});
</script>