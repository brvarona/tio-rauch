<%@ include file="/html/surgerymanager/init.jsp" %>

<h3>Nurse</h3>

<div class="panel-footer">
	<portlet:renderURL var="addNurseFormURL">
		<portlet:param name="jspPage" value="/html/surgerymanager/medicalstaff/nurse/addForm.jsp" />
	</portlet:renderURL>
	Click <a href="<%=addNurseFormURL.toString() %>" >here</a> to add a new Nurse
</div>