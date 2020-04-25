<%@page import="com.rxtro.core.util.CfgProcessor"%>
<%@ page import="com.segmax.drugrep.model.Doctor" %>
<%@ page import="com.segmax.drugrep.model.Speciality" %>
<%@ page import="com.segmax.drugrep.model.Speciality_Doctor" %>
<%@ page import="com.segmax.drugrep.service.SpecialityLocalServiceUtil" %>
<%@ page import="com.segmax.drugrep.service.Speciality_DoctorLocalServiceUtil" %>

<%@ page import="java.util.Comparator" %>

<%@include file="/html/surgerymanager/init.jsp" %>

<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<%
	Doctor unDoctor = (Doctor)request.getAttribute("unDoctor");
%>

<portlet:renderURL var="cancelURL">
	<portlet:param name="jspPage" value="/html/surgerymanager/medicalstaff/myMedicalStaff.jsp" />
</portlet:renderURL>

<portlet:actionURL name="updateDoctorInfo" var="updateDoctorInfoURL" />
<h2>Edit Staff Personal info</h2>
<aui:form action="<%= updateDoctorInfoURL.toString() %>" method="post" name="fm">
	<aui:fieldset>
	<aui:input name="doctorId" type="hidden" value="<%= unDoctor.getId_doctor() %>" />
	<aui:input label="Name" name="dcName" size="45" type="text" value="<%= unDoctor.getName() %>" />
	<aui:input label="Middle Name" name="dcMiddleName" size="45" value="<%= unDoctor.getMiddle_name() %>" />
	<aui:input label="Surname" name="dcSurname" size="45" type="text" value="<%= unDoctor.getSurname() %>" />
	<aui:input label="Preferred Name" name="dcPreferedName" size="45" value="<%= unDoctor.getPrefered_name() %>" />
	<aui:input label="CDP Number" name="dcCDPNumber" size="45" value="<%= unDoctor.getCPD_number() %>" />
	<aui:input label="Email:" name="dcEmail" size="45" value="<%= unDoctor.getEmail() %>" />
	<aui:select autocomplete="off" label="Diet Information:" multiple="true" name="dcDiet">
	<%
		String[] foodTypes = CfgProcessor.getFoodTypes();
		for (int i = 0; i<foodTypes.length;i++) {
			%>
				<aui:option selected="<%= unDoctor != null && unDoctor.getDiet_data().contains(foodTypes[i]) %>" value="<%= foodTypes[i] %>"><%= foodTypes[i] %></aui:option>
			<%
		}
	%>
	</aui:select>

	<aui:select label="Gluten Free" name="dcGlutenFree">
	<c:choose>
			<c:when test="<%= unDoctor.getGluten_free() %>">
				<aui:option selected="true" value="YES">Yes</aui:option>
	 			<aui:option value="NO">No</aui:option>
			</c:when>

			<c:otherwise>
				<aui:option value="YES">Yes</aui:option>
	 			<aui:option value="NO" selected="true">No</aui:option>
			</c:otherwise>

		  </c:choose>
	 </aui:select>

	 <aui:select name="dcGender" label="Gender">
	 	<c:choose>
	 		<c:when test='<%= unDoctor.getGender() != null && unDoctor.getGender().equals(\"Female\") %>'>
	 			<aui:option value="Male">Male</aui:option>
	 			<aui:option value="Female" selected="true">Female</aui:option>
	 		</c:when>
	 		<c:otherwise>
	 			<aui:option value="Male" selected="true">Male</aui:option>
	 			<aui:option value="Female">Female</aui:option>
	 		</c:otherwise>
	 	</c:choose>
	 </aui:select>

	 <aui:select name="dcSpeciality" label="Specialty">

		<%
		Long specialityId = null;
		List<Speciality_Doctor> specialityDoctorList = Speciality_DoctorLocalServiceUtil.getSpeciality(unDoctor.getId_doctor());
		if (specialityDoctorList.size() > 0) {
			specialityId = SpecialityLocalServiceUtil.getSpeciality(specialityDoctorList.get(0).getId_speciality()).getId_speciality();
		}

		List<Speciality> specialities = SpecialityLocalServiceUtil.getSpelialities();
		for (int i=0 ; i<specialities.size(); i++) {
			Speciality spec = specialities.get(i);
		%>

			<aui:option selected="<%= specialityId != null && specialityId == spec.getId_speciality() %>" value="<%= spec.getId_speciality() %>"><%= spec.getName() %></aui:option>

		<%
		}
		%>

	 </aui:select>

		<aui:button-row>
			<aui:button type="submit" />
			<aui:button onClick="<%= cancelURL %>" type="cancel" value="Cancel" />
		</aui:button-row>

	</aui:fieldset>
</aui:form>