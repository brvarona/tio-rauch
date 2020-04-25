<%@include file="/html/territorymanager/init.jsp" %>

<h3>Products</h3>


<liferay-ui:success key="products-updated-key" message="products-updated-msg"/>
<liferay-ui:error key="drug-representative-name-is-required" message="drug-representative-name-is-required" />
<liferay-ui:error key="unexpected-error" message="unexpected-error-msg" />
<liferay-ui:error key="products-too-long" message="products-too-long" />

<portlet:actionURL name="updateProducts" var="updateProductsURL" />
<form action="<%= updateProductsURL.toString() %>" method="post" name="fm" >
	<div class="control-group">
		<label class="control-label" for="firstLineProducts">First Line Products:</label>
		<div class="controls">
			<input type="text" id="firstLineProducts" name="<portlet:namespace/>firstLineProducts" value="${firstLineProducts}" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="secondLineProducts">Second Line Products:</label>
		<div class="controls">
			<input type="text" id="secondLineProducts" name="<portlet:namespace/>secondLineProducts" value="${secondLineProducts}" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="thirdLineProducts">Third Line Products:</label>
		<div class="controls">
			<input type="text" id="thirdLineProducts" name="<portlet:namespace/>thirdLineProducts" value="${thirdLineProducts}" />
		</div>
	</div>
	<button class="btn btn-info" >Update</button>
</form>

<h3>Company Update</h3>

<liferay-ui:error key="company-email-is-required" message="company-email-is-required" />
<liferay-ui:error key="company-email-already-exists" message="company-email-already-exists" />
<liferay-ui:error key="company-email-is-invalid" message="company-email-is-invalid" />
<liferay-ui:error key="company-id-is-required" message="company-id-is-required" />
<liferay-ui:error key="appointment-shoud-be-canceled" message="appointment-shoud-be-canceled" />
<liferay-ui:error key="company-email-shoud-change-key" message="company-email-shoud-change-msg" />

<liferay-ui:error key="unexpected-error" message="unexpected-error-msg" />

<portlet:actionURL name="changeCompany" var="changeCompanyURL" />

<c:if test="${not empty successChangeCompany}">
	<div id="changeCompanySuccessMessage" style="margin:10px 0 12px 0;">
		<span style="font-size:1.5em;color:#666">Your new company is </span><span class="orangeText" style="font-size:2em;">${currentCompanyName}</span>
	</div>

	<script>
		setTimeout(function() { 
			document.getElementById('changeCompanyForm').className = '';
			document.getElementById('changeCompanySuccessMessage').className = 'hidden';
		}
		, 3000);
	</script>
</c:if>

<div class="hidden" id="changeCompanyForm">
	<form action="<%= changeCompanyURL.toString() %>" method="post" name="fm" 
	onsubmit="javascript:confirmEmail(document.forms.fm,document.forms.fm._territorymanager_WAR_drugrepportlet_email.value);">
		<select name="<portlet:namespace/>companyId" id="company">
			<c:forEach items="${companyList}" var="company">
				<c:if test="${empty company.activeChildOrgs}">
					<option value="${company.id}">
						${company.name}
					</option>
				</c:if>
				<c:if test="${not empty company.activeChildOrgs}">
					<optgroup label="${company.name}">
						<c:forEach items="${company.activeChildOrgs}" var="subcompany">
							<c:if test="${currentCompanyId == subcompany.organizationId}">
								<option value="${subcompany.organizationId}" selected="selected">
									${subcompany.name}
								</option>
							</c:if>
							<c:if test="${currentCompanyId != subcompany.organizationId}">
								<option value="${subcompany.organizationId}">
									${subcompany.name}
								</option>
							</c:if>
						</c:forEach>
					</optgroup>
				</c:if>
			</c:forEach>
		</select>
		If your company isn't in this list, please email support@rxtro.com, it will be updated within 24 hours
		<div class="control-group">
			<label class="control-label" for="email">New Company email:</label>
			<div class="controls">
				<input name="<portlet:namespace/>email" id="email" type="text" value="${currentEmail}" />
			</div>
		</div>

		<button class="btn btn-info" id="boton_add_apphour">Change</button>
	</form>
</div>

<c:if test="${empty successChangeCompany}">
	<script>
		document.getElementById('changeCompanyForm').className = '';
	</script>
</c:if>