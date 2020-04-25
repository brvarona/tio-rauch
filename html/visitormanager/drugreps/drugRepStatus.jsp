<%@page import="com.segmax.drugrep.model.Drug_Representative_Blocked"%>
<%@page import="com.segmax.drugrep.service.Drug_Representative_BlockedLocalServiceUtil"%>
<%@ include file="/html/visitormanager/init.jsp" %>

<%
ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
String status = (String) row.getParameter("status");
Long drugRepId = (Long) row.getParameter("drugRepId");
Long surgeryId = (Long) row.getParameter("surgeryId");
Drug_Representative_Blocked blocked = null;
if (status.equals("Blocked")) {
	blocked = Drug_Representative_BlockedLocalServiceUtil.getDrugRepresentativeBlocked(surgeryId, drugRepId);
	System.out.println("blocked="+blocked);
}
String statusId = "status"+row.getRowId();
%>

<span id="<%=statusId%>" ><%=status %></span>

<%
if (blocked != null) { 
%>
<script>
var tdBlock = document.getElementById('<%=statusId%>').parentNode
tdBlock.id = 'p'+'<%=statusId%>';
tdBlock.title = "<%=blocked.getComment() %>";
YUI().use(
  'aui-tooltip',
  function(Y) {
    new Y.Tooltip(
      {
        trigger: '#p<%=statusId%>',
        position: 'left',
        zIndex: 10,
        visible: false
      }
    ).render();
  }
);
</script>
<%}%>