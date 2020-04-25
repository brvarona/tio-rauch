
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.enums.AppointmentStatus"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>
<%@page import="com.rxtro.core.model.AppModel"%>

<%@ page import="java.util.List" %>

<%@ page import="javax.portlet.PortletURL" %>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<%@include file="/html/territorymanager/territory/territoryMenu.jsp" %>

<h2>Cancellations and Vacancies</h2>

<liferay-ui:error key="appointment-already-Allocated-key" message="appointment-already-allocated-msg" />
<liferay-ui:error key="appointment-time-not-available-key" message="appointment-time-not-available-msg" />
<liferay-ui:error key="appointment-within-half-an-hour" message="Unfortunately you were unable to make this appointment as you already have an appointment at this time" />

<p>
	This is a list of clinics that you already have appointments with however there is an available appointment earlier than your current one
</p>

<%
Long appointmentId = (Long) request.getAttribute("appointmentId");
if (appointmentId == null && request.getParameter("appointmentId") != null) {
	appointmentId = Long.parseLong(request.getParameter("appointmentId"));
}

PortletURL iteratorURL = renderResponse.createRenderURL();
if (appointmentId != null) {
	iteratorURL.setParameter("appointmentId", String.valueOf(appointmentId));
}
iteratorURL.setParameter("jspPage", "/html/territorymanager/apptaker/earlierApps.jsp");

%>

<div class="earlyApps" id="earlyApps">
	<liferay-ui:search-container curParam="cur2" delta="30" emptyResultsMessage="No earlier appointments to take" iteratorURL="<%= iteratorURL %>" orderByCol="Clinic">
		<liferay-ui:search-container-results>
			<%
				List<AppModel> apps = AppUtil.getOtherSchedulesForDrugRepAndApp(drugRep.getId(), appointmentId);
				results = ListUtil.subList(apps, searchContainer.getStart(), searchContainer.getEnd());
				total = apps.size();
	
				pageContext.setAttribute("results", results);
				pageContext.setAttribute("total", total);
			%>
	
		</liferay-ui:search-container-results>
		<liferay-ui:search-container-row
			className="com.rxtro.core.model.AppModel"
			keyProperty="id"
			modelVar="app">
			<%
				String type = app.getType().getLabel();
				Long idTarget;
				if (app.isIndividual()) {
					type = type + " ( "+app.getAttendants().get(0).getFullName()+" )";
				}
				String colorRow = "";
				if (AppointmentStatus.APP_STATE_SWAPPED.equals(app.getStatus())) {
					colorRow = "rowColorBlue";
				}
				
				StringBuilder withDesc = new StringBuilder();
				withDesc.append("(");
				withDesc.append(app.getSurgery().getAddress().getCity());
				withDesc.append("), ");
				withDesc.append(app.getSurgery().getName());
				if (app.isIndividual()) {
					withDesc.append(" - ");
					if (app.getAttendants() != null && !app.getAttendants().isEmpty()) {
						withDesc.append(app.getAttendants().get(0).getFullName());
					} else {
						withDesc.append("No Attendant");
					}
				}
				withDesc.append(", ");
				withDesc.append(app.getSurgery().getAddress().getStreet1());
				withDesc.append(" ");
				withDesc.append(app.getSurgery().getAddress().getStreet2());
				withDesc.append(" ");
				withDesc.append(app.getSurgery().getAddress().getStreet3());
			%>
			<liferay-ui:search-container-column-text 
				name="When" 
				value="<%= FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>" 
				cssClass="<%=colorRow %>"
			/>
			<liferay-ui:search-container-column-text 
				name="With"
				value="<%= withDesc.toString() %>"
				cssClass="<%=colorRow %>"
			/>
			<liferay-ui:search-container-column-jsp 
				align="right" 
				path="/html/territorymanager/apptaker/earlierAppsAction.jsp" 
				cssClass="<%=colorRow %>"
			/>
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>

<style>
.earlyApps .rowColorBlue {
	background-color: #62B1FF !important;
    color: #fff;
}
</style>