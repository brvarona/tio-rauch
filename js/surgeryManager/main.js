//
// Surgery Manager Scripts
//

function doAlert(header, message, color) {
	YUI().use('aui-modal', function(Y) {
		var modal = new Y.Modal({
			bodyContent: '<div style="color: '+color+'; text-align: center">'+message+'</div>',
			centered: true,
			headerContent: '<h3>'+header+'</h3>',
			modal: true,
			render: '#myAlert',
			resizable: false,
			draggable: false,
			zIndex: 30
		}).render();
		
		modal.addToolbar([{
			label: 'Ok',
			centered: true,
			on: {
				click: function() {
					modal.hide();
				}
			}
		}]);
	});
}

function buildTimeStr(hour, minutes) {
	var hStr = hour;
	if (hour < 0) {
		hStr = '0' + hour;
	}
	var mStr = minutes;
	if (minutes < 0) {
		mStr = '0' + minutes;
	}
	return hour + ":" + minutes;
}

function changeCancelReason() {
	AUI().use('node', function(A) {
		var value = A.one('.select').get("value");
	  	if (value == "Other"){
	       A.one('.input_other').set('required', true);  
	       A.one('.input_other').set('style', "display: ");
	     } else {
	         A.one('.input_other').set('required', false);  
	         A.one('.input_other').set('style', "display: none");
	     }
	  	return false;
	});
}

var cancelReason;
function setOption() {

	AUI().use('node', function(A) {
		var value = A.one('.select').get("value");
	  	if (value == "Other") {
	       var otherField = A.one('.input_other').get("value"); 
	       cancelReason = otherField;
	    } else {
	  		cancelReason = value;
	  	}
		return false;
	});
}

var modalForm;
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

function doPopupFormOnlyAction(doSave, title, size) {
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
			          label: 'OK',
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

var modalView;
function doPopupView(title) {
	YUI().use('aui-modal', function(Y) {
		modalView = new Y.Modal({
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
			width: 400,
			zIndex: 30
		}).render();

		modalView.addToolbar([
			{
				label: 'Close',
				on: {
					click: function() {
						modalView.hide();
					}
				}
			}
		]);
	});
}

function closePopupView() {
	modalView.hide();
}

//------

function addEvent(evnt, elem, func) {
	   if (elem.addEventListener)  // W3C DOM
	      elem.addEventListener(evnt,func,false);
	   else if (elem.attachEvent) { // IE DOM
	      elem.attachEvent("on"+evnt, func);
	   } else { // No much to do
	      elem[evnt] = func;
	   }
}

// Show form with doctors that could attend a schedule.
function showEditAttendantsForm(scheduleId, surgeryId, showEditAttendantsURL, editAttendantsAndConfirmAppURL, appointmentId, reloadScheduleAppsLinkId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showEditAttendantsURL, {
			method : 'GET',
			data: {
				_surgerymanager_WAR_drugrepportlet_scheduleId: scheduleId,
				_surgerymanager_WAR_drugrepportlet_surgeryId: surgeryId,
				_surgerymanager_WAR_drugrepportlet_appointmentId: appointmentId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
								submitAttendantsAndConfirmApp(editAttendantsAndConfirmAppURL, reloadScheduleAppsLinkId);
							}, 'Edit attendants', 400);
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

//Close form with doctors that could attend a schedule.
function closeEditAttendantFormDep(event) {
	var content = document.getElementById('editAttendantsContent');
	while (content.firstChild) {
		content.removeChild(content.firstChild);
	}
	content.style.display = 'none';
	var overlayder = document.getElementById('overlayder');
	overlayder.style.display = 'none';
}

function submitAttendantsAndConfirmApp(editAttendantsAndConfirmAppURL, reloadScheduleAppsLinkId) {
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(editAttendantsAndConfirmAppURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'editAttendantsFm' },
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
									var reloadScheduleAppsLink = document.getElementById(reloadScheduleAppsLinkId)
									reloadScheduleAppsLink.click();
								}
							}
						}
					} catch (error) {
						console.log(error);
						Message.className = 'popupMessage-error';
						popupMessage.innerHTML = 'Unexpected error';
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
					popupMessage.innerHTML = 'Unexpected error';
				}
			}
		});
	});
}

