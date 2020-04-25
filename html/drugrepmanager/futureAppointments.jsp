<%@page import="com.rxtro.core.rep.management.AdminFactory"%>
<%@page import="com.rxtro.core.rep.management.AdminAbstract"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.util.enums.AppointmentType"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.model.TerritoryModel"%>
<%@page import="java.util.Map"%>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@include file="/html/drugrepmanager/init.jsp" %>

<%
DrugRepModel manager = DrugRepUtil.buildByUser(themeDisplay.getUser());
AdminAbstract admin = AdminFactory.build(manager);
%>
<liferay-util:include page="/html/drugrepmanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="20" />
	<liferay-util:param name="subordinatesTitle" value="<%=admin.getSubordinatesTitle() %>" />
</liferay-util:include>
<br />

<!-- View of the appointments of the DRs assigned to a DR Manager -->
<!-- Actions: No Actions -->

<%
PortletURL appsIteratorURL = renderResponse.createRenderURL();
appsIteratorURL.setParameter("jspPage", "/html/drugrepmanager/futureAppointments.jsp");

Long drugRepId = (Long) session.getAttribute("drugRepId");
if (drugRepId == null) {
	drugRepId = 0L;
}

Long managerId = (Long) session.getAttribute("managerId");
if (managerId == null) {
	managerId = 0L;
}

Map<String, TerritoryModel> territoriesTarget = (Map<String, TerritoryModel>) session.getAttribute("territoriesTarget");

%>

<portlet:resourceURL id="reloadRepOfManager" var="reloadRepOfManagerURL" />

<h3>Future Appointments</h3>
<portlet:actionURL var="getFutureAppsByDrugRepURL" name="getFutureAppsByDrugRep" />
<form action="<%=getFutureAppsByDrugRepURL.toString() %>" method="post" name="getByDrugRep" id="getByDrugRep" class="form-search">
	<c:if test="${not empty managersTeam}">
		<select name="<portlet:namespace/>managerId" id="filterManager" onchange="reloadRepOfManager('<%=reloadRepOfManagerURL.toString() %>', '<%=manager.getId() %>', this)">
			<option value="0">All Managers</option>
			<c:forEach items="${managersTeam}" var="manager" varStatus="status">
				<c:if test="${manager.id eq managerId}">
					<option selected="selected" value="${manager.id}">${manager.fullName}</option>
				</c:if>
				<c:if test="${not (manager.id eq managerId)}">
					<option value="${manager.id}">${manager.fullName}</option>
				</c:if>
			</c:forEach>
		</select>
	</c:if>

	<select name="<portlet:namespace/>drugRepId" id="filterRep">
		<option value="0">All Representatives</option>
		<c:forEach items="${drugRepsTeam}" var="drugRep" varStatus="status">
			<c:if test="${drugRep.id eq drugRepId}">
				<option selected="selected" value="${drugRep.id}">${drugRep.fullName}</option>
			</c:if>
			<c:if test="${not (drugRep.id eq drugRepId)}">
				<option value="${drugRep.id}">${drugRep.fullName}</option>
			</c:if>
		</c:forEach>
	</select>
	<button name="getFutureApps" type="submit" class="btn btn-default">Submit</button>
</form>

<div class="drugRepApps" id="drugRepApps">
	<liferay-ui:search-container curParam="appsCur" delta="10" emptyResultsMessage="Not appointments" iteratorURL="<%= appsIteratorURL %>">
		<liferay-ui:search-container-results>
			<%
				List<AppModel> apps = (List<AppModel>) session.getAttribute("futureApps");
				results = ListUtil.subList(apps, searchContainer.getStart(), searchContainer.getEnd());
				total = apps.size();

				pageContext.setAttribute("results", results);
				pageContext.setAttribute("total", total);
			%>
	
		</liferay-ui:search-container-results>
			<liferay-ui:search-container-row
				className="com.rxtro.core.model.AppModel"
				keyProperty="id"
				modelVar="app"
				>
			<%
				String where = app.getSurgery().getAddress().getStreet1() +
						", " + app.getSurgery().getAddress().getCity();
				
				String when = "Not Appointed Yet";
				String colorRow = "";
				if (app.getAppDate() != null) {
					when = FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM);
				}
				
				DrugRepModel repManager = app.getDrugRep().getManager();
				String territoryKey;
				String repManagerName;
				if (repManager != null) {
					territoryKey = repManager.getId() + "." + app.getTerritoryKey();
					repManagerName = repManager.getFullName();
				} else {
					territoryKey = app.getTerritoryKey();
					repManagerName = "";
				}
				
				boolean isTarget = territoriesTarget.containsKey(territoryKey);
				if (app.getAppDate() != null && isTarget) {
					colorRow = "rowColorGreen";
				} else if (isTarget) {
					colorRow = "rowColorRed";
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
		
			<liferay-ui:search-container-column-text cssClass="<%=colorRow %>"
				name="Rep"
				value="<%= app.getDrugRep().getFullName() %>"
			/>
			<c:if test="${empty managerId or managerId == 0}">
				<liferay-ui:search-container-column-text cssClass="<%=colorRow %>"
					name="Manager"
					value="<%= repManagerName %>"
				/>
			</c:if>
			<liferay-ui:search-container-column-text cssClass="<%=colorRow %>"
				name="When"
				value="<%= when  %>"
			/>
			<liferay-ui:search-container-column-jsp cssClass="<%=colorRow %>"
				align="left"
				path="/html/drugrepmanager/withLink.jsp"
			/>
			<liferay-ui:search-container-column-text cssClass="<%=colorRow %>"
				name="Contact"
				value="<%= app.getSurgery().getPhone()  %>"
			/>
			<liferay-ui:search-container-column-text cssClass="<%=colorRow %>"
				name="Is Target"
				value="<%= isTarget ? \"Yes\" : \"No\" %>"
			/>
			</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
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
</style>

