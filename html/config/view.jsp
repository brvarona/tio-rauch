<%@ page import="com.segmax.drugrep.model.Config" %>
<%@ page import="com.segmax.drugrep.service.ConfigLocalServiceUtil" %>

<%@ page import="java.util.List" %>

<%@ include file="/html/config/init.jsp" %>

<liferay-portlet:actionURL name="save" var="saveURL" />

<table>
	<thead>
		<tr>
			<td>Id</td>
			<td>Key</td>
			<td>Value</td>
			<td>Action</td>
		</tr>
	</thead>
	<tbody>

		<%
			List<Config> configValueList = ConfigLocalServiceUtil.getConfigs(0, ConfigLocalServiceUtil.getConfigsCount());
			request.setAttribute("configValueList", configValueList);
		%>

		<c:forEach items="${configValueList}" var="item">
			<aui:form action="<%= saveURL.toString() %>" method="post" name="saveItem${item.configId}">
				<tr>
					<td>${item.configId}<aui:input name="configId" type="hidden" value="${item.configId}" /></td>
					<td><aui:input label="" name="key" value="${item.key}" /></td>
					<td><aui:input label="" name="value" value="${item.value}" /></td>
					<liferay-portlet:actionURL name="delete" var="deleteURL">
						<portlet:param name="configId" value="${item.configId}"></portlet:param>
					</liferay-portlet:actionURL>
					<td><aui:button inlineField="true" name="Save" type="submit" /><a href="<%= deleteURL.toString() %>">Delete</a></td>
				</tr>
			</aui:form>
		</c:forEach>
		<aui:form action="<%= saveURL.toString() %>" method="post" name="saveItem0">
			<tr>
				<td>New<aui:input name="configId" type="hidden" value="0" /></td>
				<td><aui:input label="" name="key" value="" /></td>
				<td><aui:input label="" name="value" value="" /></td>
				<td><aui:button name="Save" type="submit" /></td>
			</tr>
		</aui:form>
	</tbody>
</table>