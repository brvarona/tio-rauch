
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
			          label: 'Save',
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

function addEvent(evnt, elem, func) {
	if (elem.addEventListener) { // W3C DOM
		elem.addEventListener(evnt,func,false);
	} else if (elem.attachEvent) { // IE DOM
		elem.attachEvent("on"+evnt, func);
	} else { // No much to do
		elem[evnt] = func;
	}
}

//Show form with notifications options.
function showSelectDrugRepForm(assignAppURL) {
	doPopupForm(function () {
		assignApp(assignAppURL);
	}, 'Assign Appointment', 400);
}

function assignApp(assignAppURL) {
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(assignAppURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'assignAppFm' },
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							if (response.error != null) {
								popupMessage.className = 'popupMessage-error';
								popupMessage.innerHTML = response.error;
							} else {
								popupMessage.className = 'popupMessage';
								popupMessage.innerHTML = 'SAVED';
								if (response.redirectAction != null) {
									document.location.href = response.redirectAction;
								} else {
									setTimeout(closePopupForm, 700);
								}
							}
						}
					} catch (error) {
						console.log(error);
						popupMessage.className = 'popupMessage-error';
						popupMessage.innerHTML = 'Unexpected error: ' + error;
					}
				},
				error: function(e) {
					try {
						var response = this.get('responseData');
						console.log(response);
					} catch (error) {
						console.log(error);
					}
					popupMessage.className = 'popupMessage-error';
					popupMessage.innerHTML = 'Unexpected error: ' + error;
				}
			}
		});
	});
}

function reloadRepOfManager(reloadRepOfManagerUrl, directorId, select) {
	var managerId = select.value;
	console.log("Select managerId="+ managerId);
	YUI().use('aui-io-request', function(A) {
		A.io.request(reloadRepOfManagerUrl, {
			method : 'GET',
			dataType : 'json',
			data: { 
				_drugrepmanager_WAR_drugrepportlet_managerId: managerId,
				_drugrepmanager_WAR_drugrepportlet_directorId: directorId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							if (response.error != null) {
								console.log(response.error);
							} else {
								console.log(response);
								var filterRep = document.getElementById('filterRep');
								while (filterRep.firstChild) {
									filterRep.removeChild(filterRep.firstChild);
								}
								var optDefault = document.createElement("option");
								optDefault.value = '0';
								var nameDefault = document.createTextNode('All');
								optDefault.appendChild(nameDefault);
								filterRep.appendChild(optDefault);
								for (i=0; i<response.reps.length; i++) {
									var opt = document.createElement("option");
									opt.value = response.reps[i].id;
									var name = document.createTextNode(response.reps[i].fullName);
									opt.appendChild(name);
									filterRep.appendChild(opt);
								}
							}
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						var response = this.get('responseData');
						console.log(response);
					} catch (error) {
						console.log(error);
					}
				}
			}
		});
	});
}

