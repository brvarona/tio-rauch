<%@page import="com.rxtro.core.validation.message.KeyErrorMessage"%>
<%@page import="com.rxtro.core.validation.message.KeySuccessMessage"%>
<%@page import="com.rxtro.core.util.error.DrugRepError" %>
<%@ include file="/html/surgerymanager/init.jsp" %>

<div class="messagesContainer">
	<!-- SUCCESS MESSAGES -->
	<liferay-ui:success key="<%=KeySuccessMessage.APPOINTMENT_HOUR_ADDED %>" message="appointment-hour-added-msg"/>
	<liferay-ui:success key="<%=KeySuccessMessage.APPOINTMENT_HOUR_DELETED %>" message="appointment-hour-deleted-msg" />
	<liferay-ui:success key="<%=KeySuccessMessage.BLOCK_OUT_DATE_ADDED %>" message="block-out-date-added-msg" />
	<liferay-ui:success key="<%=KeySuccessMessage.BLOCK_OUT_DATE_DELETED %>" message="block-out-date-deleted-msg"/>
	
	<!-- ERROR MESSAGES FOR DELETE APPOINTMENT HOUR-->
	<liferay-ui:error key="<%=KeyErrorMessage.EXIST_PENDING_APPOINTMENTS %>" message="open-pennding-appointments-with-this-hour"/>
	<liferay-ui:error key="problem-appointment-hour-deleted" message="problem-appointment-hour-deleted" />
	<liferay-ui:error key="<%=KeyErrorMessage.INVALID_APPOINTMENT_HOUR %>" message="invalid-appointment-hour-msg"/>
	
	<!-- ERROR MESSAGES FOR ADD APPOINTMENT HOUR -->
	<liferay-ui:error key="<%=DrugRepError.INVALID_DOCTOR.getErrorKey()%>" message="<%=DrugRepError.INVALID_DOCTOR.getMessageKey() %>" />
	<liferay-ui:error key="<%=DrugRepError.INVALID_SURGERY.getErrorKey()%>" message="<%=DrugRepError.INVALID_SURGERY.getMessageKey() %>" />
	<liferay-ui:error key="<%=DrugRepError.INVALID_SCHEDULE_TIME.getErrorKey()%>" message="<%=DrugRepError.INVALID_SCHEDULE_TIME.getMessageKey() %>" />
	<liferay-ui:error key="<%=DrugRepError.NO_DOCTOR_ATTEND_IN_SURGERY.getErrorKey()%>" message="<%=DrugRepError.NO_DOCTOR_ATTEND_IN_SURGERY.getMessageKey() %>" />
	<liferay-ui:error key="<%=DrugRepError.SCHEDULE_ALREADY_EXIST.getErrorKey()%>" message="<%=DrugRepError.SCHEDULE_ALREADY_EXIST.getMessageKey() %>" />
	
	<!-- ERROR MESSAGES FOR ADD BLOCK OUT DATE -->
	<liferay-ui:error key="<%=KeyErrorMessage.SURGERY_ID_IS_REQUIRED %>" message="surgery-id-is-required"/>
	<liferay-ui:error key="<%=KeyErrorMessage.WITH_IS_REQUIRED %>" message="with-is-required-msg"/>
	<liferay-ui:error key="<%=KeyErrorMessage.BLOCK_OUT_FROM_REQUIRED %>" message="block-out-from-required" />
	<liferay-ui:error key="<%=KeyErrorMessage.BLOCK_OUT_TO_REQUIRED %>" message="block-out-to-required" />
	<liferay-ui:error key="<%=KeyErrorMessage.BLOCK_OUT_DESCRIPTION_LARGE %>" message="block-out-description-large"/>
	<liferay-ui:error key="<%=KeyErrorMessage.BLOCK_OUT_TIME_INVALID %>" message="block-out-time-invalid" />
	<liferay-ui:error key="<%=KeyErrorMessage.BLOCK_OUT_TIME_SHOULD_BE_FUTURE_DAY %>" message="block-out-time-should-be-future-time" />
	<liferay-ui:error key="<%=KeyErrorMessage.BLOCK_OUT_TIME_OVERLAP %>" message="block-out-time-overlap"/>
	<liferay-ui:error key="<%=KeyErrorMessage.BLOCK_OUT_TIME_WITH_APPOINTMENT %>" message="block-out-time-with-appointment"/>
	
	<!-- GENERIC ERROR MESSAGES -->
	<liferay-ui:error key="<%=KeyErrorMessage.UNEXPECTED_ERROR %>" message="unexpected-error-msg"/>
	<liferay-ui:error key="<%=DrugRepError.UNEXPECTED_ERROR.getErrorKey()%>" message="<%=DrugRepError.UNEXPECTED_ERROR.getMessageKey() %>" />
</div>