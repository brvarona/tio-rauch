<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.enums.AppointmentType"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<%
PortletURL reviewIteratorURL = renderResponse.createRenderURL();
reviewIteratorURL.setParameter("jspPage", "/html/surgerymanager/appointments/appointments.jsp");

List<AppModel> appsToBeReviewed = AppUtil.getPrevLastAppsTobeReviewedBySurgery(surgery);
%>

<c:if test="<%=!appsToBeReviewed.isEmpty() %>">
	<h3>Appointments to be reviewed</h3>
	<liferay-ui:search-container  curParam="cu1" delta="10" emptyResultsMessage="You do not have appointments to be reviewed" iteratorURL="<%= reviewIteratorURL %>">
		<liferay-ui:search-container-results>
			<%
				results = ListUtil.subList(appsToBeReviewed, searchContainer.getStart(), searchContainer.getEnd());
				total = appsToBeReviewed.size();
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
					System.out.println("[WARNING] Appointment with unidentified Drug Rep. id = "+app.getId());
				}

				String target;
				if (app.isIndividual()) {
					try {
						target = app.getAttendants().get(0).getFullName();						
					} catch (Exception e) {
						target = "No Attendant";
					}
				}else {
					target = AppointmentType.SURGERY.getLabel();
				}
			%>
		<liferay-ui:search-container-column-text
			name="Drug Representative"
			value="<%=drugRepName %>"
		/>
		<liferay-ui:search-container-column-text
			name="With"
			value="<%=target %>"
		/>
		<liferay-ui:search-container-column-text
			name="First Line Products"
			value="<%=app.getDrugRep().getFirstLineProducts() %>"
		/>
		<liferay-ui:search-container-column-text
			name="Date Time"
			value="<%=FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>"
		/>
		<liferay-ui:search-container-column-text
			name="Status"
			value="<%=app.getStatus().getLabel() %>"
		/>
		<liferay-ui:search-container-column-jsp
			align="right"
			path="/html/surgerymanager/appointments/appToBeReviewedAction.jsp"
		/>
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</c:if>