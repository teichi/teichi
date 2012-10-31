<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" href="book.css" type="text/css"/>
			</head>
			<body>
				<xsl:apply-templates select="TEI/text/body/div/*" />
			</body>
		</html>			
	</xsl:template>
	
<!-- ###############################################/ teiHeader/################################################ -->
<!-- ########################################################################################################### -->
<!-- ###  Der Inhalt von <teiHeader> wird nicht angezeigt, nur der Inhalt von <text>. Der Haupttext befindet ### -->
<!-- ###  sich in <body>                                                                                     ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="teiHEader">
	</xsl:template>
	
	
<!-- ##################################################/ div /################################################## -->
<!-- ########################################################################################################### -->
<!-- ###  Division, die großen Gliederungseinheiten des Textes: Vorwort, Kapitel, Index. Dies wird nicht     ### -->
<!-- ###  angezeigt, kann aber für die Verlinkung genutzt werden.                                            ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="div">
	</xsl:template>
	
<!-- ##################################################/ head /################################################# -->
<!-- ########################################################################################################### -->
<!-- ###  Beschreibung: Titel; eine Stufe größer als der Text, fett formatiert. Wenn zusätzlich rend=        ### -->
<!-- ###  "italic" gilt, dann zusätzlich kursiv.                                                             ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="head">
		<h1>
			<xsl:choose>
				<xsl:when test="@rend='italic'">
					<SPAN class="italic">
						<xsl:apply-templates />
					</SPAN>
				</xsl:when>
				<xsl:otherwise>					
						<xsl:apply-templates />					
				</xsl:otherwise>
			</xsl:choose>
		</h1> 
	</xsl:template>
	
<!-- ##################################################/ text /################################################# -->
<!-- ########################################################################################################### -->
<!-- ###  Beschreibung: Text enthaelt den gesamten Text des Kapitels                                         ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="text">
		<xsl:choose>
			<xsl:when test="@rend='italic'">
				<SPAN class="italic">
					<xsl:apply-templates />
				</SPAN>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!-- ###################################################/ p /################################################### -->
<!-- ########################################################################################################### -->
<!-- ###  Beschreibung: Absatz, Blocksatz, geringer Abstand zwischen Absätzen.                               ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="p">
		<p class="maincontent">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
<!-- ##################################################/ orig /################################################# -->
<!-- ########################################################################################################### -->
<!-- ###  Beschreibung: Hier wird standardmäßig der Inhalt von <reg> (regularisiert) oder <corr>             ### -->
<!-- ###  (korrigiert) angezeigt (Lesetext), bei Klicken auf ein entsprechendes Wort aber der Inhalt von     ### -->
<!-- ###  <orig> (Variante im Original) bzw. <sic> (falsch im Original). Alternative: bei Klicken auf ein    ### -->
<!-- ###  solches Wort oder einen bestimmten Button auf der Seite wird zwischen den beiden Anzeigemodi       ### -->
<!-- ###  Lesetext Originaltranskription gewechselt; dann müssen aber alle Regularisierungen getagt werden.  ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="choice">		
			<xsl:apply-templates /> 	
	</xsl:template>
	
	<xsl:template match="reg">
		<xsl:choose>	
			<xsl:when test="string-length() = 0">
				<span class="choice reg">
					&#xA0;
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="choice reg">
					<xsl:apply-templates />
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="corr">
		<xsl:choose>	
			<xsl:when test="string-length() = 0">
				<span class="choice corr">
					&#xA0;
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="choice corr">
					<xsl:apply-templates />
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="sic">
		<xsl:choose>	
			<xsl:when test="string-length() = 0">
				<span class="choice sic">
					&#xA0;
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="choice sic">
					<xsl:apply-templates />
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="orig">
		<xsl:choose>	
			<xsl:when test="string-length() = 0">
				<span class="choice orig">
					&#xA0;
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="choice orig">
					<xsl:apply-templates />
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
 
	
<!-- ##################################################/ index /################################################ -->
<!-- ########################################################################################################### -->
<!-- ###  Beschreibung: Der Inhalt von <index> wird hier nicht angezeigt, sondern zur Generierung des Index  ### -->
<!-- ###  und der Indexeinträge genutzt.                                                                     ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="index">
	</xsl:template>
	
	
<!-- ####################################################/ hi /################################################# -->
<!-- ########################################################################################################### -->
<!-- ###  Beschreibung: Hervohebung eines oder mehrerer Worte, durch Kursivierung.                           ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="hi">
		<span class="hi">
			<xsl:apply-templates />
		</span>
	</xsl:template>
	
<!-- ##################################################/ bibl /################################################# -->
<!-- ########################################################################################################### -->
<!-- ###  Das Tag <bibl> kann überall im Text und den Anmerkungen vorkommen, wird aber normalerweise nicht   ### -->
<!-- ###  besonders angezeigt.                                                                               ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="bibl">
		<xsl:apply-templates />
	</xsl:template>
	
	<!--########################################################################################################### -->
