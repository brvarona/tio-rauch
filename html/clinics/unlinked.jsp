<%@ include file="/html/clinics/init.jsp" %>

<liferay-util:include page="/html/clinics/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="30" />
</liferay-util:include>

<h3>Unlinked Clinics</h3>

<portlet:actionURL name="runSurgeryUnlinkedCollector" var="runSurgeryUnlinkedCollectorURL" />
<form action="<%=runSurgeryUnlinkedCollectorURL.toString() %>" method="post" >
	<button class="btn btn-info">Search</button>
</form>

<table class="table table-bordered table-hover table-striped">
	<thead class="table-columns">
		<tr>
			<th class="table-first-header">Unlinked</th>
			<th>Name</th>
			<th>PM</th>
			<th>Location</th>
			<th>Active</th>
			<th>Apps.</th>
			<th>Territories</th>
			<th>Doctors</th>
			<th>Nurses</th>
			<th>Times</th>
			<th>Reps. Blocked</th>
			<th>BODs</th>
			<th class="table-last-header"></th>
		</tr>
	</thead>
	<tbody class="table-data">
		<c:forEach items="${unlinkedResult}" var="surgery">
			<tr>
				<td class="table-cell">${surgery.comments}</td>
				<td class="table-cell">${surgery.name}</td>
				<td class="table-cell">${surgery.userId}</td>
				<td class="table-cell">${surgery.orgId}</td>
				<td class="table-cell">${surgery.active}</td>
				<td class="table-cell">${surgery.totalApps}</td>
				<td class="table-cell">${surgery.totalTerritories}</td>
				<td class="table-cell">${surgery.totalDoctors}</td>
				<td class="table-cell">${surgery.totalNurses}</td>
				<td class="table-cell">${surgery.totalSchedules}</td>
				<td class="table-cell">${surgery.totalDrugRepBlocked}</td>
				<td class="table-cell">${surgery.totalBOD}</td>
				<td class="table-cell last">
					<liferay-ui:icon-menu>
						<c:if test="${surgery.readyToRemove}">
							<portlet:actionURL name="cleanSurgeryUnlinked" var="cleanSurgeryUnlinkedURL">
								<portlet:param name="surgeryId" value="${surgery.orgId}"></portlet:param>
							</portlet:actionURL>
							<liferay-ui:icon image="delete" message="Clean" url="<%=cleanSurgeryUnlinkedURL.toString() %>" />
						</c:if>
					</liferay-ui:icon-menu>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

