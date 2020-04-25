<%@ include file="/html/territorymanager/init.jsp" %>

<div class="popupTitle">
	<span class="popupMessage" id="popupMessage"></span>
</div>
<c:set value="true" var="first" />
<c:if test="${not empty drugRepList}">
	<div class="popupForm">
		<form action="javascript:;" method="POST" class="popupForm" id="assignAppFm" name="assignAppFm">
			<div class="modal-body">
				<c:forEach items="${drugRepList}" var="drugRep" varStatus="status">
					<c:if test="${first}">
						<input checked="checked" type="radio" name="<portlet:namespace/>drugRepId" value="${drugRep.id}"> ${drugRep.fullName}
					</c:if>
					<c:if test="${not first}">
						<input type="radio" name="<portlet:namespace/>drugRepId" value="${drugRep.id}"> ${drugRep.fullName}
					</c:if>
					<br />
					<c:set value="false" var="first" />
				</c:forEach>
			</div>
			<aui:input name="appId" type="hidden" value="${appId}" />
		</form>
	</div>
</c:if>
<c:if test="${empty drugRepList}">
	<div class="modal-body">
		<p>
			No Drug Representative
		</p>
	</div>
</c:if>
