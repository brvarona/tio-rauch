<%@ include file="/html/clinics/init.jsp" %>

<portlet:actionURL name="showMigrateSurgeriesForm" var="showMigrateSurgeriesFormURL" />

<portlet:renderURL var="viewHomePagelURL">
	<portlet:param name="jspPage" value="/html/clinics/view.jsp" />
</portlet:renderURL>

<portlet:renderURL var="viewDetailPageURL">
	<portlet:param name="jspPage" value="/html/clinics/details.jsp" />
</portlet:renderURL>

<portlet:actionURL name="runSurgeryUnlinkedCollector" var="runSurgeryUnlinkedCollectorURL" />

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

<%if (permissionChecker.isOmniadmin()) { %>
<ul class="nav nav-pills">
	<li role="menuSelectedA" class="${active10}">
		<a href="<%= viewHomePagelURL.toString() %>" id="menuSelectedA">Details</a>
	</li>
	<li role="menuSelectedC" class="${active30}">
		<a href="<%= runSurgeryUnlinkedCollectorURL.toString() %>" id="menuSelectedC">Unlinked</a>
	</li>
	<li role="menuSelectedD" class="${active40}">
		<a href="<%= showMigrateSurgeriesFormURL.toString() %>" id="menuSelectedD">Migration</a>
	</li>
</ul>
<%} else { %>
	<div class="alert alert-warning">
	  <strong>Warning!</strong> Permission required.
	</div>
<%} %>
