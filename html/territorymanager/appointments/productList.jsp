
<%@include file="/html/territorymanager/init.jsp" %>

<h3>Requests</h3>

<liferay-portlet:resourceURL id="getPendingProducts" var="loadTableUrl" />
<liferay-portlet:resourceURL id="assignOrderToMe" var="assignOrderToMeURL" />
<c:set value="<%=assignOrderToMeURL.toString() %>" var="assignOrderToMeURL" />

<table class="table table-bordered table-hover table-striped">
	<thead class="table-columns">
		<tr>
			<th class="table-first-header">Order#</th>
			<th>Date</th>
			<th>Doctor</th>
			<th>Clinic</th>
			<th>Assigned To</th>
			<th>Status</th>
			<th class="table-last-header"></th>
		</tr>
	</thead>
	<tbody class="table-data">
		<c:forEach items="${orderResults}" var="r" varStatus="s">
			<tr id="productRowId${s.index}">
				<td title="Order#" class="table-cell">${r.order.number}</td>
				<td title="Date" class="table-cell">${r.orderDateStr}</td>
				<td title="Doctor" class="table-cell">${r.docName}</td>
				<td title="Clinic" class="table-cell">${r.surgeryName}</td>
				<td title="Assigned To" class="table-cell">${r.assignedToName}</td>
				<td title="Status" class="table-cell">${r.status.label}</td>
				<td title="Actions" class="table-cell last">
					<liferay-ui:icon-menu>
						<c:choose>
							<c:when test="${r.status == 'PENDING'}">
								<liferay-ui:icon image="assign" message="Assign to Me" url="javascript:assignOrderToMe('${assignOrderToMeURL}', '${r.getOrderItemIdsJson()}', '${loadTableUrl}', 'productRowId${s.index}');" />
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</liferay-ui:icon-menu>
				
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>


<c:if test="${orderResultTotal > 10}">

	<c:set var="loadTableUrl" value="<%=loadTableUrl.toString() %>"  />
	
<%-- 	<c:set var="pageCur" value="${pageCur}" /> --%>
<%-- 	<c:set var="pageSize" value="${pageSize}" /> --%>
	<c:if test="${empty pageCur}">
		<c:set var="pageCur" value="1" />
	</c:if>
	<c:if test="${empty pageSize}">
		<c:set var="pageSize" value="10" />
	</c:if>
	
	<c:set var="subTotalPages" value="${(orderResultTotal / pageSize) + 1}" />
	<fmt:parseNumber var="pageTotal" integerOnly="true"  type="number" value="${fn:replace(subTotalPages,'.',',')}" />
	<c:set var="pageStart" value="${(pageCur * pageSize) - pageSize + 1}" />
	<c:set var="pageEnd" value="${orderResultTotal < (pageCur * pageSize) ? orderResultTotal : (pageCur * pageSize)}" />
	
	<div class="taglib-search-iterator-page-iterator-bottom">
		<div class="taglib-page-iterator">
 			<div class="clearfix lfr-pagination">
				<div class="lfr-pagination-config">
					<div class="lfr-pagination-page-selector">
						<select onchange="selectPage(this.value, ${pageCur}, ${pageSize}, '${loadTableUrl}')">
							<c:forEach begin="1" end="${pageTotal}" var="nextPage" >
								<option value="${nextPage}" ${nextPage eq pageCur ? 'selected' : ''}>Page ${nextPage} ${nextPage eq pageCur ? 'of' : ''} ${nextPage eq pageCur ? pageTotal : ''}</option>	
							</c:forEach>
						</select>
					</div>
					<div class="lfr-pagination-delta-selector">
						<select onchange="selectPageSize(this.value, ${pageSize}, '${loadTableUrl}')">
							<c:forEach begin="10" end="${orderResultTotal > 70 ? 70 : (orderResultTotal+10)}" step="10" var="nextPageSize" >
								<option value="${nextPageSize}" ${nextPageSize eq pageSize ? 'selected' : ''}>${nextPageSize} ${nextPageSize eq pageSize ? 'Items per Page' : ''}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<small class="search-results"> Showing ${pageStart} - ${pageEnd} of ${orderResultTotal} results. </small>
				<ul class="pager lfr-pagination-buttons">
					<li class="${pageCur > 1 ? '' : 'disabled'}  first">
						<c:choose>
							<c:when test="${pageCur > 1}">
								<a href="javascript:;" onclick="selectPage(1, ${pageCur}, ${pageSize}, '${loadTableUrl}')" target="_self"> First </a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" target="_self"> First </a>
							</c:otherwise>
						</c:choose>
					</li>
					<li class="${pageCur > 1 ? '' : 'disabled'}">
						<c:choose>
							<c:when test="${pageCur > 1}">
								<a href="javascript:;" onclick="selectPage(${pageCur-1}, ${pageCur}, ${pageSize}, '${loadTableUrl}')" target="_self"> Previous </a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" target="_self"> Previous </a>
							</c:otherwise>
						</c:choose>
					</li>
					<li class="${pageCur < pageTotal ? '' : 'disabled'}">
						<c:choose>
							<c:when test="${pageCur < pageTotal}">
								<a href="javascript:;" onclick="selectPage(${pageCur+1}, ${pageCur}, ${pageSize}, '${loadTableUrl}')" target="_self"> Next </a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" target="_self"> Next </a>
							</c:otherwise>
						</c:choose>
					</li>
					<li class="${pageCur < pageTotal ? '' : 'disabled'} last">
						<c:choose>
							<c:when test="${pageCur < pageTotal}">
								<a href="javascript:;" onclick="selectPage(${pageTotal}, ${pageCur}, ${pageSize}, '${loadTableUrl}')" target="_self"> Last </a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" target="_self"> Last </a>
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</div>
		</div>
	</div>
</c:if>