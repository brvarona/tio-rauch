<%@ include file="/html/territorymanager/init.jsp" %>

<c:set value="false" var="areNotifications" />
	<c:if test="${not empty notifications}">
		<c:set value="true" var="areNotifications" />
	</c:if>

<div class="popupTitle">
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="javascript:;" class="popupForm" id="editNotificationsFm" name="editNotificationsFm">
	<div class="modal-body">
		<c:forEach items="${notifications}" var="notification">
			<input ${notification.enabled ? 'checked=checked' : '' } id="${notification.ordinal}" name="<portlet:namespace/>notifications" type="checkbox" value="${notification.ordinal}">(${notification.notificationType}) ${notification.name}
			<br />
		</c:forEach>
		<input name="<portlet:namespace/>territoryId" type="hidden" value="${territoryId}" />
	</div>
</form>

<c:if test="${not areNotifications}">
	<liferay-ui:message key="rep-does-not-have-notifications-msg" />
</c:if>
