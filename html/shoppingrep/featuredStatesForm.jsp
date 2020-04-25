<%@page import="com.rxtro.core.util.ManagerUtil"%>
<%@include file="/html/shoppingrep/init.jsp" %>

<h3>State Notifications</h3>

<portlet:actionURL name="updateFeaturedStates" var="updateFeaturedStatesURL"/>
<form action="<%=updateFeaturedStatesURL.toString() %>" id="featuredStatesFm" name="featuredStatesFm" method="post" >
	<div class="modal-body">
		<c:forEach items="${states}" var="state">
			<input id="${state.regionId}" name="<portlet:namespace/>featuredStates" type="checkbox" value="${state.regionId}">${state.name}
			<br />
		</c:forEach>
		<aui:input name="managerId" type="hidden" value="${param.currentDrugRepId}" />
	</div>
	<button class="btn">Save</button>
</form>

<c:forEach items="${featuredStates}" var="fs">
	<script>
		document.getElementById('${fs}').checked = true;
	</script>
</c:forEach>

