<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>

<%@ page import="com.segmax.drugrep.model.Invited" %>

<%
	ResultRow row2 = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	Invited unaReview = (Invited)row2.getObject();
	Long idInvited = unaReview.getId_invited();
	Long idAppointment = unaReview.getId_appoiment();
	String[] comments = {"Doctor left the Practice","Doctor wasn't working that day"};
%>

<liferay-ui:icon-menu>

<%
	for (int i=0;i<comments.length;i++) {
		%>

		<portlet:actionURL name="makeIndividualReview" var="makeIndividualReviewURL">
			<portlet:param name="idInvited" value="<%= idInvited.toString() %>"></portlet:param>
			<portlet:param name="idAppointment" value="<%= idAppointment.toString() %>"></portlet:param>
			<portlet:param name="comment" value="<%= comments[i] %>"></portlet:param>
		</portlet:actionURL>
		<liferay-ui:icon image="add" message="<%= comments[i] %>" url="<%= makeIndividualReviewURL.toString() %>" />

		<%
	}
%>

</liferay-ui:icon-menu>