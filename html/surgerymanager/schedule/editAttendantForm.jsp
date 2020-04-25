<%@ include file="/html/surgerymanager/init.jsp" %>

<c:set value="false" var="areAttendants" />
	<c:if test="${not empty attendants or not empty noAttendants}">
		<c:set value="true" var="areAttendants" />
	</c:if>

<div class="popupTitle">
	${scheduleDay} ${scheduleHour}:${scheduleMinutes}
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="javascript:;" class="popupForm" id="editAttendantsFm" name="editAttendantsFm">
	<div class="modal-body">
		<c:forEach items="${attendants}" var="doctor">
			<input checked="checked" id="${doctor.id_doctor}" name="<portlet:namespace/>attendants" type="checkbox" value="${doctor.id_doctor}">${doctor.fullName}
			<br />
		</c:forEach>
		<c:forEach items="${noAttendants}" var="doctor">
			<input id="${doctor.id_doctor}" name="<portlet:namespace/>attendants" type="checkbox" value="${doctor.id_doctor}" />${doctor.fullName}
			<br />
		</c:forEach>
		<aui:input name="scheduleId" type="hidden" value="${scheduleId}" />
		<aui:input name="appointmentId" type="hidden" value="${appointmentId}" />
	</div>
</form>

<c:if test="${not areAttendants}">
	<liferay-ui:message key="surgery-does-not-have-doctors-msg" />
</c:if>
