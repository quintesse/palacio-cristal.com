<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:txt="http://www.codejive.org/NS/portico/richtext"
	xmlns:code="http://www.codejive.org/NS/portico/code"
	version="1.0">

	<xsl:output omit-xml-declaration="yes" />

	<xsl:template match="/">
		<span class="richtext">
			<xsl:apply-templates />
		</span>
	</xsl:template>

	<xsl:template match="*">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="txt:link[@internal]">
		<a href="{@internal}" class="link internallink"><xsl:apply-templates /></a>
	</xsl:template>

	<xsl:template match="txt:link[@external]">
		<a href="{@external}" class="link externallink" target="_blank"><xsl:apply-templates /></a><img src="/images/link.png" class="extlink" width="13px" height="9px" />
	</xsl:template>

	<xsl:template match="txt:b">
		<b class="bold"><xsl:apply-templates /></b>
	</xsl:template>

	<xsl:template match="txt:i">
		<i class="italic"><xsl:apply-templates /></i>
	</xsl:template>

	<xsl:template match="txt:u">
		<u class="underline"><xsl:apply-templates /></u>
	</xsl:template>

	<xsl:template match="txt:para">
		<p/><xsl:apply-templates />
	</xsl:template>

	<xsl:template match="txt:code">
		<div class="code"><pre><code><xsl:apply-templates /></code></pre></div>
	</xsl:template>

	<xsl:template match="txt:quote">
		<div class="quote"><blockquote><xsl:apply-templates /></blockquote></div>
	</xsl:template>

	<xsl:template match="txt:list">
		<xsl:choose>
			<xsl:when test="(@type = 'ordered') or (@type = 'numbered')">
				<ol class="list orderedlist">
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
				<dl class="list definitionlist">
					<xsl:apply-templates select="txt:item" mode="definition" />
				</dl>
			</xsl:when>
			<xsl:otherwise>
				<ul class="list unorderedlist">
					<xsl:apply-templates select="txt:item" mode="simple" />
				</ul>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<xsl:template match="txt:item" mode="simple">
		<li class="listitem"><xsl:apply-templates /></li>
	</xsl:template>

	<xsl:template match="txt:item" mode="definition">
		<dt class="listitem listitemterm"><xsl:value-of select="@term" /></dt>
		<dd class="listitem listitemdescription"><xsl:apply-templates /></dd>
	</xsl:template>

	<xsl:template match="code:*">
		<span class="{local-name()}"><xsl:apply-templates /></span>
	</xsl:template>
</xsl:stylesheet>
