<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="java.util.Calendar" %>

<style>
.blockForm {
	display: none;
	-webkit-transition: display 2s; /* Safari */
    transition: display 2s;
}
</style>

<portlet:actionURL var="showMonthAppointmentURL" name="showMonthAppointment">
	<%
	Calendar date = Calendar.getInstance();
	%>
	<portlet:param name="month" value="<%= String.valueOf(date.get(Calendar.MONTH)) %>" />
	<portlet:param name="year" value="<%= String.valueOf(date.get(Calendar.YEAR)) %>" />
</portlet:actionURL>

<portlet:renderURL var="viewSwappedAppointmentsURL">
	<portlet:param name="jspPage" value="/html/territorymanager/apptaker/earlierApps.jsp" />
</portlet:renderURL>

<h2>
	CLICK HERE TO SEARCH FOR AVAILABLE APPOINTMENTS
</h2>
<p>
	<aui:button cssClass="btn btn-large" onClick="<%= showMonthAppointmentURL %>" type="button" value="Make Appointment"></aui:button>
</p>
<p>
	<aui:button cssClass="btn btn-large" onClick="<%= viewSwappedAppointmentsURL %>" type="button" value="Swap Appointment"></aui:button>
</p>

<p class="orangeText">
	You can only make one appointment with the system at a time
</p>

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

</script>