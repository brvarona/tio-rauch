<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@ page import="com.segmax.drugrep.model.Surgery" %>
<%@ page import="com.segmax.drugrep.service.SurgeryLocalServiceUtil" %>
<%@ page import="com.segmax.drugrep.model.Appoiment" %>
<%@ page import="com.segmax.drugrep.service.AppoimentLocalServiceUtil" %>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="50" />
</liferay-util:include>

<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/territorymanager/appointments/history.jsp");
%>

<h3>Previous Appointments</h3>
<liferay-ui:search-container delta="10" emptyResultsMessage="You do not have appointments in your history" iteratorURL="<%= iteratorURL %>">
	<liferay-ui:search-container-results>

		<%
		    //List<Appoiment> tempResults = AppoimentLocalServiceUtil.getHistoryByUser(themeDisplay.getUserId());
			List<AppModel> apps = AppUtil.getPrevAppsByUser(themeDisplay.getUserId());
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
			String surgeryName = app.getSurgery().getName();
			String suburbName = app.getSurgery().getAddress().getCity();
			String address = app.getSurgery().getAddress().getStreet1() + ", " + suburbName;
			if (app.isIndividual()) {
				if (app.getAttendants() != null && app.getAttendants().size() > 0) {
					surgeryName += " " + app.getAttendants().get(0).getFullName();
				} else {
					surgeryName += " " + "No Attendant";
				}
			}
		%>
	<liferay-ui:search-container-column-text
		name="Suburb"
		value="<%= suburbName %>"
	/>
	<liferay-ui:search-container-column-text
		name="Clinic"
		value="<%= surgeryName %>"
	/>
	<liferay-ui:search-container-column-text
		name="Where"
		value="<%= address %>"
	/>
	<liferay-ui:search-container-column-text
		name="When"
		value="<%=FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>"
	/>
	<liferay-ui:search-container-column-text
		name="Status"
		value="<%= app.getStatus().getLabel() %>"
	/>
	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/territorymanager/appointments/historyActions.jsp"
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
