<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${resultTotal > 10}">

	<c:set var="baseUrl" value="${param.baseUrl}"  />
	
	<c:if test="${empty pageCur}">
		<c:set var="pageCur" value="1" />
	</c:if>
	<c:if test="${empty pageSize}">
		<c:set var="pageSize" value="10" />
	</c:if>
	
	<fmt:formatNumber var="pageTotal" type="number" value="${((resultTotal - 1) - (resultTotal - 1) % pageSize) / pageSize + 1}" 
		minFractionDigits="0" maxFractionDigits="0"/>
	
	<c:set var="pageStart" value="${(pageCur * pageSize) - pageSize + 1}" />
	<c:set var="pageEnd" value="${resultTotal < (pageCur * pageSize) ? resultTotal : (pageCur * pageSize)}" />
	
	<a href="javascript:;" class="hidden" id="reloadPaginator${param.boxId}" onclick="reloadPage(${pageCur}, ${pageSize}, '${baseUrl}', '${param.boxId}')" target="_self"> Reload </a>
	
	<div class="taglib-search-iterator-page-iterator-bottom">
		<div class="taglib-page-iterator">
 			<div class="clearfix lfr-pagination">
				<div class="lfr-pagination-config">
					<div class="lfr-pagination-page-selector">
						<select onchange="selectPage(this.value, ${pageCur}, ${pageSize}, '${baseUrl}', '${param.boxId}')">
							<c:forEach begin="1" end="${pageTotal}" var="nextPage" >
								<option value="${nextPage}" ${nextPage eq pageCur ? 'selected' : ''}>Page ${nextPage} ${nextPage eq pageCur ? 'of' : ''} ${nextPage eq pageCur ? pageTotal : ''}</option>	
							</c:forEach>
						</select>
					</div>
					<div class="lfr-pagination-delta-selector">
						<select onchange="selectPageSize(this.value, ${pageSize}, '${baseUrl}', '${param.boxId}')">
							<c:forEach begin="10" end="${resultTotal > 70 ? 70 : (resultTotal+10)}" step="10" var="nextPageSize" >
								<option value="${nextPageSize}" ${nextPageSize eq pageSize ? 'selected' : ''}>${nextPageSize} ${nextPageSize eq pageSize ? 'Items per Page' : ''}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<small class="search-results"> Showing ${pageStart} - ${pageEnd} of ${resultTotal} results. </small>
				<ul class="pager lfr-pagination-buttons">
					<li class="${pageCur > 1 ? '' : 'disabled'}  first">
						<c:choose>
							<c:when test="${pageCur > 1}">
								<a href="javascript:;" onclick="selectPage(1, ${pageCur}, ${pageSize}, '${baseUrl}', '${param.boxId}')" target="_self"> First </a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" target="_self"> First </a>
							</c:otherwise>
						</c:choose>
					</li>
					<li class="${pageCur > 1 ? '' : 'disabled'}">
						<c:choose>
							<c:when test="${pageCur > 1}">
								<a href="javascript:;" onclick="selectPage(${pageCur-1}, ${pageCur}, ${pageSize}, '${baseUrl}', '${param.boxId}')" target="_self"> Previous </a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" target="_self"> Previous </a>
							</c:otherwise>
						</c:choose>
					</li>
					<li class="${pageCur < pageTotal ? '' : 'disabled'}">
						<c:choose>
							<c:when test="${pageCur < pageTotal}">
								<a href="javascript:;" onclick="selectPage(${pageCur+1}, ${pageCur}, ${pageSize}, '${baseUrl}', '${param.boxId}')" target="_self"> Next </a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" target="_self"> Next </a>
							</c:otherwise>
						</c:choose>
					</li>
					<li class="${pageCur < pageTotal ? '' : 'disabled'} last">
						<c:choose>
							<c:when test="${pageCur < pageTotal}">
								<a href="javascript:;" onclick="selectPage(${pageTotal}, ${pageCur}, ${pageSize}, '${baseUrl}', '${param.boxId}')" target="_self"> Last </a>
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
