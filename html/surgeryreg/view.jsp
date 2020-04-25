<%@page import="com.liferay.portal.kernel.util.TextFormatter"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.model.Organization"%>
<%@page import="com.liferay.portlet.expando.util.ExpandoBridgeFactoryUtil"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoBridge"%>
<%@page import="com.liferay.portal.service.RegionServiceUtil"%>
<%@page import="com.liferay.portal.kernel.servlet.SessionErrors"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="java.util.Date"%>
<%@include file="/html/surgeryreg/init.jsp" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<script type="text/javascript">

jQuery(document).ready(function(){
		$('#boton_registrar').removeAttr("disabled");
		$('#surgeryFixLineNumber').mask('(00) 0000 0000');
		$('#surgeryFax').mask('(00) 0000 0000');
});//fin funcion ready
</script>

<liferay-ui:error key="internal-error" message="There was a problem and the clinic could not be registered"/>

<portlet:actionURL name="addSurgery" var="addSurgeryURL"/>

<%
Long selectedRegionId = (Long) session.getAttribute("regionId");
Long selectedSuburbId = (Long) session.getAttribute("suburbId");
%>

<c:set var="allRegions" value="<%=RegionServiceUtil.getRegions(32L) %>" />
<liferay-portlet:resourceURL id="searchSuburbs" var="searchSuburbsURL" />

<aui:form action="<%= addSurgeryURL.toString() %>" name="fm" method="post">
	
	<aui:fieldset>
		<div class="message-header-form">
	 		<span class="underline">Please note:</span> This form is to register as a practice so that representatives can make appointments to see you. If you are an allied health provider or wish to make appointments to see practices, you will need to register as a representative.
	 	</div>
    	<aui:input name="surgeryName" size="45" label="Clinic Name" value="${param.surgeryName}"/> 
		<liferay-ui:error key="surgery-name-is-required" message="surgery-name-is-required"/>
		<liferay-ui:error key="surgery-name-too-long" message="surgery-name-too-long"/>
		<liferay-ui:error key="surgery-already-exists" message="surgery-already-exists-msg"/>

		<aui:field-wrapper label="Clinic email" >
			<input type="text" name="<portlet:namespace/>surgeryEmail" value="${param.surgeryEmail}" size="45" title="This will be used to notify you once the representative has confirmed the appointment" /> 
		</aui:field-wrapper>
		This will be used to notify you once the representative has confirmed the appointment
		<liferay-ui:error key="surgery-email-is-required" message="surgery-email-is-required"/>
		<liferay-ui:error key="surgery-email-already-exists" message="surgery-email-already-exists"/>
		<liferay-ui:error key="surgery-email-is-invalid" message="surgery-email-is-invalid" />
		<liferay-ui:error key="surgery-email-too-long" message="surgery-email-too-long"/>
				
		<aui:input name="surgeryAddress" size="45" label="Address" value="${param.surgeryAddress}"/>
		<liferay-ui:error key="address-is-required" message="address-is-required"/>
		<liferay-ui:error key="address-too-long" message="address-too-long"/>
		
		<aui:select name="regionId" id="regionSelector" label="State" autocomplete="off" >
			<aui:option value="-1">(Choose a State)</aui:option>
			<c:forEach var="region" items="${allRegions}">
				<aui:option value="${region.regionId}">${region.name}</aui:option>
			</c:forEach>
		</aui:select>
		
		<aui:select name="suburbId" id="suburbSelector" label="Suburb" autocomplete="off">
			<aui:option value="-1">(Choose a Suburb)</aui:option>
		</aui:select>
		<liferay-ui:error key="suburb-id-is-required" message="suburb-id-is-required"/>
		<liferay-ui:error key="suburb-invalid" message="suburb-invalid"/>
		
		<aui:field-wrapper>
			<label class="field-label" for="drCellPhone">
				Clinic Phone Number
			</label>
			<input id="surgeryFixLineNumber" name="<portlet:namespace/>surgeryFixLineNumber" size="45" type="text" value="${param.surgeryFixLineNumber}" />
		</aui:field-wrapper>
		<liferay-ui:error key="surgery-fix-line-number-is-required" message="surgery-fix-line-number-is-required"/>
		<liferay-ui:error key="surgery-fix-line-number-too-long" message="surgery-fix-line-number-too-long"/>
		
		<aui:field-wrapper>
			<label class="field-label" for="drCellPhone">
				Fax
			</label>
			<input id="surgeryFax" name="<portlet:namespace/>surgeryFax" size="45" type="text" value="${param.surgeryFax}" />
		</aui:field-wrapper>
		<liferay-ui:error key="fax-too-long" message="fax-too-long"/>
		
<%-- 		<aui:input name="avgPerDay" size="45" label="Average Patients per Day" value="${param.avgPerDay}" /> --%>
<%-- 		<liferay-ui:error key="surgery-avg-is-required" message="surgery-avg-is-required"/> --%>
		
		<aui:input name="surgeryId" value="${param.surgeryId}>" type="hidden" />
		
