<%@include file="/html/drugrepresentativereg/init.jsp" %>

<portlet:actionURL name="add" var="addDrugRepresentativeURL" />

<style>
.aui input[type="reset"] {
    margin-bottom: 11px;
    margin-top: 6px;
}
</style>
<script type="text/javascript">
var emailAlreadyExists = null;
</script>

<liferay-ui:error key="drug-representative-name-is-required" message="drug-representative-name-is-required" />
<liferay-ui:error key="dr-name-too-long" message="dr-name-too-long" />
<liferay-ui:error key="drug-representative-surname-is-required" message="drug-representative-surname-is-required" />
<liferay-ui:error key="dr-surname-too-long" message="dr-surname-too-long" />
<liferay-ui:error key="company-cell-phone-is-required" message="company-cell-phone-is-required" />
<liferay-ui:error key="company-cell-phone-too-long" message="company-cell-phone-too-long" />
<liferay-ui:error key="company-id-is-required" message="company-id-is-required" />
<liferay-ui:error key="company-email-is-required" message="company-email-is-required" />
<liferay-ui:error key="company-email-already-exists" message="company-email-already-exists" />
<liferay-ui:error key="company-email-is-invalid" message="company-email-is-invalid" />
<liferay-ui:error key="company-email-too-long" message="company-email-too-long" />
<liferay-ui:error key="first-line-product-is-required" message="first-line-product-is-required" />
<liferay-ui:error key="products-too-long" message="products-too-long" />
<liferay-ui:error key="country-id-is-required" message="country-id-is-required" />

<form action="<%=addDrugRepresentativeURL.toString() %>" method="post" id="drugRepAddForm" name="drugRepAddForm" onsubmit="javascript:submitDrugRepAddForm(this); return false;">

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
    <label class="control-label" for="mobilePhone">Company Mobile Phone:</label>
    <div class="controls">
      <input name="<portlet:namespace/>mobilePhone" id="mobilePhone" class="form-control" type="text">
    </div>
  </div>
  
  <div class="control-group">
    <label class="control-label" for="company">Company:</label>
    <div class="controls">
      <select name="<portlet:namespace/>company" id="company" class="form-control">
        <option value="-1">
          <liferay-ui:message key="please-choose" />
        </option>
        <c:forEach items="${companies}" var="company">
          <c:if test="${empty company.activeChildOrgs}">
            <option value="${company.id}">
              ${company.name}
            </option>
          </c:if>
          <c:if test="${not empty company.activeChildOrgs}">
            <optgroup label="${company.name}">
              <c:forEach items="${company.activeChildOrgs}" var="subcompany">
                <option value="${subcompany.organizationId}">
                  ${subcompany.name}
                </option>
              </c:forEach>
            </optgroup>
          </c:if>
        </c:forEach>
      </select>
    </div>
    If your company isn't in this list, please email support@rxtro.com , it will be updated within 24 hours
  </div>
  
  <div class="control-group">
    <label class="control-label" for="email">Company email:</label>
    <div class="controls">
      <input name="<portlet:namespace/>email" id="email" class="form-control" type="text" >
    </div>
  </div>
  
  <div class="control-group">
    <label class="control-label" for="firstLineProducts">First line products:</label>
    <div class="controls">
      <input name="<portlet:namespace/>firstLineProducts" id="firstLineProducts" class="form-control" type="text">
    </div>
  </div>
    
  <div class="control-group">
    <label class="control-label" for="otherProducts">Second line products:</label>
    <div class="controls">
      <input name="<portlet:namespace/>otherProducts" id="otherProducts" class="form-control" type="text">
    </div>
  </div>
  
  <div class="control-group">
    <label class="control-label" for="thirdLineProducts">Third line products:</label>
    <div class="controls">
      <input name="<portlet:namespace/>thirdLineProducts" id="thirdLineProducts" class="form-control" type="text">
    </div>
  </div>
  
 <div class="control-group">
    <label class="control-label" for="country">Country:</label>
    <div class="controls">
      <select name="<portlet:namespace/>country" id="country" class="form-control">
        <option value="32">
          Australia
        </option>
      </select>
    </div>
  </div>

  <input class="btn btn-info" type="submit" value="Submit">
  <input class="btn btn-primary" type="reset" value="Reset">

</form>

<portlet:resourceURL id="validateDrugRepEmail" var="validateDrugRepEmailURL" />


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
      rangeLength: [2, 50],
      required: true
    },
    <portlet:namespace/>company: {
        required: true,
        range: [0, 1000000]
    },
    <portlet:namespace/>mobilePhone: {
    	required: true,
    	rangeLength: [12, 12]
    },
    <portlet:namespace/>firstLineProducts: {
    	required: true,
    	rangeLength: [2, 50],
    },
    <portlet:namespace/>otherProducts: {
    	rangeLength: [2, 50],
    },
    <portlet:namespace/>thirdLineProducts: {
    	rangeLength: [2, 50],
    },
    <portlet:namespace/>country: {
    	required: true
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
    },
    <portlet:namespace/>company: {
      required: 'Please choose your company name',
      range: 'Please choose your company name'
    },
    <portlet:namespace/>mobilePhone: {
      required: 'Please provide your company mobile phone',
      rangeLength: 'Please provide 10 digits'
    },
    <portlet:namespace/>firstLineProducts: {
      required: 'Please provide your first line product'
    },
    <portlet:namespace/>country: {
      required: 'Please provide your country'
    }
  };
  
  validator = new Y.FormValidator({
    boundingBox: '#drugRepAddForm',
    fieldStrings: fieldStrings,
    rules: rules,
    showAllMessages: false
  });
});

jQuery(document).ready(function() {
  $('#boton_registrar').removeAttr("disabled");
  $('#mobilePhone').mask('0000 000 000');
});

function submitDrugRepAddForm(form) {
	try {
		validator.validate();
		if (!validator.hasErrors()) {
			validateDrugRepEmailAndSubmit('<%=validateDrugRepEmailURL.toString() %>');
		}
	} catch (e) {
		console.log('[ERROR] ' + e);
	}
}

function validateDrugRepEmailAndSubmit(validateEmailUrl) {
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
					if (response != null && response.email != null && response.email.length > 0) {
						emailAlreadyExists = response.email;
						validator.validate();
					} else {
						emailAlreadyExists = null;
						validator.validate();
						if (!validator.hasErrors()) {
							A.one('#drugRepAddForm').submit();
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