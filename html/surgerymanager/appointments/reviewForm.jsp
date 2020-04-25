<%@include file="/html/surgerymanager/init.jsp" %>

<div class="popupTitle">
	Date: ${appDate}
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="javascript:;" class="popupFormPlus" id="surgeryReviewFm" name="surgeryReviewFm">
	<div class="modal-body">
		<input type="hidden" name="<portlet:namespace/>appId" value="${appId}" />
		<label>The Drug Representative attended?</label>
		<select name="<portlet:namespace/>reviewStatus">
			<aui:option selected="${not isReviewed}" value="-1">Not Reviewed</aui:option>
			<aui:option selected="${isDrugRepAttended}" value="1">Yes</aui:option>
			<aui:option selected="${isReviewed and not isDrugRepAttended}" value="2">No</aui:option>
		</select>
		<label>Spent Time (Minutes)</label>
		<select name="<portlet:namespace/>spentTime">
			<% for (int i=0;i<240;i+=10) { %>
				<option value="<%= i %>"><%= i %></option>
			<% } %>
		</select>
		<aui:input name="comments" size="75" label="comments" type="text">${surgeryComments}</aui:input>
	</div>
</form>

