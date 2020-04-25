
<%@page import="com.rxtro.core.util.enums.AppReviewed"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>

<%@ page import="com.segmax.drugrep.model.Appoiment" %>

<%@ include file="/html/surgerymanager/init.jsp" %>

<%
	ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	AppModel app = (AppModel) row.getObject();
	boolean showMakeReview = !AppReviewed.isReviewedBySurgery(app.getReviewed());
	String showAppReviewFormLinkId = "showAppReviewForm" + String.valueOf(app.getId());
%>
<liferay-ui:icon-menu>
	<c:if test="<%= showMakeReview %>">
		<liferay-ui:icon id="<%= showAppReviewFormLinkId %>" image="add" message="Make Review" url="javascript:;" />
		<portlet:resourceURL id="submitReviewForm" var="submitReviewFormURL" />
		<portlet:resourceURL id="showAppReviewForm" var="showAppReviewFormURL" />
		<script type="text/javascript">
			var showAppReviewButton = document.getElementById('<portlet:namespace /><%= showAppReviewFormLinkId %>');
			addEvent('click', showAppReviewButton, function() {
				showAppReviewForm('<%= showAppReviewFormURL.toString() %>', '<%=app.getId()%>', '<%=submitReviewFormURL.toString() %>' , '<portlet:namespace /><%= showAppReviewFormLinkId %>', false);
			});
		</script>
	</c:if>
</liferay-ui:icon-menu>
