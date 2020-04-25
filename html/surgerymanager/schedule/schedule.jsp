<%@page import="com.rxtro.core.common.utils.StringUtil"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.util.ScheduleUtil"%>
<%@ include file="/html/surgerymanager/init.jsp" %>
<%@page import="com.rxtro.core.model.view.ScheduleView"%>

<%
PortletURL iteratorSchURL = renderResponse.createRenderURL();
iteratorSchURL.setParameter("jspPage", "/html/surgerymanager/schedule/appointmentTimes.jsp");
%>

<h3>My Schedule</h3>
<p><span style="display: none;" class="loadingPopup" id="loadingAttendantsContent">Loading...</span></p>
<liferay-ui:search-container delta="10" curParam="curSch1" iteratorURL="<%=iteratorSchURL %>" emptyResultsMessage="No items" >
	<liferay-ui:search-container-results>
	<%
		List<ScheduleView> schedules = ScheduleUtil.getScheduleViewBySurgery(surgery.getId(), surgery.getCurrentTime());
	 	
		results = ListUtil.subList(schedules, searchContainer.getStart(), searchContainer.getEnd());
		total = schedules.size();
		
		pageContext.setAttribute("results", results);
		pageContext.setAttribute("total", total);
	%>
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row 
		className="com.rxtro.core.model.view.ScheduleView" 
		keyProperty="scheduleId" 
		modelVar="schedule" >
			<liferay-ui:search-container-column-text name="Frecuency" value="<%=schedule.getFrecuency().getLabel() %>" />
			<liferay-ui:search-container-column-text name="Day" value="<%=schedule.getDayOfWeek() %>" />
			<liferay-ui:search-container-column-text name="Hour" value="<%=schedule.getTime()  %>" />
			<liferay-ui:search-container-column-text name="With" value="<%=schedule.getWith() %>" />
			<liferay-ui:search-container-column-text name="Visitors" value="<%=StringUtil.listStringToString(schedule.getVisitors(), \", \") %>" />
			<liferay-ui:search-container-column-text name="Start" value="<%=schedule.getStartDate() %>" />
			<liferay-ui:search-container-row-parameter name="limitDate" value="<%=schedule.getStartDate() %>" />
			<liferay-ui:search-container-column-jsp name="End" path="/html/surgerymanager/schedule/editEndDateAction.jsp" align="middle" />
			<liferay-ui:search-container-column-jsp path="/html/surgerymanager/schedule/myAppointmentScheduleActions.jsp" align="right" />
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>

<style>
.blockForm {
	display: none;
	-webkit-transition: display 2s; /* Safari */
    transition: display 2s;
}
</style>

<button id="btnShowBlockForm" class="btn btn-info" onclick="javascript:showBlockForm(this, 'scheduleBlockForm')">Add New Appointment Hour</button>
<div class="blockForm" id="scheduleBlockForm">
	<%@ include file="/html/surgerymanager/schedule/scheduleForm.jsp" %>
</div>

<script type="text/javascript" charset="utf-8">

function showBlockForm(btn, blockId) {
	var block = document.getElementById(blockId);
	if (block.style.display == '') {
		block.style.display = 'block';
		btn.className = 'btn';
	} else {
		block.style.display = '';
		btn.className = 'btn btn-info';
	}
}

YUI().ready(function (A) {
	var overlayder = document.createElement('div');
	overlayder.id = 'overlayder';
	overlayder.className = 'overlayder';
	overlayder.style.display = 'none';
	var editAttendantsContent = document.createElement('div');
	editAttendantsContent.id = 'editAttendantsContent';
	editAttendantsContent.className = 'minPopup';
	editAttendantsContent.style.display = 'none';
	
	var loadingAttendantsContent = document.createElement('div');
	loadingAttendantsContent.id = 'loadingAttendantsContent';
	loadingAttendantsContent.className = 'loadingPopup';
	loadingAttendantsContent.style.display = 'none';
	
	overlayder.appendChild(editAttendantsContent);
	document.body.insertBefore(overlayder, document.body.firstChild);
});


</script>