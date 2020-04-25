<%@include file="/html/adminpanel/init.jsp" %>

<liferay-util:include page="/html/adminpanel/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="30" />
</liferay-util:include>

<style>
.grayText {
	color: #444;
	font-weight: bold;
	font-size: 16px;
}

.grayTextTitle {
	color: #666;
	font-weight: bold;
	font-size: 16px;
	text-decoration: underline;
}

.grayTextLabel {
	color: #666;
	font-weight: bold;
}
</style>

<portlet:actionURL name="searchSurgeryDetail" var="searchSurgeryDetailURL" />
<form action="<%=searchSurgeryDetailURL.toString() %>" method="post" name="" id="">
	<span class="grayText">
		Search for clinic detail
	</span>
	<br />
	<input type="text" name="<portlet:namespace/>surgeryEmail" value="" placeholder="email" />
	<br />
	<input type="text" name="<portlet:namespace/>userId" value="" placeholder="liferay user id" />
	<br />
	<input type="text" name="<portlet:namespace/>surgeryId" value="" placeholder="clinic id" />
	<br />
	<button class="btn btn-info">Submit</button>
</form>


<c:if test="${not empty surgery}">
	<span class="grayText">
		Clinic ${surgery.name}
	</span>
	<br />
	<br />
	<span class="grayTextTitle">
		Practice Manager:
	</span>
	<br />
	<ul>
		<li><span class="grayTextLabel">Address:</span> ${surgery.address.street1}</li>
		<li><span class="grayTextLabel">Create Date:</span> ${surgery.createDate}</li>
		<li><span class="grayTextLabel">Email:</span> ${surgery.email}</li>
		<li><span class="grayTextLabel">PM First Name:</span> ${surgery.pmFirstName}</li>
		<li><span class="grayTextLabel">PM Last Name:</span> ${surgery.pmLastName}</li>
		<li><span class="grayTextLabel">Region:</span> ${surgery.region.name} (${surgery.region.regionId})</li>
		<li><span class="grayTextLabel">Suburb:</span> ${surgery.suburb.name} (${surgery.suburb.id_suburb})</li>
		<li><span class="grayTextLabel">Liferay User Id:</span> ${surgery.userId}</li>
		<li><span class="grayTextLabel">Clinic Id:</span> ${surgery.surgeryId}</li>
		<li><span class="grayTextLabel">Is Active:</span> ${surgery.active}</li>
	</ul>
	<br />
	<span class="grayTextTitle">
		Doctors:
	</span>
	<br />
	<ul>
		<c:if test="${empty surgery.doctors}">No doctors</c:if>
		<c:forEach items="${surgery.doctors}" var="doctor">
			<li>${doctor.id} - ${doctor.fullName}</li>
		</c:forEach>
	</ul>
	<br />
	<span class="grayTextTitle">
		Drug Representatives:
	</span>
	<br />
	<ul>
		<c:if test="${empty surgery.drugReps}">No drug reps.</c:if>
		<c:forEach items="${surgery.drugReps}" var="drugRep">
			<li>${drugRep.id} - ${drugRep.email} - ${drugRep.firstName} - ${drugRep.lastName}</li>
		</c:forEach>
	</ul>
	<br />
	<span class="grayTextTitle">
		Drug Representatives Blocked:
	</span>
	<br />
	<ul>
		<c:if test="${empty drugRepsBlocked}">No drug reps. blocked</c:if>
		<c:forEach items="${drugRepsBlocked}" var="drugRepBlocked">
			<li><span class="grayTextLabel">Drug Rep Id:</span> ${drugRepBlocked.id_drug_representative}</li>
		</c:forEach>
	</ul>
	<br />
	<span class="grayTextTitle">
		Appointments:
	</span>
	<br />
	<ul>
		<c:if test="${empty apps}">No appointments</c:if>
		<c:forEach items="${apps}" var="app">
			<li>${app.appDate} - ${app.id} - ${app.drugRep.id} - ${app.status}</li>
		</c:forEach>
	</ul>
	<br />
	<span class="grayTextTitle">
		Clinic Schedules:
	</span>
	<br />
	<ul>
		<c:set var="isSsch" value="false" />
		<c:forEach items="${schedules}" var="ssch">
			<c:if test="${ssch.type eq 1}">
				<c:set var="isSsch" value="true" />
				<li>${ssch.time}</li>
			</c:if>
		</c:forEach>
		<c:if test="${not isSsch}">No clinic schedules</c:if>
	</ul>
	<br />
	<span class="grayTextTitle">
		Doctor Schedules:
	</span>
	<br />
	<ul>
		<c:set var="isDsch" value="false" />
		<c:forEach items="${schedules}" var="dsch">
			<c:if test="${dsch.type eq 2}">
				<c:set var="isDsch" value="true" />
				<li>${dsch.time}</li>
			</c:if>
		</c:forEach>
		<c:if test="${not isDsch}">No doctor schedules</c:if>
	</ul>
	<br />
	<span class="grayTextTitle">
		Clinic Block Out Dates:
	</span>
	<br />
	<ul>
		<c:if test="${empty surgeryBlockOutDates}">No clinic block out dates</c:if>
		<c:forEach items="${surgeryBlockOutDates}" var="sBlockOutDate">
			<li>${sBlockOutDate.from} - ${sBlockOutDate.to} - ${sBlockOutDate.description}</li>
		</c:forEach>
	</ul>
	<br />
	<span class="grayTextTitle">
		Doctor Block Out Dates:
	</span>
	<br />
	<ul>
		<c:if test="${empty doctorBlockOutDates}">No doctor block out dates</c:if>
		<c:forEach items="${doctorBlockOutDates}" var="dBlockOutDate">
			<li>${dBlockOutDate.from} - ${dBlockOutDate.to} - ${dBlockOutDate.description}</li>
		</c:forEach>
	</ul>
	<br />
</c:if>