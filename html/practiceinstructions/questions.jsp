<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.util.PracticeInstructionsUtil"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoValueLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoValue"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoColumnLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoColumn"%>
<%@page import="com.liferay.portal.model.Organization"%>
<%@page import="com.liferay.portal.service.ClassNameLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoTableLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoTable"%>
<%@include file="/html/practiceinstructions/init.jsp" %>

<portlet:actionURL name="updateInitialQuestions" var="updateInitialQuestionsURL"/>
<aui:form action="<%= updateInitialQuestionsURL.toString() %>" name="fm" method="post">
	<%
	SurgeryModel surgeryModel = SurgeryUtil.buildByUser(themeDisplay.getUserId());
	%>
	<aui:fieldset>
		<span class="message-block-m">
			We are happy for representatives to make an appointment to  visit the doctors at our practice
		</span>
		<%
		int appForDrugRepsRadio = PracticeInstructionsUtil.getAppForDrugRepsResponse(surgeryModel.getId());
		%>
		<aui:input type="radio" name="appForDrugReps" value="1" label="Yes, please contact the practice directly." checked="<%=appForDrugRepsRadio==1 %>" />
		<aui:input type="radio" name="appForDrugReps" value="4" label="Yes, please contact the practice directly about new products only." checked="<%=appForDrugRepsRadio==4 %>" />
		<aui:input type="radio" name="appForDrugReps" value="2" label="Yes, please make your appointment via RxTro." checked="<%=appForDrugRepsRadio==2 %>" />
		<aui:input type="radio" name="appForDrugReps" value="3" label="No, we are not able to make appointment times available for representatives." checked="<%=appForDrugRepsRadio==3 %>" />
		<br />
		
		<span class="message-block-m">
			We are happy for specialists and allied health to make an  appointment to visit the doctors at our practice
		</span>
		<%
		int appForAlliedHealthRadio = PracticeInstructionsUtil.getAppForAlliedHealthResponse(surgeryModel.getId());
		%>
		<aui:input type="radio" name="appForAlliedHealth" value="1" label="Yes, please contact the practice directly." checked="<%=appForAlliedHealthRadio==1 %>" />
		<aui:input type="radio" name="appForAlliedHealth" value="2" label="Yes, please make your appointment via RxTro." checked="<%=appForAlliedHealthRadio==2 %>" />
		<aui:input type="radio" name="appForAlliedHealth" value="3" label="No, we are not able to make appointment times available for specialists and allied health providers." checked="<%=appForAlliedHealthRadio==3 %>" />
		<br />
		
		<span class="message-block-m">
			We are happy for representatives to attend the practice without an appointment
		</span>
		<%
		int noAppsValueRadio = PracticeInstructionsUtil.getNoAppsValueResponse(surgeryModel.getId());
		%>
		<aui:input type="radio" name="noApps" value="1" label="Yes" checked="<%=noAppsValueRadio == 1 %>" />
		<aui:input type="radio" name="noApps" value="3" label="Yes - To check starter-packs only." checked="<%=noAppsValueRadio == 3 %>" />
		<aui:input type="radio" name="noApps" value="2" label="No" checked="<%=noAppsValueRadio == 2 %>" />
		<br />
		
		<span class="message-block-m">
			We are happy for representatives to conduct a web-detail with our practice 
		</span>
		<%
		int webinarWithOurPracticeeRadio = PracticeInstructionsUtil.getWebinarWithOurPracticeeResponse(surgeryModel.getId());
		%>
		<aui:input type="radio" name="webinarWithOurPractice" value="1" label="Yes" checked="<%=webinarWithOurPracticeeRadio == 1 %>" />
		<aui:input type="radio" name="webinarWithOurPractice" value="2" label="No" checked="<%=webinarWithOurPracticeeRadio == 2 %>"  />
		<br />
		<button class="btn btn-default" type="submit">Save</button>
  	</aui:fieldset>
</aui:form> 