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

	<xsl:template match="txt:list">
		<xsl:choose>
			<xsl:when test="@type = 'definition'">
				<xsl:apply-templates select="txt:item" mode="definition" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="txt:item" mode="simple" />
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<xsl:template match="txt:item" mode="simple">
		* <xsl:apply-templates />
	</xsl:template>

	<xsl:template match="txt:item" mode="definition">
		* <xsl:value-of select="@term" /> - <xsl:apply-templates />
	</xsl:template>
</xsl:stylesheet>
