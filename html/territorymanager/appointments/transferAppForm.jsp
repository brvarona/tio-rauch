<%@ include file="/html/territorymanager/init.jsp" %>

<c:set value="false" var="areColleagues" />
<c:if test="${not empty colleagues}">
	<c:set value="true" var="areColleagues" />
</c:if>

<div class="popupTitle">
	Select a colleague
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="javascript:;" class="popupForm" id="transferAppFm" name="transferAppFm">
	<div class="modal-body">
		<c:forEach items="${colleagues}" var="colleague" varStatus="status">
			<input ${status.index == 0 ? 'checked=\"checked\"' : ''} id="${colleague.id}" 
				name="<portlet:namespace/>colleagueDrugRepId" type="radio" value="${colleague.id}">${colleague.fullName} (${colleague.team.companyName} - ${colleague.team.name})
			<br />
		</c:forEach>
		<aui:input name="appId" type="hidden" value="${appId}" />
		<br />
	</div>
</form>

<c:if test="${not areColleagues}">
	<liferay-ui:message key="not-colleagues-for-this-app-msg" />
</c:if>

