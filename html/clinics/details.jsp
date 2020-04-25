<%@ include file="/html/clinics/init.jsp" %>

<h3>Details</h3>

<portlet:actionURL name="getDetailsOfSurgery" var="getDetailsOfSurgeryURL" />
<form action="<%=getDetailsOfSurgeryURL.toString() %>" method="post" >
	<input type="text" name="<portlet:namespace/>surgeryId" value="" placeholder="Location Id" style="height: 28px;" />
	<br />
	<button class="btn btn-info">Submit</button>
</form>

<table class="table table-bordered table-hover table-striped">
	<thead class="table-columns">
		<tr>
			<th class="table-first-header">Name</th>
			<th>PM</th>
			<th>Location</th>
			<th>Active</th>
			<th>Apps.</th>
			<th>Territories</th>
			<th>Doctors</th>
			<th>Nurses</th>
			<th>Times</th>
			<th>Reps. Blocked</th>
			<th class="table-last-header">BODs</th>
		</tr>
	</thead>
	<tbody class="table-data">
		<c:forEach items="${detailsResult}" var="surgery">
			<tr>
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
				<td class="table-cell last">${surgery.totalBOD}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>