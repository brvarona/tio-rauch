<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.model.MedicalStaff"%>
<%@page import="com.segmax.drugrep.model.Speciality"%>
<%@page import="com.segmax.drugrep.service.DoctorLocalServiceUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>

<%@ page import="java.util.List" %>

<%@ page import="javax.portlet.PortletURL" %>

<%
PortletURL docIteratorURL = renderResponse.createRenderURL();
docIteratorURL.setParameter("jspPage", "/html/territorymanager/territory/availableTerritories.jsp");
%>

<h3>Individuals to add to your territory</h3>
<liferay-ui:search-container curParam="cur3" delta="10" emptyResultsMessage="No individuals to add" iteratorURL="<%= docIteratorURL %>">
	<liferay-ui:search-container-results>

		<%
			if (session.getAttribute("listDoctorWorkSurgery") != null) {
				List<MedicalStaff> listOfDoctorsWorkSurgery = (List<MedicalStaff>) session.getAttribute("listDoctorWorkSurgery");
				results = ListUtil.subList(listOfDoctorsWorkSurgery, searchContainer.getStart(), searchContainer.getEnd());
				total = listOfDoctorsWorkSurgery.size();

				pageContext.setAttribute("results",results);
				pageContext.setAttribute("total",total);
			}
		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.MedicalStaff"
		keyProperty="id"
		modelVar="individual">
	<%
		long diffTime = Calendar.getInstance().getTime().getTime() - individual.getSurgery().getCreateDate().getTime();
		long diffDays = diffTime / (1000 * 60 * 60 * 24);
		String surgeryStyle = "";
		String addLinkTitle = "Add";
		if (diffDays <= 30) {
			surgeryStyle = "highlight-text-1";
			addLinkTitle = "New Add";
		}
		List<Speciality> speciality = DoctorLocalServiceUtil.getSpecialty(individual.getId());
	%>
	<liferay-ui:search-container-column-text
		name="State"
		value="<%= individual.getSurgery() != null ? individual.getSurgery().getAddress().getRegion().getName() : new String() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Suburb"
		value="<%= individual.getSurgery() != null ? individual.getSurgery().getAddress().getCity() : new String()  %>"
	/>
	<liferay-ui:search-container-column-text cssClass="<%=surgeryStyle %>"
		name="Clinic"
		value="<%= individual.getSurgery() != null ? individual.getSurgery().getName() : new String()  %>"
	/>
	<liferay-ui:search-container-column-text cssClass="<%=surgeryStyle %>"
		name="Name"
		value="<%= individual.getFirstName() %>"
	/>
	<liferay-ui:search-container-column-text cssClass="<%=surgeryStyle %>"
		name="Surname"
		value="<%= individual.getLastName() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Gender"
		value="<%= individual.getGender() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Specialty"
		value="<%=speciality.get(0).getName()%>"
	/>
	<liferay-ui:search-container-row-parameter name="addLinkTitle" value="<%=addLinkTitle %>" />
	<liferay-ui:search-container-row-parameter name="drugRep" value="<%=drugRep %>" />
	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/territorymanager/doctors/doctorListActions.jsp"
	/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>