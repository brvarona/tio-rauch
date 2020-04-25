
<%@include file="/html/drugrepresentativereg/init.jsp" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<script type="text/javascript">
jQuery(document).ready(function() {
		$('#boton_registrar').removeAttr("disabled");
		$('#drCellPhone').mask('0000 000 000');
});//fin funcion ready
</script>
<portlet:defineObjects />

<liferay-ui:error key="internal-error" message="There was a problem and the clinic could not be registered" />

<div id="info"></div>
<portlet:actionURL name="addDrugRepresentative" var="addDrugRepresentativeURL" />

<aui:form action="<%= addDrugRepresentativeURL.toString() %>" method="post">

<aui:fieldset>
	<aui:input label="First Name" name="drName" size="45" value="${param.drName}" />
	<liferay-ui:error key="drug-representative-name-is-required" message="drug-representative-name-is-required" />
	<liferay-ui:error key="dr-name-too-long" message="dr-name-too-long" />

	<aui:input label="Last Name" name="drSurname" size="45" value="${param.drSurname}" />
	<liferay-ui:error key="drug-representative-surname-is-required" message="drug-representative-surname-is-required" />
	<liferay-ui:error key="dr-surname-too-long" message="dr-surname-too-long" />

	<aui:field-wrapper>
		<label class="field-label" for="drCellPhone">
			Company Mobile Phone
		</label>
		<input id="drCellPhone" name="_drugrepresentativereg_WAR_drugrepportlet_drCellPhone" size="45" type="text" value="${param.drCellPhone}" />
	</aui:field-wrapper>
	<liferay-ui:error key="company-cell-phone-is-required" message="company-cell-phone-is-required" />
	<liferay-ui:error key="company-cell-phone-too-long" message="company-cell-phone-too-long" />

	<aui:select label="Company" name="drIdCompany">
	  <aui:option value="-1" selected="${-1 eq param.drIdCompany}">
		<liferay-ui:message key="please-choose" />
	  </aui:option>

	  <c:forEach items="${companyList}" var="company">
	      <aui:option value="${company.id_company}" selected="${company.id_company eq param.drIdCompany}">
	          ${company.name}
	      </aui:option>
	  </c:forEach>
	</aui:select>
	If your company isn't in this list, please email support@rxtro.com , it will be updated within 24 hours
	<liferay-ui:error key="company-id-is-required" message="company-id-is-required" />

	<aui:field-wrapper label="Company email">
		<input name="_drugrepresentativereg_WAR_drugrepportlet_drCompanyEmail" size="45" type="text" value="${param.drCompanyEmail}" />
	</aui:field-wrapper>
	<liferay-ui:error key="company-email-is-required" message="company-email-is-required" />
	<liferay-ui:error key="company-email-already-exists" message="company-email-already-exists" />
	<liferay-ui:error key="company-email-is-invalid" message="company-email-is-invalid" />
	<liferay-ui:error key="company-email-too-long" message="company-email-too-long" />

	<aui:input label="First line products" name="drFirstList" size="45" value="${param.drFirstList}" />
	<liferay-ui:error key="first-line-product-is-required" message="first-line-product-is-required" />
	<liferay-ui:error key="products-too-long" message="products-too-long" />

	<aui:input label="Other Products" name="drOtherProducts" size="45" value="${param.drOtherProducts}" />
	<liferay-ui:error key="products-too-long" message="products-too-long" />

	<aui:select label="Country" name="drIdCountry">
	  <aui:option value="-1" selected="${-1 eq param.drIdCountry}">
		<liferay-ui:message key="please-choose" />
	  </aui:option>

	  <c:forEach items="${countryList}" var="country">
		  <aui:option value="${country.countryId}" selected="${country.countryId eq param.drIdCountry}">
			  ${country.name}
		  </aui:option>
	  </c:forEach>
	</aui:select>
	<liferay-ui:error key="country-id-is-required" message="country-id-is-required" />

	<aui:button-row>
		<aui:button disabled="false" id="boton_registrar" onClick="confirmEmail(document.forms._drugrepresentativereg_WAR_drugrepportlet_fm,document.forms._drugrepresentativereg_WAR_drugrepportlet_fm._drugrepresentativereg_WAR_drugrepportlet_drCompanyEmail.value);" value="Save" />
	</aui:button-row>
</aui:fieldset>

</aui:form>
<liferay-ui:success key="Drug-Representative-saved-successfully" message="Your registration was saved successfully. Check you mail" />