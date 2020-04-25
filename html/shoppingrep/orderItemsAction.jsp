<%@page import="com.rxtro.core.util.enums.OrderStatusEnum"%>
<%@page import="com.rxtro.core.model.ShoppingOrderModel"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.dao.search.ResultRow"%>
<%@include file="/html/shoppingrep/init.jsp" %>

<%

ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
ShoppingOrderModel order = (ShoppingOrderModel) row.getObject();
Long currentRepId = (Long) row.getParameter("currentRepId");
Boolean isAssigned = (Boolean) row.getParameter("isAssigned");

String showEditOrderDetailLinkId = "showEditOrderDetail" + String.valueOf(order.getOrderId());
String showOrderShippingDetailLinkId = "showOrderShippingDetail" + String.valueOf(order.getOrderId());
String assignToMeLinkId = "assignToMe" + String.valueOf(order.getOrderId());
String unassignLinkId = "unassign" + String.valueOf(order.getOrderId());
String confirmLinkId = "confirm" + String.valueOf(order.getOrderId());

%>
<portlet:resourceURL id="assignOrderToMe" var="assignOrderToMeURL" />
<portlet:resourceURL id="showOrderItemDetail" var="showOrderItemDetailURL" />
<portlet:resourceURL id="showOrderShippingDetail" var="showOrderShippingDetailURL" />
<portlet:resourceURL id="unassignOrder" var="unassignOrderURL" />
<portlet:resourceURL id="confirmOrder" var="confirmOrderURL" />
<portlet:resourceURL id="editOrder" var="editOrderURL" />

<liferay-ui:icon-menu>
	<%
	if (order.getStatus() != OrderStatusEnum.DELIVERED) {
		if (!isAssigned) { %>
			<liferay-ui:icon id="<%=assignToMeLinkId %>" image="assign" message="Assign to Me" url="javascript:;" />
			<liferay-ui:icon id="<%=showEditOrderDetailLinkId %>" image="view" message="View Order" url="javascript:;" />
		<%} else if (order.isAssignedToMe(currentRepId)) { %>
			<%if (OrderStatusEnum.INPROGRESS.equals(order.getStatus())) { %>
				<liferay-ui:icon id="<%=unassignLinkId %>" image="delete" message="Unassign" url="javascript:;" />
			<%} %>
			<liferay-ui:icon id="<%=showEditOrderDetailLinkId %>" image="edit" message="Update Order" url="javascript:;" />
			<liferay-ui:icon id="<%=confirmLinkId %>" image="check" message="Confirm Delivery" url="javascript:;" />
	<%	} else {%>
			<liferay-ui:icon id="<%=showEditOrderDetailLinkId %>" image="view" message="View Order" url="javascript:;" />
	<%  }
	} else {
	%>
		<liferay-ui:icon id="<%=showEditOrderDetailLinkId %>" image="view" message="View Order" url="javascript:;" />
	<%} %>
	<liferay-ui:icon id="<%=showOrderShippingDetailLinkId %>" image="view" message="View Shipping Detail" url="javascript:;" />
</liferay-ui:icon-menu>

<script>

var showEditOrderDetailButton = document.getElementById('<portlet:namespace /><%= showEditOrderDetailLinkId %>');
if (showEditOrderDetailButton != null) {
	addEvent('click', showEditOrderDetailButton, function() {
		showOrderItemDetail('<%=showOrderItemDetailURL.toString() %>','<%=editOrderURL.toString() %>','submitAmounts','<%=order.getOrderId()%>',<%=order.isEditableByMe(currentRepId)%>);
	});
}

var showOrderShippingDetailButton = document.getElementById('<portlet:namespace /><%= showOrderShippingDetailLinkId %>');
if (showOrderShippingDetailButton != null) {
	addEvent('click', showOrderShippingDetailButton, function() {
		showOrderShippingDetail('<%=showOrderShippingDetailURL.toString() %>', '<%=order.getOrderId()%>');
	});
}

var assignToMeButton = document.getElementById('<portlet:namespace /><%= assignToMeLinkId %>');
if (assignToMeButton != null) {
	addEvent('click', assignToMeButton, function() {
		assignOrderToMe('<%=assignOrderToMeURL.toString() %>', '<%=order.getOrderItemIdsJson() %>');
	});
}

var unassignButton = document.getElementById('<portlet:namespace /><%= unassignLinkId %>');
if (unassignButton != null) {
	addEvent('click', unassignButton, function() {
		unassignOrder('<%=unassignOrderURL.toString() %>', '<%=order.getOrderItemIdsJson() %>');
	});
}

var confirmButton = document.getElementById('<portlet:namespace /><%= confirmLinkId %>');
if (confirmButton != null) {
	addEvent('click', confirmButton, function() {
		confirmOrder('<%=confirmOrderURL.toString() %>', '<%=order.getOrderItemIdsJson() %>');
	});
}
</script>