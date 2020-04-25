<%@ include file="/html/surgerymanager/init.jsp" %>

<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="40" />
</liferay-util:include>

<div class="messagesContainer">
	<liferay-ui:success key="Appoiment-canceled-successfully" message="Appointment cancelled" />
</div>

<h3>Future Appointments</h3>
<table class="table table-bordered table-hover table-striped">
	<thead class="table-columns" id="yui_patched_v3_11_0_1_1480005583210_206"> 
		<tr id="yui_patched_v3_11_0_1_1480005583210_205" class=""> 
			<th class="table-first-header" id="_surgerymanager_WAR_drugrepportlet_appointmentViewsSearchContainer_col-drug-representative"> Drug Representative </th> 
			<th class="" id="_surgerymanager_WAR_drugrepportlet_appointmentViewsSearchContainer_col-with"> With </th> 
			<th class="" id="_surgerymanager_WAR_drugrepportlet_appointmentViewsSearchContainer_col-first-line-products"> First Line Products </th> 
			<th class="" id="_surgerymanager_WAR_drugrepportlet_appointmentViewsSearchContainer_col-date-time"> Date Time </th> 
			<th class="" id="_surgerymanager_WAR_drugrepportlet_appointmentViewsSearchContainer_col-status"> Status </th> 
			<th class="table-last-header" id="_surgerymanager_WAR_drugrepportlet_appointmentViewsSearchContainer_col-6"> &nbsp; </th> 
		</tr> 
	</thead>
	<tbody class="table-data" >
		<tr>
			<td class="table-cell last" align="center" style="text-align: center" colspan="6">Loading...</td>
		</tr>
	</tbody>
</table>


<portlet:actionURL name="showSurgeryAppointmentView" var="showSurgeryAppointmentViewURL" />
<script>
	location.href = '<%= showSurgeryAppointmentViewURL.toString() %>';
</script>