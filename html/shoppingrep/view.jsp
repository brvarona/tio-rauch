<%@include file="/html/shoppingrep/init.jsp" %>

<portlet:actionURL name="getPharmaOrders" var="getPharmaOrdersURL" />
<script>
	location.href = '<%= getPharmaOrdersURL.toString() %>';
</script>
