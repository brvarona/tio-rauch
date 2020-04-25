<%@include file="/html/territorymanager/init.jsp" %>

<h3>Products Update</h3>

<liferay-ui:error key="" message="" />

<liferay-ui:error key="system-error" message="system-error" />

<portlet:actionURL name="selectProducts" var="selectProductsURL" />

<!-- <select id="companiesSelect" onchange="changeCompanyView(this)"> -->
<%-- <c:forEach items="${drcompanies}" var="compa"> --%>
<%-- <c:if test="${currentCompanyId eq comp.companyId}"> --%>
<%-- <option value="${compa.companyId}">${compa.code}</option> --%>
<%-- </c:if> --%>
<%-- </c:forEach> --%>
<!-- </select> -->

<aui:form action="<%= selectProductsURL.toString() %>" method="post" name="fmProduct" onSubmit="">
	<aui:fieldset>
		<c:set value="false" var="isProductSection" />
		<c:forEach items="${drcompanies}" var="comp">
			<c:if test="${currentCompanyId eq comp.companyId}">
				<section class="productSelector" id="comp_${comp.companyId}" style="display: none">
					<div>
						<aui:select id="leftValues${comp.companyId}" label="Choose" multiple="true" name="availableProducts" size="10">
							<c:forEach items="${comp.imsProducts}" var="imsProducts" varStatus="status">
								<optgroup id="G${status.index}${comp.companyId}_S1" label="${imsProducts.code}">
									<c:forEach items="${imsProducts.products}" var="product">
										<aui:option title="G${status.index}${comp.companyId}" value="${product.productId}">${product.code}</aui:option>
									</c:forEach>
								</optgroup>
							</c:forEach>
						</aui:select>
					</div>
					<div class="selector">
						<input id="btnRight" onclick="selectToRight(${comp.companyId})" type="button" value="&gt;&gt;" />
						<input id="btnLeft" onclick="selectToLeft(${comp.companyId})" type="button" value="&lt;&lt;" />
					</div>
					<div>
						<aui:select id="rightValues${comp.companyId}" label="Selected" multiple="true" name="products" size="10">
							<c:forEach items="${comp.imsProducts}" var="imsProducts" varStatus="status">
								<optgroup id="G${status.index}${comp.companyId}_S2" label="${imsProducts.code}">
								</optgroup>
							</c:forEach>
						</aui:select>
					</div>
				</section>
				<c:set value="true" var="isProductSection" />
			</c:if>
		</c:forEach>

		<c:if test="${isProductSection}">
			<aui:button-row>
				<aui:button type="submit" value="Submit"  />
			</aui:button-row>
		</c:if>
	</aui:fieldset>
</aui:form>

<c:if test="${not isProductSection}">
	No products for your company
</c:if>

<script>
	changeCompanyView(document.getElementById('companiesSelect'));
</script>