<%@page import="com.rxtro.core.model.NurseModel"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<%
	PortletURL itNursURL = renderResponse.createRenderURL();
	itNursURL.setParameter("jspPage", "/html/surgerymanager/medicalstaff/myMedicalStaff.jsp");
	SurgeryModel surgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());
%>

<h4>Nurses</h4>
<liferay-ui:search-container delta="10" emptyResultsMessage="No nurse added" curParam="nursecur" iteratorURL="<%= itNursURL %>" >
	<liferay-ui:search-container-results>
		<%
			List<NurseModel> tempResults = surgery.getNurses();
			results = ListUtil.subList(tempResults, searchContainer.getStart(), searchContainer.getEnd());
			total = tempResults.size();
			pageContext.setAttribute("results",results);
			pageContext.setAttribute("total",total);
		%>
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.NurseModel"
		keyProperty="id"
		modelVar="nurse">

	<liferay-ui:search-container-column-text
		name="First Name"
		property="firstName"
	/>
	<liferay-ui:search-container-column-text
		name="Last Name"
		property="lastName"
	/>
	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/surgerymanager/medicalstaff/nurse/myNursesActions.jsp"
	/>

	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>
