<%@ include file="/html/visitormanager/init.jsp" %>

<%


String compTerm = (String) request.getAttribute("compTerm");
if (compTerm == null) {
	compTerm = "";
}
//prodItURL.setParameter("compTerm", compTerm);

String productTerm = (String) request.getAttribute("productTerm");
if (productTerm == null) {
	productTerm = "";
}
//prodItURL.setParameter("productTerm", productTerm);

String orgId = (String) request.getAttribute("orgId");
if (orgId == null) {
	orgId = "";
}
//prodItURL.setParameter("orgId", orgId);

%>
<liferay-portlet:resourceURL id="nextProductsResult" varImpl="nextProductsResultUrl">
	<portlet:param name="compTerm" value="<%= compTerm %>" />
	<portlet:param name="productTerm" value="<%= productTerm %>" />
	<portlet:param name="orgId" value="<%= orgId %>" />
</liferay-portlet:resourceURL>

<table class="table table-bordered table-hover table-striped">
	<thead class="table-columns">
		<tr>
			<th class="table-first-header">Product</th>
			<th>Company & Team</th>
			<th>Status</th>
			<th class="table-last-header"></th>
		</tr>
	</thead>
	<tbody class="table-data">
		<c:forEach items="${productResult}" var="result">
			<tr>
				<td class="table-cell">${result.itemName}</td>
				<td class="table-cell">${result.companyName} / ${result.teamName}</td>
				<td class="table-cell">${result.status}</td>
				<td class="table-cell last"></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="taglib-search-iterator-page-iterator-bottom">
	<div class="taglib-page-iterator">
		<div class="clearfix lfr-pagination">
			<div class="lfr-pagination-config">
				<div class="lfr-pagination-page-selector">
					<div class="btn-group lfr-icon-menu current-page-menu">
						<a class="dropdown-toggle direction-down max-display-items-15 btn" href="javascript:;" title="Page 1 of 5">
							<span class="lfr-icon-menu-text">Page 1 of 5</span>
							<i class="caret"></i>
						</a>
						<ul class="dropdown-menu lfr-menu-list direction-down">
							<li class="" role="presentation">
								<a href="" target="_self" class=" taglib-icon" role="menuitem">
									<span class="taglib-text-icon">1</span>
								</a>
							</li>
							<li class="" role="presentation">
								<a href="" class=" taglib-icon" role="menuitem">
									<span class="taglib-text-icon">2</span>
								</a>
							</li>
						</ul>
					</div>
				</div>

				<div class="lfr-pagination-delta-selector">
					<div class="btn-group lfr-icon-menu">
						<a class="dropdown-toggle direction-down max-display-items-15 btn" href="javascript:;" title="10 Items per Page">
							<span class="lfr-icon-menu-text">10 Items per Page</span>
							<i class="caret">
							</i>
						</a>
						<ul class="dropdown-menu lfr-menu-list direction-down">
							<li class="" role="presentation">
								<a href="" class=" taglib-icon" role="menuitem">
									<span class="taglib-text-icon">5</span>
								</a>
							</li>
							<li class="" role="presentation">
								<a href="" class=" taglib-icon" role="menuitem">
									<span class="taglib-text-icon">10</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<small class="search-results"> Showing 1 - 10 of 50 results. </small>
		
			<ul class="pager lfr-pagination-buttons">
				<li class="disabled first">
					<a href="javascript:;" target="_self"> First </a>
				</li>
				<li class="disabled">
					<a href="javascript:;" target="_self"> Previous </a>
				</li> <li class="">
					<a href="" target="_self"> Next </a>
				</li>
				<li class=" last">
					<a href="" target="_self"> Last </a>
				</li>
			</ul>
		</div>
	</div>
</div>

