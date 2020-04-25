<%@include file="/html/territorymanager/init.jsp" %>
<%@ page import="com.liferay.portal.service.RegionServiceUtil" %>

<portlet:actionURL name="filterSurgeries" var="filterSurgeriesURL" />

<%
String term = (String) session.getAttribute("term");
Long selectedRegionId = (Long) session.getAttribute("regionId");
Long selectedSuburbId = (Long) session.getAttribute("suburbId");
if (selectedRegionId == null || selectedRegionId == 0) {
	selectedRegionId = -1L;
}
if (selectedSuburbId == null || selectedSuburbId == 0) {
	selectedSuburbId = -1L;
}
%>

<liferay-portlet:resourceURL id="searchTerritories" var="searchTerritoriesURL" />
<liferay-portlet:resourceURL id="searchSuburbs" var="searchSuburbsURL" />

<form action="<%= filterSurgeriesURL.toString() %>" method="post" name="fm" class="form-search">
	<select id="regionSelector" name="<portlet:namespace/>regionId">
		<option value="-1" selected="selected">(All States)</option>
		<c:forEach items="${allRegions}" var="region">
			<option value="${region.regionId}">${region.name}</option>
		</c:forEach>
	</select>
	<select id="suburbSelector" name="<portlet:namespace/>suburbId">
		<option value="-1">(All Suburbs)</option>
		<c:forEach items="${allSuburbs}" var="suburb">
			<option value="${suburb.id}">${fn:toLowerCase(suburb.name)} (${suburb.postalCode})</option>
		</c:forEach>
	</select>
	<input placeholder="Name" autocomplete="off" id="inputSearchTerm" name="<portlet:namespace/>term" type="text" value="<%= term %>" />
    <button name="searchSurgery" type="submit" class="btn btn-default">Search</button>
	<input name="<portlet:namespace/>item" type="hidden" value="B" />
</form>

<p class="orangeText">
To find the clinic you are looking for, select a State or alternatively type the name of the clinic in the search.
</p>

<script charset="utf-8" type="text/javascript">
	YUI().ready(function(A) {
		initOnRegionSelectorEvent('<%= searchSuburbsURL.toString() %>', '<%= selectedRegionId %>', '<%= selectedSuburbId %>');
		
		var autoComplete = new AutoComplete({
			maxItems: 10,
			inputId: 'inputSearchTerm',
			cat1Id: 'regionSelector',
			cat2Id: 'suburbSelector',
			searchUrl: '<%= searchTerritoriesURL.toString() %>'
		});
		autoComplete.init();
		
	});
</script>