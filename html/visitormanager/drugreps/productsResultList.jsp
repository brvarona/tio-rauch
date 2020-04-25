<%@page import="com.rxtro.core.model.ShoppingItemDetailModel"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
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
PortletURL prodIteratorURL = renderResponse.createActionURL();
prodIteratorURL.setParameter(ActionRequest.ACTION_NAME, "searchProductsByNameAndCompanies");
if (request.getParameter("compTerm") != null) {
	prodIteratorURL.setParameter("compTerm", request.getParameter("compTerm"));
}
if (request.getParameter("productTerm") != null) {
	prodIteratorURL.setParameter("productTerm", request.getParameter("productTerm"));
}

if (request.getParameter("filterValue") != null) {
	prodIteratorURL.setParameter("filterValue", "2");
}

String compTerm = (String) request.getAttribute("compTerm");
if (compTerm == null) {
	compTerm = "";
}

String productTerm = (String) request.getAttribute("productTerm");
if (productTerm == null) {
	productTerm = "";
}

%>

<portlet:actionURL name="searchProductsByNameAndCompanies" var="searchProductsByNameAndCompaniesActionURL" />
<form action="<%=searchProductsByNameAndCompaniesActionURL.toString() %>" method="post" name="searchForm">
	
<%-- 	<aui:input name="surgeryId" type="hidden" value="${param.surgeryId}" /> --%>
	<aui:column>
		<select name="<portlet:namespace/>filterValue" onchange="doOnSelectSearched(this)" >
			<aui:option selected="false" value="1">Search by Rep</aui:option>
			<aui:option selected="true" value="2">Search by Product</aui:option>
		</select>
	</aui:column>
	<aui:column>
	    <div class="searchbox-term">
			<liferay-portlet:resourceURL id="searchCompanyAndTeams" var="searchCompanyAndTeamsURL" />
			<liferay-portlet:resourceURL id="searchRepsByCompanyAndTeams" var="searchRepsByCompanyAndTeamsURL" />
			<liferay-portlet:resourceURL id="searchProductsByNameAndCompanies" var="searchProductsByNameAndCompaniesURL" />
			<input class="input-medium" placeholder="All Companies" autocomplete="off" id="orgSearchTerm" name="<portlet:namespace/>compTerm" type="text" value="<%=compTerm %>" />
			
			<input class="input-medium" placeholder="All Products" autocomplete="off" id="pordSearchTerm" name="<portlet:namespace/>productTerm" type="text" value="<%=productTerm %>" />
			<input type="hidden" name="<portlet:namespace/>sku" id="sku" value="" />
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
						
						var prodAutoComplete = new AutoComplete2({
							maxItems: 15,
							inputId: 'pordSearchTerm',
							withCat: true,
							cat1Id: 'orgSearchTerm',
							cat2Id: 'orgId',
							cat3Id: 'isTeam',
							searchUrl: '<%= searchProductsByNameAndCompaniesURL.toString() %>',
							doOnSelect: function(data) {
								console.log(data);
								if (data) {
									document.getElementById('sku').value = data.sku;
								} else {
									document.getElementById('sku').value = '';
								}
							}
						});
						prodAutoComplete.init();
						
					} catch(e) {
						console.log(e);
					}
				});
			</script>
	    </div>
	</aui:column>
	<button class="btn btn-default" type="submit">Search</button>
</form>

<liferay-ui:search-container delta="10" emptyResultsMessage="No Results" iteratorURL="<%= prodIteratorURL %>" >
	<liferay-ui:search-container-results>

		<%
			List<ShoppingItemDetailModel> productResult = (List<ShoppingItemDetailModel>) request.getAttribute("productResult");
			if (productResult == null) {
				productResult = new ArrayList<ShoppingItemDetailModel>();
			}
			results = ListUtil.subList(productResult, searchContainer.getStart(),searchContainer.getEnd());
			total = productResult.size();
			System.out.println("Prduct Result Size="+total);
			pageContext.setAttribute("results",results);
			pageContext.setAttribute("total",total);

		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.ShoppingItemDetailModel"
		keyProperty="id"
		modelVar="prodDetail">
		<%
		String companyAndTeam = prodDetail.getCompanyName() + "/" + prodDetail.getTeamName();
		%>
		<liferay-ui:search-container-column-text
			name="Product"
			property="sku"
		/>
		<liferay-ui:search-container-column-text
			name="Company & Team"
			value="<%=companyAndTeam %>"
		/>
		<liferay-ui:search-container-column-text
			name="Status"
			property="status"
		/>
		<liferay-ui:search-container-row-parameter name="id" value="<%=prodDetail.getId() %>" />
		<liferay-ui:search-container-row-parameter name="drugReps" value="<%=prodDetail.getDrugReps() %>" />
		<liferay-ui:search-container-column-jsp
			align="right"
			path="/html/visitormanager/drugreps/productsResultActions.jsp"
		/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>