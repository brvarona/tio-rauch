// Write your Javascript code.

//Dashboard chart colors
window.chartColors = {
    red: 'rgb(255, 99, 132)',
    orange: 'rgb(255, 159, 64)',
    yellow: 'rgb(255, 205, 86)',
    green: 'rgb(75, 192, 192)',
    blue: 'rgb(54, 162, 235)',
    purple: 'rgb(153, 102, 255)',
    grey: 'rgb(201, 203, 207)',
    lightgrey: 'rgb(240, 240, 240)',
    darkgrey: 'rgb(92, 96, 103)'
};

chartSeriesColors = [
    'rgb(255, 99, 132)',
    'rgb(255, 159, 64)',
    'rgb(255, 205, 86)',
    'rgb(75, 192, 192)',
    'rgb(54, 162, 235)',
    'rgb(153, 102, 255)',
    'rgb(225, 103, 110)',
    'rgb(40, 140, 140)',
    'rgb(150, 196, 203)',
    'rgb(175, 100, 103)',
    'rgb(86, 199, 132)',
    'rgb(155, 159, 64)',
    'rgb(24, 205, 86)',
    'rgb(30, 192, 192)',
    'rgb(154, 162, 235)',
    'rgb(53, 102, 255)',
    'rgb(150, 103, 107)',
    'rgb(140, 40, 140)',
    'rgb(192, 96, 103)',
    'rgb(133, 130, 103)',
    'rgb(199, 255, 132)',
    'rgb(19, 155, 64)',
    'rgb(25, 5, 86)',
    'rgb(92, 75, 192)',
    'rgb(62, 54, 235)',
    'rgb(10, 153, 255)',
    'rgb(13, 50, 107)',
    'rgb(140, 40, 140)',
    'rgb(196, 92, 103)',
    'rgb(110, 103, 33)',
    'rgb(9, 132, 255)',
    'rgb(19, 64, 255)',
    'rgb(25, 86, 255)',
    'rgb(12, 192, 75)',
    'rgb(12, 235, 54)',
    'rgb(12, 255, 153)',
    'rgb(13, 107, 50)',
    'rgb(140, 140, 40)',
    'rgb(196, 103, 92)',
    'rgb(203, 33, 103)',
    'rgb(9, 132, 200)',
    'rgb(19, 64, 150)',
    'rgb(25, 86, 125)',
    'rgb(12, 192, 120)',
    'rgb(12, 235, 110)',
    'rgb(120, 255, 80)',
    'rgb(100, 255, 50)',
    'rgb(14, 240, 40)',
    'rgb(196, 103, 30)',
    'rgb(203, 33, 10)'
]

var modalForm = null;
function doPopupForm(doSave, title, size) {
	if (size == null) {
		size = 400;
	}
	YUI().use(
			  'aui-modal',
			  function(Y) {
				  modalForm = new Y.Modal(
			      {
			        bodyContent: '',
			        centered: true,
			        destroyOnHide: false,
			        headerContent: '<h3>' + title + '</h3>',
			        modal: true,
			        // render: '#modal',
			        boundingBox: '#bb',
			        contentBox: '#cb',
			        resizable: {
			          handles: 'b, r'
			        },
			        visible: true,
			        width: size,
			        zIndex: 30
			      }
			    ).render();

				modalForm.addToolbar(
			      [
			        {
			          label: 'Cancel',
			          on: {
			            click: function() {
			            	modalForm.hide();
			            }
			          }
			        },
			        {
			          label: 'Submit',
			          on: {
			            click: function() {
			            	doSave();
			            }
			          }
			        }
			      ]
			    );

			  }
			);
}

function closePopupForm() {
	modalForm.hide();
}

