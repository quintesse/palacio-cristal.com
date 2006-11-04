
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta name="KEYWORDS" content="palacio de cristal, DeeEnEs dynamic IP updater, Easy Accent, digital photos, Nikon Coolpix 950, Nikon Coolpix 990">
	<meta name="DESCRIPTION" content="Palacio de Cristal contains is the home website of the programs DeeEnEs and Easy Accent and hosts a large selection of Digital Photographs as well">
	<meta name="AUTHOR" content="Tako Schotanus, Alkmaar, The Netherlands, http://palacio-cristal.com">
	<title>Palacio de Cristal</title>
	<link rel="stylesheet" type="text/css" href="/styles.css">
	<% if (request.getParameter("header") != null) { %>
	<jsp:include page="<%= getRootPath(request, request.getParameter("header")) %>" flush="true" />
	<% } %>
</head>

<body>
	<table class="mainTable" cellspacing="0" cellpadding="0">
		<tr>
			<td class="navBar" colspan="3"><jsp:include page="/PARTS/navbar.jsp" flush="true" /></td>
		</tr>
		<tr>
			<td colspan="3" height="10px">&nbsp;</td>
		</tr>
		<tr>
			<td class="menuBar"><jsp:include page="/PARTS/menu.jsp" flush="true" /></td>
			<td><img src="/images/spacer.gif" width="10" height="1"></td>
			<td class="contentBar"><jsp:include page="<%= getRootPath(request, request.getParameter("content")) %>" flush="true" /></td>
		</tr>
	</table>

</body>
</html>

<%!

private String getRootPath(HttpServletRequest request, String relPath) {
	String res = "";
	if (relPath.length() > 0) {
		if (!relPath.startsWith("/")) {
			res = request.getServletPath();
			int p = res.lastIndexOf('/');
			if (p >= 0) {
				res = res.substring(0, p + 1);
			}
			res += relPath;
		} else {
			res = relPath;
		}
	}
	return res;
}

%>
