<%@page import="com.rxtro.core.util.CfgProcessor"%>
<%@page import="com.liferay.portal.service.OrganizationLocalServiceUtil"%>
<%@page import="com.liferay.portal.model.Organization"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ include file="/html/companypreferences/init.jsp" %>

<h3>Company Selector</h3>
<p>Please, uncheck those organizations you are not interested to get visited by. Clicking on each name you drill down the hierarchy.</p>
<c:if test="${not empty companiesNoUpdated}">
        <div class="portlet-msg-error">
            The next companies were not updated because pending appointments: 
            <c:forEach items="${companiesNoUpdated}" var="message" varStatus="status">
            ${message},
            </c:forEach>
        </div>
</c:if>

<% 
Organization org = OrganizationLocalServiceUtil.getOrganization(CfgProcessor.getRepresentativesOrgId());
SurgeryModel currentSurgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());
%>
<script>
var myCompaniesInWishList = new Array();
</script>
<%
for (String compId : currentSurgery.getCompaniesIdsInWishList()) {
	%>
	<script>
		myCompaniesInWishList.push('<%=compId %>');
	</script>
	<%
}

%>
<c:set var="organizations" value="<%=org.getSuborganizations() %>" />
<c:set var="myCompaniesInWishList" value="<%=currentSurgery.getCompaniesIdsInWishList() %>" />

<portlet:actionURL name="saveCompanySelected" var="saveCompanySelectedURL" />

<form method="post" action="<%=saveCompanySelectedURL.toString() %>" name="compSelFm" id="compSelFm">
	<div class="selectorList">
		<ul style="background-color: white; color: black">
			<c:forEach items="${organizations}" var="org1" varStatus="status1">
				<li style="border-left: 1px solid white">
					<input type="checkbox" name="<portlet:namespace/>${org1.organizationId}" id="org_${org1.organizationId}" /> 
					<c:if test="${not empty org1.suborganizations}">
						<span class="accordion" title="Show more" >${org1.name}</span>
					</c:if>
					<c:if test="${empty org1.suborganizations}">
						<span>${org1.name}</span>
					</c:if>
					<c:if test="${not empty org1.suborganizations}">
						<ul class="panel">
							<c:forEach items="${org1.suborganizations}" var="org2" varStatus="status2">
								<li style="border-left: 1px solid white">
									<input type="checkbox" name="<portlet:namespace/>${org2.organizationId}" id="org_${org2.organizationId}" /> 
									<c:if test="${not empty org2.suborganizations}">
										<span class="accordion" title="Show more" >${org2.name}</span>
									</c:if>
									<c:if test="${empty org2.suborganizations}">
										<span>${org2.name}</span>
									</c:if>
									<c:if test="${not empty org2.suborganizations}">
										<ul class="panel">
											<c:forEach items="${org2.suborganizations}" var="org3" varStatus="status3">
												<li style="border-left: 1px solid white">
													<input type="checkbox" name="<portlet:namespace/>${org3.organizationId}" id="org_${org3.organizationId}" /> ${org3.name}
												</li>
											</c:forEach>
										</ul>
									</c:if>
								</li>
							</c:forEach>
						</ul>
					</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
	<button class="btn btn-default" type="submit">Save</button>
</form>

<style>
/* Style the buttons that are used to open and close the accordion panel */
.selectorList li {
	list-style-type: none;
	list-style: none;
}

.selectorList .accordion {
/*     background-color: #eee; */
    color: #444;
    cursor: pointer;
/*     padding: 18px; */
    width: 100%;
    text-align: left;
    border: none;
    outline: none;
    transition: 0.4s;
}

/* Add a background color to the button if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
.selectorList .accordion.active, .selectorList .accordion:hover {
    background-color: #ddd;
}

/* Style the accordion panel. Note: hidden by default */
.selectorList .panel {
    padding: 0 18px;
    background-color: white;
    display: none;
}
</style>

<script>

$('input[type="checkbox"]').change(function(e) {

	  var checked = $(this).prop("checked"),
	      container = $(this).parent(),
	      siblings = container.siblings();

	  container.find('input[type="checkbox"]').prop({
	    indeterminate: false,
	    checked: checked
	  });

	  function checkSiblings(el) {

	    var parent = el.parent().parent(),
	        all = true;

	    el.siblings().each(function() {
	      return all = ($(this).children('input[type="checkbox"]').prop("checked") === checked);
	    });

	    if (all && checked) {

	      parent.children('input[type="checkbox"]').prop({
	        indeterminate: false,
	        checked: checked
	      });

	      checkSiblings(parent);

	    } else if (all && !checked) {

	      parent.children('input[type="checkbox"]').prop("checked", checked);
	      parent.children('input[type="checkbox"]').prop("indeterminate", (parent.find('input[type="checkbox"]:checked').length > 0));
	      checkSiblings(parent);

	    } else {

	      el.parents("li").children('input[type="checkbox"]').prop({
	        indeterminate: true,
	        checked: false
	      });

	    }

	  }

	  checkSiblings(container);
});

console.log('WISH LIST='+myCompaniesInWishList.length);
for (i = 0; i < myCompaniesInWishList.length; i++) {
	console.log('{} '+myCompaniesInWishList[i]);
	document.getElementById('org_'+myCompaniesInWishList[i]).click();
}

var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        /* Toggle between adding and removing the "active" class,
        to highlight the button that controls the panel */
        this.classList.toggle("active");

        /* Toggle between hiding and showing the active panel */
        var panel = this.nextElementSibling;
        if (panel) {
	        if (panel.style.display === "block") {
	            panel.style.display = "none";
	        } else {
	            panel.style.display = "block";
	        }
        }
    }
}
</script>

