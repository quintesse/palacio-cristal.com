<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:txt="http://www.codejive.org/NS/portico/richtext"
	version="1.0">

	<xsl:output omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="*">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="txt:link[@internal]">
		<a href="{@internal}"><xsl:apply-templates /></a>
	</xsl:template>

	<xsl:template match="txt:link[@external]">
		<a href="{@external}"><xsl:apply-templates /></a>
	</xsl:template>

	<xsl:template match="txt:b">
		<b><xsl:apply-templates /></b>
	</xsl:template>

	<xsl:template match="txt:i">
		<i><xsl:apply-templates /></i>
	</xsl:template>

	<xsl:template match="txt:u">
		<u><xsl:apply-templates /></u>
	</xsl:template>

	<xsl:template match="txt:para">
		<p/><xsl:apply-templates />
	</xsl:template>

	<xsl:template match="txt:code">
		<pre><code><xsl:apply-templates /></code></pre>
	</xsl:template>

	<xsl:template match="txt:quote">
		<blockquote><xsl:apply-templates /></blockquote>
	</xsl:template>

	<xsl:template match="txt:list">
		<xsl:choose>
			<xsl:when test="(@type = 'ordered') or (@type = 'numbered')">
				<ol>
					<xsl:if test="@number-type">
						<xsl:attribute name="type"><xsl:value-of select="@number-type"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="@start">
						<xsl:attribute name="start"><xsl:value-of select="@start"/></xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="txt:item" mode="simple" />
				</ol>
			</xsl:when>
			<xsl:when test="@type = 'definition'">
				<dl>
					<xsl:apply-templates select="txt:item" mode="definition" />
				</dl>
			</xsl:when>
			<xsl:otherwise>
				<ul>
					<xsl:apply-templates select="txt:item" mode="simple" />
				</ul>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<xsl:template match="txt:item" mode="simple">
		<li><xsl:apply-templates /></li>
	</xsl:template>

	<xsl:template match="txt:item" mode="definition">
		<dt><xsl:value-of select="@term" /></dt>
		<dd><xsl:apply-templates /></dd>
	</xsl:template>
</xsl:stylesheet>
