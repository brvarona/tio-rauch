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


function showDrugRepresentativeInfo(drugRepresentativeId, showDrugRepresentativeInfoURL, drugRepFullName) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showDrugRepresentativeInfoURL, {
			method : 'GET',
			data: {
				_visitormanager_WAR_drugrepportlet_drugRepresentativeId: drugRepresentativeId
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

function showBlockDrugRepForm(showBlockDrugRepFormURL, drugRepresentativeId, surgeryId, companyId, compTerm, repTerm, drugRepName) {
	YUI().use('aui-io-request', function(A) {
		A.io.request(showBlockDrugRepFormURL, {
			method : 'GET',
			data: {
				_visitormanager_WAR_drugrepportlet_drugRepresentativeId: drugRepresentativeId,
				_visitormanager_WAR_drugrepportlet_sId: surgeryId,
				_visitormanager_WAR_drugrepportlet_companyId: companyId,
				_visitormanager_WAR_drugrepportlet_compTerm: compTerm,
				_visitormanager_WAR_drugrepportlet_repTerm: repTerm,
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

function showDrugRepInfo(elemId, drugReps) {

}

