<%@ include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>

<%@ page import="com.segmax.drugrep.model.Doctor" %>
<%@ page import="com.segmax.drugrep.model.Invited" %>
<%@ page import="com.segmax.drugrep.service.DoctorLocalServiceUtil" %>

<%@ page import="java.util.List" %>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="40" />
</liferay-util:include>

<liferay-ui:search-container delta="100" emptyResultsMessage="no-invited-were-found">
	<liferay-ui:search-container-results>

		<%
		    List<Invited> tempResults = (List<Invited>) request.getAttribute("listToReview");
			results = ListUtil.subList(tempResults,searchContainer.getStart(),searchContainer.getEnd());
			total = tempResults.size();

			pageContext.setAttribute("results",results);
			pageContext.setAttribute("total",total);
		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.segmax.drugrep.model.Invited"
		keyProperty="id_invited"
		modelVar="InvitedRow">

	<%
		Doctor unD = DoctorLocalServiceUtil.getDoctor(InvitedRow.getId_doctor());
	%>

	<liferay-ui:search-container-column-text
		name="Name"
		value="<%= unD.getFullName() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Doctor is attending"
		value="<%= InvitedRow.getPm_confirmation() %>"
	/>
	<liferay-ui:search-container-column-text
		name="Comment"
		value="<%= InvitedRow.getComment() %>"
	/>

	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/territorymanager/appointments/reviewActions.jsp"
	/>
	</liferay-ui:search-container-row>
</liferay-ui:search-container>

<liferay-ui:success key="Comment-added-successfully" message="Comment-added-successfully" />