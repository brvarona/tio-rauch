<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.util.enums.AppReviewed"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>

<%
	ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	AppModel app = (AppModel) row.getObject();
	boolean canMakeReview = !AppReviewed.isReviewedByDrugRep(app.getReviewed());
	String showAppReviewFormLinkId = "showAppReviewForm" + String.valueOf(app.getId());
%>

<%if (canMakeReview) {%>
	<liferay-ui:icon-menu>
		<liferay-ui:icon id="<%= showAppReviewFormLinkId %>" image="add" message="Complete Appointment" url="javascript:;" />
	</liferay-ui:icon-menu>
	
	<portlet:resourceURL id="submitReviewForm" var="submitReviewFormURL" />
	<portlet:resourceURL id="showAppReviewForm" var="showAppReviewFormURL" />
	<script type="text/javascript">
	var showAppReviewButton = document.getElementById('<portlet:namespace /><%= showAppReviewFormLinkId %>');
		addEvent('click', showAppReviewButton, function() {
			showAppReviewForm('<%= showAppReviewFormURL.toString() %>', '<%=app.getId()%>', '<%=submitReviewFormURL.toString() %>' , '<portlet:namespace /><%= showAppReviewFormLinkId %>', true);
		});
	</script>
<%} %>
