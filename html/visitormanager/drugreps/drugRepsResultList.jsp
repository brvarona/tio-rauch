<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.sort.DrugRepOrderComparator.DrugRepTableColumnEnum"%>
<%@page import="com.rxtro.core.sort.DrugRepOrderComparator"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.liferay.portal.kernel.util.OrderByComparator"%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.liferay.portlet.PortletPreferencesFactoryUtil"%>
<%@page import="com.liferay.portlet.PortalPreferences"%>
<%@page import="javax.portlet.ActionRequest"%>
<%@ include file="/html/visitormanager/init.jsp" %>

<script>
function countText(event) { 
	document.getElementById("valmess2").innerHTML=""; // init and clear if b < max allowed character 
	a = document.getElementById("<portlet:namespace/>comments").value; 
	b = a.length; 
	if (b >= 999) {
		document.getElementById("valmess2").innerHTML="The max length of 999 characters is reached.";
		return false;
	} 
}
</script>

<%
PortletURL iteratorURL = renderResponse.createActionURL();
iteratorURL.setParameter(ActionRequest.ACTION_NAME, "searchRepsByCompanyAndTeams");
if (request.getParameter("compTerm") != null) {
	iteratorURL.setParameter("compTerm", request.getParameter("compTerm"));
}
if (request.getParameter("repTerm") != null) {
	iteratorURL.setParameter("repTerm", request.getParameter("repTerm"));
}

String compTerm = (String) request.getAttribute("compTerm");
if (compTerm == null) {
	compTerm = "";
}

String repTerm = (String) request.getAttribute("repTerm");
if (repTerm == null) {
	repTerm = "";
}

%>

<portlet:actionURL name="searchRepsByCompanyAndTeams" var="searchRepsByCompanyAndTeamsActionURL" />
<form action="<%=searchRepsByCompanyAndTeamsActionURL.toString() %>" method="post" name="searchForm">
	<aui:column>
		<select name="<portlet:namespace/>filterValue" onchange="doOnSelectSearched(this)" >
			<aui:option selected="true" value="1">Search by Rep</aui:option>
			<aui:option selected="false" value="2">Search by Product</aui:option>
		</select>
	</aui:column>
	<aui:column>
	    <div class="searchbox-term">
			<liferay-portlet:resourceURL id="searchCompanyAndTeams" var="searchCompanyAndTeamsURL" />
			<liferay-portlet:resourceURL id="searchRepsByCompanyAndTeams" var="searchRepsByCompanyAndTeamsURL" />
			<liferay-portlet:resourceURL id="searchProductsByNameAndCompanies" var="searchProductsByNameAndCompaniesURL" />
			<input class="input-medium" placeholder="All Companies" autocomplete="off" id="orgSearchTerm" name="<portlet:namespace/>compTerm" type="text" value="<%=compTerm %>" />
			
			<input class="input-medium" placeholder="All Representatives" autocomplete="off" id="repSearchTerm" name="<portlet:namespace/>repTerm" type="text" value="<%=repTerm %>" />
			<input type="hidden" name="<portlet:namespace/>orgId" id="orgId" value="" />
			<input type="hidden" name="<portlet:namespace/>isTeam" id="isTeam" value="" />
			
			<script charset="utf-8" type="text/javascript">
				YUI().ready(function(A) {
					try {
						var compAutoComplete = new AutoComplete2({
							maxItems: 15,
							inputId: 'orgSearchTerm',
							withCat: false,
							searchUrl: '<%= searchCompanyAndTeamsURL.toString() %>',
							doOnSelect: function(data) {
								if (data) {
									document.getElementById('orgId').value = data.id;
									document.getElementById('isTeam').value = data.isTeam;
								} else {
									document.getElementById('orgId').value = '';
									document.getElementById('isTeam').value = '';
								}
							}
						});
						compAutoComplete.init();
						
						var repAutoComplete = new AutoComplete2({
							maxItems: 15,
							inputId: 'repSearchTerm',
							withCat: true,
							cat1Id: 'orgSearchTerm',
							cat2Id: 'orgId',
							cat3Id: 'isTeam',
							searchUrl: '<%= searchRepsByCompanyAndTeamsURL.toString() %>',
							doOnSelect: function(data) {
								console.log(data);
							}
						});
						repAutoComplete.init();
						
					} catch(e) {
						console.log(e);
					}
				});
			</script>
	    </div>
	</aui:column>
	<button class="btn btn-default" type="submit">Search</button>
