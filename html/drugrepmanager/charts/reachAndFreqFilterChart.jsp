<%@ include file="/html/drugrepmanager/init.jsp" %>


<div class="popupTitle">
	Specify one or more inputs by which to filter the report
	<span id="popupMessage"></span>
</div>

<liferay-portlet:actionURL name="loadReachAndFreqChartFromFilter" var="filterChartUrl" />

<form class="filterForm" action="<%=filterChartUrl.toString() %>" method="post" id="chartFilterForm">
	<input type="hidden" type="text" name="<portlet:namespace/>resultPage" value="${chartFilters.chartPage}" />
	<div class="">
		<div class="col-md-6">
			<label for="fromDate">From</label>
			<input type="text" class="form-control" id="fromDate" name ="<portlet:namespace/>fromDate" value="${chartFilters.from}" />
		</div>
		<div class="col-md-6">
			<label for="toDate">To</label>
			<input type="text" class="form-control" id="toDate" name="<portlet:namespace/>toDate" value="${chartFilters.to}" />
		</div>
	</div>
	<div>
		<div class="col-md-6">
			<label for="aggregate">Aggregate</label>
			<select id="aggregate" class="form-control" name="<portlet:namespace/>aggregateId" >
				<option value="MAT" ${chartFilters.aggregateId eq 'MAT' ? 'selected': ''} >MAT</option>
				<option value="MTH" ${chartFilters.aggregateId eq 'MTH' ? 'selected': ''} >MTH</option>
				<option value="ROLLQTR" ${chartFilters.aggregateId eq 'ROLLQTR' ? 'selected': ''}>ROLLQTR</option>
				<option value="YTD" ${chartFilters.aggregateId eq 'YTD' ? 'selected' : ''}>YTD</option>
			</select>
		</div>
		<div class="col-md-6">
			<label for="companyRank">Company Rank</label>
			<select id="companyRank" class="form-control" name="<portlet:namespace/>companyRank">
				<c:forEach begin="5" end="55" step="5" var="rank">
					<option value="${rank}" ${rank eq chartFilters.rank ? 'selected' : '' }>Top ${rank}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="hidden">
		<label for="managerId">Manager Id: </label>
		<input type="text" id="managerId" class="form-control" name="<portlet:namespace/>managerId" value="${chartFilters.managerId}" />
	</div>
	
	<div class="">
		<div class="col-md-6">
			<label for="state">State</label>
			<select id="state" class="form-control" name="<portlet:namespace/>state">
				<c:forEach items="${chartFilters.states}" var="state">
					<option value="${state.code}" ${state.code eq chartFilters.stateCode ? 'selected' : '' }>${state.code}</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-md-6">
			<label for="atc">ATC</label>
			<select id="atc" class="form-control" name="<portlet:namespace/>atc">
				<c:forEach items="${chartFilters.atcs}" var="atc">
					<option value="${atc.code}" ${atc.code eq chartFilters.atcCode ? 'selected' : '' }>${atc.description}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="">
		<div class="col-md-6">
			<label for="rep">Representative</label>
			<select id="rep" class="form-control" name="<portlet:namespace/>repId">
				<option value="0" ${0 eq chartFilters.drugRepUserId ? 'selected' : '' }>All Reps</option>
				<c:forEach items="${chartFilters.drugReps}" var="rep">
					<option value="${rep.repId}" ${rep.repId eq chartFilters.drugRepUserId ? 'selected' : '' }>${rep.repName}</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-md-6">
			<label for="target">Targets</label>
			<select id="target" class="form-control" name="<portlet:namespace/>targetName">
				<c:forEach items="${chartFilters.targets}" var="target">
					<option value="${target.name}" ${target.name eq chartFilters.targetName ? 'selected' : '' }>${target.name}</option>
				</c:forEach>
			</select>
		</div>
	</div>
</form>
