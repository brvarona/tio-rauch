

<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>

<%@ include file="/html/visitormanager/init.jsp" %>

<portlet:renderURL var="viewSearchByRepUrl">
	<portlet:param name="jspPage" value="/html/visitormanager/drugreps/myDrugRepresentativeList.jsp" />
	<portlet:param name="filterValue" value="1" />
</portlet:renderURL>
<portlet:renderURL var="viewSearchByProductUrl">
	<portlet:param name="jspPage" value="/html/visitormanager/drugreps/myDrugRepresentativeList.jsp" />
	<portlet:param name="filterValue" value="2" />
</portlet:renderURL>
<script>
function doOnSelectSearched(s) {
	console.log(s.value);
	if (s.value == 2) {
		location.href = '<%=viewSearchByProductUrl.toString()%>';
	} else {
		location.href = '<%=viewSearchByRepUrl.toString()%>';
	}
}
</script>

<liferay-util:include page="/html/visitormanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<div class="messagesContainer">
	<liferay-ui:error key="appointment-shoud-be-canceled" message="appointment-shoud-be-canceled" />
	<liferay-ui:error key="drug-rep-already-blocked-key" message="drug-rep-already-blocked-msg" />
	
	<!-- SUCCESS MESSAGES -->
	<liferay-ui:success key="territory-unblocked-success" message="territory-unblocked-success-msg"/>
	<liferay-ui:success key="territory-blocked-success" message="territory-blocked-success-msg"/>
</div>

<h3>Drugs Representatives</h3>

<%
int filterValue = ParamUtil.getInteger(request, "filterValue", 1);
if (filterValue == 1) {
%>
	<liferay-util:include page="/html/visitormanager/drugreps/drugRepsResultList.jsp" servletContext="<%= this.getServletContext() %>" />
<%} else { %>
	<liferay-util:include page="/html/visitormanager/drugreps/productsResultList.jsp" servletContext="<%= this.getServletContext() %>" />
<%} %>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
	</div>
</div>