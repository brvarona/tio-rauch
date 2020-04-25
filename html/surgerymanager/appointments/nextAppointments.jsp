<%@page import="javax.portlet.ActionRequest"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@page import="javax.portlet.ResourceURL"%>
<%@page import="com.rxtro.core.util.enums.AppointmentStatus"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>

<%@ include file="/html/surgerymanager/init.jsp" %>

<%
PortletURL futureAppsIteratorURL = renderResponse.createRenderURL();
futureAppsIteratorURL.setParameter("jspPage", "/html/surgerymanager/appointments/appointments.jsp");

%>

<h3>Future Appointments</h3>
<portlet:actionURL name="filterMyApps" var="filterMyAppsURL" />
<form action="<%= filterMyAppsURL.toString() %>" method="post" name="appBySurgeryFilterFm" class="form-search">
	<select name="<portlet:namespace/>appFilterId">
		<option value="-1">All</option>
		<option value="0">Clinic Only</option>
		<optgroup label="Individuals">
			<c:forEach items="<%=surgery.getIndividualsAttendants() %>" var="individual">
				<option "${sessionScope.appFilterId eq individual.id ? 'selected=selected' : ''}" value="${individual.id}">${individual.fullName}</option>
			</c:forEach>
		</optgroup>
	</select>
	<button name="filterAppsButton" type="submit" class="btn btn-default">Filter</button>
</form>

<liferay-ui:search-container curParam="cur2" delta="10" emptyResultsMessage="No appointments on your Planner were found" iteratorURL="<%= futureAppsIteratorURL %>">
	<liferay-ui:search-container-results>
		<%
			List<AppModel> nextScheduleApps = AppUtil.getNextScheduleApps(surgery);
			results = ListUtil.subList(nextScheduleApps, searchContainer.getStart(), searchContainer.getEnd());
			total = nextScheduleApps.size();
			pageContext.setAttribute("results", results);
			pageContext.setAttribute("total", total);
		%>
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.AppModel"
		keyProperty="id"
		modelVar="appointment">
		<%
		String target = appointment.isIndividual() ? appointment.getAttendants().get(0).getFullName() : TerritoryType.GENERIC.getName();
		String drugRepInfo = "";
		String blockOutDateInfo = "";
		String productsInfo = "";
		if (appointment.isBlockOutDate()) {
			blockOutDateInfo = " " + appointment.getBlockOutDateDescription();
			appointment.setStatus(AppointmentStatus.APP_STATE_BLOQUED);
		} else if (!AppointmentStatus.APP_STATE_VACANT.equals(appointment.getStatus())) {
			DrugRepModel drugRep = appointment.getDrugRep();
			drugRepInfo = drugRep.getFullName();
			if (drugRep.getTeamId() != null && drugRep.getTeamId() > 0) {
				drugRepInfo += " (" + drugRep.getTeam().getName() + ")";
			}
			productsInfo = drugRep.getFirstLineProducts();
		}
		String appStatus = "Appointment Made";
		if (!AppointmentStatus.APP_STATE_PENDING_CONFIRMATION.equals(appointment.getStatus()) && !AppointmentStatus.APP_STATE_NOTIFIED.equals(appointment.getStatus())) {
			appStatus = appointment.getStatus().getLabel();
		}
		%>
		<liferay-ui:search-container-column-text
			name="Drug Representative"
			value="<%=drugRepInfo + blockOutDateInfo %>"
		/>
		<liferay-ui:search-container-column-text
			name="With"
			value="<%=target %>"
		/>
		<liferay-ui:search-container-column-text
			name="First Line Products"
			value="<%= productsInfo %>"
		/>
		<liferay-ui:search-container-column-text
			name="Date Time"
			value="<%=FormatDateUtil.format(appointment.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>"
		/>
		<liferay-ui:search-container-column-text
			name="Status"
			value="<%= appStatus %>"
		/>
		<liferay-ui:search-container-row-parameter name="appPageCursor" value="${cur2}" />
		<liferay-ui:search-container-column-jsp
			align="right"
			path="/html/surgerymanager/appointments/appoimentsActions.jsp"
		/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>
