<%@include file="/html/adminpanel/init.jsp" %>

<liferay-util:include page="/html/adminpanel/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="60" />
</liferay-util:include>

<portlet:actionURL name="updateGlobalIds" var="updateGlobalIdsURL" />
<form action="<%=updateGlobalIdsURL.toString() %>" method="post" name="updateGlobalIdsFm" id="updateGlobalIdsFm">
	<button class="btn btn-info">Update GlobalIds</button>
</form>

<br />

<portlet:actionURL name="updateDefaultValuesOfSchedules" var="updateDefaultValuesOfSchedulesURL" />
<form action="<%=updateDefaultValuesOfSchedulesURL.toString() %>" method="post" name="updateDefaultValuesOfSchedulesFm" id="updateDefaultValuesOfSchedulesFm">
	<button class="btn btn-info">Update Visitors</button>
</form>

<portlet:actionURL name="updateNotifications" var="updateNotificationsURL" />
<form action="<%=updateNotificationsURL.toString() %>" method="post" name="updateNotificationsFm" id="updateNotificationsFm">
	<button class="btn btn-info">Update Notifications</button>
</form>

<portlet:actionURL name="addAppIds" var="addAppIdsURL" />
<form action="<%=addAppIdsURL.toString() %>" method="post" name="addAppIdsFm" id="addAppIdsFm">
	<button class="btn btn-info">Add Cancelled App Ids</button>
</form>

<portlet:actionURL name="addSpecialty" var="addSpecialtyURL" />
<form action="<%=addSpecialtyURL.toString() %>" method="post" name="addSpecialtyFm" id="addSpecialtyFm">
	<input type="text" name="<portlet:namespace />spName" value="" placeholder="Spcialty Name" />
	<button class="btn btn-info">Add Specialty</button>
</form>

<portlet:actionURL name="addSchedulesIds" var="addSchedulesIdsURL" />
<form action="<%=addSchedulesIdsURL.toString() %>" method="post" name="addSchedulesIdsFm" id="addSchedulesIdsFm">
	<button class="btn btn-info">Add Schedules Ids</button>
</form>

<portlet:actionURL name="addSpecialtyOrganizations" var="addSpecialtyOrganizationsURL" />
<form action="<%=addSpecialtyOrganizationsURL.toString() %>" method="post" name="addSpecialtyOrganizationsFm" id="addSpecialtyOrganizationsFm">
	<button class="btn btn-info">Add Specialty Organizations</button>
</form>

<portlet:actionURL name="addOtherOrganizations" var="addOtherOrganizationsURL" />
<form action="<%=addOtherOrganizationsURL.toString() %>" method="post" name="addOtherOrganizationsFm" id="addOtherOrganizationsFm">
	<button class="btn btn-info">Add Other Organizations</button>
</form>

<portlet:actionURL name="addSpecialtyOrganizations_Schedule" var="addSpecialtyOrganizationsScheduleURL" />
<form action="<%=addSpecialtyOrganizationsScheduleURL.toString() %>" method="post" name="addSpecialtyOrganizationsScheduleFm" id="addSpecialtyOrganizationsScheduleFm">
	<button class="btn btn-info">Add Specialty Organizations to Schedules</button>
</form>

<portlet:actionURL name="run_GetRecentReviews" var="run_GetRecentReviewsURL" />
<form action="<%= run_GetRecentReviewsURL %>" method="post" name="run_GetRecentReviewsFm" id="run_GetRecentReviewsFm">
	<button class="btn btn-info">Run process to get recent apps reviews</button>
</form>

<portlet:actionURL name="setFeaturedStatesManagerDefault" var="setFeaturedStatesManagerDefaultURL" />
<form action="<%=setFeaturedStatesManagerDefaultURL.toString() %>" method="post" name="setFeaturedStatesManagerDefaultFm" id="setFeaturedStatesManagerDefaultFm">
	<button class="btn btn-info">Set Default Featured States to Managers</button>
</form>

<form action="javascript:;" >
	<portlet:resourceURL var="companyReportURL">
		<portlet:param name="resourceName" value="COMPANY_REPORT"></portlet:param>
	</portlet:resourceURL>
	<a href="<%= companyReportURL.toString() %>">Company Report</a>
</form>

<form action="javascript:;" >
	<portlet:resourceURL var="dropInMigrationURL">
		<portlet:param name="resourceName" value="DROPIN_MIGRATION"></portlet:param>
	</portlet:resourceURL>
	<a href="<%= dropInMigrationURL.toString() %>">DNSR / Drop In Migration</a>
</form>

<portlet:actionURL name="updateCompaniesForDropInAndDNSRSurgeries" var="updateCompaniesForDropInAndDNSRSurgeriesURL" />
<form action="<%=updateCompaniesForDropInAndDNSRSurgeriesURL.toString() %>" method="post" name="updateCompaniesForDropInAndDNSRSurgeriesFm" id="updateCompaniesForDropInAndDNSRSurgeriesFm">
	<button class="btn btn-info">Update Companies for Drop In / DNSR Clinics</button>
</form>

<portlet:actionURL name="updateCompaniesForContactPracticeSurgeries" var="updateCompaniesForContactPracticeSurgeriesURL" />
<form action="<%=updateCompaniesForContactPracticeSurgeriesURL.toString() %>" method="post" name="updateCompaniesForContactPracticeSurgeriesFm" id="updateCompaniesForContactPracticeSurgeriesFm">
	<button class="btn btn-info">Update Companies for Contact Practice Clinics</button>
</form>




