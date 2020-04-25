<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<script type="text/javascript">
var emailAlreadyExists = null;
</script>

<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="20" />
</liferay-util:include>

<h2>Nurse</h2>

<liferay-ui:error key="unexpected-error" message="There was a problem, please contact us"/>

<portlet:actionURL name="addNurse" var="addNurseURL" />
<form action="<%=addNurseURL.toString() %>" method="post" id="nurseAddForm" name="nurseAddForm" onsubmit="javascript:submitNurseAddForm(this); return false;">
  
  <div class="control-group">
    <label class="control-label" for="firstName">First Name:</label>
    <div class="controls">
      <input name="<portlet:namespace/>firstName" id="firstName" class="form-control" type="text">
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="lastName">Last Name:</label>
    <div class="controls">
      <input name="<portlet:namespace/>lastName" id="lastName" class="form-control" type="text">
    </div>
  </div>
  
  <div class="control-group">
    <label class="control-label" for="email">Email:</label>
    <div class="controls">
      <input name="<portlet:namespace/>email" id="email" class="form-control" type="text" >
    </div>
  </div>
  
  <div class="control-group">
	  <label class="control-label" for="gender">Gender:</label>
	  <select name="<portlet:namespace/>gender" id="gender">
	  	<option value="0">Male</option>
	  	<option value="1">Female</option>
	  </select>
  </div>
  
  <input class="btn btn-info" type="submit" value="Submit">
  <input class="btn btn-primary" type="reset" value="Reset">
  
</form>

<portlet:resourceURL id="validateUserEmail" var="validateUserEmailURL" />

<script type="text/javascript">
var validator;
YUI().use('aui-form-validator', function(Y) {
  var DEFAULTS_FORM_VALIDATOR = Y.config.FormValidator;
  Y.mix(
    DEFAULTS_FORM_VALIDATOR.RULES, {
      customRuleForEmailRegistered: function (val, fieldNode, ruleValue) {
        return val !== emailAlreadyExists;
      }
    },
	true
  );
  Y.mix(
    DEFAULTS_FORM_VALIDATOR.STRINGS, {
      customRuleForEmailRegistered:"The email address you have entered is already registered."
    },
    true
  );
  
  var rules = {
    <portlet:namespace/>email: {
      email: true,
      required: true,
      customRuleForEmailRegistered: true
    },
    <portlet:namespace/>firstName: {
      required: true,
      rangeLength: [2, 50]
    },
    <portlet:namespace/>lastName: {
      required: true,
      rangeLength: [2, 50]
    },
    <portlet:namespace/>picture: {
      acceptFiles: 'jpg, gif, png',
      required: true
    },
    <portlet:namespace/>url: {
      url: true
    },
    <portlet:namespace/>emailConfirmation: {
      email: true,
      equalTo: '#email',
      required: true
    }
  };
  
  var fieldStrings = {
    <portlet:namespace/>email: {
      required: 'Type your company email in this field.',
      exist: 'This email is not availble.'
    },
    <portlet:namespace/>firstName: {
      required: 'Please provide your first name.'
    },
    <portlet:namespace/>lastName: {
      required: 'Please provide your last name.'
    }
  };
  
  validator = new Y.FormValidator({
    boundingBox: '#nurseAddForm',
    fieldStrings: fieldStrings,
    rules: rules,
    showAllMessages: false
  });
});

function submitNurseAddForm(form) {
	try {
		validator.validate();
		if (!validator.hasErrors()) {
			validateUserEmailAndSubmit('<%=validateUserEmailURL.toString() %>');
		}
	} catch (e) {
		console.log('[ERROR] ' + e);
	}
}

function validateUserEmailAndSubmit(validateEmailUrl) {
	console.log('URL: ' + validateEmailUrl);
	YUI().use('aui-io-request', function(A) {
		A.io.request(validateEmailUrl, {
			method : 'POST',
			dataType : 'json',
			data: { 
				<portlet:namespace/>email: A.one('#email').get('value')
			},
			on : {
				success : function() {
					var response = this.get('responseData');
					console.log(response);
					if (response != null && response.email != null && response.email.length > 0) {
						emailAlreadyExists = response.email;
						validator.validate();
					} else {
						emailAlreadyExists = null;
						validator.validate();
						if (!validator.hasErrors()) {
							var ok = confirm("Please confirm the email: " + A.one('#email').get('value'));
							if (ok) {
								A.one('#nurseAddForm').submit();
							}
						}
					}
				}
			},
			error: function(e) {
				console.log('Error: ' + e);
			}
		});
	});
}
</script>
