var tmPortletId = '_territorymanager_WAR_drugrepportlet_';

function selectPage(nextPage, currentPage, pageSize, loadTableUrl) {
	if (nextPage != currentPage) {
		YUI().use('aui-io-request', function(A) {
			A.io.request(loadTableUrl, {
				method : 'GET',
				data: {
					_territorymanager_WAR_drugrepportlet_page_p: nextPage,
					_territorymanager_WAR_drugrepportlet_page_ps: pageSize
				},
				on : {
					success : function(e) {
						try {
							var response = this.get('responseData');
							if (response != null && !response.includes("<html")) { // !response.includes("<html") to prevent session timeout page
								document.getElementById('productListBoxId').innerHTML = response;
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
	} else {
		console.log('current page selected');
	}
}

function selectPageSize(nextPageSize, currentPageSize, loadTableUrl) {
	if (nextPageSize != currentPageSize) {
		YUI().use('aui-io-request', function(A) {
			A.io.request(loadTableUrl, {
				method : 'GET',
				data: {
					_territorymanager_WAR_drugrepportlet_page_p: 1,
					_territorymanager_WAR_drugrepportlet_page_ps: nextPageSize
				},
				on : {
					success : function(e) {
						try {
							var response = this.get('responseData');
							if (response != null && !response.includes("<html")) { // !response.includes("<html") to prevent session timeout page
								document.getElementById('productListBoxId').innerHTML = response;
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
	} else {
		console.log('current page size selected');
	}
}

function assignOrderToMe(assignOrderToRepURL, orderItemIds, loadTableUrl, rowId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(assignOrderToRepURL, {
			method : 'POST',
			dataType : 'json',
			data: {
				_territorymanager_WAR_drugrepportlet_orderItemIds: orderItemIds,
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						console.log(response);
						if (response != null) {
							if (response.error != null) {
								doAlert('Requests', response.error, 'red');
							} else if (response.success != null) {
								var row = document.getElementById(rowId);
								var assignedTo = row.querySelectorAll('[title="Assigned To"]')[0];
								assignedTo.innerHTML = "Me";
								var status = row.querySelectorAll('[title="Status"]')[0];
								status.innerHTML = "In Progress";
								var actions = row.querySelectorAll('[title="Actions"]')[0];
								actions.innerHTML = "";
								doAlert('Requests', 'Successfully assigned', 'green');
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
			zIndex: 30,
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
			        zIndex: 30,
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

var modalView;
function doPopupView(title, size) {
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
			width: size,
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

var doctorsAccurateValid = true;
function changeDoctorsAccurate(value) {	
	if (value == 0) {
		document.getElementById("labelWrongList").style.display = '';
		document.getElementById("repComment").style.display = '';
		doctorsAccurateValid = false;
	} else {
		document.getElementById("labelWrongList").style.display = 'none';
		document.getElementById("repComment").style.display = 'none';
		doctorsAccurateValid = true;
	}	
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

function buildId(id) {
	return tmPortletId + id;
}

function initOnRegionSelectorEvent(suburbUrl, selectedRegionId, selectedSuburbId) {
	var regionSelector = document.getElementById('regionSelector');
	regionSelector.suburbUrl = suburbUrl;
	addEvent('change', regionSelector, function(e) {
		var target = e.target || e.srcElement;
		searchSuburbs2(suburbUrl, target.value, -1);
	});
	//var suburbSelector = document.getElementById('suburbSelector');
	// suburbSelector.addEventListener('change', function(e) {
	// }, false);
	//updateSuburbSelector(suburbSelector, []);
	regionSelector.value = selectedRegionId;
	suburbSelector.value = selectedSuburbId;
	//searchSuburbs(selectedRegionId, selectedSuburbId);
}

function searchSuburbs(regionId, suburbId) {
	var suburbSelector = document.getElementById('suburbSelector');
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
		suburbSelector.value = suburbId;
	}, 0);
}

function searchSuburbs2(suburbUrl, regionId, suburbId) {
	YUI().use('aui-io-request', function(A) {
		var suburbSelector = document.getElementById('suburbSelector');
		selectLoadingMessage(suburbSelector);
		A.io.request(suburbUrl, {
			method : 'GET',
			dataType : 'json',
			data: {
				_territorymanager_WAR_drugrepportlet_regionId: regionId
			},
			on : {
				success : function() {
					var response = this.get('responseData');
					console.log(response);
					if (response != null) {
						updateSuburbSelector(suburbSelector, response);
					} else {
						updateSuburbSelector(suburbSelector, []);
					}
					suburbSelector.value = suburbId;
				}
			}
		});
	});
}

function addTerritory(addTerritoryURL, targetId, surgeryId, drugRepId, type, actionLinkId) {
	YUI().use('aui-io-request', function(A) {
		var actionLink = document.getElementById(actionLinkId).parentNode;
		actionLink.innerHTML = '<span class="loadingValue">Adding</span>';
		A.io.request(addTerritoryURL, {
			method : 'POST',
			dataType : 'json',
			data: {
				_territorymanager_WAR_drugrepportlet_targetId: targetId,
				_territorymanager_WAR_drugrepportlet_surgeryId: surgeryId,
				_territorymanager_WAR_drugrepportlet_drugRepId: drugRepId,
				_territorymanager_WAR_drugrepportlet_type: type
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							console.log('Add Territory response.');
							if (response.error != null) {
								console.log('Finish with error');
							} else {
								if (response.redirectAction != null) {
									document.location.href = response.redirectAction;
								} else {
									//DO SUCCESS ACTION;
									actionLink.parentNode.innerHTML = '<span class="bockedValue">Added</span>';
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

function cleanSelector(selector) {
	while(selector.firstChild) {
		selector.removeChild(selector.firstChild);
	}
}

function buildOptionGroup(label) {
	var optgroup = document.createElement('optgroup');
	optgroup.label = label;
	return optgroup;
}

function buildOption(value, text) {
	var option = document.createElement('option');
	option.value = value;
	option.innerHTML = text;
	return option;
}

function updateSuburbSelector(suburbSelector, suburbList) {
	cleanSelector(suburbSelector);
	var defOption = buildOption(-1, '(All Suburbs)');
	suburbSelector.appendChild(defOption);
	for (var i=0; i<suburbList.length; i++) {
		suburbSelector.appendChild(buildOption(suburbList[i].id, suburbList[i].name + ' (' + suburbList[i].postalCode + ')'));
	}
}

function selectLoadingMessage(selector) {
	cleanSelector(selector);
	selector.appendChild(buildOption(-1, '...loading'));
}

//Show form with notifications options.
function showEditNotificationsForm(territoryId, showEditNotificationsURL, editNotificationsURL) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(showEditNotificationsURL, {
			method : 'GET',
			data: {
				_territorymanager_WAR_drugrepportlet_territoryId: territoryId
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
								editNotifications(editNotificationsURL);
							}, 'Edit notifications', 400);
							
//							var overlayder = document.getElementById('overlayder');
//							overlayder.style.display = '';
//							var content = document.getElementById('editNotificationsContent');
//							content.style.display = '';
//							content.innerHTML = response;
//							var editNotificationsButton = document.getElementById("editNotificationsButton");
//							addEvent('click', editNotificationsButton, editNotifications);
//							editNotificationsButton.editNotificationsURL = editNotificationsURL;
//							var closeEditNotificationsButton = document.getElementById('closeEditNotificationsButton');
//							addEvent('click', closeEditNotificationsButton, closeEditNotificationsForm);
						}
					} catch (error) {
						console.log(error);
						var overlayder = document.getElementById('overlayder');
						if (overlayder != null) {
							overlayder.style.display = '';
						}
						var content = document.getElementById('editNotificationsContent');
						if (content != null) {
							content.style.display = '';
						}
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

//Edit Notifications.
function editNotifications(editNotificationsURL) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(editNotificationsURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'editNotificationsFm' },
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
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
						var overlayder = document.getElementById('overlayder');
						if (overlayder != null) {
							overlayder.style.display = '';
						}
						var content = document.getElementById('editNotificationsContent');
						if (content != null) {
							content.style.display = '';
						}
						popupMessage.className = 'popupMessage-error';
						popupMessage.innerHTML = 'Unexpected error: ' + error;
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
					popupMessage.className = 'popupMessage-error';
					popupMessage.innerHTML = 'Unexpected error: ' + error;
				}
			}
		});
	});
}

function showEditUserNotificationsForm(showEditUserNotificationsURL, editUserNotificationsURL) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(showEditUserNotificationsURL, {
			method : 'GET',
			data: {
			},
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
								editUserNotifications(editUserNotificationsURL);
							}, 'Edit notifications for all territories', 400);
						}
					} catch (error) {
						console.log(error);
						var overlayder = document.getElementById('overlayder');
						if (overlayder != null) {
							overlayder.style.display = '';
						}
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

function editUserNotifications(editUserNotificationsURL) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(editUserNotificationsURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'editNotificationsFm' },
			on : {
				success : function(e) {
					try {
						loadingMark.className = '';
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
						var overlayder = document.getElementById('overlayder');
						if (overlayder != null) {
							overlayder.style.display = '';
						}
						popupMessage.className = 'popupMessage-error';
						popupMessage.innerHTML = 'Unexpected error: ' + error;
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
					popupMessage.className = 'popupMessage-error';
					popupMessage.innerHTML = 'Unexpected error: ' + error;
				}
			}
		});
	});
}

function showMoreTerritoryInfo(showMoreTerritoryInfoURL, territoryId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showMoreTerritoryInfoURL, {
			method : 'GET',
			data: {
				_territorymanager_WAR_drugrepportlet_territoryId: territoryId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupView('Territory info', 800);
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

function showSelectDrugRepToTransferForm(showMyTeamListUrl, appId, transferAppToRepUrl, rowId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showMyTeamListUrl, {
			method : 'GET',
			data: {
				_territorymanager_WAR_drugrepportlet_appId: appId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
								transferAppToRep(transferAppToRepUrl, 'assignAppFm', rowId);
								//document.getElementById('assignAppFm').submit();
							}, 'Transfer Appointment', 400);
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

function transferAppToRep(transferAppToRepUrl, formId, rowId) {
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(transferAppToRepUrl, {
			method : 'POST',
			dataType : 'json',
			form: { id: formId },
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
									var row = document.getElementById(rowId);
									row.parentNode.parentNode.parentNode.parentNode.removeChild(row.parentNode.parentNode.parentNode);
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


function showAppReviewForm(showAppReviewFormURL, appointmentId, submitReviewFormURL, showAppReviewFormLinkId, removeRow) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showAppReviewFormURL, {
			method : 'GET',
			data: {
				_territorymanager_WAR_drugrepportlet_appId: appointmentId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function() {
								if (!doctorsAccurateValid && document.getElementById("repComment").value == "") {
									var popupMessage = document.getElementById('popupMessage');
									popupMessage.className = 'popupMessage-error';
									popupMessage.innerHTML = 'Please insert comment';
								} else {
									submitAppReview(submitReviewFormURL, showAppReviewFormLinkId, removeRow);
								}
							}, 'Attendants', 400);
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
			form: { id: 'drugRepReviewFm' },
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

function showTransferAppToColleagueForm(showTransferAppToColleagueFormURL, appId, drugRepId, territoryId, transferAppToColleagueURL, rowId) {
	YUI().use('aui-io-request', function(A) {
		var loadingMark = document.getElementById('loading-mark-container');
		loadingMark.className = loadingMark.id;
		A.io.request(showTransferAppToColleagueFormURL, {
			method : 'GET',
			data: {
				_territorymanager_WAR_drugrepportlet_appId: appId,
				_territorymanager_WAR_drugrepportlet_drugRepId: drugRepId,
				_territorymanager_WAR_drugrepportlet_territoryId: territoryId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function() {
								transferAppointmentToColleague(transferAppToColleagueURL, rowId);
							}, 'Colleagues', 400);
						} else {
							console.log("Empty response for showTransferAppToColleagueForm...");
						}
					} catch (error) {
						console.log(error);
					}
					loadingMark.className = "";
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

function transferAppointmentToColleague(transferAppToColleagueURL, rowId) {
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(transferAppToColleagueURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'transferAppFm' },
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
								var row = document.getElementById(rowId);
								row.parentNode.parentNode.parentNode.parentNode.removeChild(row.parentNode.parentNode.parentNode);
								setTimeout(closePopupForm, 700);
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

function removeSurgeryFromTerritory(removeSurgeryFromTerritoryUrl, territoryId, rowId) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(removeSurgeryFromTerritoryUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_territorymanager_WAR_drugrepportlet_territoryId: territoryId
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
							doAlert('My Territory', 'Territory removed', 'green');
						} else if (response.error) {
							doAlert('My Territory', response.error, 'red');
						} else {
							doAlert('My Territory', 'Could not perform this action.', 'red');
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

function cancelApp(cancelAppUrl, appId, surgeryId, rowId) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(cancelAppUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_territorymanager_WAR_drugrepportlet_appId: appId,
				_territorymanager_WAR_drugrepportlet_surgeryId: surgeryId
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
							doAlert('My Appointments', 'Appointment cancelled', 'green');
						} else if (response.error) {
							doAlert('My Appointments', response.error, 'red');
						} else {
							doAlert('My Appointments', 'Could not perform this action', 'red');
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

function transferAppToManager(transferAppToManagerUrl, appId, rowId) {
	var loadingMark = document.getElementById('loading-mark-container');
	loadingMark.className = loadingMark.id;
	YUI().use('aui-io-request', function(A) {
		A.io.request(transferAppToManagerUrl, {
			method : 'POST',
			dataType : 'json',
			data: {
				_territorymanager_WAR_drugrepportlet_appId: appId,
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
							doAlert('My Appointments', 'Appointment transfered', 'green');
						} else if (response.error) {
							doAlert('My Appointments', response.error, 'red');
						} else {
							doAlert('My Appointments', 'Could not perform this action', 'red');
						}
					} catch (error) {
						doAlert('My Appointments', 'Could not perform this action', 'red');
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

