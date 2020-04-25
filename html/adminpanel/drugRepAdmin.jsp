<%@include file="/html/adminpanel/init.jsp" %>

<liferay-util:include page="/html/adminpanel/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="40" />
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

<portlet:actionURL name="searchDrugRepDetail" var="searchDrugRepDetailURL" />
<form action="<%=searchDrugRepDetailURL.toString() %>" method="post" name="" id="">
	<span class="grayText">
		Search for drug rep detail
	</span>
	<br />
	<input type="text" name="<portlet:namespace/>drugRepEmail" value="${param.drugRepEmail}" placeholder="email" />
	<br />
	<input type="text" name="<portlet:namespace/>userId" value="${param.userId}" placeholder="liferay user id" />
	<br />
	<input type="text" name="<portlet:namespace/>drugRepId" value="${param.drugRepId}" placeholder="Drug Rep id" />
	<br />
	<button class="btn btn-info">Submit</button>
</form>

<c:if test="${not empty drugRep}">
	<span class="grayText">
		Drug Rep Detail
	</span>
	<br />
	<br />
	<span class="grayTextTitle">
		${drugRep.fullName}
	</span>
	<br />
	<ul>
		<li><span class="grayTextLabel">Mobile Phone:</span> ${drugRep.mobilePhone}</li>
		<li><span class="grayTextLabel">Liferay User Id:</span> ${drugRep.userId}</li>
		<li><span class="grayTextLabel">Drug Rep Id:</span> ${drugRep.id}</li>
		<li><span class="grayTextLabel">Email:</span> ${drugRep.email}</li>
		<li><span class="grayTextLabel">Is Active:</span> ${drugRep.active ? 'ACTIVE' : 'NO ACTIVE'}</li>
		<li><span class="grayTextLabel">First Line Products:</span> ${drugRep.firstLineProducts}</li>
		<li><span class="grayTextLabel">Other Products:</span> ${drugRep.secondLineProducts}</li>
		<li><span class="grayTextLabel">Location:</span> ${drugRep.locationInLine}</li>
		<li><span class="grayTextLabel">Stop Notification:</span> ${drugRep.stopNotification}</li>
		<li><span class="grayTextLabel">Created Date:</span> ${drugRep.createDate}</li>
		<li><span class="grayTextLabel">Company:</span> ${drugRep.company.name} (drugRep.company.id)</li>
	</ul>
	<br />
	<span class="grayTextTitle">
		Territories:
	</span>
	<br />
	<ul>
		<c:forEach items="${drugRep.territories}" var="t">
			<li><span class="grayTextLabel">Id:</span> ${t.id}</li>
			<li>
				<ul>
					<li><span class="grayTextLabel">Surgery:</span> ${t.surgery.name} (t.surgery.id)</li>
					<li><span class="grayTextLabel">Type:</span> ${t.type.name}</li>
					<c:if test="${not empty t.allAppointments}">
						<li><span class="grayTextLabel">Appointments:</span></li>
						<li>
							<ul>
								<c:forEach items="${t.allAppointments}" var="a">
									<li><span class="grayTextLabel">${a.appDate}</span></li>
									<li>
										<ul>
											<li>${a.status.label}</li>
											<li>${a.type.name}</li>
											<li><span class="grayTextLabel">Doctors:</span></li>
											<li>
												<ul>
													<c:forEach items="${a.attendants}" var="at">
														<li>${at.fullName} ${at.id}</li>
													</c:forEach>
												</ul>
											</li>
										</ul>
									</li>
								</c:forEach>
							</ul>
						</li>
					</c:if>
				</ul>
			</li>
		</c:forEach>
	</ul>
	<br />
	<span class="grayTextTitle">
		History:
	</span>
	<br />
	<ul>
		<c:forEach items="${history}" var="h">
			<c:if test="${drugRep.id ne h.id}">
				<li><span class="grayText">Drug Rep: ${h.fullName}</span></li>
				<li>
					<ul>
						<li><span class="grayTextLabel">Liferay User Id:</span> ${h.userId}</li>
						<li><span class="grayTextLabel">Drug Rep Id:</span> ${h.id}</li>
						<li><span class="grayTextLabel">Email:</span> ${h.email}</li>
						<li><span class="grayTextLabel">Is Active:</span> ${h.active ? 'ACTIVE' : 'NO ACTIVE'}</li>
						<li><span class="grayTextLabel">Created Date:</span> ${h.createDate}</li>
						<li><span class="grayTextLabel">Company:</span> ${h.company.name} (h.company.id)</li>
					</ul>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<br />
	<span class="grayTextTitle">
		Manager User Detail
	</span>
	<c:if test="${not empty drugRep.drugRepManager}">
		<ul>
			<li><span class="grayTextLabel">Name:</span> ${drugRep.drugRepManager.fullName}</li>
			<li><span class="grayTextLabel">Liferay User Id:</span> ${drugRep.drugRepManager.userId}</li>
			<li><span class="grayTextLabel">Drug Rep Id:</span> ${drugRep.drugRepManager.id}</li>
			<li><span class="grayTextLabel">Email:</span> ${drugRep.drugRepManager.email}</li>
			<li><span class="grayTextLabel">Is Active:</span> ${drugRep.drugRepManager.active ? 'ACTIVE' : 'NO ACTIVE'}</li>
			<li><span class="grayTextLabel">Created Date:</span> ${drugRep.drugRepManager.createDate}</li>
			<li><span class="grayTextLabel">Company:</span> ${drugRep.drugRepManager.company.name} (drugRep.drugRepManager.company.id)</li>
		</ul>
	</c:if>
	<c:if test="${empty drugRep.drugRepManager}">
		Does not have manager
	</c:if>
	<br />
	<span class="grayTextTitle">
		Team:
	</span>
	<c:if test="${drugRep.isManagerOfTeam}">
		<ul>
			<c:forEach items="${team}" var="t">
				<li>${t}</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${!drugRep.isManagerOfTeam}">
		Not an manager
	</c:if>
	<br />
	<span class="grayTextTitle">
		Blocked by
	</span>
	<c:if test="${not empty surgeriesThatBlockedMe}">
		<ul>
			<c:forEach items="${surgeriesThatBlockedMe}" var="s">
				<li>${s.name} (${s.id})</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${empty surgeriesThatBlockedMe}">
		No surgery blocked this drug representative
	</c:if>
	<br />
</c:if>

