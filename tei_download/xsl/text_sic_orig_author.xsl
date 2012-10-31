<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"  />
	<!--leerzeichen entfernen -->
	<xsl:strip-space elements="*"/>
 
	<xsl:template match="/">
		<xsl:apply-templates select="TEI/text/body/div/*" />		
	</xsl:template>
	
	<xsl:template match="p">
<xsl:text>

</xsl:text>
<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="reg"/>
	
	<xsl:template match="corr"/>
	
	<xsl:template match="sic">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="orig">
		<xsl:apply-templates/>
	</xsl:template>
 
	<xsl:template match="note">
		<xsl:choose>
			<xsl:when test="@resp='author'">
				<xsl:text> [</xsl:text> 
					<xsl:apply-templates/>
				<xsl:text>]</xsl:text> 
			</xsl:when>
			<xsl:when test="(@resp='editor')"/>
		</xsl:choose>
	</xsl:template>	
	
	<xsl:template match="pb">
		<xsl:choose>
			<xsl:when test="@n">[p.<xsl:value-of select="@n"/>]</xsl:when>
			<xsl:otherwise>[p.<xsl:value-of select="substring(@xml:id, 2,string-length(@xml:id))"/>]</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="index">
	</xsl:template>
	
</xsl:stylesheet>
