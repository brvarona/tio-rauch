<%@include file="/html/territorymanager/init.jsp" %>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>

<%
DrugRepModel drugRep = DrugRepUtil.buildByUserId(themeDisplay.getUserId());
%>