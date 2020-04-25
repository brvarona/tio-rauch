
<%@page import="com.segmax.drugrep.model.Doctor"%>
<%@page import="com.segmax.drugrep.service.SurgeryLocalServiceUtil"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ page import="com.liferay.portal.util.PortalUtil" %>

<%@ page import="com.segmax.drugrep.model.Speciality" %>
<%@ page import="com.segmax.drugrep.model.Speciality_Doctor" %>
<%@ page import="com.segmax.drugrep.service.SpecialityLocalServiceUtil" %>
<%@ page import="com.segmax.drugrep.service.Speciality_DoctorLocalServiceUtil" %>

<%@ include file="/html/surgerymanager/init.jsp" %>


<%
	PortletURL itDoctorURL = renderResponse.createRenderURL();
	itDoctorURL.setParameter("jspPage", "/html/surgerymanager/medicalstaff/myMedicalStaff.jsp");
%>

<h4>Doctors</h4>
<liferay-ui:search-container delta="10" curParam="doctorcur" emptyResultsMessage="No doctors added" iteratorURL="<%= itDoctorURL %>" >
	<liferay-ui:search-container-results>
		<%
			SurgeryModel surgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());
			List<Doctor> tempResults = SurgeryLocalServiceUtil.getDoctorsBySurgery(surgery.getId());
			results = ListUtil.subList(tempResults,searchContainer.getStart(),searchContainer.getEnd());
			total = tempResults.size();
			pageContext.setAttribute("results",results);
			pageContext.setAttribute("total",total);
		%>
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.segmax.drugrep.model.Doctor"
		keyProperty="id_doctor"
		modelVar="undoctor">

	<liferay-ui:search-container-column-text
		name="First Name"
		property="name"
	/>
	<liferay-ui:search-container-column-text
		name="Last Name"
		property="surname"
	/>

	<%
		String specialityName = "";
		List<Speciality_Doctor> elems = Speciality_DoctorLocalServiceUtil.getSpeciality(undoctor.getId_doctor());
		if (elems.size() > 0) {
			specialityName = SpecialityLocalServiceUtil.getSpeciality(elems.get(0).getId_speciality()).getName();
		}
	%>

	<liferay-ui:search-container-column-text
		name="Specialty"
		value="<%= specialityName %>"
	/>
	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/surgerymanager/medicalstaff/doctors/myDoctorsActions.jsp"
	/>

	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>

