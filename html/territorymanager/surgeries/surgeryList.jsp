<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="com.liferay.portal.model.Region" %>
<%@ page import="com.liferay.portal.service.RegionServiceUtil" %>

<%@ page import="com.segmax.drugrep.model.Suburb" %>
<%@ page import="com.segmax.drugrep.model.Surgery" %>
<%@ page import="com.segmax.drugrep.service.SuburbLocalServiceUtil" %>

<%@ page import="java.util.List" %>

<%@ page import="javax.portlet.PortletURL" %>

<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/territorymanager/territory/availableTerritories.jsp");
%>

<h3>Available Clinics to add to your Territory</h3>
<liferay-ui:search-container curParam="cur1" delta="10" emptyResultsMessage="No Clinics to add" iteratorURL="<%= iteratorURL %>">
	<liferay-ui:search-container-results>

		<%
			if (session.getAttribute("listSurgery") != null) {
				List<SurgeryModel> surgeryList = (List<SurgeryModel>) session.getAttribute("listSurgery");
				results = ListUtil.subList(surgeryList, searchContainer.getStart(), searchContainer.getEnd());
				total = surgeryList.size();
				pageContext.setAttribute("results",results);
				pageContext.setAttribute("total",total);
			}
		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.SurgeryModel"
		keyProperty="id"
		modelVar="surgery">

	<%
		long diffTime = Calendar.getInstance().getTime().getTime() - surgery.getCreateDate().getTime();
		long diffDays = diffTime / (1000 * 60 * 60 * 24);
		String surgeryStyle = "";
		String addLinkTitle = "Add";
		if (diffDays <= 30) {
			surgeryStyle = "highlight-text-1";
			addLinkTitle = "New Add";
		}
	%>

	<liferay-ui:search-container-column-text
		name="State"
		value="<%= surgery.getAddress().getRegion().getName() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Suburb"
		value="<%= surgery.getAddress().getCity() %>"
	/>
	<liferay-ui:search-container-column-text cssClass="<%=surgeryStyle %>"
		name="Name"
		property="name"
	/>
	<liferay-ui:search-container-column-text
		name="Address"
		value="<%=surgery.getAddress().getStreet1() %>"
	/>
	<liferay-ui:search-container-row-parameter name="addLinkTitle" value="<%=addLinkTitle %>" />
	<liferay-ui:search-container-row-parameter name="drugRep" value="<%=drugRep %>" />
	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/territorymanager/surgeries/surgeryListActions.jsp"
	/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>