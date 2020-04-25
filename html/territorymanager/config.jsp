<%@ page import="com.segmax.drugrep.model.Config" %>
<%@ page import="com.segmax.drugrep.service.ConfigLocalServiceUtil" %>

<%
	Boolean isTestEnv = Boolean.FALSE;
	try {
		Config testEnvConf = ConfigLocalServiceUtil.getByKey("TEST_ENV");
		if (testEnvConf != null) {
			isTestEnv = Boolean.valueOf(testEnvConf.getValue());
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>