<%@ page import="com.segmax.drugrep.model.Doctor_Blockoutdate" %>

<%@ include file="/html/surgerymanager/init.jsp" %>

	<%
		ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
		Doctor_Blockoutdate doctorBlockOutDate = (Doctor_Blockoutdate) row.getObject();
		Long doctorBlockOutDateId = doctorBlockOutDate.getId_doctor_blockoutdate();
	%>

	<liferay-ui:icon-menu>
		<portlet:actionURL name="deleteDoctorBlockOutDate" var="deleteDoctorBlockOutDateURL">
			<portlet:param name="doctorBlockOutDateId" value="<%= doctorBlockOutDateId.toString() %>"></portlet:param>
		</portlet:actionURL>
		<liferay-ui:icon image="delete" message="Delete" url="<%= deleteDoctorBlockOutDateURL.toString() %>" />
	</liferay-ui:icon-menu>