<%@page import="com.segmax.drugrep.service.persistence.SuburbActionableDynamicQuery"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="com.segmax.drugrep.service.SuburbLocalServiceUtil"%>
<%@page import="com.segmax.drugrep.model.Suburb"%>
<%@page import="java.util.List"%>

<%@include file="/html/suburb/init.jsp" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />

<portlet:actionURL name="addSuburb" var="addSuburbURL" />

<aui:form action="<%= addSuburbURL.toString() %>" method="post">

<aui:fieldset>

	<aui:input name="sbName" size="45" />

	<aui:input name="sbPostalCode" size="45" />

	<%
	  List<Suburb> suburbList = SuburbLocalServiceUtil.getAll();
	%>

	<aui:select label="Select a City" name="sbIdCity">
	  <aui:option value="-1">
		<liferay-ui:message key="please-choose" />
	  </aui:option>

	  <%
		for (int i = 0; i < suburbList.size(); i++) {
	  %>

	  <aui:option
		value="<%= suburbList.get(i).getId_suburb() %>">
		<%= suburbList.get(i).getName() %>
	  </aui:option>

	  <%
		}
	  %>

	</aui:select>
	<liferay-ui:error key="fields-required" message="Pleas Select a City" />

	<aui:button-row>

	  <aui:button type="submit" />

	</aui:button-row>

</aui:fieldset>

</aui:form>
<liferay-ui:success key="Suburb-saved-successfully" message="The Suburb was saved successfully" />
<liferay-ui:error key="fields-required" message="Fields required" />

<liferay-ui:search-container>
	<liferay-ui:search-form page=""></liferay-ui:search-form>
	<liferay-ui:search-container delta="10" emptyResultsMessage="no-suburbs-were-found" />
	<liferay-ui:search-container-results>

		<%
			List<Suburb> tempResults = SuburbLocalServiceUtil.getAll();
			results = ListUtil.subList(tempResults,searchContainer.getStart(),searchContainer.getEnd());
			total = tempResults.size();

			pageContext.setAttribute("results",results);
			pageContext.setAttribute("total",total);
		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.segmax.drugrep.model.Suburb"
		keyProperty="id_suburb"
		modelVar="Suburba">

	<liferay-ui:search-container-column-text
		name="Name"
		property="name"
	/>
	<liferay-ui:search-container-column-text
		name="PostalCode"
		property="postal_code"
	/>

	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>