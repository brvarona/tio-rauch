<%@page import="javax.portlet.ActionRequest"%>
<%@page import="com.rxtro.core.util.enums.AppointmentStatus"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.sort.AppModelComparator"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.util.ScheduleUtil"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>

<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@ page import="com.segmax.drugrep.model.Appoiment" %>
<%@ page import="com.segmax.drugrep.service.AppoimentLocalServiceUtil" %>

<%@include file="/html/territorymanager/config.jsp" %>

<div class="" id="loading-mark-container">
	<div class="loading-mark"></div>
</div>

<div id="myAlert"></div>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="30" />
</liferay-util:include>

<div class="messagesContainer">
	<liferay-ui:success key="Appoiment-swaped-successfully" message="Appointment swapped successfully" />
	<liferay-ui:success key="Appoiment-successfully-Confirmed" message="Appointment successfully confirmed" />
	
	<liferay-ui:error key="appointment-already-exists" message="appointment-already-exists" />
	<liferay-ui:error key="appointment-canceled-error" message="appointment-canceled-error" />
	<liferay-ui:error key="appointment-can-not-canceled" message="appointment-can-not-canceled" />
	<liferay-ui:error key="premium-company-required" message="premium-company-required-msg" />
	<liferay-ui:error key="no-manager-company" message="no-manager-company-msg" />
	<liferay-ui:error key="invalid-user-manager" message="invalid-user-manager-msg" />
	<liferay-ui:error key="invalid-app-tranfer" message="invalid-app-tranfer-msg" />
	<liferay-ui:error key="app-already-confirmed" message="app-already-confirmed-msg" />
	<liferay-ui:error key="territory-missing-destination" message="territory-missing-destination-msg" />
	<liferay-ui:error key="appointment-is-not-canceleble-key" message="appointment-is-not-canceleble-msg" />
	
	<liferay-ui:error key="it-is-no-longer-possible-to-swap-err" message="it-is-no-longer-possible-to-swap-msg" />
	<liferay-ui:error key="invalid-territory-err" message="Invalid territory" />
</div>

<portlet:actionURL name="filterMyApps" var="filterMyAppsIteratorURLw">
	<portlet:param name="surgeryId" value="<%=request.getParameter(\"surgeryId\") %>"></portlet:param>
	<portlet:param name="drugRepId" value="<%=request.getParameter(\"drugRepId\") %>"></portlet:param>
</portlet:actionURL>

<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/territorymanager/appointments/myAppoiments.jsp");

PortletURL filterMyAppsIteratorURL = renderResponse.createActionURL();
filterMyAppsIteratorURL.setParameter(ActionRequest.ACTION_NAME, "filterMyApps");
filterMyAppsIteratorURL.setParameter("jspPage", "/html/territorymanager/appointments/myAppoiments.jsp");

if (request.getAttribute("surgeryId") != null) {
	filterMyAppsIteratorURL.setParameter("surgeryId", String.valueOf(request.getAttribute("surgeryId")));
} else if (request.getParameter("surgeryId") != null) {
	filterMyAppsIteratorURL.setParameter("surgeryId", request.getParameter("surgeryId"));
}
	
if (request.getAttribute("drugRepId") != null) {
	filterMyAppsIteratorURL.setParameter("drugRepId", String.valueOf(request.getAttribute("drugRepId")));
} else if (request.getParameter("drugRepId") != null) {
	filterMyAppsIteratorURL.setParameter("drugRepId", request.getParameter("drugRepId"));	
}

//List<AppModel> appsToBeReviewed = AppUtil.getPrevLastAppsTobeReviewedByDrugRep(drugRep.getId());
List<AppModel> appsToBeReviewed = AppUtil.getPrevLastAppsTobeReviewedByDrugRep(drugRep.getId(), AppUtil.MAX_DAYS_TO_BE_ALERT_BY_REVIEWED);

Collections.sort(appsToBeReviewed, new AppModelComparator());

Map<Long,String> assistance = (Map<Long,String>) session.getAttribute("statistics");
%>
<c:set var="drugRep" value="<%=drugRep %>" />

