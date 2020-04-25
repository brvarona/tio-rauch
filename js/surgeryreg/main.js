var tmPortletId = '_surgeryreg_WAR_drugrepportlet_';

function buildId(id) {
	return tmPortletId + id;
}

function addEvent(evnt, elem, func) {
	   if (elem.addEventListener)  // W3C DOM
	      elem.addEventListener(evnt,func,false);
	   else if (elem.attachEvent) { // IE DOM
	      elem.attachEvent("on"+evnt, func);
	   }
	   else { // No much to do
	      elem[evnt] = func;
	   }
}

function initOnRegionSelectorEvent(suburbUrl) {
	var regionSelector = document.getElementById(buildId('regionSelector'));
	regionSelector.suburbUrl = suburbUrl;
	
	addEvent('change', regionSelector, function(e) {
		var target = e.target || e.srcElement;
		searchSuburbs(target.value);
	});
	var suburbSelector = document.getElementById(buildId('suburbSelector'));
	//addEvent('change', suburbSelector, function(e) {
	//});
	updateSuburbSelector(suburbSelector, []);
}

function searchSuburbs(regionId) {
	var suburbSelector = document.getElementById(buildId('suburbSelector'));
	selectLoadingMessage(suburbSelector);
	setTimeout(function() {
		var response = [];
		switch (regionId) {
			case '32001': response = sub_act; break;
			case '32002': response = sub_nsw; break;
			case '32003': response = sub_nt; break;
			case '32004': response = sub_q; break;
			case '32005': response = sub_sa; break;
			case '32006': response = sub_t; break;
			case '32007': response = sub_v; break;
			case '32008': response = sub_wa; break;
			default: response = [];
		}
		updateSuburbSelector(suburbSelector, response);
	}, 0);
}

function searchSuburbs2(suburbUrl, regionId) {
	YUI().use('aui-io-request', function(A) {
		var suburbSelector = document.getElementById(buildId('suburbSelector'));
		selectLoadingMessage(suburbSelector);
		
		A.io.request(suburbUrl, {
			method : 'GET',
			dataType : 'json',
			data: {
				regionId: regionId
			},
			on : {
				success : function() {
					var response = this.get('responseData');
					if (response != null) {
						updateSuburbSelector(suburbSelector, response);
					} else {
						updateSuburbSelector(suburbSelector, []);
					}
				}
			}
		});
	});
}

function cleanSelector(selector) {
	while(selector.firstChild) {
		selector.removeChild(selector.firstChild);
	}
}

function buildOption(value, text) {
	var option = document.createElement('option');
	option.value = value;
	option.innerHTML = text;
	return option;
}

function updateSuburbSelector(suburbSelector, suburbList) {
	cleanSelector(suburbSelector);
	var defOption = buildOption(-1, '(Choose a Suburb)');
	suburbSelector.appendChild(defOption);
	for (var i=0; i<suburbList.length; i++) {
		suburbSelector.appendChild(buildOption(suburbList[i].id, suburbList[i].name + ' (' + suburbList[i].postalCode + ')'));
	}
}

function selectLoadingMessage(selector) {
	cleanSelector(selector);
	selector.appendChild(buildOption(-1, '...loading'));
}