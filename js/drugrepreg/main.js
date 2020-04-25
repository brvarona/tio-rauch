
function validateDrugRepForm(validateUrl) {
	console.log('URL: ' + validateUrl);
	AUI().use('aui-io-request', function(A) {
		A.io.request(validateUrl, {
			method : 'POST',
			dataType : 'json',
			form: { id: 'drugRepAddForm' },
			on : {
				success : function() {
					var response = this.get('responseData');
					console.log(response);
					if (response != null) {
					} else {
						
					}
				}
			},
			error: function(e) {
				console.log('Error: ' + e);
			}
		});
	});
}
