<%@ include file="/html/visitormanager/init.jsp" %>

<div class="drugRepInfo">
	<img src="<%= themeDisplay.getPathImage() %>/user_portrait?img_id=${imageId}">

	<ul>
		<li>
			<span class="label">Email: </span><a href="mailto:${email}">${email}</a>
		</li>
		<li>
			<span class="label">Company: </span>${companyName}
		</li>
		<c:if test="${not empty firstLineProducts}">
			<li>
				<span class="label">First Line Products: </span>${firstLineProducts}
			</li>
		</c:if>
		<c:if test="${not empty otherProducts}">
			<li>
				<span class="label">Second Line Products: </span>${otherProducts}
			</li>
		</c:if>
		<c:if test="${not empty thirdLineProducts}">
			<li>
				<span class="label">Third Line Products: </span>${thirdLineProducts}
			</li>
		</c:if>
		<c:forEach items="${phoneList}" var="phone" varStatus="status">
			<li>
				<c:if test="${phone.isPrimary()}">
					<span class="label">Company Mobile Phone: </span>${phone.getNumber()}
				</c:if>
				<c:if test="${not phone.isPrimary()}">
					<span class="label">Phone: </span>${phone.getNumber()}
				</c:if>
			</li>
		</c:forEach>
		<c:if test="${not empty headOfficeNumber}">
			<li>
				<span class="label">Head Office Number: </span>${headOfficeNumber}
			</li>
		</c:if>
	</ul>
</div>