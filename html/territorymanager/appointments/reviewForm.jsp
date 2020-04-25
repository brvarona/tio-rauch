<%@ include file="/html/territorymanager/init.jsp" %>

<c:set value="false" var="areAttendants" />
<c:if test="${not empty attendants}">
	<c:set value="true" var="areAttendants" />
</c:if>

<div class="popupTitle">
	Which doctors attended the appointment?
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="javascript:;" class="popupForm" id="drugRepReviewFm" name="drugRepReviewFm">
	<div class="modal-body">
		<c:forEach items="${attendants}" var="doctor">
			<input id="${doctor.id}" name="<portlet:namespace/>attendants" type="checkbox" value="${doctor.id}"/>${doctor.fullName}
			<br />
		</c:forEach>
		<aui:input name="appId" type="hidden" value="${appId}" />
		<br />
		<p>Is the list of doctors at the practice accurate?</p>
		<input checked id="doctorsAccurate" name="<portlet:namespace/>doctorsAccurate" type="radio" value="1" onChange="changeDoctorsAccurate(value);" > Yes
		<br />
		<input id="doctorsAccurate" name="<portlet:namespace/>doctorsAccurate" type="radio" value="0" onChange="changeDoctorsAccurate(value);"> No
		<br />	<br />
		<label id="labelWrongList" type="label" style="display: none"> What was wrong with the doctors list? <br /> <b><i> Please note this will trigger an email to the practice to update their list with the comments below included </i></b></label>
		<input id="repComment" name="<portlet:namespace/>repComment" placeholder="Comment" type="textarea" maxlength="150" style="display: none"/>		
	</div>
</form>

<c:if test="${not areAttendants}">
	<liferay-ui:message key="not-attendants-for-this-app-msg" />
</c:if>

