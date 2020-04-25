<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<portlet:defineObjects />
 
<liferay-ui:error key="empty-file" message="The file upload is empty" />
<liferay-ui:error key="exception-error" message="Error while processing the file" />

<portlet:resourceURL var="downloadURL"></portlet:resourceURL>


<b>Please Upload a CSV Document</b> 
<br><br>
<aui:form action="<%= downloadURL %>" enctype="multipart/form-data" method="POST" id="fm" > 
	<aui:input id="file1" type="file" cssClass="file" name="fileupload" accept=".csv" />	
	<aui:button type="button" cssClass="process" value="Process" onclick="submitForm();" disabled="true" /> 
</aui:form>


<script type="text/javascript" charset="utf-8">    
AUI().ready(function(A) {
	A.one('.file').on('change',function(){
        var name = A.one('.file').get("value");
        var ext = name.substring(name.lastIndexOf('.') + 1).toLowerCase();
     	if (ext == "csv"){
          A.one('.process').set('disabled', false);
          A.one('.process').removeClass('disabled');             
        } else {
           	A.one('.process').set('disabled', true);
            A.one('.process').addClass('disabled');             

        }
     	return false;
   });
});

function submitForm(){
    document.<portlet:namespace />fm.submit();
    return false;
}
</script> 