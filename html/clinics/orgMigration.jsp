<%@ include file="/html/clinics/init.jsp" %>

<liferay-util:include page="/html/clinics/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="40" />
</liferay-util:include>

<style>
.resultPanel {
	padding: 5px;
	border: 1px solid #444;
	height: 200px;
	max-height: 200px;
	overflow: scroll;
}

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

</style>

<div>
	${totalActiveToBeMigrated} active clinics not migrated yet
</div>
<div>
	${totalInactiveToBeMigrated} inactive clinics not migrated yet
</div>
<br />
<div>
	<portlet:actionURL name="migrateSurgeries" var="migrateSurgeriesURL" />
	<form action="<%=migrateSurgeriesURL.toString() %>" method="post" name="" id="">
		<input type="number" name="<portlet:namespace/>pmUserId" value="" placeholder="User Id" style="height: 28px;"  />
		<br />
		<input type="text" name="<portlet:namespace/>pmEmail" value="" placeholder="Email" style="height: 28px;"  />
		<br />
		<button class="btn btn-info">Submit</button>
	</form>
</div>
<br />
<div class="resultPanel">
	<c:if test="${empty migratedSurgeries}">
		<span class="grayText">
			Migration Results
		</span>
	</c:if>
	<c:if test="${not empty migratedSurgeries}">
		<span class="grayTextTitle">
			Recently migrated clinics:
		</span>
		<ul>
			<c:forEach items="${migratedSurgeries}" var="mSur">
				<li>${mSur}</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${not empty notMigratedSurgeries}">
		<span class="grayTextTitle">
			Error migrating ${fn:length(notMigratedSurgeries)} clinics:
		</span>
		<ul>
			<c:forEach items="${notMigratedSurgeries}" var="eSur">
				<li>${eSur}</li>
			</c:forEach>
		</ul>
	</c:if>
	
</div>