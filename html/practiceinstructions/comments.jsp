<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@include file="/html/practiceinstructions/init.jsp" %>

<portlet:actionURL name="updateCfgs" var="updateCfgsURL"/>
<aui:form action="<%= updateCfgsURL.toString() %>" name="fm" method="post">
	<aui:fieldset>
		<textarea class="field lfr-textarea" id="comments" name='<portlet:namespace/>comments' style="height: 155px; max-width: 400px; width: 400px;" wrap="soft" onkeydown=" Liferay.Util.disableEsc();"><%=user.getComments() %></textarea>
	</aui:fieldset>
	
	<br />

	<aui:fieldset>
		<%
		SurgeryModel surgeryModel = SurgeryUtil.buildByUser(themeDisplay.getUserId());
		boolean notifyAllAppUpdates = surgeryModel.notifyAllAppUpdates();
		boolean notifyWrongDoctorList = surgeryModel.notifyWrongListDoctor();
		%>
		<span class="message-block-m">
			I would like to get email notifications for all the appointments' changes
		</span>
		<aui:input type="radio" name="receiveAllNotifications" value="1" label="Yes" checked="<%=notifyAllAppUpdates %>" />
		<aui:input type="radio" name="receiveAllNotifications" value="2" label="No" checked="<%=!notifyAllAppUpdates %>" />
	
		<span class="message-block-m">
			Receive notifications if my 'doctor-list' is out of date
		</span>
		<aui:input type="radio" name="wrongDoctorListNotification" value="1" label="Yes" checked="<%=notifyWrongDoctorList %>" />
		<aui:input type="radio" name="wrongDoctorListNotification" value="2" label="No" checked="<%=!notifyWrongDoctorList %>" />	
	
	</aui:fieldset>
	
	<button class="btn btn-default" type="submit">Save</button>
</aui:form>

