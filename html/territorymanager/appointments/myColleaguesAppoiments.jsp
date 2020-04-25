<%@page import="com.rxtro.core.util.enums.AppointmentType"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@include file="/html/territorymanager/init.jsp" %>


<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.portlet.PortletURL" %>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="40" />
</liferay-util:include>

<div class="messagesContainer">
	<liferay-ui:success key="Appoiment-swaped-successfully" message="Appointment swapped successfully" />
	<liferay-ui:success key="Appoiment-successfully-Confirmed" message="Appointment successfully confirmed" />
	<liferay-ui:error key="appointment-already-exists" message="appointment-already-exists" />
	<liferay-ui:error key="appointment-canceled-error" message="appointment-canceled-error" />
	<liferay-ui:error key="appointment-can-not-canceled" message="appointment-can-not-canceled" />
</div>

<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/territorymanager/appointments/myColleaguesAppoiments.jsp");
%>

<h3>Colleagues Appointments</h3>
<liferay-ui:search-container delta="10" emptyResultsMessage="You do not have appointments" iteratorURL="<%= iteratorURL %>">
	<liferay-ui:search-container-results>

		<%
		    List<AppModel> colleaugesApps = drugRep.getColleaguesAppointments();
			results = ListUtil.subList(colleaugesApps, searchContainer.getStart(), searchContainer.getEnd());
			total = colleaugesApps.size();

			pageContext.setAttribute("results",results);
			pageContext.setAttribute("total",total);
		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.AppModel"
		keyProperty="id"
		modelVar="appointment">

	<%
		String target = appointment.getType().getLabel();
		if (appointment.getType().equals(AppointmentType.DOCTOR)) {
			if (appointment.getAttendants() != null && appointment.getAttendants().size() > 0) {
				target = appointment.getAttendants().get(0).getFullName();
			} else {
				target = "No Attendant";
			}
		}
		String status = appointment.getStatus().getLabel();
		if (status.equalsIgnoreCase("Pending Confirmation")) {
			status = "Appointment Made";
		}
		String where = appointment.getSurgery().getAddress().getStreet1() +
				", " + appointment.getSurgery().getAddress().getCity();
	%>

	<liferay-ui:search-container-column-text
		name="Drug Representative"
		value="<%= appointment.getDrugRep().getFullName() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Team"
		value="<%= appointment.getDrugRep().getTeam().getName() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Type"
		value="<%= target %>"
	/>
	<liferay-ui:search-container-column-text
		name="Clinic"
		value="<%= appointment.getSurgery().getName() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Where"
		value="<%= where %>"
	/>
	<liferay-ui:search-container-column-text
		name="When"
		value="<%= FormatDateUtil.format(appointment.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>"
	/>
	<liferay-ui:search-container-column-text
		name="Status"
		value="<%= status %>"
	/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>

