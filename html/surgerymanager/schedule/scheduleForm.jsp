<%@ include file="/html/surgerymanager/init.jsp" %>
<%@page import="com.rxtro.core.util.enums.DayOfWeek"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>

<style>

.scheduleForm {
	border: 1px solid #ddd;
}

.scheduleForm input[type=text]{
	height: 30px;
    line-height: 30px;
}

/* Create three equal columns that floats next to each other */
.formColumn {
    float: left;
    width: 25%;
    padding: 10px;
    box-sizing: border-box;
}

/* Clear floats after the columns */
.formRow:after {
    content: "";
    display: table;
    clear: both;
}

/* Responsive layout - makes the three columns stack on top of each other instead of next to each other */
@media (max-width: 600px) {
    .formColumn {
        width: 100%;
    }
}
</style>

<portlet:actionURL name="addAppointmentHour" var="addAppHourURL"/>
<form action="<%=addAppHourURL.toString() %>" class="scheduleForm" id="scheduleFm" name="scheduleFm" method="post">
	<aui:input name="surgeryId" value="${surgeryId}" type="hidden" inlineField="true"></aui:input>
	<div class="formRow">
		<div class="formColumn">
			<label>With</label>
			<select id="withSelect" name="<portlet:namespace/>with" onchange="onChangeWith(this)">
				<option selected value="1">Clinic</option>
				<option value="2">Individual</option>
			</select>
		</div>
		<div class="formColumn">
			<label>Attendants</label>
			<select id="attendantsSelected" name="<portlet:namespace/>attendants" multiple="multiple">
				<c:forEach items="${individuals}" var="individual">
					<option selected value="${individual.id}" class="${individual.individualAttendant ? 'isindividual' : ''}" >${individual.fullName}</option>
				</c:forEach>
			</select>
		</div>
		<div class="formColumn">
			<label>Visitor</label>
			<select id="visitorSelect" name="<portlet:namespace/>visitor" multiple="multiple">
				<c:forEach items="${visitors}" var="visitor">
					<option selected value="${visitor.organizationId}">${visitor.name}</option>
				</c:forEach>
			</select>
		</div>
		<div class="formColumn"></div>
	</div>
	<div class="formRow">
		<div class="formColumn">
			<label>Frequency</label>
			<select id="frecuencySelect" name="<portlet:namespace/>frecuency" onchange="onChangeFrecuency(this)">
				<option selected value="1">Weekly</option>
				<option value="2">Monthly</option>
			</select>
		</div>
		<div class="formColumn">
			<label>Recurrence</label>
			<select id="recurrenceSelect" name="<portlet:namespace/>recurrence">
				<option selected value="1">Every week</option>
				<option value="2">Every two weeks</option>
				<option value="3">Every three weeks</option>
				<option value="4">Every four weeks</option>
			</select>
		</div>
		<div class="formColumn">
			<label>Day</label>
			<select id="daySelect" name="<portlet:namespace/>day" >
				<option selected value="<%=DayOfWeek.MONDAY.getId() %>"><%=DayOfWeek.MONDAY.getLabel() %></option>
				<option value="<%=DayOfWeek.TUESDAY.getId() %>"><%=DayOfWeek.TUESDAY.getLabel() %></option>
				<option value="<%=DayOfWeek.WEDNESDAY.getId() %>"><%=DayOfWeek.WEDNESDAY.getLabel() %></option>
				<option value="<%=DayOfWeek.THURSDAY.getId() %>"><%=DayOfWeek.THURSDAY.getLabel() %></option>
				<option value="<%=DayOfWeek.FRIDAY.getId() %>"><%=DayOfWeek.FRIDAY.getLabel() %></option>
			</select>
		</div>
		<div class="formColumn">
			<label>Hour</label>
			<input class="input-medium" id="hour" name="<portlet:namespace/>hour" type="text" placeholder="hh:mm" value="06:00" />
		</div>
	</div>
	<div class="formRow">
		<div class="formColumn">
			<label>Start</label>
			<input class="input-medium" id="fromSch" name="<portlet:namespace/>startDate" type="text" placeholder="Day-Mon-yyyy" value="${surgeryCurrentTimeStr}" />
		</div>
		<div class="formColumn">
			<label>End
				<span class="switch">
					<input type="checkbox" name="<portlet:namespace/>switcherEndDate" id="switcherEndDate" onchange="onSwitchEndDate(this, '${surgeryCurrentTimeStr}', 'toSch')" />
					<span class="slider round"></span>
				</span>
			</label>
			<input disabled="disabled" class="input-medium" id="toSch" name="<portlet:namespace/>endDate" type="text" placeholder="Day-Mon-yyyy" value="" />
		</div>
		<div class="formColumn"></div>
		<div class="formColumn"></div>
	</div>
	<button class="btn">Add</button>
</form>

<script type="text/javascript">
var currenDate = '${surgeryCurrentTimeStr}';

function onChangeWith(select) {
	var attendantsSelected = document.getElementById('attendantsSelected');
	if (select.value == 1) {
		for (var i=0; i<attendantsSelected.options.length; i++) {
			attendantsSelected.options[i].hidden = false;
		}
		attendantsSelected.multiple = 'multiple';
	} else {
		attendantsSelected.multiple = '';
		for (var i=0; i<attendantsSelected.options.length; i++) {
			console.log('is indiv: '+attendantsSelected.options[i].className);
			if (attendantsSelected.options[i].className != 'isindividual') {
				attendantsSelected.options[i].hidden = true;
			}
		}
	}
}

function onChangeFrecuency(select) {
	var recurrenceSelect = document.getElementById('recurrenceSelect');
	while (recurrenceSelect.firstChild) {
		recurrenceSelect.removeChild(recurrenceSelect.firstChild);
	}
	if (select.value == 1) {
		var opt1 = document.createElement('option');
		opt1.value = '1';
		opt1.appendChild(document.createTextNode('Every week'));
		recurrenceSelect.appendChild(opt1);
		var opt2 = document.createElement('option');
		opt2.value = '2';
		opt2.appendChild(document.createTextNode('Every two weeks'));
		recurrenceSelect.appendChild(opt2);
		var opt3 = document.createElement('option');
		opt3.value = '3';
		opt3.appendChild(document.createTextNode('Every three weeks'));
		recurrenceSelect.appendChild(opt3);
	} else {
		var opt4 = document.createElement('option');
		opt4.value = '1';
		opt4.appendChild(document.createTextNode('The first'));
		recurrenceSelect.appendChild(opt4);
		var opt5 = document.createElement('option');
		opt5.value = '2';
		opt5.appendChild(document.createTextNode('The second'));
		recurrenceSelect.appendChild(opt5);
		var opt6 = document.createElement('option');
		opt6.value = '3';
		opt6.appendChild(document.createTextNode('The third'));
		recurrenceSelect.appendChild(opt6);
		var opt7 = document.createElement('option');
		opt7.value = '4';
		opt7.appendChild(document.createTextNode('The fourth'));
		recurrenceSelect.appendChild(opt7);
	}
	
}


</script>