<!-- ###  Beschreibung: Es gibt zwei Arten von Anmerkungen, die des Autors, die im Originalbuch schon sind,  ###--> 
<!-- ###  und die des Herausgebers, mit denen weitere Informationen und Erklärungen gegeben werden können.   ### -->
<!-- ###  Diese	werden sowohl für die Anzeige als auch für die Suchfunktion unterschieden. Eine dritte Art   ### -->
<!-- ###  von Anmerkungen ist <note resp="internal">Vorübergehende Bearbeitungsnotizen</note>, die dafür     ### -->
<!-- ###  dient, interne Vermerke einzufügen, die im Quelltext auffindbar sind, aber nicht angezeigt werden. ### -->
<!-- ###  (Evtl. sollten diese auch von der Online-Suchfunktion	ausgeschlossen werden.)                      ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="note">
		<xsl:choose>
			<xsl:when test="@resp='author'">
				<span class="note author"> 
					<xsl:text> [</xsl:text> 
					<xsl:apply-templates />
					<xsl:text>]</xsl:text> 
				</span>
			</xsl:when>
			<xsl:when test="(@resp='editor')">
				<span class="note editor"> 
					<xsl:text> [Ed.: </xsl:text> 
					<xsl:apply-templates />
					<xsl:text>]</xsl:text> 
				</span>
			</xsl:when>
		</xsl:choose>
	</xsl:template>	
	
<!-- ##################################################/ quote /################################################ -->
<!-- ########################################################################################################### -->
<!-- ###  Beschreibung: Anmerkungen                                                                          ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="quote">
		<xsl:choose>
			<!-- rend="inline" => Das Zitat bleibt im Fließtext, aber mit französischen Anführungszeichen. -->
			<!-- «&#160; geschütztes Leerzeichen -->
			<xsl:when test="@rend='inline'">
				<xsl:text>«&#160;</xsl:text> 
				<xsl:apply-templates />
				<xsl:text>&#160;»</xsl:text>
			</xsl:when>
			<!-- rend="block"  => Das Zitat wird als separater Absatz formatiert, eine Stufe
              kleiner, mit geringem Einzug, nicht kursiv, keine Anführungszeichen -->
			<xsl:when test="@rend='block'">
				<span class="quote block"> 
					<xsl:apply-templates />
				</span>
			</xsl:when>
			<xsl:when test="@rend='verse'">
				<span class="quote verse">
					<xsl:apply-templates />
				</span>
			</xsl:when>
			<xsl:otherwise>
			<!-- rend="italic" => Das Zitat bleibt im Fließtext, aber ohne Anführungszeichen, statt
              dessen kursiv -->
				<span class="quote italic">
					<xsl:apply-templates />
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!-- ###################################################/ lb /################################################## -->
<!-- ########################################################################################################### -->
<!-- ###  Erzwungener Zeilenumbruch, kommt evtl. in <quote rend="verse"> vor.                                ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="lb">
		<br></br>
			<xsl:apply-templates />
	</xsl:template>
	
<!-- ###################################################/ pb /################################################## -->
<!-- ########################################################################################################### -->
<!-- ###neue Seite (Angabe der Seitenzahl. Diese muss dann auch ander entsprechenden Stelle angezeigt werden,### -->
<!-- ###vom	umliegenden Text abgesetzt: [123])																 ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="pb">
		<xsl:choose>
			<xsl:when test="@n">
				[p.<xsl:value-of select="@n"/>]	
			</xsl:when>
			<xsl:otherwise>
				[p.<xsl:value-of select="substring(@xml:id, 2,string-length(@xml:id))"/>]
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

<!-- ##################################################/ ref /################################################## -->
<!-- ########################################################################################################### -->
<!-- ###  Die Definition der externen Links kann einfach über URI/URL erfolgen. Angezeigt 	werden sollen    ### -->
<!-- ###  diese Links dann in einer üblichen Form, bspw. dunkelblaue Schrift, auf eine Unterstreichung kann  ### -->
<!-- ###  verzichtet werden.                                                                                 ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="ref">
		<xsl:apply-templates />
	</xsl:template>
	
<!-- ###################################################/ lg /################################################## -->
<!-- ########################################################################################################### -->
<!-- ###  Linegroup und Lines. Separater Absatz, kleiner Einzug links, Zeilenumbruch für jede Zeile,         ### -->
<!-- ###  Schriftgröße eine Stufe kleiner als Text.                                                          ### -->
<!-- ########################################################################################################### -->
	<xsl:template match="lg">
		<!-- <xsl:apply-templates /> -->
	</xsl:template>

	<xsl:template match="l">
		<xsl:choose>
			<xsl:when test="@rend='indent'">		
				<!--  <br></br>  style="font-size:13px;" -->
				<!-- leerzeichen -->
				<span class="ll">&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
					<xsl:apply-templates />
					<br/>
				</span>
			</xsl:when>
			<xsl:otherwise>
			<!-- <br></br> -->
				<!-- leerzeichen -->
				<span class="ll">&#xA0;
					<xsl:apply-templates />
					<br/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		
</xsl:stylesheet>
