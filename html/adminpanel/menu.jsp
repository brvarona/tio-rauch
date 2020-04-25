<%@include file="/html/adminpanel/init.jsp" %>

<portlet:actionURL name="showMigrateSurgeriesForm" var="showMigrateSurgeriesFormURL" />

<portlet:renderURL var="viewAdminPanelURL">
	<portlet:param name="jspPage" value="/html/adminpanel/view.jsp" />
</portlet:renderURL>

<portlet:renderURL var="viewSurgeryAdminlURL">
	<portlet:param name="jspPage" value="/html/adminpanel/surgery/surgeryAdmin.jsp" />
</portlet:renderURL>

<portlet:renderURL var="viewDrugRepAdminlURL">
	<portlet:param name="jspPage" value="/html/adminpanel/drugRepAdmin.jsp" />
</portlet:renderURL>

<portlet:renderURL var="viewJobsURL">
	<portlet:param name="jspPage" value="/html/adminpanel/jobs.jsp" />
</portlet:renderURL>

<portlet:renderURL var="viewConsoleURL">
	<portlet:param name="jspPage" value="/html/adminpanel/console.jsp" />
</portlet:renderURL>

<c:choose>
	<c:when test="${param.menuId == 10}">
		<c:set var="active10" value="active" />
	</c:when>
	<c:when test="${param.menuId == 20}">
		<c:set var="active20" value="active" />
	</c:when>
	<c:when test="${param.menuId == 30}">
		<c:set var="active30" value="active" />
	</c:when>
	<c:when test="${param.menuId == 40}">
		<c:set var="active40" value="active" />
	</c:when>
	<c:when test="${param.menuId == 50}">
		<c:set var="active50" value="active" />
	</c:when>
	<c:when test="${param.menuId == 60}">
		<c:set var="active60" value="active" />
	</c:when>
</c:choose>

<ul class="nav nav-pills">
	<li role="menuSelectedA" class="${active10}">
		<a href="<%= viewAdminPanelURL.toString() %>" id="menuSelectedA">Admin Home</a>
	</li>
	<li role="menuSelectedB" class="${active20}">
		<a href="<%= showMigrateSurgeriesFormURL.toString() %>" id="menuSelectedB">Surgery to Organization Migration</a>
	</li>
	<li role="menuSelectedC" class="${active30}">
		<a href="<%= viewSurgeryAdminlURL.toString() %>" id="menuSelectedC">Surgery Admin</a>
	</li>
	<li role="menuSelectedD" class="${active40}">
		<a href="<%= viewDrugRepAdminlURL.toString() %>" id="menuSelectedD">Drug Rep Admin</a>
	</li>
	<li role="menuSelectedE" class="${active50}">
		<a href="<%= viewJobsURL.toString() %>" id="menuSelectedE">Jobs</a>
	</li>
	<li role="menuSelectedF" class="${active60}">
		<a href="<%= viewConsoleURL.toString() %>" id="menuSelectedF">Console</a>
	</li>
</ul>