function openChartFilterPopUp(chartFilterPopupUrl, formId, from, to, aggregateId, rank, managerId, selectedStateCode, selectedATCCode, repId, targetName) {
	YUI().use('aui-io-request', function(A) {
		var loadingMark = document.getElementById('loading-mark-container');
		loadingMark.className = loadingMark.id;
		A.io.request(chartFilterPopupUrl, {
			method : 'POST',
			data: {
				_reports_WAR_drugrepportlet_fromDate: from,
				_reports_WAR_drugrepportlet_toDate: to,
				_reports_WAR_drugrepportlet_aggregateId: aggregateId,
				_reports_WAR_drugrepportlet_companyRank: rank,
				_reports_WAR_drugrepportlet_managerId: managerId,
				_reports_WAR_drugrepportlet_selectedStateCode: selectedStateCode,
				_reports_WAR_drugrepportlet_selectedATCCode: selectedATCCode,
				_reports_WAR_drugrepportlet_repId: repId,
				_reports_WAR_drugrepportlet_targetName: targetName,
				_drugrepmanager_WAR_drugrepportlet_fromDate: from,
				_drugrepmanager_WAR_drugrepportlet_toDate: to,
				_drugrepmanager_WAR_drugrepportlet_aggregateId: aggregateId,
				_drugrepmanager_WAR_drugrepportlet_companyRank: rank,
				_drugrepmanager_WAR_drugrepportlet_managerId: managerId,
				_drugrepmanager_WAR_drugrepportlet_selectedStateCode: selectedStateCode,
				_drugrepmanager_WAR_drugrepportlet_selectedATCCode: selectedATCCode,
				_drugrepmanager_WAR_drugrepportlet_repId: repId,
				_drugrepmanager_WAR_drugrepportlet_targetName: targetName
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						console.log('Response='+response)
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							addDatePicker();
							doPopupForm(function () {
								closePopupForm();
								var loadingMark = document.getElementById('loading-mark-container');
								loadingMark.className = loadingMark.id;
								var form = document.getElementById(formId);
								form.submit();
							}, 'Filters', 600);
						}
						loadingMark.className = '';
					} catch (error) {
						console.log(error);
						loadingMark.className = '';
					}
				},
				error: function(e) {
					try {
						var response = this.get('responseData');
						console.log(response);
					} catch (error) {
						console.log(error);
					}
					loadingMark.className = '';
				}
			}
		});
	});
}

function loadDefaultChart(defaultChartFormId) {
	var form = document.getElementById(defaultChartFormId);
	if (form != null) {
		var loadingMark = document.getElementById('loading-mark-container');
		loadingMark.className = loadingMark.id;
		form.submit();
	}
}

function addDatePicker() {
	YUI().use('aui-datepicker', 'aui-datatype-date-parse', function(Y) {
		var dp1;
		var dp2;
		var limitDate = Y.Date.parse('%d-%m-%Y', Y.one('#fromDate').get('value'));
		dp1 = new Y.DatePicker({
			trigger: '#fromDate',
			activeInput: '#fromDate',
			popover: {
				zIndex: 100
			},
			on: {
				selectionChange: function(event) {
					var currentD1 = Y.Date.parse('%d-%m-%Y', Y.one('#fromDate').get('value'));
					var dsVal = Y.Date.format(event.newSelection[0], {format:'%d-%m-%Y'});
					var ds = Y.Date.parse('%d-%m-%Y', dsVal);
					if (compareOnlyDate(ds, currentD1, true) === 0) return; // Nothing change
					
					var currentD2 = Y.Date.parse('%d-%m-%Y', Y.one('#toDate').get('value'));
					var c = compareOnlyDate(ds, currentD2, true); // Compare Date Selected with D2
					if (c > 0) { // If Date Selected is greater than D2 then update D2
						Y.one('#toDate').set('value', dsVal); // Update DP2
					}
				}
			},
			mask: '%d-%m-%Y',
			initialized: true,
//			calendar: {
//				minimumDate: limitDate
//			}
		});
		
		dp2 = 	new Y.DatePicker({
			trigger: '#toDate',
			activeInput: '#toDate',
			popover: {
				zIndex: 100
			},
			on: {
				selectionChange: function(event) {
					var currentD2 = Y.Date.parse('%d-%m-%Y', Y.one('#toDate').get('value'));
					var dsVal = Y.Date.format(event.newSelection[0], {format:'%d-%m-%Y'});
					var ds = Y.Date.parse('%d-%m-%Y', dsVal);
					if (compareOnlyDate(ds, currentD2, true) === 0) return; // Nothing change
					
					var currentD1 = Y.Date.parse('%d-%m-%Y', Y.one('#fromDate').get('value'));
					var c = compareOnlyDate(ds, currentD1, true); // Compare Date Selected with D1
					if (c < 0) { // If Date Selected is lower than D1 then update D1 // IT SHULD NOT BE ABLE TO SELECT THIS
						Y.one('#fromDate').set('value', dsVal); // Update DP2
					}
				}
			},
			mask: '%d-%m-%Y',
//			calendar: {
//				minimumDate: limitDate
//			}
		});
		
	});
}