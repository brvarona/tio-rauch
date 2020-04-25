<%@page import="com.liferay.portlet.shopping.model.ShoppingOrderItem"%>
<%@include file="/html/shoppingrep/init.jsp" %>

<div class="popupOrderDetail">
	<div class="popupTitle">
		<span class="popupMessage" id="popupMessage"></span>
	</div>
	<form action="#" name="submitAmounts" id="submitAmounts">
		<table>
			<thead>
				<tr>
					<th></th>
					<th>Sku</th>
					<th>Name</th>
					<th>Quantity</th>
					<th>Delivered</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${order.orderItems}" var="item">
					<tr>
						<td></td>
						<td>${item.orderItem.sku}</td>
						<td>${item.orderItem.name}</td>
						<td>${item.orderItem.quantity}</td>
						<c:if test="${item.editable}">
							<td>
								<input name="<portlet:namespace/>orderItemId" type="hidden" id="orderItemId${item.orderItem.orderItemId}" value="${item.orderItem.orderItemId}" />
								<input name="<portlet:namespace/>deliveredValue" type="text" id="deliveredValue${item.orderItem.orderItemId}" value="${empty item.orderItemExt ? 0 : item.orderItemExt.deliveredQuantity}" />
							</td>
						</c:if>
						<c:if test="${not item.editable}">
							<td>${empty item.orderItemExt ? 0 : item.orderItemExt.deliveredQuantity}</td>
						</c:if>
						<td></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</div>
