<%@page import="com.rxtro.core.model.DoctorModel"%>
<%@page import="com.rxtro.core.model.MedicalStaff"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>

<%@include file="/html/territorymanager/init.jsp" %>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="30" />
</liferay-util:include>

<h2>Appointment Info</h2>

<%
		Long appId = (Long)request.getAttribute("idAppoiment");
		Long surgeryId = (Long)request.getAttribute("idSurgery");
		SurgeryModel surgery = SurgeryUtil.buildFromOrgId(surgeryId);
		
		AppModel app = AppUtil.buildApp(appId);

		String googleMapQuery = surgery.getAddress().getStreet1()+","+surgery.getAddress().getCity()+","+surgery.getAddress().getRegion().getName()+","+surgery.getAddress().getCountry().getName();
%>

<table id="tabla">
	<tr>
	    <td width="425" >
	    	<img width="425" height="350" src="https://maps.googleapis.com/maps/api/staticmap?center=<%= googleMapQuery.replace( ' ','+' ) %>&zoom=13&size=425x350&scale=2&markers=<%= googleMapQuery.replace( ' ','+' ) %>&key=AIzaSyC3gH738mvF8q4i0SxgQ2dUlCN6tvdSNxw" />
<!-- 	    	<iframe  -->
<!-- 		    	width="425"  -->
<!-- 		    	height="350"  -->
<!-- 		    	frameborder="0"  -->
<!-- 		    	scrolling="no"  -->
<!-- 		    	marginheight="0"  -->
<!-- 		    	marginwidth="0" -->
<%-- 				src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=<%= googleMapQuery.replace( ' ','+' ) %>&amp;aq=&amp;sll=-35.277944,149.120586&amp;sspn=0.026066,0.055747&amp;gl=ar&amp;ie=UTF8&amp;hq=<%= googleMapQuery.replace( ' ','+' ) %>&amp;ll=-35.277927,149.120607&amp;spn=0.024524,0.036478&amp;z=14&amp;iwloc=A&amp;output=embed" --%>
<!-- 			> -->
<!-- 			</iframe> -->
<!-- 			<br /> -->
<!-- 			<small> -->
<!-- 				<a  -->
<%-- 					href="http://maps.google.com.ar/maps?f=q&amp;source=embed&amp;hl=es&amp;geocode=&amp;q=Australian+National+University,++Australian+Capital+Territory,+Australia&amp;aq=&amp;sll=-35.277944,149.120586&amp;sspn=0.026066,0.055747&amp;gl=ar&amp;ie=UTF8&amp;hq=<%= googleMapQuery.replace( ' ','+' ) %>&amp;ll=-35.277927,149.120607&amp;spn=0.024524,0.036478&amp;z=14&amp;iwloc=A"  --%>
<!-- 					style="color:#0000FF; text-align:left" -->
<!-- 					target="_blank" -->
<!-- 				> -->
<!-- 					see big -->
<!-- 				</a> -->
<!-- 			</small> -->
		</td>
		
		<td style="padding: 20px">
			<h4>Clinic Confirmation Information</h4>
			<%= surgery.getComments() %><br>
			<h4>Place:</h4>
			Surgery: <%= surgery.getName() %><br>
			Address: <%= surgery.getAddress().getStreet1()  %>, <%= surgery.getAddress().getCity()  %>, <%= surgery.getAddress().getRegion().getName()  %><br>
			Phone: <%= surgery.getPhone() %><br>
			<h4>Participants</h4>
			<ul>
			<%
				for (MedicalStaff doctor : app.getAttendants()) {
					DoctorModel dm = ((DoctorModel) doctor);
					if ( dm.getDietInfo() != null && !dm.getDietInfo().trim().isEmpty()) {
					%>
						<li><%= dm.getFullName() %> (Diet Information: <%= dm.getDietInfo() %>)</li>
					<%
					} else {
					%>
						<li><%= dm.getFullName() %></li>
					<%
					}
				}
			%>
			</ul>
		</td>
	</tr>
</table>