<c:if test="<%=!appsToBeReviewed.isEmpty() %>">
	<h3>Appointments to be completed</h3>
	<liferay-ui:search-container curParam="cur1" delta="10" emptyResultsMessage="You do not have appointments for review" iteratorURL="<%= iteratorURL %>">
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
			modelVar="app"
			>
			<%
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
		/>
		<liferay-ui:search-container-column-text 
			name="With"
			value="<%= withDesc.toString() %>"
		/>
		<liferay-ui:search-container-column-text
			name="Status"
			value="<%= app.getStatus().getLabel() %>"
		/>
		<liferay-ui:search-container-column-jsp
			align="right"
			path="/html/territorymanager/appointments/appsForReviewActions.jsp"
		/>
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</c:if>

<br />

<c:if test="${not empty orderResults}">
	<div id="productListBoxId">
		<liferay-util:include page="/html/territorymanager/appointments/productList.jsp" servletContext="<%= this.getServletContext() %>" />
	</div>
	<br />
</c:if>

<c:if test="${not empty drugRep and drugRep.team.premium}">
	<liferay-util:include page="/html/territorymanager/territory/targetTerritoryList.jsp" servletContext="<%= this.getServletContext() %>" />
</c:if>

<h3>Future Appointments</h3>

<c:if test="${not empty drugRep}">

	<portlet:actionURL name="filterMyApps" var="filterMyAppsURL" />
	<form action="<%= filterMyAppsURL.toString() %>" method="post" name="appBySurgeryFilterFm" class="form-search">
		Clinic
		<select name="<portlet:namespace/>surgeryId">
			<aui:option value="-1">All</aui:option>
			<c:forEach items="${surgeries}" var="surgery">
				<c:if test="${surgeryId eq surgery.id}">
					<aui:option selected="true" value="${surgery.id}">${surgery.name}</aui:option>
				</c:if>
				<c:if test="${surgeryId ne surgery.id}">
					<aui:option value="${surgery.id}">${surgery.name}</aui:option>
				</c:if>
			</c:forEach>
		</select>
		Representative
		<select name="<portlet:namespace/>drugRepId">
			<c:if test="<%=drugRep.getTeam().isPremium() %>">
				<aui:option value="-1">All</aui:option>
			</c:if>
			<c:if test="${drugRepId eq drugRep.id}">
				<aui:option selected="true" value="<%=drugRep.getId() %>">Me</aui:option>
			</c:if>
			<c:if test="${drugRepId ne drugRep.id}">
				<aui:option value="<%=drugRep.getId() %>">Me</aui:option>
			</c:if>
			<c:forEach items="${colleagues}" var="colleague">
				<c:if test="${drugRepId eq colleague.id}">
					<aui:option selected="true" value="${colleague.id}">${colleague.fullName}</aui:option>
				</c:if>
				<c:if test="${drugRepId ne colleague.id}">
					<aui:option value="${colleague.id}">${colleague.fullName}</aui:option>
				</c:if>
			</c:forEach>
		</select>
		<button name="filterByApps" type="submit" class="btn btn-default">Filter</button>
	</form>
	
	<div class="drugRepApps" id="drugRepApps">
		<liferay-ui:search-container delta="10" emptyResultsMessage="You do not have appointments" curParam="cur2" iteratorURL="<%= filterMyAppsIteratorURL %>">
			<liferay-ui:search-container-results>
	
				<%
						
					    List<AppModel> apps;
						if (request.getAttribute("apps") != null) {
							apps = (List<AppModel>) request.getAttribute("apps");
							session.setAttribute("apps", apps);
						} else {
							apps = (List<AppModel>) session.getAttribute("apps");
						}
						
					    if (apps == null) {
					    	apps = new ArrayList<AppModel>();
					    }
					    
						results = ListUtil.subList(apps, searchContainer.getStart(), searchContainer.getEnd());
						total = apps.size();
			
						pageContext.setAttribute("results",results);
						pageContext.setAttribute("total",total);
				%>
		
			</liferay-ui:search-container-results>
			<liferay-ui:search-container-row
				className="com.rxtro.core.model.AppModel"
				keyProperty="id"
				modelVar="appointment">
		
				<%
					StringBuilder withDesc = new StringBuilder();
					withDesc.append("(");
					withDesc.append(appointment.getSurgery().getAddress().getCity());
					withDesc.append("), ");
					withDesc.append(appointment.getSurgery().getName());
					if (appointment.isIndividual()) {
						withDesc.append(" - ");
						if (appointment.getAttendants() != null && !appointment.getAttendants().isEmpty()) {
							withDesc.append(appointment.getAttendants().get(0).getFullName());
						} else {
							withDesc.append("No Attendant");
						}
					}
					withDesc.append(", ");
					withDesc.append(appointment.getSurgery().getAddress().getStreet1());
					withDesc.append(" ");
					withDesc.append(appointment.getSurgery().getAddress().getStreet2());
					withDesc.append(" ");
					withDesc.append(appointment.getSurgery().getAddress().getStreet3());
					if (drugRep.getTeam().isPremium() && !appointment.isIndividual()) {
						withDesc.append("<br>");
						if (!assistance.containsKey(appointment.getScheduleId())) {
							String desc = ScheduleUtil.getAttendantsStatisticsByScheduleId(appointment.getScheduleId());
							assistance.put(appointment.getScheduleId(), desc);
						}
						withDesc.append(assistance.get(appointment.getScheduleId()));
					}
					
					String appStatus = appointment.getStatus().getLabel();
					if (appointment.getStatus().equals(AppointmentStatus.APP_STATE_PENDING_CONFIRMATION)) {
						appStatus = "Appointment Made";
					}
					String colorRow = "";
					if (appointment.getTerritory() != null) {
						if (appointment.getTerritory().isTarget()) {
							colorRow = "rowColorGreen";
							appointment.getTerritory().setTarget(true);
						} else {
							appointment.getTerritory().setTarget(false);
						}
					}
				%>
			<liferay-ui:search-container-column-text  cssClass="<%=colorRow %>"
				name="When"
				value="<%= FormatDateUtil.format(appointment.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>"
			/>
			<liferay-ui:search-container-column-text  cssClass="<%=colorRow %>"
				name="With"
				value="<%= withDesc.toString() %>"
			/>
			<liferay-ui:search-container-column-text  cssClass="<%=colorRow %>"
				name="Contact"
				value="<%= appointment.getSurgery().getPhone() %>"
			/>
			<liferay-ui:search-container-column-text  cssClass="<%=colorRow %>"
				name="Status"
				value="<%= appStatus %>"
			/>
			<liferay-ui:search-container-row-parameter name="cursor1" value="<%=request.getParameter(\"cur2\") %>" />
			<%
				if (permissionChecker.isOmniadmin() || isTestEnv) {
			%>
					<liferay-ui:search-container-column-text 
					cssClass="<%=colorRow %>"
					name="Clinic Time" 
					value="<%= appointment.getSurgery().getCurrentTimeStr(FormatDateUtil.PATTERN_YYYY_MM_DD_HH_MM) %>"
					 />
			<% } %>
			<%
			if (drugRep.getId().equals(appointment.getDrugRep().getId())) {
			%>
			<liferay-ui:search-container-column-jsp
				cssClass="<%=colorRow %>"
				align="right"
				path="/html/territorymanager/appointments/myAppoimentsActions.jsp"
			/>
			<%} else {
				String drugRepDesc = appointment.getDrugRep().getFullName();
				try {
					drugRepDesc += " - " + appointment.getDrugRep().getTeam().getName();
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
			<liferay-ui:search-container-column-text cssClass="<%=colorRow %>"
				name="Representative"
				value="<%= drugRepDesc %>"
			/>
			<%} %>
			</liferay-ui:search-container-row>
			<liferay-ui:search-iterator />
		</liferay-ui:search-container>
	</div>

</c:if>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
	</div>
</div>

<style>
.drugRepApps .rowColorYellow {
	background-color: #ffffcc !important;
}

.drugRepApps .rowColorRed {
	background-color: #ffbbbb !important;
}
.drugRepApps .rowColorGreen {
	background-color: #ccff99 !important;
}
.territories .notDisplay {
	display: none !important;
}

</style>