function confirmAppointmentWithoutDoctors(confirmAppointmentWithoutDoctorsURL, appId, reloadScheduleAppsLinkId) {
	AUI().use('aui-io-request', function(A) {
		A.io.request(confirmAppointmentWithoutDoctorsURL, {
			method : 'POST',
			dataType : 'json',
			data: { 
				_surgerymanager_WAR_drugrepportlet_appId: appId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							if (response.error != null) {
								console.log(response.error);
							} else {
								var reloadScheduleAppsLink = document.getElementById(reloadScheduleAppsLinkId)
								reloadScheduleAppsLink.click();
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

//Edit attendants.
function editAttendants(event) {
	var target = event.target || event.srcElement;
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(target.editAttendantsURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'editAttendantsFm' },
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
									setTimeout(closeEditAttendantForm, 700);
								}
							}
						}
					} catch (error) {
						console.log(error);
						var overlayder = document.getElementById('overlayder');
						if (overlayder != null) {
							overlayder.style.display = '';
						}
						var content = document.getElementById('editAttendantContent');
						if (content != null) {
							content.style.display = '';
						}
						popupMessage.className = 'popupMessage-error';
						popupMessage.innerHTML = 'Unexpected error';
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
					popupMessage.innerHTML = 'Unexpected error';
				}
			}
		});
	});
}

