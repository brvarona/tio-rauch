<%@ include file="/html/territorymanager/init.jsp" %>

<div class="popupTitle">
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="javascript:;" class="popupForm" id="editNotificationsFm" name="editNotificationsFm">
	<div class="modal-body">
		<c:forEach items="${notifications}" var="notification">
			<input ${notification.enabled ? 'checked=checked' : '' } id="${notification.ordinal}" name="<portlet:namespace/>notifications" type="checkbox" value="${notification.ordinal}">(${notification.notificationType}) ${notification.name}
			<br />
		</c:forEach>
	</div>
</form>

