<%@ page import="com.segmax.drugrep.model.Doctor" %>
<%@ page import="com.segmax.drugrep.model.Surgery" %>
<%@ page import="com.segmax.drugrep.service.DoctorLocalServiceUtil" %>

<%@ page import="java.util.List" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%
	Doctor unDoctor = (Doctor)request.getAttribute("unDoctor");
	List<Surgery> dws = DoctorLocalServiceUtil.getSurgeries(unDoctor.getId_doctor());
	String glutenFree = unDoctor.getGluten_free() ? "Yes" : "No";
%>
<div class="modal-body">
<b>First Name: </b><%= unDoctor.getName() %><br>
<b>Middle Name: </b><%= unDoctor.getMiddle_name() %><br>
<b>Last Name: </b><%= unDoctor.getSurname() %><br>
<b>Prefered Name: </b><%= unDoctor.getPrefered_name() %><br>
<b>CDP: </b><%= unDoctor.getCPD_number() %><br>
<b>Gender: </b><%= unDoctor.getGender() %><br>
<b>Diet Information: </b><%= unDoctor.getDiet_data() %><br>
<b>Gluten Free: </b><%=glutenFree %><br/>

<h3>Work on: </h3>

<%
	for (int i = 0;i<dws.size();i++) {
		%>

			<b>Surgery: </b><%= dws.get(i).getName() %><br>

		<%
	}
%>

</div>