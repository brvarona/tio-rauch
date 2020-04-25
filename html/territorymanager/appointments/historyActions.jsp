<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.common.utils.TimeUtil"%>
<%@page import="com.rxtro.core.util.enums.AppReviewed"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	AppModel app = (AppModel) row.getObject();
	long diffDays = TimeUtil.getDiffDays(app.getSurgery().getCurrentTime(), app.getAppDate(), false);
	boolean canMakeReview = !AppReviewed.isReviewedByDrugRep(app.getReviewed()) && diffDays <= AppUtil.MAX_DAYS_TO_BE_REVIEWED && diffDays > AppUtil.MAX_DAYS_TO_BE_ALERT_BY_REVIEWED;
	
	String showAppReviewFormLinkId = "showAppReviewForm" + String.valueOf(app.getId());
%>

<%if (canMakeReview) { %>
	<liferay-ui:icon-menu>
		<liferay-ui:icon id="<%= showAppReviewFormLinkId %>" image="add" message="Complete Appointment" url="javascript:;" />
	</liferay-ui:icon-menu>
	
	<portlet:resourceURL id="submitReviewForm" var="submitReviewFormURL" />
	<portlet:resourceURL id="showAppReviewForm" var="showAppReviewFormURL" />
	<script type="text/javascript">
	var showAppReviewButton = document.getElementById('<portlet:namespace /><%= showAppReviewFormLinkId %>');
		addEvent('click', showAppReviewButton, function() {
			showAppReviewForm('<%= showAppReviewFormURL.toString() %>', '<%=app.getId()%>', '<%=submitReviewFormURL.toString() %>' , '<portlet:namespace /><%= showAppReviewFormLinkId %>', false);
		});
	</script>
<%} %>
