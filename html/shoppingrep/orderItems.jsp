<%@page import="com.rxtro.core.util.CfgProcessor"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.util.ShoppingOrderUtil"%>
<%@page import="com.rxtro.core.model.ShoppingOrderModel"%>
<%@page import="com.liferay.portal.service.RegionServiceUtil"%>
<%@page import="com.liferay.portal.model.Region"%>
<%@page import="com.liferay.portlet.shopping.model.ShoppingOrderItem"%>
<%@page import="com.segmax.drugrep.service.DoctorLocalServiceUtil"%>
<%@page import="com.segmax.drugrep.model.Doctor"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.liferay.portlet.shopping.service.ShoppingOrderLocalServiceUtil"%>
<%@page import="com.liferay.portlet.shopping.model.ShoppingOrder"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@page import="com.liferay.portal.kernel.dao.search.SearchContainer"%>
<%@include file="/html/shoppingrep/init.jsp" %>

<style>

.orders .rowColorGreen {
	background-color: #ccff99 !important;
}

.popupOrderDetail table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

.popupOrderDetail td, .popupOrderDetail th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

.popupOrderDetail tr:nth-child(even) {
    background-color: #dddddd;
}

.popupOrderDetail td input[type=text] {
	width: 60px;
}
</style>

<liferay-ui:success key="featured-states-updated" message="featured-states-updated-msg"/>


<%
List<ShoppingOrderModel> pageResult = null;
DrugRepModel currentDrugRep = DrugRepUtil.buildByUserId(themeDisplay.getUserId());
%>

<%if (CfgProcessor.showFeaturedStatesForm() && currentDrugRep.isManagerOfTeam()) { %>

<liferay-util:include page="/html/shoppingrep/featuredStatesForm.jsp" servletContext="<%=this.getServletContext() %>">
	<liferay-util:param name="currentDrugRepId" value="<%=currentDrugRep.getId().toString() %>" />
</liferay-util:include>


<%} %>
<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/shoppingrep/orderItems.jsp");
%>


<h3>Order Items</h3>
<div class="orders">
	<liferay-ui:search-container curParam="cur1" delta="10" emptyResultsMessage="No Orders" iteratorURL="<%= iteratorURL %>">
		<liferay-ui:search-container-results>
	
			<%
				List<ShoppingOrderModel> items = ShoppingOrderUtil.getMyShoppingOrders(currentDrugRep);
				Collections.sort(items);
			    Collections.reverse(items);
				pageResult = ListUtil.subList(items, searchContainer.getStart(), searchContainer.getEnd());
				results = pageResult;
				
				total = items.size();
				pageContext.setAttribute("results",results);
				pageContext.setAttribute("total",total);
			%>
	
		</liferay-ui:search-container-results>
		<liferay-ui:search-container-row
			className="com.rxtro.core.model.ShoppingOrderModel"
			keyProperty="orderId"
			modelVar="order">
	
		<%
			DateFormat orderDateFormat = new SimpleDateFormat("dd/MM/yyyy");
			String docName;
			try {
				Doctor doc = DoctorLocalServiceUtil.getDoctor(Long.valueOf(order.getOrder().getComments()));
				docName = doc.getFullName();
			} catch (Exception e) {
				docName = order.getOrder().getComments();
			}
			String colorRow = "";
			String assignedToName = "Unassigned";
			Long assignedToId = 0L;
			if (order.getAssignedTo() != null) {
				colorRow = "rowColorGreen";
				assignedToId = order.getAssignedTo().getId();
				if (assignedToId.equals(currentDrugRep.getId())) {
					assignedToName = "Me";
				} else {
					assignedToName = order.getAssignedTo().getFullName();
				}
			}
		%>
		
		<liferay-ui:search-container-column-text
			name="Order#"
			value="<%=order.getOrder().getNumber()  %>"
			cssClass="<%=colorRow %>"
		/>
		<liferay-ui:search-container-column-text
			name="Date"
			value="<%=orderDateFormat.format(order.getOrder().getCreateDate())  %>"
			cssClass="<%=colorRow %>"
		/>
		<liferay-ui:search-container-column-text
			name="Doctor"
			value="<%=docName  %>"
			cssClass="<%=colorRow %>"
		/>
		<liferay-ui:search-container-column-text
			name="Clinic"
			value="<%=order.getSurgeryName() %>"
			cssClass="<%=colorRow %>"
		/>
		<liferay-ui:search-container-column-text
			name="Assigned To"
			value="<%=assignedToName %>"
			cssClass="<%=colorRow %>"
		/>
		<liferay-ui:search-container-column-text
			name="Status"
			value="<%=order.getStatus().getLabel() %>"
			cssClass="<%=colorRow %>"
		/>
		<liferay-ui:search-container-row-parameter name="currentRepId" value="<%=currentDrugRep.getId() %>" />
		<liferay-ui:search-container-row-parameter name="isAssigned" value="<%=assignedToId > 0 %>" />
		<liferay-ui:search-container-column-jsp
			align="right"
			path="/html/shoppingrep/orderItemsAction.jsp"
			cssClass="<%=colorRow %>"
		/>
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>
<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
	</div>
</div>

