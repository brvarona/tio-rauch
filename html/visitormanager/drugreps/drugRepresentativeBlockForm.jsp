<%@ include file="/html/visitormanager/init.jsp" %>

<portlet:actionURL name="blockDrugRrepresentative" var="blockDrugRrepresentativeURL" />

<form action="<%= blockDrugRrepresentativeURL.toString() %>" name="blockDrugRrepresentativeForm" class="popupForm" method="post">
	<div class="modal-body">
		<aui:fieldset>
			<aui:input name="drugRepresentativeId" type="hidden" value="${param.drugRepresentativeId}" />
			<aui:input name="surgeryId" type="hidden" value="${surgeryId}" />
			<aui:input name="companyId" type="hidden" value="${companyId}" />
			<aui:input name="compTerm" type="hidden" value="${compTerm}" />
			<aui:input name="repTerm" type="hidden" value="${repTerm}" />
			<aui:input name="comments" id="comments" type="textarea" onKeypress="return countText(event)" />
			<p id="valmess2" style="color:red" ></p>
		</aui:fieldset>
	</div>
</form>

