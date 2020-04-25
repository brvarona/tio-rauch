<%@include file="/html/surgerymanager/init.jsp" %>

<div class="popupTitle">
	Date: ${appDate}
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="javascript:;" class="popupFormPlus" id="blockFm" name="blockFm">
	<div class="modal-body">
		<input type="hidden" name="<portlet:namespace/>appTime" value="${appTime}" />
		<input type="hidden" name="<portlet:namespace/>individualId" value="${individualId}" />
		<input type="hidden" name="<portlet:namespace/>surgeryId" value="${surgeryId}" />
		<aui:input name="comments" size="75" label="comments" type="text"></aui:input>
	</div>
</form>

