

<%@page import="com.rxtro.core.util.CfgProcessor"%>
<%@page import="com.segmax.drugrep.service.SuburbLocalServiceUtil"%>

<%@include file="/html/surgeryreg/init.jsp" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<script type="text/javascript">
	jQuery(document).ready(function() {
			$('#boton_registrar').removeAttr("disabled");

	});
</script>
<style>
div.schedule-time-container {
	padding: 10px 0 10px 0;
}

div.schedule-time {
	padding-top: 10px;
}

div.schedule-time label a.reset:hover {
	cursor: pointer;
}

div.schedule-time input[type='text'] {
	text-align: center;
	cursor: pointer;
	color: #aaa;
}
</style>

<portlet:defineObjects />

<liferay-ui:error key="internal-error" message="There was a problem and the clinic could not be registered" />

<portlet:actionURL name="addSurgery" var="addSurgeryURL" />

<aui:form action="<%= addSurgeryURL.toString() %>" method="post" name="fm">

	<aui:fieldset>
		Please note: This form is to register as a practice so that representatives can make appointments to see you. If you are an allied health provider or wish to make appointments to see practices, you will need to register as a representative
		<aui:input label="Clinic Name" name="surgeryName" size="45" value="${param.surgeryName}" />
		<liferay-ui:error key="surgery-name-is-required" message="surgery-name-is-required" />
		<liferay-ui:error key="surgery-name-too-long" message="surgery-name-too-long" />

		<aui:field-wrapper label="Clinic email">
			<input name="surgeryEmail" size="45" title="This will be used to notify you once the representative has confirmed the appointment" type="text" value="${param.surgeryEmail}" />
		</aui:field-wrapper>
		This will be used to notify you once the representative has confirmed the appointment
		<liferay-ui:error key="surgery-email-is-required" message="surgery-email-is-required" />
		<liferay-ui:error key="surgery-email-already-exists" message="surgery-email-already-exists" />
		<liferay-ui:error key="surgery-email-is-invalid" message="surgery-email-is-invalid" />
		<liferay-ui:error key="surgery-email-too-long" message="surgery-email-too-long" />

		<aui:input label="Address" name="surgeryAddress" size="45" value="${param.surgeryAddress}" />
		<liferay-ui:error key="address-is-required" message="address-is-required" />
		<liferay-ui:error key="address-too-long" message="address-too-long" />

		<aui:select label="Suburb" name="suburbId" title="Start typing in the first few letters of the suburb and your location will appear automatically'">
			<aui:option value="-1">
				<liferay-ui:message key="please-choose" />
			</aui:option>
			<c:forEach items="<%= SuburbLocalServiceUtil.getAll() %>" var="suburb">
				<aui:option selected="${param.suburbId == suburb.id_suburb}" value="${suburb.id_suburb}">
					${suburb.name} - ${suburb.postal_code}
				</aui:option>
			</c:forEach>
		</aui:select>
		<liferay-ui:error key="suburb-id-is-required" message="suburb-id-is-required" />
		<liferay-ui:error key="suburb-invalid" message="suburb-invalid" />

		<aui:input label="Fixed Line Number" name="surgeryFixLineNumber" size="45" value="${param.surgeryFixLineNumber}" />
		<liferay-ui:error key="surgery-fix-line-number-is-required" message="surgery-fix-line-number-is-required" />
		<liferay-ui:error key="surgery-fix-line-number-too-long" message="surgery-fix-line-number-too-long" />

		<aui:input label="Fax" name="surgeryFax" size="45" value="${param.surgeryFax}" />
		<liferay-ui:error key="fax-too-long" message="fax-too-long" />

		<aui:input label="Average Patients per Day" name="avgPerDay" size="45" value="${param.avgPerDay}" />
		<liferay-ui:error key="surgery-avg-is-required" message="surgery-avg-is-required" />

		<aui:input name="surgeryId" value="${param.surgeryId}>" type="hidden" />

		<aui:select label="Clinic Patient Demographic" name="agePopulation" title="Some general information about your clinic assist representatives in making a decision about whether or not their drugs are relevant to your doctors">
			Some general information about your clinic assist representatives in making a decision about whether or not their drugs are relevant to your doctors
			<aui:option value="-1">
				<liferay-ui:message key="please-choose" />
			</aui:option>
			<c:forEach items="<%= CfgProcessor.getAgePopulationTypes() %>" var="agePopulationType">
				<aui:option selected="${agePopulationType == param.agePopulation}" value="${agePopulationType}">${agePopulationType}</aui:option>
			</c:forEach>
		</aui:select>
		<liferay-ui:error key="surgery-age-is-required" message="surgery-age-is-required" />
		<liferay-ui:error key="patient-demographic-invalid" message="patient-demographic-invalid" />

		<aui:select label="Meal Preference" name="mealPreference">
			<aui:option value="-1">
				<liferay-ui:message key="please-choose" />
			</aui:option>
			<c:forEach items="<%= CfgProcessor.getFoodTypes() %>" var="foodType">
				<aui:option selected="${foodType == param.mealPreference}" value="${foodType}">${foodType}</aui:option>
			</c:forEach>
		</aui:select>
		<liferay-ui:error key="surgery-meal-preference-is-required" message="surgery-meal-preference-is-required" />
		<liferay-ui:error key="meal-preference-invalid" message="meal-preference-invalid" />

		<aui:input label="Practice Manager Name" name="pmName" size="45" value="${param.pmName}" />
		<liferay-ui:error key="practice-manager-name-is-required" message="practice-manager-name-is-required" />
		<liferay-ui:error key="practice-manager-name-too-long" message="practice-manager-name-too-long" />

		<aui:input label="Practice Manager Surname" name="pmSurname" size="45" value="${param.pmSurname}" />
		<liferay-ui:error key="practice-manager-surname-is-required" message="practice-manager-surname-is-required" />
		<liferay-ui:error key="practice-manager-surname-too-long" message="practice-manager-surname-too-long" />

		<aui:button-row>
			<aui:button id="boton_registrar" onClick="confirmEmail(document.forms._surgeryreg_WAR_drugrepportlet_fm,document.forms._surgeryreg_WAR_drugrepportlet_fm.surgeryEmail.value);" value="Save" />
		</aui:button-row>
	</aui:fieldset>
</aui:form>

<liferay-ui:success key="clinic-saved-successfully" message="" />