<%@page import="com.liferay.portal.kernel.workflow.WorkflowConstants"%>
<%@page import="com.liferay.portal.model.ListTypeConstants"%>
<%@ include file="/html/reports/init.jsp" %>
<liferay-ui:header title="OurdrugReports"></liferay-ui:header>
<ol>
<!-- 	<li> -->
<%-- 		<portlet:resourceURL var="reportResourceURL1"> --%>
<%-- 			<portlet:param name="reportType" value="1"></portlet:param> --%>
<%-- 		</portlet:resourceURL> --%>
<%-- 		<a href="<%= reportResourceURL1.toString() %>">Client</a> --%>
<!-- 	</li> -->
	<li>
		<portlet:resourceURL var="reportResourceURL2">
			<portlet:param name="reportType" value="2"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL2.toString() %>">Clinic</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL3">
			<portlet:param name="reportType" value="3"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL3.toString() %>">Doctor</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL4">
			<portlet:param name="reportType" value="4"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL4.toString() %>">DoctorClinic</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL5" id="5">
			<portlet:param name="reportType" value="5"></portlet:param>
		</portlet:resourceURL>
		<portlet:resourceURL var="reportResourceURL12" id="12">
			<portlet:param name="reportType" value="12"></portlet:param>
		</portlet:resourceURL>
		<portlet:resourceURL var="reportResourceURL13" id="13">
			<portlet:param name="reportType" value="13"></portlet:param>
		</portlet:resourceURL>
		<form action="<%= reportResourceURL5.toString() %>" method="post" name="drugRepReport" id="drugRepReport" style="margin: 0; display: inline;">
			<a href="#" onclick="javascript:document.getElementById('drugRepReport').submit();">DrugRep</a>
			(<select name='<portlet:namespace/>status' onchange="changeDrugRepReport(this)" style="height: 20px; line-height: 20px; width: 80px; margin: 0 5px">
				<option value="<%=WorkflowConstants.STATUS_ANY %>">Any</option>
				<option value="<%=WorkflowConstants.STATUS_APPROVED %>">Active</option>
				<option value="<%=WorkflowConstants.STATUS_INACTIVE %>">Inactive</option>
			</select>)
		</form>
		<script type="text/javascript">
			function changeDrugRepReport(select) {
				if (select.value == '<%=WorkflowConstants.STATUS_ANY %>') {
					document.getElementById('drugRepReport').action = '<%=reportResourceURL5.toString()%>';
				} else if  (select.value == '<%=WorkflowConstants.STATUS_APPROVED %>') {
					document.getElementById('drugRepReport').action = '<%=reportResourceURL12.toString()%>';
				} else if  (select.value == '<%=WorkflowConstants.STATUS_INACTIVE %>') {
					document.getElementById('drugRepReport').action = '<%=reportResourceURL13.toString()%>';
				}
			}
		</script>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL6">
			<portlet:param name="reportType" value="6"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL6.toString() %>">Territories</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL7">
			<portlet:param name="reportType" value="7"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL7.toString() %>">AvailableAppointments</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL8">
			<portlet:param name="reportType" value="8"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL8.toString() %>">BlockOutDates</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL9">
			<portlet:param name="reportType" value="9"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL9.toString() %>">Appointments</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL10">
			<portlet:param name="reportType" value="10"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL10.toString() %>">Shopping Orders</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL14">
			<portlet:param name="reportType" value="14"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL14.toString() %>">Cancelled Apps</a>
	</li>
	<li>
		<portlet:resourceURL var="reportResourceURL15">
			<portlet:param name="reportType" value="15"></portlet:param>
		</portlet:resourceURL>
		<a href="<%= reportResourceURL15.toString() %>">Visitors</a>
	</li>
</ol>