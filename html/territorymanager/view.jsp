<%@ include file="/html/territorymanager/init.jsp" %>

<%
if (!permissionChecker.isOmniadmin()) {
%>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="30" />
</liferay-util:include>

<h3>Future Appointments</h3>
<table class="table table-bordered table-hover table-striped">
	<thead class="table-columns" id="yui_patched_v3_11_0_1_1480005583210_206"> 
		<tr id="yui_patched_v3_11_0_1_1480005583210_205" class=""> 
			<th class="" id="_territorymanager_WAR_drugrepportlet_appointmentModelsSearchContainer_col-when"> When </th> 
			<th class="" id="_territorymanager_WAR_drugrepportlet_appointmentModelsSearchContainer_col-suburb"> With </th>
			<th class="" id="_territorymanager_WAR_drugrepportlet_appointmentModelsSearchContainer_col-contact"> Contact </th> 
			<th class="table-last-header" id="_territorymanager_WAR_drugrepportlet_appointmentModelsSearchContainer_col-status"> Status </th> 
			<th class="table-last-header" id="_territorymanager_WAR_drugrepportlet_appointmentModelsSearchContainer_col-7"> &nbsp; </th>
		</tr> 
	</thead>
	<tbody class="table-data" >
		<tr>
			<td class="table-cell last" align="center" style="text-align: center" colspan="7">Loading...</td>
		</tr>
	</tbody>
</table>

<portlet:actionURL name="showMyApps" var="showMyAppsURL" />
<script>
	location.href = '<%= showMyAppsURL.toString() %>';
</script>

<%} %>