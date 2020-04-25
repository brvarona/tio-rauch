<%@ include file="/html/findrepresentatives/init.jsp" %>

<portlet:actionURL name="searchReps" var="searchRepsURL" />
<form action="<%=searchRepsURL.toString() %>" method="post" name="defaultSearchForm">
	<input type="hidden" name="<portlet:namespace/>seachByFilter" value="1">
	<input type="hidden" name="<portlet:namespace/>term" value="">
</form>

<script type="text/javascript">
	YUI().ready(function(A) {
		document.forms.defaultSearchForm.submit();
	});
</script>