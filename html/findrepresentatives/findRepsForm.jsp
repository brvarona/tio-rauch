<%@page import="com.rxtro.core.model.DrugRepBlockedInfo"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@ include file="/html/findrepresentatives/init.jsp" %>

<liferay-portlet:resourceURL id="quickSearchReps" var="quickSearchRepsURL" />
<portlet:actionURL name="searchReps" var="searchRepsURL" />
<form class="form-inline searchForm" action="<%=searchRepsURL.toString() %>" method="post" name="searchForm">
	<fieldset>
		<select name="<portlet:namespace/>seachByFilter" id="<portlet:namespace/>searchByFilter" >
			<option ${param.seachByFilter == 1 ? 'selected=selected':''} value="1">Search by Rep</option>
			<option ${param.seachByFilter == 2 ? 'selected=selected':''} value="2">Search by Company</option>
			<option ${param.seachByFilter == 3 ? 'selected=selected':''} value="3">Search by Product</option>
		</select>
		<input placeholder="All" autocomplete="off" id="<portlet:namespace/>term" name="<portlet:namespace/>term" type="text" value="${term}" />
		<input type="hidden" name="<portlet:namespace/>orgId" id="orgId" value="" />
		<input type="hidden" name="<portlet:namespace/>isTeam" id="isTeam" value="" />
		<script charset="utf-8" type="text/javascript">
			YUI().ready(function(A) {
				try {
					var repAutoComplete = new AutoComplete2({
						maxItems: 15,
						inputId: '<portlet:namespace/>term',
						withCat: true,
						cat1Id: '<portlet:namespace/>searchByFilter',
						cat2Id: 'orgId',
						cat3Id: 'isTeam',
						searchUrl: '<%=quickSearchRepsURL.toString() %>',
						doOnSelect: function(data) {
							if (data && data.id && data.isTeam) {
								document.getElementById('orgId').value = data.id;
								document.getElementById('isTeam').value = data.isTeam;
							} else {
								document.getElementById('orgId').value = '';
								document.getElementById('isTeam').value = '';
							}
						}
						
					});
					repAutoComplete.init();
				} catch(e) {
					console.log(e);
				}
			});
		</script>
		<button class="btn btn-default" type="submit">Search</button>
	</fieldset>
</form>

<%
SurgeryModel surgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());

PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/findrepresentatives/findRepsForm.jsp");
%>
<div class="drugRepApps" id="drugRepApps">
	<liferay-ui:search-container curParam="cur1" delta="10" emptyResultsMessage="No Reps" iteratorURL="<%=iteratorURL %>">
			<liferay-ui:search-container-results>
				<%
				List<DrugRepModel> drugRepsResult = (List<DrugRepModel>) session.getAttribute("searchResult");
				if (drugRepsResult != null) {
					results = ListUtil.subList(drugRepsResult, searchContainer.getStart(),searchContainer.getEnd());
					total = drugRepsResult.size();
					pageContext.setAttribute("results",results);
					pageContext.setAttribute("total",total);
				}
				%>
			</liferay-ui:search-container-results>
			<liferay-ui:search-container-row
				className="com.rxtro.core.model.DrugRepModel"
				keyProperty="id"
				modelVar="drugRep">
				
				<liferay-ui:search-container-row-parameter name="isBlocked" value="<%=drugRep.isBloqued() %>" />
				<liferay-ui:search-container-row-parameter name="surgeryId" value="<%=surgery.getId() %>" />
				<liferay-ui:search-container-column-jsp
					name="Representative"
					align="right"
					path="/html/findrepresentatives/repItem.jsp"
				/>
				<liferay-ui:search-container-column-jsp
					name="Status"
					align="right"
					path="/html/findrepresentatives/linkedInfo.jsp"
				/>
				<liferay-ui:search-container-column-jsp
					align="right"
					path="/html/findrepresentatives/repItemAction.jsp"
				/>
			</liferay-ui:search-container-row>
			<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
	</div>
</div>
