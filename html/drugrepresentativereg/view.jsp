<%@include file="/html/drugrepresentativereg/init.jsp" %>
<portlet:actionURL name="showDrugRepRegistrationForm" var="showDrugRepRegistrationFormURL" />
<script>
	location.href = '<%= showDrugRepRegistrationFormURL.toString() %>';
</script>