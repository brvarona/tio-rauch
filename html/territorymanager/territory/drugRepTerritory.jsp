<%@page import="com.rxtro.core.model.TerritoryIndividualModel"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.model.TerritoryModel"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>

<%@ page import="javax.portlet.PortletURL" %>

<style>
.boxToRight {
    float: right;
}

.clearfix {
    overflow: auto;
}

.boxToLeft {
    float: left;
}
</style>

<div class="" id="loading-mark-container">
	<div class="loading-mark"></div>
</div>

<div id="myAlert"></div>

<!-- MENU -->
<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<!-- MESSAGES -->
<liferay-ui:success key="territory-has-been-deleted" message="Territory has been deleted" />
<liferay-ui:error key="territory-pending-appointments-exist" message="territory-pending-appointments-exist-msg" />
<liferay-ui:error key="appointment-already-Allocated-key" message="Appointment already allocated" />
<liferay-ui:error key="appointment-time-not-available-key" message="appointment-time-not-available-msg" />
<liferay-ui:error key="appointment-within-half-an-hour" message="Unfortunately you were unable to make this appointment as you already have an appointment at this time" />


<!-- SUBMENU -->
<%@include file="/html/territorymanager/territory/territoryMenu.jsp" %>

<h3>Clinics that are currently part of my territory <span style="display: none;" class="loadingPopup" id="loadingNotificationsContent">Loading...</span></h3>

<div class="clearfix">
	<p class="boxToLeft">You will only see available appointments for clinics that you have made part of your territory</p>
	<portlet:resourceURL id="showEditUserNotificationsForm" var="showEditUserNotificationsFormURL" />
	<portlet:resourceURL id="editUserNotifications" var="editUserNotificationsURL" />
	<p class="boxToRight"><span class="asLink" onclick="showEditUserNotificationsForm('<%=showEditUserNotificationsFormURL.toString()%>','<%=editUserNotificationsURL.toString()%>')">Setup Notifications for all territories</span></p>
</div>

<!-- TERRITORY LIST -->

<div id="territoryListBoxId">
	<liferay-util:include page="/html/territorymanager/territory/territoryList.jsp" servletContext="<%= this.getServletContext() %>" />
</div>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
		
	</div>
</div>

