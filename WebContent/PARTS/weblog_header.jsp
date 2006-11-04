<%@ page import="org.codejive.web.weblog.*" %>
<%@ page import="org.codejive.common.config.*" %>
<%@ page import="java.io.File, java.net.URL" %>

<%

AppConfig appConfig = AppConfig.getInstance();
String blogName = request.getParameter("blog");
File f = appConfig.getResourceFile(blogName);
URL url = new URL("http://" + request.getServerName() + ":" + request.getServerPort() + "/" + blogName + "/");
Blog b = new FolderBlog(f, url);

pageContext.setAttribute("blog", b);
pageContext.setAttribute("blogpath", blogName);

%>

<link rel="alternate" type="application/rss+xml" title="${blog.title} RSS Feed" href="/rss.jsp?blog=${blogpath}" />
