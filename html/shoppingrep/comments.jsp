<%@page import="com.liferay.portlet.shopping.model.ShoppingOrderItem"%>
<%@include file="/html/shoppingrep/init.jsp" %>

<portlet:actionURL var="discussionURL" name="addDiscussion" />
<portlet:actionURL var="redirectURL" name="getPharmaOrders" />
<liferay-ui:discussion
	className="<%= ShoppingOrderItem.class.getName() %>"
	classPK="${orderItemId}"
	formAction="<%= discussionURL %>"
	formName="fm2"
	
	userId="<%= themeDisplay.getUserId() %>"
/>