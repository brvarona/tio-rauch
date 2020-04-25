<%@page import="com.rxtro.core.util.enums.AppointmentType"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="50" />
</liferay-util:include>

<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/surgerymanager/appointments/history.jsp");
%>

<div class="messagesContainer">
	<liferay-ui:success key="Appoiment-canceled-successfully" message="Appointment cancelled" />
	<liferay-ui:success key="review-added" message="Review added" />
</div>

<h3>Previous Appointments</h3>
<liferay-ui:search-container delta="10" emptyResultsMessage="You do not have appointments in your history" iteratorURL="<%= iteratorURL %>">
	<liferay-ui:search-container-results>
		<%
			SurgeryModel surgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());
			List<AppModel> apps = AppUtil.getPrevAppsBySurgert(surgery.getId());
			results = ListUtil.subList(apps, searchContainer.getStart(), searchContainer.getEnd());
			total = apps.size();
			pageContext.setAttribute("results",results);
			pageContext.setAttribute("total",total);
		%>
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.AppModel"
		keyProperty="id"
		modelVar="app">

		<%
			String drugRepName = "";
			if (app.getDrugRep() != null) {
				drugRepName = app.getDrugRep().getFullName();
				if (app.getDrugRep().getTeam().getId() != -1) {
					drugRepName += " ("+app.getDrugRep().getTeam().getName()+")";
				}
			} else {
				System.out.println("Warning: Appointment with unidentified Drug Rep. id = "+app.getDrugRep().getId());
			}

			String target;
			if (app.isIndividual()) {
				if (app.getAttendants() != null && !app.getAttendants().isEmpty()) {
					target = app.getAttendants().get(0).getFullName();
				} else {
					target = "No Attendant";
				}
			}else {
				target = AppointmentType.SURGERY.getLabel();
			}
		%>
	<liferay-ui:search-container-column-text
		name="Drug Representative"
		value="<%= drugRepName %>"
	/>
	<liferay-ui:search-container-column-text
		name="With"
		value="<%= target %>"
	/>
	<liferay-ui:search-container-column-text
		name="First Line Products"
		value="<%= app.getDrugRep().getFirstLineProducts() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Date Time"
		value="<%= FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>"
	/>
	<liferay-ui:search-container-column-text
		name="Status"
		value="<%= app.getStatus().getLabel() %>"
	/>
	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/surgerymanager/appointments/history_actions.jsp"
	/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
	</div>
</div>

