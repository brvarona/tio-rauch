<%@page import="com.rxtro.core.util.CfgProcessor"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ page import="com.liferay.portal.model.Group" %>
<%@ page import="com.liferay.portal.model.User" %>
<%@ page import="com.liferay.portal.service.ClassNameLocalServiceUtil" %>

<%@ page import="com.segmax.drugrep.model.Speciality" %>
<%@ page import="com.segmax.drugrep.service.SpecialityLocalServiceUtil" %>

<%@ include file="/html/surgerymanager/init.jsp" %>

<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="20" />
</liferay-util:include>

<liferay-ui:success key="doctor-saved-successfully" message="The doctor was saved successfully" />
<liferay-ui:error key="fields-required" message="Fields required" />

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<h2>Add your Medical Centre staff</h2>

<portlet:actionURL name="addDoctor" var="addDoctorURL" />

<aui:form action="<%= addDoctorURL.toString() %>" method="post" name="fn">

<aui:fieldset>

	<aui:input label="Name (Required)" name="dcName" size="45" value='${param.dcName}'/>
	<liferay-ui:error key="doctor-name-is-required" message="doctor-name-is-required" />

	<aui:input label="Middle Name" name="dcMiddleName" size="45" value='${param.dcMiddleName}'/>
	<aui:input label="Surname (Required)" name="dcSurname" size="45" value='${param.dcSurname}'/>
	<liferay-ui:error key="doctor-surname-is-required" message="doctor-surname-is-required" />

	<aui:input label="Preferred Name" name="dcPreferedName" size="45" value='${param.dcPreferedName}'/>
	
	<label>Gender (Required)</label>	
	<select name="<portlet:namespace/>dcGender">
	 	<option value="Male" ${param.dcGender eq 'Male' ? 'selected' : ''}>Male</option>
		<option value="Female" ${param.dcGender eq 'Female' ? 'selected' : ''}>Female</option>
	 </select>
<%-- 	 <liferay-ui:error key="doctor-gender-is-required" message="doctor-gender-is-required" /> --%>
	 
	<aui:input label="CPD Number" name="dcCDPNumber" size="45" value='${param.dcCDPNumber}'/>
	<aui:input label="Email:" name="dcEmail" size="45" value='${param.dcEmail}'/>
	<aui:select autocomplete="off" label="Diet Information:" multiple="true" name="dcDiet">

	<%
		String[] foodTypes = CfgProcessor.getFoodTypes();
		for (int i = 0; i<foodTypes.length;i++) {
			%>
				<aui:option value="<%= foodTypes[i] %>"><%= foodTypes[i] %></aui:option>
			<%
		}
	%>

	</aui:select>

	<label>Gluten Free</label>
	<select name="<portlet:namespace/>dcGlutenFree">
		<option value="YES" ${param.dcGlutenFree eq 'YES' ? 'selected' : ''}>Yes</option>
		<option value="NO" ${param.dcGlutenFree eq 'NO' ? 'selected' : ''}>No</option>
	</select>

	 <aui:select name="dcAcceptIndividualApp" label="Does this doctor see representatives by themselves outside of the clinic representative appointment?">
	 	<aui:option value="true">Yes</aui:option>
	 	<aui:option value="false" selected="true">No</aui:option>
	 </aui:select>

	 <aui:select name="dcSpeciality" label="Specialty" autocomplete="off">

		<%
		List<Speciality> elems = SpecialityLocalServiceUtil.getSpelialities();
		for (int i=0 ;i<elems.size();i++) {
			Speciality unaS = elems.get(i);
		%>
			<aui:option selected="<%= unaS.getId_speciality() == 33 %>" value="<%= unaS.getId_speciality() %>"><%= unaS.getName() %></aui:option>
		<%
		}
		%>

	 </aui:select>
	<aui:button-row>
	 <aui:button type="submit"  />
	 </aui:button-row>

</aui:fieldset>

</aui:form>