</form>

<br />


<%
PortalPreferences portalPrefs = PortletPreferencesFactoryUtil.getPortalPreferences(request); 
String sortByCol = ParamUtil.getString(request, "orderByCol");
String sortByType = ParamUtil.getString(request, "orderByType");
if (Validator.isNotNull(sortByCol) && Validator.isNotNull(sortByType)) {
	portalPrefs.setValue("NAME_SPACE", "sort-by-col", sortByCol);
	portalPrefs.setValue("NAME_SPACE", "sort-by-type", sortByCol);
} else {
	sortByCol = portalPrefs.getValue("NAME_SPACE", "sort-by-col", "Last Name");
	sortByType = portalPrefs.getValue("NAME_SPACE", "sort-by-type ", "asc");
}
%>
<liferay-ui:search-container delta="10" emptyResultsMessage="No Results" iteratorURL="<%= iteratorURL %>" orderByCol="<%= sortByCol %>" orderByType="<%= sortByType %>">
	<liferay-ui:search-container-results>

		<%
			List<DrugRepModel> drugRepresentativeList = (List<DrugRepModel>) request.getAttribute("searchResult");
			if (drugRepresentativeList != null) {
				OrderByComparator orderByComparator = new DrugRepOrderComparator(DrugRepTableColumnEnum.getByColName(sortByCol, DrugRepTableColumnEnum.LAST_NAME), sortByType);
				Collections.sort(drugRepresentativeList, orderByComparator);
				results = ListUtil.subList(drugRepresentativeList, searchContainer.getStart(),searchContainer.getEnd());
				total = drugRepresentativeList.size();
				pageContext.setAttribute("results",results);
				pageContext.setAttribute("total",total);
			} else {
		%>
			<script>
				location.href = '<%= searchRepsByCompanyAndTeamsActionURL.toString() %>';
			</script>
		<%
			}
		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.DrugRepModel"
		keyProperty="id"
		modelVar="drugRep">
		
		<%
			SurgeryModel surgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());
			String status = "Linked";
			if (drugRep.isBloqued()) {
				status = "Blocked";
			}
			String companyAndTeam = drugRep.getTeam().getCompany().getName() + "/" + drugRep.getTeam().getName();
		%>
		
		<liferay-ui:search-container-column-text
			name="Last Name"
			property="lastName"
			orderable="<%= true %>"
		/>
		<liferay-ui:search-container-column-text
			name="First Name"
			property="firstName"
			orderable="<%= true %>"
		/>
		<liferay-ui:search-container-column-text
			name="Company & Team"
			value="<%=companyAndTeam %>"
			orderable="<%= true %>"
		/>
		<liferay-ui:search-container-column-jsp
			align="right"
			path="/html/visitormanager/drugreps/drugRepStatus.jsp"
		/>
		<liferay-ui:search-container-row-parameter name="isBlocked" value="<%=drugRep.isBloqued() %>" />
		<liferay-ui:search-container-row-parameter name="compTerm" value="<%=compTerm %>" />
		<liferay-ui:search-container-row-parameter name="repTerm" value="<%=repTerm %>" />
		<liferay-ui:search-container-row-parameter name="surgeryId" value="<%=surgery.getId() %>" />
		<liferay-ui:search-container-row-parameter name="drugRepId" value="<%=drugRep.getId() %>" />
		<liferay-ui:search-container-row-parameter name="companyId" value="<%=drugRep.getTeam().getId() %>" />
		<liferay-ui:search-container-row-parameter name="status" value="<%=status %>" />
		<liferay-ui:search-container-column-jsp
			align="right"
			path="/html/visitormanager/drugreps/myDrugRepresentativeListActions.jsp"
		/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>