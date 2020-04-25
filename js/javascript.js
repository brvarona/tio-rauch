function excecuteWithConfirm(url, message) {
	var ok = confirm(message);
	if (ok) {
		location.href = url;
	}
}


function confirmAppTime(form, weekDay, time) {
	console.log("Submit form");
	var weekDayValue = "";
	if (weekDay === '2') {
		weekDayValue = "Monday";
	} else if (weekDay === '3') {
		weekDayValue = "Tuesday";
	} else if (weekDay === '4') {
		weekDayValue = "Wednesday";
	} else if (weekDay === '5') {
		weekDayValue = "Thursday";
	} else if (weekDay === '6') {
		weekDayValue = "Friday";
	}
	
	var ok = confirm("This will add a new appointment time for representatives " + weekDayValue + " at " + time + ". Please confirm that this is correct");
	if (ok) {
		form.submit();
	}
}

function confirmEmail(form, email) {
	if (validateEmail(email)) {
		var ok = confirm("Please confirm the email: " + email);
		if (ok) {
			form.submit();
		}
	} else {
		alert("Please, enter a valid email.");
	}
}

function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
} 

// Product Selector

function changeCompanyView(select) {
	var currentSection;
	var newSection;
	if (select.defaultValue == null || select.defaultValue == 'undefined') {
		var optionP = select.options[0];
		currentSection = document.getElementById('comp_' + optionP.value);
	} else {
		currentSection = document.getElementById('comp_' + select.defaultValue);
	}
	var optionN = select.options[select.selectedIndex];
	newSection = document.getElementById('comp_' + optionN.value);
	select.defaultValue = optionN.value;
	
	currentSection.style.display = 'none';
	newSection.style.display = '';
}

function selectToRight(id) {
	var leftSelect = document.getElementById("<portlet:namespace />leftValues" + id);
	var option = leftSelect.options[leftSelect.selectedIndex];
	
	var rigthGroup = document.getElementById(option.title + "_S2");
	rigthGroup.appendChild(option);
}

function selectToLeft(id) {
	var rightSelect = document.getElementById("<portlet:namespace />rightValues" + id);
	var option = rightSelect.options[rightSelect.selectedIndex];
	
	var leftGroup = document.getElementById(option.title + "_S1");
	leftGroup.appendChild(option);
}

// End Product Selector


function compareOnlyDate(d1, d2, tolerance) {
	if ( d1.getTime() === d2.getTime() || (tolerance && (Math.abs(d1.getTime() - d2.getTime())) < 100) ) {
		return 0;
	} else if (d1.getTime() < d2.getTime()) {
		return -1;
	} else {
		return 1;
	}
}