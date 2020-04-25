// POPUP

var modalForm;
function doPopupForm(doSave, title) {
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
			        width: 400,
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

function addEvent(evnt, elem, func) {
	   if (elem.addEventListener)  // W3C DOM
	      elem.addEventListener(evnt,func,false);
	   else if (elem.attachEvent) { // IE DOM
	      elem.attachEvent("on"+evnt, func);
	   } else { // No much to do
	      elem[evnt] = func;
	   }
}
// -- POPUP

// JS ACTIONS

function showBlockDrugRepForm(showBlockDrugRepFormURL, blockDrugRepURL, drugRepId, surgeryId, drugRepName, xblockButtonId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showBlockDrugRepFormURL, {
			method : 'GET',
			data: {
				_findrepresentatives_WAR_drugrepportlet_drugRepId: drugRepId,
				_findrepresentatives_WAR_drugrepportlet_surgeryId: surgeryId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
								submitBlockDrugRep(blockDrugRepURL, xblockButtonId);
							}, 'Block ' + drugRepName);
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

function submitBlockDrugRep(blockDrugRepURL, xblockButtonId) {
	AUI().use('aui-io-request', function(A) {
		var popupMessage = document.getElementById('popupMessage');
		popupMessage.className = 'popupMessage';
		popupMessage.innerHTML = 'SAVING';
		A.io.request(blockDrugRepURL, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'blockDrugRepForm' },
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
									var blockButton = document.getElementById('block' + xblockButtonId);
									blockButton.parentNode.parentNode.className = 'hidden';
									var unblockButton = document.getElementById('unblock' + xblockButtonId);
									unblockButton.parentNode.parentNode.className = 'last';
									
									var linkedTitleBox = document.getElementById('linkedTitleId'+response.drugRepId);
									linkedTitleBox.className = 'blockedTitle';
									linkedTitleBox.innerHTML = 'Blocked';
									
									var linkedDetailBox = document.getElementById('linkedDetailId'+response.drugRepId);
									linkedDetailBox.innerHTML = response.reason;
								}
							}
						} else {
							popupMessage.className = 'popupMessage-error';
							popupMessage.innerHTML = 'Not response';
						}
					} catch (error) {
						console.log(error);
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

function unblockDrugRep(unblockDrugRepUrl, surgeryId, drugRepId, drugRepName, xblockButtonId) {
	var ok = confirm("Are you sure you wish to unblock "+drugRepName);
	if (ok) {
		YUI().use('aui-io-request', function(A) {
			A.io.request(unblockDrugRepUrl, {
				method : 'POST',
				data: {
					_findrepresentatives_WAR_drugrepportlet_drugRepId: drugRepId,
					_findrepresentatives_WAR_drugrepportlet_surgeryId: surgeryId
				},
				on : {
					success : function(e) {
						try {
							var response = this.get('responseData');
							if (response != null) {
								if (response.error != null) {
									console.log(response.error);
								} else {
									var blockButton = document.getElementById('block' + xblockButtonId);
									blockButton.parentNode.parentNode.className = '';
									var unblockButton = document.getElementById('unblock' + xblockButtonId);
									unblockButton.parentNode.parentNode.className = 'last hidden';
									console.log('Drug Rep unblocked');
									
									var linkedTitleBox = document.getElementById('linkedTitleId'+drugRepId);
									linkedTitleBox.className = 'notLinkedTitle';
									linkedTitleBox.innerHTML = 'Not Linked';
									
									var linkedDetailBox = document.getElementById('linkedDetailId'+drugRepId);
									linkedDetailBox.innerHTML = '';
									
								}
							} else {
								console.log('Not response while unblock drug rep '+drugRepId);
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
}

function showBlockDrugRepForm11(showBlockDrugRepFormURL, drugRepresentativeId, surgeryId, companyId, compTerm, repTerm, drugRepName) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showBlockDrugRepFormURL, {
			method : 'GET',
			data: {
				_findrepresentatives_WAR_drugrepportlet_drugRepresentativeId: drugRepresentativeId,
				_findrepresentatives_WAR_drugrepportlet_sId: surgeryId,
				_findrepresentatives_WAR_drugrepportlet_companyId: companyId,
				_findrepresentatives_WAR_drugrepportlet_compTerm: compTerm,
				_findrepresentatives_WAR_drugrepportlet_repTerm: repTerm,
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							document.getElementById('cb').innerHTML = response;
							doPopupForm(function () {
								document.forms.blockDrugRrepresentativeForm.submit();
							}, 'Block ' + drugRepName);
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