function loadSOVChart(chartvar, chartvarIndex, charContainerId, title, companyRank, chartData, xAxesLabel, yAxesLabel, percentage, fixed, yMin) {
	var ctx = document.getElementById(charContainerId).getContext('2d');
	chartvar[chartvarIndex] = new Chart(ctx, {
		type: 'bar',
		data: chartData,
		options: {
			responsive: true,
			legend: {
				position: 'right',
				labels: {
					filter: function (legendItem, chartData) {
						// return false to hide the label
						if (legendItem.text == '') {
							return false;
						} else {
							return true;
						}
					}
				},
				onClick : function(e, legendItem) {
					var dataset = this.chart.data.datasets[legendItem.datasetIndex];
                   	var ci = this.chart;
                   	dataset.hidden = !dataset.hidden;
                   	var maxSov = 0.0;
                       Chart.helpers.each(this.chart.data.datasets.forEach(function (dataset, i) {
                           if (dataset.label != "" && (dataset.hidden == null || dataset.hidden == false)) {
                               var meta = ci.getDatasetMeta(i);
                               Chart.helpers.each(meta.data.forEach(function (bar, j) {
                                   if (maxSov < parseFloat(dataset.data[j])) {
                                       maxSov = parseFloat(dataset.data[j]);
                                   }
                               }), this);
                           } else if (ci.currentMonthIndex == null && dataset.label == "") {
                               var meta = ci.getDatasetMeta(i);
                               Chart.helpers.each(meta.data.forEach(function (bar, j) {
                                   if (dataset.data[j] != '0' ) {
                                       ci.currentMonthIndex = j;
                                   }
                               }), this);
                           }
                       }), this);
                       if (maxSov > 0.0) {
                    	   maxSov = maxSov + 0.01;
                       }
                       console.log('MaxSov='+maxSov);
                       
                       Chart.helpers.each(this.chart.data.datasets.forEach(function (dataset, i) {
                       	if (dataset.label == "") {
                       		if (ci.currentMonthIndex != null) {
                       			dataset.data[ci.currentMonthIndex] = maxSov;
                       		}
                       	}
                       }), this);
					this.chart.update();
				}
			},
			title: {
                display: true,
                text: title
            },
            tooltips: {
            	position: "nearest",
                mode: 'point',
                intersect: false,
                filter: function (tooltipItem) {
                    //console.log(tooltipItem);
                    //return (tooltipItem.datasetIndex == companyRank ? false : true);
                    return tooltipItem.yLabel != 0;
                }
            },
            scales: {
                xAxes: [{
                    ticks: {},
                	scaleLabel: {
                    	display: true,
                    	labelString: xAxesLabel
                	}
                }],
                yAxes: [{
                    ticks: {
                    	min: yMin,
                        //beginAtZero: true,
                        //stepSize: 500000,
                        userCallback: function (value, index, values) {
                        	var n = value.toFixed(fixed);
                            //value = value.toString();
                            //value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                            return n + percentage;
                        }
                    },
                    scaleLabel: {
                        display: true,
                        labelString: yAxesLabel
                    }
                }]
            },
//             animation: {
//                 onComplete: function () {
                	
//                     var chartInstance = this.chart;
//                     var ctx = chartInstance.ctx;
//                     console.log(chartInstance);
//                     var height = chartInstance.controller.boxes[0].bottom;
//                     ctx.textAlign = "center";
//                     //ctx.
//                     var maxSov = 0.0;
//                     Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
//                     	console.log(dataset.label);
//                     	console.log(dataset._meta[0].hidden);
//                     	var meta = chartInstance.controller.getDatasetMeta(i);
//                     	console.log(meta.hidden);
//                     	if (dataset.label != "" && dataset._meta[0].hidden != true) {
//                     		Chart.helpers.each(meta.data.forEach(function (bar, index) {
//                     			if (maxSov < parseFloat(dataset.data[index])) {
//                     				maxSov = parseFloat(dataset.data[index]);
//                     			}
//                     		}), this);
//                     	}
//                         if (dataset.label == "") {
//                             Chart.helpers.each(meta.data.forEach(function (bar, index) {
//                             	console.log(dataset.data[index]);
//                             	if (dataset.data[index] != '0') {
//                             		dataset.data[index] = maxSov;
//                             	}
//                             	//chartInstance.update();
//                                 //ctx.fillText((dataset.data[index] > 0 ? "CURRENT MONTH" : ""), bar._model.x, height - ((height - bar._model.y) / 2));
//                             }), this);
//                         }
//                     }), this);
//                 }
//             }
		}
	});
}

function openChartFilterPopUp(chartFilterPopupUrl, formId, from, to, aggregateId, companyRank, managerId, stateCode, atc, repId, targetName) {
	YUI().use('aui-io-request', function(A) {
		var loadingMark = document.getElementById('loading-mark-container');
		loadingMark.className = loadingMark.id;
		A.io.request(chartFilterPopupUrl, {
			method : 'POST',
			data: {
				_reports_WAR_drugrepportlet_fromDate: from,
				_reports_WAR_drugrepportlet_toDate: to,
				_reports_WAR_drugrepportlet_aggregateId: aggregateId,
				_reports_WAR_drugrepportlet_companyRank: companyRank,
				_reports_WAR_drugrepportlet_managerId: managerId,
				_reports_WAR_drugrepportlet_state: stateCode,
				_reports_WAR_drugrepportlet_atc: atc,
				_reports_WAR_drugrepportlet_repId: repId,
				_reports_WAR_drugrepportlet_targetName: targetName,
				_drugrepmanager_WAR_drugrepportlet_fromDate: from,
				_drugrepmanager_WAR_drugrepportlet_toDate: to,
				_drugrepmanager_WAR_drugrepportlet_aggregateId: aggregateId,
				_drugrepmanager_WAR_drugrepportlet_companyRank: companyRank,
				_drugrepmanager_WAR_drugrepportlet_managerId: managerId,
				_drugrepmanager_WAR_drugrepportlet_state: stateCode,
				_drugrepmanager_WAR_drugrepportlet_atc: atc,
				_drugrepmanager_WAR_drugrepportlet_repId: repId,
				_drugrepmanager_WAR_drugrepportlet_targetName: targetName,
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
							}, 'Filters', 400);
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