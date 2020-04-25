<%@ include file="/html/findrepresentatives/init.jsp" %>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.liferay.portal.kernel.util.HtmlUtil"%>


<%
ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
DrugRepModel drugRep = (DrugRepModel) row.getObject();
%>

<c:set var="drugRep" value="<%=drugRep %>" />

<div class="profile-box" id="profile${drugRep.id}" >
	<div class="profile-row profile-tooltip" onclick="openMyAccount()" >
		<div class="profile-col col-sm-4 first">
			<c:set var="drugRepUser" value="${drugRep.user}"/>
    		<img alt="<%=HtmlUtil.escape(((User) pageContext.getAttribute("drugRepUser")).getFullName()) %>" class="user-logo" src="<%= ((User) pageContext.getAttribute("drugRepUser")).getPortraitURL(themeDisplay) %>" />
    	</div>
		<div class="profile-col col-sm-4">
			<span class="labeled">Name: </span>${drugRep.fullName}
			<br />
			<span class="labeled">Email: </span>${drugRep.email}
			<br />
			<span class="labeled">Job Title: </span>${drugRep.jobTitle}
			<br />
			<span class="labeled">Phone: </span>${drugRep.phone}
		</div>
		<div class="profile-col col-sm-4">
			<span class="labeled">Company - Team: </span>${drugRep.team.companyModel.name} - ${drugRep.team.name}
			<br />
			<span class="labeled">First Line Product: </span>${drugRep.firstLineProducts}
			<br />
			<span class="labeled">Second Line Products: </span>${drugRep.secondLineProducts}
			<br />
			<span class="labeled">Third Line Products: </span>${drugRep.thirdLineProducts}
		</div>
	</div>
</div>