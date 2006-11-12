<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ page import="org.codejive.web.weblog.*" %>
<%@ page import="org.codejive.common.config.*" %>
<%@ page import="javax.xml.stream.*" %>
<%@ page import="javax.xml.transform.*" %>
<%@ page import="javax.xml.transform.stream.*" %>
<%@ page import="javanet.staxutils.StAXSource" %>
<%@ page import="java.io.File, java.net.URL" %>

<%

AppConfig appConfig = AppConfig.getInstance();
String blogName = request.getParameter("blog");
File f = appConfig.getResourceFile(blogName);
URL url = new URL("http://" + request.getServerName() + ":" + request.getServerPort() + "/" + blogName + "/");
Blog b = new FolderBlog(f, url);

URL feedUrl = new URL("http://" + request.getServerName() + ":" + request.getServerPort() + "/rss.jsp?blog=" + blogName);

pageContext.setAttribute("blog", b);

File styleFile = appConfig.getResourceFile("xslt/richtext.xslt");
StreamSource styleSource = new StreamSource(styleFile);
TransformerFactory transFactory = TransformerFactory.newInstance();
Transformer transformer = transFactory.newTransformer(styleSource);

String article = request.getParameter("article");

%>

<div class="page">

<div class="title">
	<a href="${blog.link}">${blog.title}</a>
</div>

<% if (article == null) { %>
<p>
<div class="subtitle">
	<%{ 
		XMLStreamReader item = ((Blog)pageContext.getAttribute("blog")).getDescription();
		StAXSource xml = new StAXSource(item);
		
		StreamResult result = new StreamResult(out);
		transformer.transform(xml, result);
	}%>
</div>
<% } %>

<c:forEach items="${blog.items}" var="item" >
	<%
	BlogItem item = (BlogItem)pageContext.getAttribute("item");
	if ((article == null) || (item.getLink().toString().endsWith(article))) {
	%>
	<p>
	<div class="history">
		<div class="header">
			<a href="${item.link}"><fmt:formatDate value="${item.date}" type="date" dateStyle="full"/></a>
		</div>
		<div class="text">
			<%{ 
				StAXSource xml = new StAXSource(item.getContent());
				StreamResult result = new StreamResult(out);
				transformer.transform(xml, result);
			}%>
			
			<div style="text-align:center">
			<c:forEach items="${item.media}" var="mediainfo" >
				<%
					MediaInfo info = (MediaInfo)pageContext.getAttribute("mediainfo");
					String mediaUrl = getRelativeFileUrl(info.getFile());
					out.print("<a href='" + mediaUrl + "'>");
					out.print("<img src='/imagefx/thumbnail" + mediaUrl + "'>");
					out.print("</a>");
				%>
			</c:forEach>
			</div>
		</div>
	</div>
	<%
	}
	%>
</c:forEach>

</div>

<br/>
<a href="<%= feedUrl.toString() %>"><img src="/images/RSS.png" width="36px" height="14px" alt="RSS feed" tooltip="Link to the RSS feed for this blog" /></a>

<%{
/*
	PeriodIterator i = new PeriodIterator((Collection)b.getItems());
	SortedMap<Integer, PeriodIterator> ys = i.getYears();
	for (PeriodIterator y : ys.values()) {
		out.println("<li>" + y.getKey());
		out.println("<ul>");
		SortedMap<Integer, PeriodIterator> ms = y.getMonths();
		for (PeriodIterator m : ms.values()) {
			out.println("<li>" + m.getKey());
			out.println("<ul>");
			SortedMap<Integer, PeriodIterator> ds = y.getDays();
			for (PeriodIterator d : ds.values()) {
				out.println("<li>" + d.getKey());
			}
			out.println("</ul>");
		}
		out.println("</ul>");
	}
*/
}%>
<%!

private String getRelativeFileUrl(File _file) {
	String rootPath = getServletContext().getRealPath("/");
	String filePath = _file.getAbsolutePath();
	return filePath.substring(rootPath.length() - 1);
}

%>
