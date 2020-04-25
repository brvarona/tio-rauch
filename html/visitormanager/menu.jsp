<%@ include file="/html/visitormanager/init.jsp" %>

<portlet:renderURL var="viewMyDrugRepsURL">
	<portlet:param name="jspPage" value="/html/visitormanager/drugreps/myDrugRepresentativeList.jsp" />
</portlet:renderURL>
<portlet:renderURL var="companySelectorListURL">
	<portlet:param name="jspPage" value="/html/visitormanager/drugreps/companySelector.jsp" />
</portlet:renderURL>

<c:choose>
	<c:when test="${param.menuId == 10}">
		<c:set var="active10" value="active" />
	</c:when>
	<c:when test="${param.menuId == 20}">
		<c:set var="active20" value="active" />
	</c:when>
</c:choose>

<ul class="nav nav-pills">
 	<li role="presentation" class="${active10}">
 		<a href="<%=viewMyDrugRepsURL.toString() %>" id="menuSelectedF">My Drug Representatives</a>
 	</li>
	<li role="presentation" class="${active20}">
		<a href="<%= companySelectorListURL.toString() %>" id="menuSelectedG">My Companies</a>
	</li>
</ul>
