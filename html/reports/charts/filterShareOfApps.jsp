<%@ include file="/html/reports/init.jsp" %>

<liferay-portlet:actionURL name="dashboard" var="dashboardUrl" />

<div class="popupTitle">
	Specify one or more inputs by which to filter the report
	<span class="popupMessage" id="popupMessage"></span>
</div>

<form action="<%=dashboardUrl.toString() %>" class="popupForm" method="post" id="chartFilterForm">
	<div class="modal-body">
		<label for="fromDate" >Date From: </label>
		<input id="fromDate" name="<portlet:namespace/>fromDate" type="text" placeholder="Day-Mon-yyyy" value="${fromDate}" />
		<br />
		<label for="txtDateTo">Date To: </label>
		<input id="toDate" name="<portlet:namespace/>toDate" type="text" placeholder="Day-Mon-yyyy" value="${toDate}" />
		<br />
		<label for="ddlAggregate" >Aggregate: </label>
<%-- 		<select id="ddlAggregate" name="<portlet:namespace/>aggregateId" > --%>
<%-- 			<c:forEach items="${listOfAggregate}" var="aggregate" > --%>
<%-- 				<option value="${aggregate.aggregateId}" ${aggregate.aggregateId eq selectedAggregate ? 'selected' : ''}>${aggregate.aggregateId}</option> --%>
<%-- 			</c:forEach> --%>
<!-- 		</select> -->
		<select id="ddlAggregate" name="<portlet:namespace/>aggregateId" >
			<option value="MAT" ${aggregateId eq 'MAT' ? 'selected': ''} >MAT</option>
			<option value="MTH" ${aggregateId eq 'MTH' ? 'selected': ''} >MTH</option>
			<option value="ROLLQTR" ${aggregateId eq 'ROLLQTR' ? 'selected': ''}>ROLLQTR</option>
			<option value="YTD" ${aggregateId eq 'YTD' ? 'selected' : ''}>YTD</option>
		</select>
		<br />
		<label for="ddlCompanyRank" >Company Rank: </label>
		<select id="ddlCompanyRank" name="<portlet:namespace/>companyRank">
			<c:forEach begin="5" end="55" step="5" var="rank">
				<option value="${rank}" ${rank eq companyRank ? 'selected' : '' }>Top ${rank}</option>
			</c:forEach>
		</select>
		<c:choose>
			<c:when test="${not empty param.contextId and param.contextId == 10}">
				<br />
				<label for="managerId">Manager Id: </label>
				<input id="managerId" name="<portlet:namespace/>managerId" type="text" value="${managerId}" />
			</c:when>
			<c:otherwise>
				<div class="hidden">
					<label for="managerId" >Manager Id: </label>
					<input id="managerId" name="<portlet:namespace/>managerId" type="text" value="<%=user.getUserId() %>" />
				</div>
			</c:otherwise>
		</c:choose>
		<select id="ddlState" name="<portlet:namespace/>state">
			<c:forEach items="${states}" var="state">
				<option value="${state.code}" ${state.code eq selectedStateCode ? 'selected' : '' }>${state.code}</option>
			</c:forEach>
		</select>
		<select id="ddlATC" name="<portlet:namespace/>atc">
			<c:forEach items="${atcs}" var="atc">
				<option value="${atc.code}" ${atc.code eq selectedATCCode ? 'selected' : '' }>${atc.description}</option>
			</c:forEach>
		</select>
		<select id="ddlReps" name="<portlet:namespace/>repId">
			<option value="0" ${0 eq repId ? 'selected' : '' }>All Reps</option>
			<c:forEach items="${reps}" var="rep">
				<option value="${rep.repId}" ${rep.repId eq repId ? 'selected' : '' }>${rep.repName}</option>
			</c:forEach>
		</select>
		<select id="ddlTargets" name="<portlet:namespace/>targetName">
			<c:forEach items="${targets}" var="target">
				<option value="${target.name}" ${target.name eq targetName ? 'selected' : '' }>${target.name}</option>
			</c:forEach>
		</select>
	</div>
</form>
