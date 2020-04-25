
<%@page import="com.rxtro.core.model.view.ScheduleView"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<div class="popupTitle">
	<span class="popupMessage" id="popupMessage"></span>
</div>
<div class="popupForm">
	<form action="javascript:;" class="popupForm" id="editEndDateFm" name="editEndDateFm">
		<div class="modal-body">
			<label>End Date
				<span class="switch">
					<input type="checkbox" checked="checked" name="<portlet:namespace/>switcherEndDate" id="switcherEditedEndDate" />
					<span class="slider round"></span>
				</span>
			</label>
			<input class="input-medium" id="editedEndDate" name="<portlet:namespace/>endDate" type="text" placeholder="Day-Mon-yyyy" value="${endDate != null ? endDate : ''}" />
			<input class="input-medium" id="editedScheduleId" name="<portlet:namespace/>scheduleId" type="hidden" value="${scheduleId}" />
		</div>
	</form>
</div>

