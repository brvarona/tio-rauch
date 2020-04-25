<%@ include file="/html/surgerymanager/init.jsp" %>

<div class="" id="loading-mark-container">
	<div class="loading-mark"></div>
</div>

<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%=this.getServletContext() %>">
	<liferay-util:param name="menuId" value="30" />
</liferay-util:include>

<style>
/* The switch - the box around the slider */
span.switch {
  position: relative;
  display: inline-block;
  width: 30px;
  height: 15px;
  top: 2px;
}

/* Hide default HTML checkbox */
.switch input {display:none;}

/* The slider */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 11px;
  width: 11px;
  left: 4px;
  bottom: 2px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(11px);
  -ms-transform: translateX(11px);
  transform: translateX(11px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

</style>

<%
SurgeryModel surgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());
%>

<%@ include file="/html/surgerymanager/schedule/messages.jsp" %>

<br />

<%@ include file="/html/surgerymanager/schedule/schedule.jsp" %>

<br />

<%@ include file="/html/surgerymanager/schedule/blockOutDate.jsp" %>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
		
	</div>
</div>


<script type="text/javascript" charset="utf-8">

YUI().use('aui-timepicker', function(Y) {
	var times = [];
	var hour = 0;
	var minutes = 0;
	var interval = 15;
	var i = 0;
	while (hour < 24) {
		while (minutes < 60) {
			times[i] = buildTimeStr(hour, minutes);
			minutes += interval;
			i++;
		}
		hour++;
		minutes = 0;
	}
	new Y.TimePicker({
		trigger: '#hour',
		mask: '%H:%M',
		popover: {
			zIndex: 1
		},
		on: {
			selectionChange: function(event) {
				console.log(event.newSelection)
			}
		},
		values: times,
		initialized: true
	});
	
	new Y.TimePicker({
		trigger: '#blockHourFrom',
		mask: '%H:%M',
		popover: {
			zIndex: 1
		},
		on: {
			selectionChange: function(event) {
				console.log(event.newSelection)
			}
		},
		values: times,
		initialized: true
	});
	
	new Y.TimePicker({
		trigger: '#blockHourTo',
		mask: '%H:%M',
		popover: {
			zIndex: 1
		},
		on: {
			selectionChange: function(event) {
				console.log(event.newSelection)
			}
		},
		values: times,
		initialized: true
	});
});


YUI().use('aui-datepicker', 'aui-datatype-date-parse', function(Y) {
	var dp1;
	var dp2;
	var limitDate = Y.Date.parse('%d-%m-%Y', Y.one('#from').get('value'));
	dp1 = new Y.DatePicker({
		trigger: '#from',
		activeInput: '#from',
		popover: {
			zIndex: 1
		},
		on: {
			selectionChange: function(event) {
				var currentD1 = Y.Date.parse('%d-%m-%Y', Y.one('#from').get('value'));
				var dsVal = Y.Date.format(event.newSelection[0], {format:'%d-%m-%Y'});
				var ds = Y.Date.parse('%d-%m-%Y', dsVal);
				if (compareOnlyDate(ds, currentD1, true) === 0) return; // Nothing change
				
				var currentD2 = Y.Date.parse('%d-%m-%Y', Y.one('#to').get('value'));
				var c = compareOnlyDate(ds, currentD2, true); // Compare Date Selected with D2
				if (c > 0) { // If Date Selected is greater than D2 then update D2
					Y.one('#to').set('value', dsVal); // Update DP2
				}
			}
		},
		mask: '%d-%m-%Y',
		initialized: true,
		calendar: {
			minimumDate: limitDate
		}
	});
	
	dp2 = 	new Y.DatePicker({
		trigger: '#to',
		activeInput: '#to',
		popover: {
			zIndex: 1
		},
		on: {
			selectionChange: function(event) {
				var currentD2 = Y.Date.parse('%d-%m-%Y', Y.one('#to').get('value'));
				var dsVal = Y.Date.format(event.newSelection[0], {format:'%d-%m-%Y'});
				var ds = Y.Date.parse('%d-%m-%Y', dsVal);
				if (compareOnlyDate(ds, currentD2, true) === 0) return; // Nothing change
				
				var currentD1 = Y.Date.parse('%d-%m-%Y', Y.one('#from').get('value'));
				var c = compareOnlyDate(ds, currentD1, true); // Compare Date Selected with D1
				if (c < 0) { // If Date Selected is lower than D1 then update D1 // IT SHULD NOT BE ABLE TO SELECT THIS
					Y.one('#from').set('value', dsVal); // Update DP2
				}
			}
		},
		mask: '%d-%m-%Y',
		calendar: {
			minimumDate: limitDate
		}
	});
	
	var dp3 = new Y.DatePicker({
		trigger: '#fromSch',
		activeInput: '#fromSch',
		popover: {
			zIndex: 1
		},
		on: {
			selectionChange: function(event) {
				var currentD1 = Y.Date.parse('%d-%m-%Y', Y.one('#fromSch').get('value'));
				var dsVal = Y.Date.format(event.newSelection[0], {format:'%d-%m-%Y'});
				var ds = Y.Date.parse('%d-%m-%Y', dsVal);
				if (compareOnlyDate(ds, currentD1, true) === 0) return; // Nothing change
				
				if (Y.one('#toSch').get('value') != '') {
					var currentD2 = Y.Date.parse('%d-%m-%Y', Y.one('#toSch').get('value'));
					var c = compareOnlyDate(ds, currentD2, true); // Compare Date Selected with D2
					if (c > 0) { // If Date Selected is greater than D2 then update D2
						Y.one('#toSch').set('value', dsVal); // Update DP2
					}
				}
			}
		},
		mask: '%d-%m-%Y',
		initialized: true,
		calendar: {
			minimumDate: limitDate
		}
	});
	
	var dp4 = new Y.DatePicker({
		trigger: '#toSch',
		activeInput: '#toSch',
		popover: {
			zIndex: 1
		},
		on: {
			selectionChange: function(event) {
				var currentD2 = Y.Date.parse('%d-%m-%Y', Y.one('#toSch').get('value'));
				var dsVal = Y.Date.format(event.newSelection[0], {format:'%d-%m-%Y'});
				var ds = Y.Date.parse('%d-%m-%Y', dsVal);
				if (compareOnlyDate(ds, currentD2, true) === 0) return; // Nothing change
				
				var currentD1 = Y.Date.parse('%d-%m-%Y', Y.one('#fromSch').get('value'));
				var c = compareOnlyDate(ds, currentD1, true); // Compare Date Selected with D1
				if (c < 0) { // If Date Selected is lower than D1 then update D1 // IT SHULD NOT BE ABLE TO SELECT THIS
					Y.one('#fromSch').set('value', dsVal); // Update DP2
				}
			}
		},
		mask: '%d-%m-%Y',
		calendar: {
			minimumDate: limitDate
		}
	});
});
</script>