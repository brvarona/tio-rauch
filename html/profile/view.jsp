<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.liferay.portal.kernel.util.HtmlUtil"%>
<%@include file="/html/profile/init.jsp" %>

<%
DrugRepModel drugRep = DrugRepUtil.buildByUserId(themeDisplay.getUserId());
%>

<style>
.container4 .row4 {
	overflow: hidden;
	width: 100%;
}

.container4 .row4 .first {
	max-width: 120px;
}

.container4 .row4 .column4 {
	padding: 10px;
	position: relative;
}

.container4 .row4 .column4 .labeled {
	font-weight: bold;
}

.container4 .row4:hover {
	opacity: 0.5;
    filter: alpha(opacity=50); /* For IE8 and earlier */
    background-color: #eee;
    cursor: pointer;
}

.tooltip4 {
    position: relative;
    border-bottom: 1px dotted black;
}

.tooltip4 .tooltiptext4 {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    /* Position the tooltip */
    position: absolute;
    z-index: 1;
    top: 40px;
    left: 45%;
}

.tooltip4:hover .tooltiptext4 {
    visibility: visible;
}

.rotuled {
	color: rgb(40, 142, 204);
}
</style>

<div class="container4" >

<%if (drugRep != null) { %>
	<div class="row4 tooltip4" onclick="openMyAccount()" >
		<div class="column4 col-sm-4 first">
    		<img alt="<%=HtmlUtil.escape(user.getFullName()) %>" class="user-logo" src="<%= user.getPortraitURL(themeDisplay) %>" />
    	</div>
		<div class="column4 col-sm-4">
			<span class="labeled">Name: </span><%=drugRep.getFullName() %>
			<br />
			<span class="labeled">Email: </span><%=drugRep.getEmail() %>
			<br />
			<span class="labeled">Job Title: </span><%=drugRep.getJobTitle() %>
			<br />
			<span class="labeled">Phone: </span><%=drugRep.getPhone() %>
			<% if (drugRep.getTeam().isPremium()) { %>
				<br />
				<span class="labeled rotuled">RxTro Pro</span>
			<%} %>
		</div>
		<div class="column4 col-sm-4">
			<span class="labeled">Company - Team: </span><%=drugRep.getTeam().getCompany().getName() %> - <%=drugRep.getTeam().getName() %>
			<br />
			<%
			String managerName = "";
			if (drugRep.getManager() != null) {
				managerName = drugRep.getManager().getFullName();
			}
			%>
			<span class="labeled">Manager: </span><%=managerName %>
			<br />
			<span class="labeled">First Line Product: </span><%=drugRep.getFirstLineProducts() %>
			<br />
			<span class="labeled">Second Line Products: </span><%=drugRep.getSecondLineProducts() %>
			<br />
			<span class="labeled">Third Line Products: </span><%=drugRep.getThirdLineProducts() %>
		</div>
		<span class="tooltiptext4">Click to edit</span>
	</div>

	<script type="text/javascript">
	/* function for open modal popup onclick of myaccount */
	function openMyAccount() {
		var myAcc_url = '<%=themeDisplay.getURLMyAccount() %>';
		var popUpWindow = Liferay.Util.openWindow({
			dialog: {
				align: Liferay.Util.Window.ALIGN_CENTER,
				cache: false,
				width: 1200, // width of modal popup
				modal: true
			},
			title: "My Account", // anything you want to give 
			id: "myAccountPopUpID", //modal id
			uri: myAcc_url
		});
	}
	
	</script>

<%} else { %>
	<div>No Profile</div>

<%} %>

</div>
