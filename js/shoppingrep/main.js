var tmPortletId = '_shoppingrep_WAR_drugrepportlet_';

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

function saveEditOrder(editOrderURL, formId) {
	var popupMessage = document.getElementById('popupMessage');
	popupMessage.className = 'popupMessage';
	popupMessage.innerHTML = 'SAVING';
	AUI().use('aui-io-request', function(A) {
		A.io.request(editOrderURL, {
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

function showOrderItemDetail(showOrderItemDetailURL, editOrderURL, formId, orderId, editable) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showOrderItemDetailURL, {
			method : 'GET',
			data: {
				_shoppingrep_WAR_drugrepportlet_orderId: orderId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							console.log(response);
							document.getElementById('cb').innerHTML = response;
							if (editable) {
								doPopupForm(function() {
									saveEditOrder(editOrderURL, formId);
								}, 'Order Detail', 800);
							} else {
								doPopupView('Order Detail', 800);
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

function showOrderShippingDetail(showOrderShippingDetailURL, orderId) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showOrderShippingDetailURL, {
			method : 'GET',
			data: {
				_shoppingrep_WAR_drugrepportlet_orderId: orderId
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							console.log(response);
							document.getElementById('cb').innerHTML = response;
							doPopupView('Shipping Detail', 800);
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

function assignOrderToMe(assignOrderToRepURL, orderItemIds) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(assignOrderToRepURL, {
			method : 'POST',
			dataType : 'json',
			data: {
				_shoppingrep_WAR_drugrepportlet_orderItemIds: orderItemIds,
			},
			on : {
				success : function(e) {
					try {
						var response = this.get('responseData');
						if (response != null) {
							console.log('Assign Order To Rep response.');
							if (response.error != null) {
								console.log('Finish with error');
								console.log(response.error);
							} else {
								if (response.redirectAction != null) {
									document.location.href = response.redirectAction;
								} else {
									//DO SUCCESS ACTION;
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

function unassignOrder(unassignOrderURL, orderItemIds) {
	var ok = confirm("This will delete any progress you did, are you sure to continue?");
	if (ok) {
		YUI().use('aui-io-request', function(A) {
			A.io.request(unassignOrderURL, {
				method : 'POST',
				dataType : 'json',
				data: {
					_shoppingrep_WAR_drugrepportlet_orderItemIds: orderItemIds,
				},
				on : {
					success : function(e) {
						try {
							var response = this.get('responseData');
							if (response != null) {
								if (response.error != null) {
									console.log('Finish with error');
									console.log(response.error);
								} else {
									if (response.redirectAction != null) {
										document.location.href = response.redirectAction;
									} else {
										//DO SUCCESS ACTION;
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
}

function confirmOrder(confirmOrderURL, orderItemIds) {
	var ok = confirm("Are you sure to confirm this order?");
	if (ok) {
		YUI().use('aui-io-request', function(A) {
			A.io.request(confirmOrderURL, {
				method : 'POST',
				dataType : 'json',
				data: {
					_shoppingrep_WAR_drugrepportlet_orderItemIds: orderItemIds,
				},
				on : {
					success : function(e) {
						try {
							var response = this.get('responseData');
							if (response != null) {
								if (response.error != null) {
									console.log('Finish with error');
									console.log(response.error);
								} else {
									if (response.redirectAction != null) {
										document.location.href = response.redirectAction;
									} else {
										//DO SUCCESS ACTION;
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
}