<%@page import="com.liferay.portal.security.permission.ActionKeys"%>
<%@page import="com.liferay.portal.service.permission.PortletPermissionUtil"%>
<%@page import="com.rxtro.core.validation.message.KeySuccessMessage"%>
<%@page import="com.rxtro.core.validation.message.KeyErrorMessage"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<div class="" id="loading-mark-container">
	<div class="loading-mark"></div>
</div>

<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<div class="messagesContainer">
	
	<liferay-ui:error key="<%= KeyErrorMessage.APPOINTMENT_SHOULD_BE_CANCELED %>" message="appointment-shoud-be-canceled" />
	
	<liferay-ui:success key="doctor-removed-from-surgery" message="Doctor removed from clinic" />
	<liferay-ui:success key="doctor-allow-individual-appoiment" message="Doctor Updated" />
	<liferay-ui:success key="<%= KeySuccessMessage.INDIVIDUAL_DOCTOR_DISABLED %>" message="Doctor Updated" />
	<liferay-ui:success key="Doctor-added-successfully" message="Doctor added successfully" />
	<liferay-ui:success key="Doctor-Info-Updated-successfully" message="Doctor info updated successfully" />
	<liferay-ui:success key="Appoiment-hour-saved-successfully" message="Appoiment-hour-saved-successfully" />
	<liferay-ui:success key="nurse-removed-from-surgery" message="Nurse removed from clinic" />
	<liferay-ui:error key="<%= KeyErrorMessage.UNEXPECTED_ERROR %>" message="unexpected-error-msg" />
</div>

<h3>My Medical Staff</h3>

<%@ include file="/html/surgerymanager/medicalstaff/doctors/myDoctors.jsp" %>

<div class="panel-footer">
	<portlet:renderURL var="AddURL">
		<portlet:param name="jspPage" value="/html/surgerymanager/medicalstaff/doctors/addForm.jsp" />
	</portlet:renderURL>
	If your Doctor is not in the list click <aui:a href="<%= AddURL.toString() %>">here</aui:a>
</div>

<%if (PortletPermissionUtil.contains(permissionChecker, plid, portletDisplay.getId(), ActionKeys.ADD_USER)) { %>
	<br />
	<%@ include file="/html/surgerymanager/medicalstaff/nurse/myNurses.jsp" %>
	<div class="panel-footer">
		<portlet:renderURL var="addNurseFormURL">
			<portlet:param name="jspPage" value="/html/surgerymanager/medicalstaff/nurse/addForm.jsp" />
		</portlet:renderURL>
		Click <a href="<%=addNurseFormURL.toString() %>" >here</a> to add a new Nurse
	</div>
<%} %>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
		
	</div>
</div>
