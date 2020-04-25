<%@page import="com.rxtro.core.common.utils.StringUtil"%>
<%@ include file="/html/visitormanager/init.jsp" %>

<%
ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
List<String> drugReps = (List<String>) row.getParameter("drugReps");
String showDrugRepInfoId = "showDrugRepInfo" + String.valueOf(row.getPos());
String drugRepsArray = StringUtil.listToStringArray(drugReps);

if (drugReps != null && drugReps.size() > 0) {
%>

<%-- <liferay-ui:icon-menu> --%>
<%-- 	<liferay-ui:icon id="<%=showDrugRepInfoId %>" image="page" message="Drug Reps" url="javascript:;" /> --%>
<%-- </liferay-ui:icon-menu> --%>

<button id="<%=showDrugRepInfoId %>" class="btn btn-primary">Drug Reps</button>

<portlet:resourceURL id="showDrugRepInfo" var="showDrugRepInfoURL" />
<script>
<%-- var showDrugRepInfoButton = document.getElementById('<portlet:namespace /><%= showDrugRepInfoId %>'); --%>
// if (showDrugRepInfoButton != null) {
// 	addEvent('click', showDrugRepInfoButton, function() {
<%-- 		var reps = "<%=drugRepsArray %>".replace(/'/g, '"'); --%>
// 		reps = JSON.parse(reps);
<%-- 		showDrugRepInfo('<%= showDrugRepInfoId %>', reps); --%>
// 	});
// }
var drugReps = "<%=drugRepsArray %>".replace(/'/g, '"');
drugReps = JSON.parse(drugReps);
var reps = '';
for (var i=0; i<drugReps.length; i++) {
	reps += drugReps[i];
	reps += '<br />';
}
YUI().use(
		  'aui-popover',
		  'widget-anim',
		  function(A) {
		    var triggerAnim = A.one('#' + '<%=showDrugRepInfoId %>');

		    var popoverAnim = new A.Popover(
		      {
		        align: {
		          node: triggerAnim,
		          points:[A.WidgetPositionAlign.RC, A.WidgetPositionAlign.LC]
		        },
		        bodyContent: reps,
		        headerContent: 'Drug Reps <span class="close-popover-x" onclick="document.body.activePopover.hide()">X</span>',
		        plugins: [A.Plugin.WidgetAnim],
		        position: 'left',
		        zIndex: 30,
		        id: 'prod-popover<%=row.getPos()%>',
		        visible: false,
		      }
		    ).render();

		    triggerAnim.on(
		      'click',
		      function() {
		    	if (document.body.activePopover != null && document.body.activePopover != popoverAnim) {
		    		document.body.activePopover.hide();
		    	}
		        popoverAnim.set('visible', !popoverAnim.get('visible'));
		        document.body.activePopover = popoverAnim;
		        if (popoverAnim.get('visible')) {
		        	var topValue = document.getElementById(popoverAnim._posNode._node.id).style.top;
		        	topValue = topValue.substr(0, topValue.length-2);
		        	topValue = parseInt(topValue) + 40;
		        	document.getElementById(popoverAnim._posNode._node.id).style.top = topValue + 'px';
		        	
		        	var leftValue = document.getElementById(popoverAnim._posNode._node.id).style.left;
		        	leftValue = leftValue.substr(0, leftValue.length-2);
		        	leftValue = parseInt(leftValue) - 50;
		        	document.getElementById(popoverAnim._posNode._node.id).style.left = leftValue + 'px';
		        }
		      }
		    );
		  }
		);

</script>

<%
}
%>