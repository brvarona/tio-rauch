<%@ include file="/html/findrepresentatives/init.jsp" %>

<div class="popupTitle">
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="javascript:;" class="popupForm" id="blockDrugRepForm" name="blockDrugRepForm">
	<div class="modal-body">
		<aui:fieldset>
			<aui:input name="drugRepId" type="hidden" value="${param.drugRepId}" />
			<aui:input name="surgeryId" type="hidden" value="${surgeryId}" />
			<aui:input name="reason" label="Reason" id="comments" type="textarea" onKeypress="return countText(event)" />
			<p id="valmess2" style="color:red" ></p>
		</aui:fieldset>
	</div>
</form>
