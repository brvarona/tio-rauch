<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.segmax.drugrep.service.DoctorLocalServiceUtil"%>
<%@page import="com.segmax.drugrep.model.Doctor"%>
<%@ include file="/html/surgerymanager/init.jsp" %>
<%@page import="com.rxtro.core.model.BlockOutDateModel"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>

<%
PortletURL iteratorBODURL = renderResponse.createRenderURL();
iteratorBODURL.setParameter("jspPage", "/html/surgerymanager/schedule/appointmentTimes.jsp");
%>

<h3>Clinic Block Out Dates</h3>
<liferay-ui:search-container delta="10" curParam="cur2" iteratorURL="<%=iteratorBODURL %>" emptyResultsMessage="Add a block out date">
	<liferay-ui:search-container-results>
	<%
	 // List<Surgery_Blockout> surgeryBlockoutList = Surgery_BlockoutLocalServiceUtil.getFutureBlockoutDates(idSurgery);
	 List<BlockOutDateModel> blockOutDateList = SurgeryUtil.getBlockOutDate(surgery.getId());
	 
	 results = ListUtil.subList(blockOutDateList, searchContainer.getStart(), searchContainer.getEnd());
	 total = blockOutDateList.size();
	 
	 pageContext.setAttribute("results",results);
	 pageContext.setAttribute("total",total);
	%>
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row 
		className="com.rxtro.core.model.BlockOutDateModel"
		keyProperty="id" 
		modelVar="bod" >
		<%
			String with = "Clinic";
			if (bod.isIndividual()) {
				Doctor doctor = DoctorLocalServiceUtil.getDoctor(bod.getDoctorId());
				with = doctor.getFullName();
			}
		%>
		<liferay-ui:search-container-column-text name="From" value="<%=FormatDateUtil.format(bod.getFrom(), FormatDateUtil.PATTERN_DD_MMMM_YYYY_HH_MM) %>" />
		<liferay-ui:search-container-column-text name="To" value="<%=FormatDateUtil.format(bod.getTo(), FormatDateUtil.PATTERN_DD_MMMM_YYYY_HH_MM) %>" />
		<liferay-ui:search-container-column-text name="With" value="<%=with %>" />
		<liferay-ui:search-container-column-text name="Description" value="<%=bod.getDescription() %>" />
		<liferay-ui:search-container-column-jsp path="/html/surgerymanager/schedule/myAppoimentBlockout_actions.jsp" align="right" />
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>
		
<%@ include file="/html/surgerymanager/init.jsp" %>

<div class="form-actions">
	<dl>
	  <dt>Clinic Block Out Dates</dt>
	  <dd>Please Note: When adding a block out date, it must be in the future. Please note that the default block-out time is to start at 7am and finish at 6pm. If you are trying to block out a time for today, you will need to change the start time so that it is in the future.</dd>
	</dl>
	<portlet:actionURL name="addBlockOutDate" var="addBlockOutDateURL"/>
	<form action="<%=addBlockOutDateURL.toString() %>" method="post" class="form-line">
		<aui:input name="surgeryId" value="<%=surgery.getId() %>" type="hidden" />
		<div class="controls form-inline">
			<select name="<portlet:namespace/>with" style="margin-right: 10px">
				<option value="-1">Clinic</option>
 				<c:forEach items="${individuals}" var="doctor">
 					<option value="${doctor.id}">${doctor.fullName}</option>
 				</c:forEach>
 			</select>
				<label class="">from</label>
			<input class="input-medium" id="from" name="<portlet:namespace/>from" type="text" placeholder="Day-Mon-yyyy" value="<%=surgery.getCurrentTimeStr(FormatDateUtil.PATTERN_DD_MM_YYYY) %>" />
			<input class="input-medium" id="blockHourFrom" name="<portlet:namespace/>blockHourFrom" type="text" placeholder="hh:mm" value="07:00" style="margin-right: 10px" />
			<label class="">to</label>
			<input class="input-medium" id="to" name="<portlet:namespace/>to" type="text" placeholder="Day-Mon-yyyy" value="<%=surgery.getCurrentTimeStr(FormatDateUtil.PATTERN_DD_MM_YYYY) %>" />
			<input class="input-medium" id="blockHourTo" name="<portlet:namespace/>blockHourTo" type="text" placeholder="hh:mm" value="18:00" style="margin-right: 10px" />
			<input class="input-medium" id="description" name="<portlet:namespace/>description" type="text" placeholder="Description" value="" style="margin-right: 10px" />
			<button class="btn btn-default" type="submit">Add</button>
		</div>
	</form> 
</div>

