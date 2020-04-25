<%@include file="/html/adminpanel/init.jsp" %>

<liferay-util:include page="/html/adminpanel/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="50" />
</liferay-util:include>

<div>
	<portlet:actionURL name="runAvailableAppsJob" var="runAvailableAppsJobURL" />
	<form action="<%=runAvailableAppsJobURL.toString() %>" method="post" name="" id="">
		<button class="btn btn-info">Run Available Apps Job</button>
	</form>
</div>

<div>
	<liferay-ui:error key="order-pending-not-job-error" message="Could not run Pending Orders Job" />
	<liferay-ui:success key="order-pending-not-job-success" message="Pending Orders Job run successfully"/>
	
	<portlet:actionURL name="runOrderPendingNotJob" var="runOrderPendingNotJobURL" />
	<form action="<%=runOrderPendingNotJobURL.toString() %>" method="post" name="runOrderPendingNotJobFm" id="runOrderPendingNotJobFm">
		<input type="text" name="<portlet:namespace/>day" value="" placeholder="Day" />
		<br />
		<button class="btn btn-info">Submit</button>
	</form>
</div>