function showDoctorInfo(showDoctorInfoURL, doctorId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showDoctorInfoURL, {
			method : 'GET',
			data: {
				_surgerymanager_WAR_drugrepportlet_doctorId: doctorId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupView('Doctors info');
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loading.style.display = 'none';
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

function showDrugRepresentativeInfo(drugRepresentativeId, showDrugRepresentativeInfoURL, drugRepFullName) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showDrugRepresentativeInfoURL, {
			method : 'GET',
			data: {
				_surgerymanager_WAR_drugrepportlet_drugRepresentativeId: drugRepresentativeId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupView(drugRepFullName);
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loading.style.display = 'none';
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

function showAppReviewForm(showAppReviewFormURL, appointmentId, submitReviewFormURL, showAppReviewFormLinkId, removeRow) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showAppReviewFormURL, {
			method : 'GET',
			data: {
				_surgerymanager_WAR_drugrepportlet_appId: appointmentId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function() {
								submitAppReview(submitReviewFormURL, showAppReviewFormLinkId, removeRow);
							}, 'Appointment Review', 400);
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loading.style.display = 'none';
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

function submitAppReview(submitReviewFormURL, showAppReviewFormLinkId, removeRow) {
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(submitReviewFormURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'surgeryReviewFm' },
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
									console.log(showAppReviewFormLinkId);
									var button = document.getElementById(showAppReviewFormLinkId);
									if (removeRow) {
										button.parentNode.parentNode.parentNode.parentNode.removeChild(button.parentNode.parentNode.parentNode);
									} else {
										button.parentNode.removeChild(button);
									}
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

function showEditEndDateForm(showEditEndDateFormURL, editEndDateURL, scheduleId, limitDate, linkId) {
	YUI().use('aui-io-request', function(A) {
		var endDate = document.getElementById(linkId).innerHTML;
		if (endDate === 'Set') {
			endDate = '';
		}
		A.io.request(showEditEndDateFormURL, {
			method : 'GET',
			data: {
				_surgerymanager_WAR_drugrepportlet_endDate: endDate,
				_surgerymanager_WAR_drugrepportlet_limitDate: limitDate,
				_surgerymanager_WAR_drugrepportlet_scheduleId: scheduleId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
								editEndDate(editEndDateURL, linkId);
							}, 'Edit', 400);
							YUI().use('aui-datepicker', 'aui-datatype-date-parse', function(Y) {
								var ld = Y.Date.parse('%d-%m-%Y', limitDate);
								new Y.DatePicker({
									trigger: '#editedEndDate',
									activeInput: '#editedEndDate',
									popover: {
										zIndex: 40
									},
									on: {
										selectionChange: function(event) {
											
											//console.log(event.newSelection[0]);
											//console.log(Y.Date.parse('%d-%m-%Y', Y.one('#endDate').get('value')));
										}
									},
									mask: '%d-%m-%Y',
									initialized: true,
									calendar: {
										minimumDate: ld
									}
								});
							});
							var switcherEditedEndDate = document.getElementById('switcherEditedEndDate');
							addEvent('change', switcherEditedEndDate, function() {
								onSwitchEndDate(switcherEditedEndDate, endDate, 'editedEndDate');
							});
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

function editEndDate(editEndDateURL, linkId) {
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(editEndDateURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'editEndDateFm' },
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
									if (document.getElementById('switcherEditedEndDate').checked) {
										document.getElementById(linkId).innerHTML = document.getElementById('editedEndDate').value;
									} else {
										document.getElementById(linkId).innerHTML = 'Set';
									}
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

function onSwitchEndDate(checkbox, currenDate, inputId) {
	if (checkbox.checked) {
		document.getElementById(inputId).disabled = '';
		document.getElementById(inputId).value = currenDate;
	} else {
		document.getElementById(inputId).disabled = 'disabled';
		document.getElementById(inputId).value = '';
	}
}

function showBlockForm(showBlockFormURL, submitBlockFormURL, appTime, surgeryId, individualId, reloadScheduleAppsLinkId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showBlockFormURL, {
			method : 'GET',
			data: {
				_surgerymanager_WAR_drugrepportlet_appTime: appTime,
				_surgerymanager_WAR_drugrepportlet_individualId: individualId,
				_surgerymanager_WAR_drugrepportlet_surgeryId: surgeryId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function() {
								submitBlockForm(submitBlockFormURL, reloadScheduleAppsLinkId);
							}, 'Block Appointment', 400);
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loading.style.display = 'none';
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

function submitBlockForm(submitBlockFormURL, reloadScheduleAppsLinkId) {
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(submitBlockFormURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'blockFm' },
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
									var reloadScheduleAppsLink = document.getElementById(reloadScheduleAppsLinkId)
									reloadScheduleAppsLink.click();
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



//---------------


function selectPage(nextPage, currentPage, pageSize, loadTableUrl, resultBoxId) {
//	if (nextPage != currentPage) {
		var loadingMark = document.getElementById(resultBoxId+'-loading-box');
		loadingMark.className = 'loading-text-box';
		YUI().use('aui-io-request', function(A) {
			A.io.request(loadTableUrl, {
				method : 'GET',
				data: {
					_surgerymanager_WAR_drugrepportlet_page_p: nextPage,
					_surgerymanager_WAR_drugrepportlet_page_ps: pageSize
				},
				on : {
					success : function(e) {
						try {
							loadingMark.className = '';
							var response = this.get('responseData');
							if (response != null && response.trim().indexOf("<html")<0) { // !response.includes("<html") to prevent session timeout page
								document.getElementById(resultBoxId).innerHTML = response;
								var scripts = document.getElementById(resultBoxId).getElementsByTagName('script');
								for (var i=0; i<scripts.length; i++) {
									eval(scripts[i].innerHTML);
								}
							}
						} catch (error) {
							console.log(error);
						}
					},
					error: function(e) {
						try {
							loadingMark.className = '';
							var response = this.get('responseData');
							console.log(response);
						} catch (error) {
							console.log(error);
						}
					}
				}
			});
		});
//	} else {
//		console.log('current page selected');
//	}
}

function reloadPage(currentPage, pageSize, loadTableUrl, resultBoxId) {
	selectPage(currentPage, currentPage, pageSize, loadTableUrl, resultBoxId);
}


function selectPageSize(nextPageSize, currentPageSize, loadTableUrl, resultBoxId) {
	if (nextPageSize != currentPageSize) {
		var loadingMark = document.getElementById(resultBoxId+'-loading-box');
		loadingMark.className = 'loading-text-box';
		YUI().use('aui-io-request', function(A) {
			A.io.request(loadTableUrl, {
				method : 'GET',
				data: {
					_surgerymanager_WAR_drugrepportlet_page_p: 1,
					_surgerymanager_WAR_drugrepportlet_page_ps: nextPageSize
				},
				on : {
					success : function(e) {
						try {
							loadingMark.className = '';
							var response = this.get('responseData');
							if (response != null && response.trim().indexOf("<html")<0) { // !response.includes("<html") to prevent session timeout page
								document.getElementById(resultBoxId).innerHTML = response;
								var scripts = document.getElementById(resultBoxId).getElementsByTagName('script');
								for (var i=0; i<scripts.length; i++) {
									eval(scripts[i].innerHTML);
								}
							}
						} catch (error) {
							console.log(error);
						}
					},
					error: function(e) {
						try {
							loadingMark.className = '';
							var response = this.get('responseData');
							console.log(response);
						} catch (error) {
							console.log(error);
						}
					}
				}
			});
		});
	} else {
		console.log('current page size selected');
	}
}

function filterScheduleApps(loadTableUrl, resultBoxId) {
	var loadingMark = document.getElementById(resultBoxId+'-loading-box');
	loadingMark.className = 'loading-text-box';
	AUI().use('aui-io-request', function(A) {
		A.io.request(loadTableUrl, {
			method : 'GET',
			form: {
				id: 'appBySurgeryFilterFm'
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response != null && response.trim().indexOf("<html")<0) { // !response.includes("<html") to prevent session timeout page
							document.getElementById(resultBoxId).innerHTML = response;
							var scripts = document.getElementById(resultBoxId).getElementsByTagName('script');
							for (var i=0; i<scripts.length; i++) {
								eval(scripts[i].innerHTML);
							}
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						console.log(response);
					} catch (error) {
						console.log(error);
					}
				}
			}
		});
	});
	return false;
}

function disableIndividualApp(disableIndividualAppUrl, doctorId, actionLinkId, otherActionLinkId) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(disableIndividualAppUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_surgerymanager_WAR_drugrepportlet_doctorId: doctorId
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response.success) {
							doAlert('My Medical Staff', 'Disabled individual success', 'green');
							var actionLink = document.getElementById(actionLinkId);
							if (actionLink) {
								actionLink.parentNode.className = "hidden";
							}
							var otherActionLink = document.getElementById(otherActionLinkId);
							if (otherActionLink) {
								otherActionLink.parentNode.className = "";
							}
						} else if (response.error) {
							doAlert('My Medical Staff', response.error, 'red');
						} else {
							doAlert('My Medical Staff', 'Could not perform this action', 'red');
						}
						
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
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

function allowIndividualApp(allowIndividualAppUrl, doctorId, actionLinkId, otherActionLinkId) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(allowIndividualAppUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_surgerymanager_WAR_drugrepportlet_doctorId: doctorId
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response.success) {
							var actionLink = document.getElementById(actionLinkId);
							if (actionLink) {
								actionLink.parentNode.className = "hidden";
							}
							var otherActionLink = document.getElementById(otherActionLinkId);
							if (otherActionLink) {
								otherActionLink.parentNode.className = "";
							}
							doAlert('My Medical Staff', 'Allow individual success', 'green');
						} else if (response.error) {
							doAlert('My Medical Staff', response.error, 'red');
						} else {
							doAlert('My Medical Staff', 'Could not perform this action.', 'red');
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
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

function removeDoctorFromSurgery(removeDoctorFromSurgeryUrl, doctorId, rowId) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(removeDoctorFromSurgeryUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_surgerymanager_WAR_drugrepportlet_doctorId: doctorId
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response.success) {
							var actionLink = document.getElementById(rowId);
							if (actionLink) {
								actionLink.parentNode.parentNode.parentNode.parentNode.removeChild(actionLink.parentNode.parentNode.parentNode);
							}
							doAlert('My Medical Staff', 'Doctor removed', 'green');
						} else if (response.error) {
							doAlert('My Medical Staff', response.error, 'red');
						} else {
							doAlert('My Medical Staff', 'Could not perform this action', 'red');
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
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

function deleteSchedule(deleteScheduleUrl, scheduleId, rowId) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(deleteScheduleUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_surgerymanager_WAR_drugrepportlet_scheduleId: scheduleId
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response.success) {
							var actionLink = document.getElementById(rowId);
							if (actionLink) {
								actionLink.parentNode.parentNode.parentNode.parentNode.removeChild(actionLink.parentNode.parentNode.parentNode);
							}
							doAlert('Appointment Times', 'Appointment time deleted', 'green');
						} else if (response.error) {
							doAlert('Appointment Times', response.error, 'red');
						} else {
							doAlert('Appointment Times', 'Could not perform this action', 'red');
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
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

function refreshSurgeryInfo(surgeryInfoId, refreshSurgeryInfoURL) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(refreshSurgeryInfoURL, {
			method : 'POST',
			dataType : 'json',
			data: {},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						document.getElementById(surgeryInfoId).innerHTML = response;
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

function cancelApp(cancelAppUrl, appId, surgeryId, resultBoxId, reloadScheduleAppsLinkId, cancelReason) {
	var loadingMark = document.getElementById(resultBoxId+'-loading-box');
	loadingMark.className = 'loading-text-box';
	YUI().use('aui-io-request', function(A) {
		A.io.request(cancelAppUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_surgerymanager_WAR_drugrepportlet_appId: appId,
				_surgerymanager_WAR_drugrepportlet_surgeryId: surgeryId,
				_surgerymanager_WAR_drugrepportlet_cancelReason: cancelReason
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response.success) {
							var reloadScheduleAppsLink = document.getElementById(reloadScheduleAppsLinkId);
							reloadScheduleAppsLink.click();
						} else if (response.error) {
							doAlert('Future Appointments', response.error, 'red');
						} else {
							doAlert('Future Appointments', 'Could not perform this action', 'red');
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
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

function showCancelAppForm(showCancelAppFormUrl, cancelAppUrl, appId, surgeryId, resultBoxId, reloadScheduleAppsLinkId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showCancelAppFormUrl, {
			method : 'GET',
			dataType : 'json',
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
				            	setOption();
					            modalForm.hide();
				            	cancelApp(cancelAppUrl, appId, surgeryId, resultBoxId, reloadScheduleAppsLinkId, cancelReason);
				            	 
							}, 'Cancellation Reason', 350);
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


function changeSchedule(changeScheduleUrl, scheduleId, rowId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(changeScheduleUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_surgerymanager_WAR_drugrepportlet_scheduleId: scheduleId,
				_surgerymanager_WAR_drugrepportlet_time: document.getElementById("scheduleTime").value
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response.success) {
							var actionLink = document.getElementById(rowId);
							if (actionLink) {
								actionLink.parentNode.parentNode.parentNode.cells[2].innerText = document.getElementById("scheduleTime").value
							}
							doAlert('Appointment Times', 'Appointment time changed', 'green');
						} else if (response.error) {
							doAlert('Appointment Times', response.error, 'red');
						} else {
							doAlert('Appointment Times', 'Could not perform this action', 'red');
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
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
function showChangeScheduleForm(showChangeScheduleFormUrl, changeScheduleUrl, scheduleId, rowId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showChangeScheduleFormUrl, {
			method : 'GET',
			dataType : 'json',
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
				            	
					            modalForm.hide();
				            	changeSchedule(changeScheduleUrl, scheduleId, rowId);
				            	 
							}, 'Change Appointment Time', 350);
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
									trigger: '#scheduleTime',
									mask: '%H:%M',
									popover: {
										zIndex: 40
									},
									on: {
										selectionChange: function(event) {
											//console.log(event.newSelection)
										}
									},
									values: times,
									initialized: true
								});
							});
							
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

function resendBPNotification(resendBPNotificationUrl, appId, resultBoxId) {
	try {
		console.log(resendBPNotificationUrl);
		console.log("Calling resend BP notification for appId="+appId);
		var loadingMark = document.getElementById(resultBoxId+'-loading-box');
		loadingMark.className = 'loading-text-box';
		YUI().use('aui-io-request', function(A) {
			A.io.request(resendBPNotificationUrl, {
				method : 'POST',
				dataType : 'json',
				data: {
					_surgerymanager_WAR_drugrepportlet_appId: appId
				},
				on : {
					success : function(e) {
						try {
							loadingMark.className = '';
							var response = this.get('responseData');
							console.log("Response of resend BP notification="+response);
							if (response.success) {
								doAlert('BP Notificatios', 'Notifications sent', 'green');
							} else if (response.error) {
								doAlert('BP Notificatios', response.error, 'red');
							} else {
								doAlert('BP Notificatios', 'Could not perform this action', 'red');
							}
						} catch (error) {
							alert('#1'+error);
							console.log(error);
						}
					},
					error: function(e) {
						try {
							loadingMark.className = '';
							var response = this.get('responseData');
							console.log(response);
						} catch (error) {
							alert('#2'+error);
							console.log(error);
						}
					}
				}
			});
		});
	} catch (gerror) {
		alert('#3'+gerror);
		console.log(gerror);
	}
}

function removeBlockOutDate(removeBlockOutDateUrl, blockOutDateId, doctorId, rowId) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(removeBlockOutDateUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_surgerymanager_WAR_drugrepportlet_blockOutDateId: blockOutDateId,
				_surgerymanager_WAR_drugrepportlet_doctorId: doctorId
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response.success) {
							var row = document.getElementById(rowId);
							if (row) {
								row.parentNode.parentNode.parentNode.parentNode.removeChild(row.parentNode.parentNode.parentNode);
							}
							doAlert('Block Out Dates', 'Block out date deleted', 'green');
						} else if (response.error) {
							doAlert('Block Out Dates', response.error, 'red');
						} else {
							doAlert('Block Out Dates', 'Could not perform this action', 'red');
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
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

function removeBlockOutDateFromFutureAppsView(removeBlockOutDateUrl, blockOutDateId, doctorId, reloadScheduleAppsLinkId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(removeBlockOutDateUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_surgerymanager_WAR_drugrepportlet_blockOutDateId: blockOutDateId,
				_surgerymanager_WAR_drugrepportlet_doctorId: doctorId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response.success) {
							doAlert('Block Out Dates', 'Block out date deleted', 'green');
							var reloadScheduleAppsLink = document.getElementById(reloadScheduleAppsLinkId)
							reloadScheduleAppsLink.click();
						} else if (response.error) {
							doAlert('Block Out Dates', response.error, 'red');
						} else {
							doAlert('Block Out Dates', 'Could not perform this action', 'red');
						}
					} catch (error) {
						console.log(error);
					}
				},
				error: function(e) {
					try {
						loadingMark.className = '';
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


function showReloadScheduleForm(showReloadScheduleFormURL) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showReloadScheduleFormURL, {
			method : 'GET',
			data: {
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupFormOnlyAction(function () {
								var reloadScheduleAppsLink = document.getElementById('reloadPaginatorscheduleAppsBoxId');
								reloadScheduleAppsLink.click();
								setTimeout(closePopupForm, 700);
								setTimeout(function() {
									showReloadScheduleForm(showReloadScheduleFormURL);
								}, 10000);
								
								
							}, 'Appointments', 400);
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
