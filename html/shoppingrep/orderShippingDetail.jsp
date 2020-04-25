<%@include file="/html/shoppingrep/init.jsp" %>

<div class="popupOrderDetail">
	<table>
		<thead>
			<tr>
			<th>Name</th>
				<th>Street</th>
				<th>City</th>
				<th>State</th>
				<th>Zip</th>
				<th>Phone</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${order.firstName} ${order.order.billingLastName}</td>
				<td>${order.street}</td>
				<td>${order.city}</td>
				<td>${order.region}</td>
				<td>${order.zip}</td>
				<td>${order.phone}</td>
			</tr>
		</tbody>
	</table>
</div>
