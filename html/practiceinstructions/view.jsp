<%@include file="/html/practiceinstructions/init.jsp" %>

<div class="messagesContainer">
	<liferay-ui:error key="surgery-saved-unsuccessfully" message="Could not be updated" />
	<liferay-ui:success key="surgery-saved-successfully" message="Updated successfully" />
</div>

<div class="pi-content">
	<div class="pi-box-left">
		<%@include file="/html/practiceinstructions/comments.jsp" %>
	</div>
	<div class="pi-box-right">
		<%@include file="/html/practiceinstructions/questions.jsp" %>
	</div>
</div>