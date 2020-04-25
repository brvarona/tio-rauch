<%@include file="/html/surgerymanager/init.jsp" %>

<aui:form name="cancelAppForm" class="popupForm">
	<h4>Please select the reason for your cancellation<h4>
	<br>
	<aui:select name="" cssClass="select" onChange="changeCancelReason();">
		<c:forEach items="${cancelReasonsList}" var="option">
                <aui:option value="${option.getLabel()}" >
                	<c:out value="${option.getLabel()}"></c:out>
                </aui:option>
        </c:forEach>				
	</aui:select>
	<aui:input placeholder="Other Reason" cssClass="input_other" type="textarea" maxlength="150" style="display: none" name=""/>
</aui:form>


