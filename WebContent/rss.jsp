<?xml version="1.0" encoding="UTF-8" ?>
<%@ page contentType="text/xml; charset=UTF-8" %>
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

pageContext.setAttribute("blog", b);

File styleFile = appConfig.getResourceFile("xslt/poortext.xslt");
StreamSource styleSource = new StreamSource(styleFile);
TransformerFactory transFactory = TransformerFactory.newInstance();
Transformer transformer = transFactory.newTransformer(styleSource);

%>
<rss version="2.0">
    <channel>
        <title>${blog.title}</title>
        <link>${blog.link}</link>
        <description>
		<%{ 
			XMLStreamReader item = ((Blog)pageContext.getAttribute("blog")).getDescription();
			StAXSource xml = new StAXSource(item);
			
			StreamResult result = new StreamResult(out);
			transformer.transform(xml, result);
		}%>
        </description>
        <language>nl-nl</language>
        <copyright>Copyright 2005 Tako Schotanus</copyright>
        <pubDate>Wed, 28 Dec 2005 01:38:56 +0100</pubDate>
        <webMaster>quintesse@palacio-cristal.com (Tako Schotanus)</webMaster>
        <managingEditor>quintesse@palacio-cristal.com (Tako Schotanus)</managingEditor>
		<c:forEach items="${blog.items}" var="item" >
			<%
			BlogItem item = (BlogItem)pageContext.getAttribute("item");
			%>
		    <item>
		        <title>${item.title}</title>
		        <description>
				<%{ 
					StAXSource xml = new StAXSource(item.getSummary());
					StreamResult result = new StreamResult(out);
					transformer.transform(xml, result);
				}%>
		        </description>
		        <pubDate>${item.date}</pubDate>
		        <author>quintesse@palacio-cristal.com (Tako Schotanus)</author>
		        <link>${item.link}</link>
		    </item>
		</c:forEach>
	</channel>
</rss>
