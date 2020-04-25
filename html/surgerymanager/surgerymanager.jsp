<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<!-- NOT USED YET -->

<!-- BASIC URLS -->
<c:set value="/html/surgerymanager/" var="surgerymanagerUrl" />
<c:set value="${surgerymanagerUrl}/appointments" var="appointmentUrl" />
<c:set value="${surgerymanagerUrl}/doctors" var="doctorsUrl" />
<c:set value="${surgerymanagerUrl}/drugreps" var="drugrepsUrl" />
<c:set value="${surgerymanagerUrl}/schedule" var="scheduleUrl" />

<!-- APPOINTMENTS PAGES URLS -->
<c:set value="${appointmentUrl}/history_actions.jsp" var="history_actionsUrl" />
<c:set value="${appointmentUrl}/history.jsp" var="historyUrl" />
<c:set value="${appointmentUrl}/myAppoiments_actions.jsp" var="myAppoiments_actionsUrl" />
<c:set value="${appointmentUrl}/myAppoiments.jsp" var="myAppoimentsUrl" />
<c:set value="${appointmentUrl}/reviewForm.jsp" var="reviewFormUrl" />

<!-- DOCTORS PAGES URLS -->
<c:set value="${doctorsUrl}/addDoctorView.jsp" var="addDoctorViewUrl" />
<c:set value="${doctorsUrl}/addForm.jsp" var="addFormUrl" />
<c:set value="${doctorsUrl}/allDoctorsActions.jsp" var="allDoctorsActionsUrl" />
<c:set value="${doctorsUrl}/doctorInfo.jsp" var="doctorInfoUrl" />
<c:set value="${doctorsUrl}/editDoctorInfo.jsp" var="editDoctorInfoUrl" />
<c:set value="${doctorsUrl}/myDoctors-Originals.jsp" var="myDoctors-OriginalsUrl" />
<c:set value="${doctorsUrl}/myDoctors.jsp" var="myDoctorsUrl" />
<c:set value="${doctorsUrl}/myDoctorsActions.jsp" var="myDoctorsActionsUrl" />

<!-- DRUGREPS PAGES URLS -->
<c:set value="${drugrepsUrl}/companyBlockForm.jsp" var="companyBlockFormUrl" />
<c:set value="${drugrepsUrl}/drugRepresentativeBlockForm.jsp" var="drugRepresentativeBlockFormUrl" />
<c:set value="${drugrepsUrl}/drugRepresentativeInfo.jsp" var="drugRepresentativeInfoUrl" />
<c:set value="${drugrepsUrl}/drugRepresentativeInviteForm.jsp" var="drugRepresentativeInviteFormUrl" />
<c:set value="${drugrepsUrl}/drugRepresentativeList_actions.jsp" var="drugRepresentativeList_actionsUrl" />
<c:set value="${drugrepsUrl}/drugRepresentativeList.jsp" var="drugRepresentativeListUrl" />

<!-- SCHEDULE PAGES URLS -->
<c:set value="${scheduleUrl}/addDoctorAppoimentHours_actions.jsp" var="addDoctorAppoimentHours_actionsUrl" />
<c:set value="${scheduleUrl}/addDoctorBlockOutDate_actions.jsp" var="addDoctorBlockOutDate_actionsUrl" />
<c:set value="${scheduleUrl}/myAppoimentBlockout_actions.jsp" var="myAppoimentBlockout_actionsUrl" />
<c:set value="${scheduleUrl}/myAppoimentSchedule_actions.jsp" var="myAppoimentSchedule_actionsUrl" />
<c:set value="${scheduleUrl}/myAppoimentSchedule.jsp" var="myAppoimentScheduleUrl" />