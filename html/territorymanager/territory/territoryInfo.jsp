<%@ page import="com.liferay.portal.model.User" %>
<%@ page import="com.liferay.portal.service.UserLocalServiceUtil" %>

<%@include file="/html/territorymanager/init.jsp" %>

<!-- MENU -->
<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<portlet:renderURL var="viewMyTerritoryURL">
	<portlet:param name="jspPage" value="/html/territorymanager/territory/drugRepTerritory.jsp" />
</portlet:renderURL>
<a href="<%= viewMyTerritoryURL.toString() %>" id="menuSelectedA">Back</a>

<table id="tabla">
	<tr>
	    <td>
	    	<iframe 
		    	width="425" 
		    	height="350" 
		    	frameborder="0" 
		    	scrolling="no" 
		    	marginheight="0" 
		    	marginwidth="0"
				src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=${googleMapQuery}&amp;aq=&amp;sll=-35.277944,149.120586&amp;sspn=0.026066,0.055747&amp;gl=ar&amp;ie=UTF8&amp;hq=${googleMapQuery}&amp;ll=-35.277927,149.120607&amp;spn=0.024524,0.036478&amp;z=14&amp;iwloc=A&amp;output=embed"
			>
			</iframe>
		</td>
		<td style="padding: 20px">
			<h4>Clinic Confirmation Information</h4>
			<p>
				${surgeryComments}
			</p>
			<h4>Place:</h4>
			<p>
				Surgery: ${surgeryName}
				<br>
				Address: ${surgeryAddress}
				<br>
				Phone: ${surgeryPhone}
			</p>
			<h4>Participants</h4>
			<ul>
				<c:forEach items="${doctors}" var="d">
					<li>
						<c:if test="${not empty d.dietInfo}">
							${d.fullName} (Diet Information: ${d.dietInfo})
						</c:if>
						<c:if test="${empty d.dietInfo}">
							${d.fullName}
						</c:if>
					</li>
				</c:forEach>
			</ul>
		</td>
	</tr>
</table>

