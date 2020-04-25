<%@page import="com.rxtro.core.util.DoctorUtil"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.model.MedicalStaff"%>
<%@page import="com.segmax.drugrep.model.impl.SpecialityImpl"%>
<%@ page import="com.liferay.portal.model.Group" %>
<%@ page import="com.liferay.portal.model.User" %>
<%@ page import="com.liferay.portal.service.ClassNameLocalServiceUtil" %>

<%@ page import="com.segmax.drugrep.model.Speciality" %>
<%@ page import="com.segmax.drugrep.service.SpecialityLocalServiceUtil" %>

<%@ page import="java.util.ArrayList" %>

<%@ page import="javax.portlet.ActionRequest" %>

<%@ include file="/html/surgerymanager/init.jsp" %>

<%
List<MedicalStaff> resultSearch = (List<MedicalStaff>) session.getAttribute("resultSearch");
String term = "";
String termTitle = "";
if (session.getAttribute("term") != null) {
	term = (String) session.getAttribute("term");
	if (term.trim().length() > 0 && resultSearch != null && resultSearch.size() > 0) {
		termTitle = "with name like " + term;
	}
}

PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/surgerymanager/medicalstaff/addMedicalStaff.jsp");
%>

<h3>Could your doctor already be registered at another location? Save time and find them here</h3>
<portlet:actionURL name="searchDoctors" var="searchDoctorsURL" />
<liferay-portlet:resourceURL id="searchDoctorsId" var="searchDoctorsResourceURL" />
<form action="<%= searchDoctorsURL.toString() %>" method="post" name="fm" class="form-search">
	<aui:input name="item" id="cat1" type="hidden" value="" />
	<aui:input name="item" id="cat2" type="hidden" value="" />
	<input class="input-medium" placeholder="Search" autocomplete="off" id="inputSearchTerm" name="<portlet:namespace/>term" type="text" value="<%= term %>" />
	<button type="submit" class="btn btn-default">Search</button>
</form>
<script charset="utf-8" type="text/javascript">
	YUI().ready(function(A) {
		try {
		var autoComplete = new AutoComplete({
			maxItems: 10,
			inputId: 'inputSearchTerm',
			cat1Id: '<portlet:namespace/>cat1',
			cat2Id: '<portlet:namespace/>cat2',
			searchUrl: '<%= searchDoctorsResourceURL.toString() %>'
		});
		autoComplete.init();
		} catch(e) {
			console.log(e);
		}
	});
</script>
<liferay-ui:search-container delta="10" emptyResultsMessage="No doctors" iteratorURL="<%= iteratorURL %>">
	<liferay-ui:search-container-results>
	<%
		results = ListUtil.subList(resultSearch, searchContainer.getStart(), searchContainer.getEnd());
		total = resultSearch.size();
		pageContext.setAttribute("results",results);
		pageContext.setAttribute("total",total);
	%>
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.MedicalStaff"
		keyProperty="id"
		modelVar="doctor">
		<%
			StringBuilder result = new StringBuilder();
			String surgeryAttended = DoctorUtil.getSurgeriesAttendedAsStr(doctor.getId());
			if (surgeryAttended.isEmpty()) {
				surgeryAttended = "No clinic";
			}
		%>
		<liferay-ui:search-container-column-text
			name="FirstName"
			property="firstName"
		/>
		<liferay-ui:search-container-column-text
			name="LastName"
			property="lastName"
		/>
		<liferay-ui:search-container-column-text
			name="Specialty"
			value="<%= doctor.getSpeciality() %>"
		/>
		<liferay-ui:search-container-column-text
			name="Clinic"
			value="<%=surgeryAttended %>"
		/>
		<liferay-ui:search-container-column-jsp
			align="right"
			path="/html/surgerymanager/medicalstaff/doctors/searchDoctorsActions.jsp"
		/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>
<div class="panel-footer">
	<portlet:renderURL var="AddURL">
		<portlet:param name="jspPage" value="/html/surgerymanager/medicalstaff/doctors/addForm.jsp" />
	</portlet:renderURL>
	If your Doctor is not in the list click <aui:a href="<%= AddURL.toString() %>">here</aui:a>
</div>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
		
	</div>
</div>
