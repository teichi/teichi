<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template match="/">
		<name>
			<corr_reg><xsl:apply-templates select="TEI/text/body/div/head" mode="corr_reg"/></corr_reg>
			<sic_orig><xsl:apply-templates select="TEI/text/body/div/head" mode="sic_orig"/></sic_orig>	
		</name>
	</xsl:template>
	
	<xsl:template match="reg" mode="corr_reg">
		<xsl:apply-templates mode="corr_reg"/>
	</xsl:template>
	
	<xsl:template match="corr" mode="corr_reg">
		<xsl:apply-templates mode="corr_reg"/>
	</xsl:template>
	
	<xsl:template match="sic" mode="corr_reg"/>
	
	<xsl:template match="orig" mode="corr_reg"/>
	
	
	<xsl:template match="reg" mode="sic_orig"/>
	
	<xsl:template match="corr" mode="sic_orig"/>
	
	<xsl:template match="sic" mode="sic_orig">
		<xsl:apply-templates mode="sic_orig"/>
	</xsl:template>
	
	<xsl:template match="orig" mode="sic_orig">
		<xsl:apply-templates mode="sic_orig"/>
	</xsl:template>
	
</xsl:stylesheet>