<%-- 		<aui:select name="agePopulation" label="Clinic Patient Demographic" title="Some general information about your clinic assist representatives in making a decision about whether or not their drugs are relevant to your doctors">  --%>
<!-- 			Some general information about your clinic assist representatives in making a decision about whether or not their drugs are relevant to your doctors -->
<%-- 			<aui:option value="-1"> --%>
<%-- 				<liferay-ui:message key="please-choose" /> --%>
<%-- 			</aui:option> --%>
<%-- 			<c:forEach items="<%=CfgProcessor.getAgePopulationTypes() %>" var="agePopulationType"> --%>
<%-- 				<aui:option value="${agePopulationType}" selected="${agePopulationType == param.agePopulation}">${agePopulationType}</aui:option> --%>
<%-- 			</c:forEach> --%>
<%-- 		</aui:select> --%>
<%-- 		<liferay-ui:error key="surgery-age-is-required" message="surgery-age-is-required"/> --%>
<%-- 		<liferay-ui:error key="patient-demographic-invalid" message="patient-demographic-invalid"/> --%>
		
<%-- 		<aui:select name="mealPreference" label="Meal Preference"> --%>
<%-- 			<aui:option value="-1"> --%>
<%-- 				<liferay-ui:message key="please-choose" /> --%>
<%-- 			</aui:option> --%>
<%-- 			<c:forEach items="<%=CfgProcessor.getFoodTypes() %>" var="foodType"> --%>
<%-- 				<aui:option value="${foodType}" selected="${foodType == param.mealPreference}">${foodType}</aui:option> --%>
<%-- 			</c:forEach> --%>
<%-- 		</aui:select> --%>
<%-- 		<liferay-ui:error key="surgery-meal-preference-is-required" message="surgery-meal-preference-is-required"/> --%>
<%-- 		<liferay-ui:error key="meal-preference-invalid" message="meal-preference-invalid"/> --%>
		
		<aui:input name="pmName" size="45" label="Practice Manager First Name" value="${param.pmName}"/>
		<liferay-ui:error key="practice-manager-name-is-required" message="practice-manager-name-is-required"/>
		<liferay-ui:error key="practice-manager-name-too-long" message="practice-manager-name-too-long"/>
		
		<aui:input name="pmSurname" size="45" label="Practice Manager Surname" value="${param.pmSurname}"/>
		<liferay-ui:error key="practice-manager-surname-is-required" message="practice-manager-surname-is-required"/>
		<liferay-ui:error key="practice-manager-surname-too-long" message="practice-manager-surname-too-long"/>
		
		<span class="message-block-m">
			We are happy for representatives to make an appointment to  visit the doctors at our practice
		</span>
		<aui:input type="radio" name="appForDrugReps" value="1" label="Yes, please contact the practice directly." />
		<aui:input type="radio" name="appForDrugReps" value="4" label="Yes, please contact the practice directly about new products only." />
		<aui:input type="radio" name="appForDrugReps" value="2" label="Yes, please make your appointment via RxTro." checked="true" />
		<aui:input type="radio" name="appForDrugReps" value="3" label="No, we are not able to make appointment times available for representatives." />
		<br />
		<span class="message-block-m">
			We are happy for specialists and allied health to make an  appointment to visit the doctors at our practice
		</span>
		<aui:input type="radio" name="appForAlliedHealth" value="1" label="Yes, please contact the practice directly." />
		<aui:input type="radio" name="appForAlliedHealth" value="2" label="Yes, please make your appointment via RxTro." checked="true" />
		<aui:input type="radio" name="appForAlliedHealth" value="3" label="No, we are not able to make appointment times available for specialists and allied health providers." />
		<br />
		<span class="message-block-m">
			We are happy for representatives to attend the practice without an appointment
		</span>
		<aui:input type="radio" name="noApps" value="1" label="Yes" />
		<aui:input type="radio" name="noApps" value="3" label="Yes - To check starter-packs only." />
		<aui:input type="radio" name="noApps" value="2" label="No" checked="true" />
		<span class="message-block-m">
			We are happy for representatives to conduct a web-detail with our practice 
		</span>
		<aui:input type="radio" name="webinarWithOurPractice" value="1" label="Yes" checked="true" />
		<aui:input type="radio" name="webinarWithOurPractice" value="2" label="No"  />
		<aui:button-row> 
			<aui:button value="Save" onClick="confirmEmail(document.forms._surgeryreg_WAR_drugrepportlet_fm,document.forms._surgeryreg_WAR_drugrepportlet_fm._surgeryreg_WAR_drugrepportlet_surgeryEmail.value);" id="boton_registrar"/> 
		</aui:button-row> 
  	</aui:fieldset> 
</aui:form> 

<liferay-ui:success key="clinic-saved-successfully" message="" />

<script type="text/javascript" charset="utf-8">   
	YUI().ready(function (A) {
		initOnRegionSelectorEvent('<%=searchSuburbsURL.toString()%>');
	});
</script>