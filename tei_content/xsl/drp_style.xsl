<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <xsl:apply-templates select="TEI/text/body/div/*" />
        <div id="pageindex"><b>Index</b>
            <a href="javascript:Drupal.teichiTogglePageIndex();">
                <span style="display:block;text-align:center;margin-top:5px;">
                    <img src="/drupal-7/sites/all/modules/tei_content/img/index.png" width="78" height="7" />
                </span>
            </a>
            <ul>
                <xsl:for-each select="//pb">
                     <li>
                         <a class="pageindexlink">
                            <xsl:attribute name='href'>
                                <xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/>
                            </xsl:attribute>
                            <!-- siehe Kommentar unten -->
                            p.<xsl:value-of select="substring(@xml:id, 2,string-length(@xml:id))"/>
                        </a>
                                   
                     </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
    
    
    <!-- ##########################################  / teiHeader /############################################## -->
    <!-- ####################################################################################################### -->
    <!-- ##################  Contents are not currently displayed in HTML output.############################### -->
    <!-- ###                                                                                                 ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="teiHeader">
    </xsl:template>
    
    
    
    <!-- ##################################################/ div /############################################## -->
    <!-- ####################################################################################################### -->
    <!-- ###  Major divisions of text; is not being displayed, but used for linking purposes.                ### -->
    <!-- ###                                                                                                 ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="div">
    </xsl:template>
    
    
    
    <!-- ################################################/ head /############################################### -->
    <!-- ####################################################################################################### -->
    <!-- ###  Title of headings (div level) one step larger, bold. Can be italic.                            ### -->
    <!-- ###                                                                                                 ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="head">
        <h1>
            <xsl:choose>
                <xsl:when test="@rend='italic'">
                    <span class="italic">
                        <xsl:apply-templates />
                    </span>
                </xsl:when>
                <xsl:otherwise>                    
                        <xsl:apply-templates />                    
                </xsl:otherwise>
            </xsl:choose>
        </h1> 
    </xsl:template>
    
    
    
    <!-- ################################################/ text /############################################### -->
    <!-- ####################################################################################################### -->
    <!-- ### Contains the complete text of the chapter.                                                      ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="text">
        <xsl:choose>
            <xsl:when test="@rend='italic'">
                <span class="italic">
                    <xsl:apply-templates />
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <!-- #################################################/ p /################################################# -->
    <!-- ####################################################################################################### -->
    <!-- ###  Paragraph: align:block, line height 1.8                                                        ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="p">
        <p class="maincontent">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    
    <!-- ################################################/ choice /############################################# -->
    <!-- ####################################################################################################### -->
    <!-- ###  Choice groups three sets of alternative text views: sic/corr, reg/orig, abbr/expan.            ### -->
    <!-- ###  The bottom toolbar lets the reader toggle between the two readings.                            ### -->
    <!-- ####################################################################################################### -->

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
    
    <xsl:template match="abbr">
        <xsl:choose>    
            <xsl:when test="string-length() = 0">
                <span class="choice abbr">
                    &#xA0;
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="choice abbr">
                    <xsl:apply-templates />
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="expan">
        <xsl:choose>    
            <xsl:when test="string-length() = 0">
                <span class="choice expan">
                    &#xA0;
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="choice expan">
                    <xsl:apply-templates />
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    
    <!-- ################################################/ index /############################################## -->
    <!-- ####################################################################################################### -->
    <!-- ###  Not currently displayed in any specific way.                                                   ### -->
    <!-- ###                                                                                                 ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="index">
    </xsl:template>
    
    
    
    <!-- ################################################/ note /############################################### -->
    <!-- ####################################################################################################### -->
    <!-- ###  Two types of notes, author's and editor's notes.                                               ### -->
    <!-- ###                                                                                                 ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="note">
        <xsl:choose>
            <xsl:when test="@resp='author'">
                <!-- create link in main text-->
                <sup>
                    <span class="authornotelink">
                        <xsl:attribute name="onmousedown">
                            <xsl:text>javascript:Drupal.teichiShowNote2("</xsl:text>
                            <xsl:number level="any" count="note" format="1" />
                            <xsl:text>")</xsl:text>
                        </xsl:attribute>
                        <xsl:text>*</xsl:text>
                    </span>
                    <!-- space between * and 123 -->
                    <span>
                        <xsl:text>&#xA0;</xsl:text>
                    </span>
                </sup>
                <!-- create the note-window on the right side-->
                <span class="note author"> 
                    <sup>
                       <span style="font-weight:bold;cursor:pointer;">
                            <xsl:attribute name="onclick">
                              <xsl:text>javascript:Drupal.teichiShowNote2("</xsl:text>
                              <xsl:number level="any" count="note" format="1" />
                              <xsl:text>")</xsl:text>
                            </xsl:attribute>
                            <xsl:text>*</xsl:text>
                      </span>
                    </sup>
                    <span class="content">
                        <xsl:attribute name="id">
                            <xsl:text>note</xsl:text>
                            <xsl:number level="any" count="note" format="1" />
                        </xsl:attribute>
                        <xsl:apply-templates />
                        <span style="cursor:pointer;">
                            <xsl:attribute name="onclick">
                                <xsl:text>javascript:Drupal.teichiHideNote("</xsl:text>
                                <xsl:number level="any" count="note" format="1" />
                                <xsl:text>")</xsl:text>
                            </xsl:attribute>
                            <span style="display:block;text-align:center;margin-top:5px;">
                                <img src="/drupal-7/sites/all/modules/tei_content/img/closenote.png" width="120" height="7" />
                            </span>
                        </span>
                    </span>
                </span>
            </xsl:when>
            
        
            <xsl:when test="(@resp='editor')">
                <!-- create link in main text-->
                <sup>
                    <span class="editornotelink">
                        <xsl:attribute name="onmousedown">
                            <xsl:text>javascript:Drupal.teichiShowNote2("</xsl:text>
                            <xsl:number level="any" count="note" format="1" />
                            <xsl:text>")</xsl:text>
                        </xsl:attribute>
                        <xsl:number level="any" count="note[@resp='editor']" format="1" />
                    </span>
                </sup>
                  <!-- create the note-window on the right side-->
                <span class="note editor">
                    <sup>
                      <span style="font-weight:bold;cursor:pointer;">
                            <xsl:attribute name="onclick">
                                <xsl:text>javascript:Drupal.teichiShowNote2("</xsl:text>
                                <xsl:number level="any" count="note" format="1" />
                                <xsl:text>")</xsl:text>
                            </xsl:attribute>
                            <xsl:number level="any" count="note[@resp='editor']" format="1" />
                      </span>
                    </sup>
                    <span class="content">
                        <xsl:attribute name="id">
                            <xsl:text>note</xsl:text><xsl:number level="any" count="note" format="1" />
                        </xsl:attribute>
                        <xsl:apply-templates />
                        <span style="cursor:pointer;">
                            <xsl:attribute name="onclick">
                                <xsl:text>javascript:Drupal.teichiHideNote("</xsl:text>
                                <xsl:number level="any" count="note" format="1" />
                                <xsl:text>")</xsl:text>
                            </xsl:attribute>
                            <span style="display:block;text-align:center;margin-top:5px;">
                                <img src="/drupal-7/sites/all/modules/tei_content/img/closenote.png" width="120" height="7" />
                            </span>
                        </span>
                    </span>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>    
    
    
    <!-- ##################################################/ hi, emph, mentioned /############################## -->
    <!-- ####################################################################################################### -->
    <!-- ###  Various types of highlighting: general, emphasis, "mentioned"                                  ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="hi">
        <span class="hi">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="emph">
        <span class="emph">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="mentioned">
        &#8216;<span class="mentioned">
            <xsl:apply-templates />&#8217;</span>
    </xsl:template>
    
    
    
    <!-- #######################################/ del, add, gap, unclear / ##################################### -->
    <!-- ####################################################################################################### -->
    <!-- ###  Deletion = strike through; Addition = underlined ; Gap = empty marked space.                   ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="del">
        <span class="del">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="add">
        <span class="add">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="gap">
            &lt;&#xA0;
        <span class="gap">
            <xsl:apply-templates />
            &#xA0;&gt;
        </span>
    </xsl:template>
    
    <xsl:template match="unclear">
        <span class="unclear">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    
    
    <!-- ##################################################/ opener tags / ##################################### -->
    <!-- ####################################################################################################### -->
    <!-- ### Dateline (right), epigraph (indent 4cm), salute (right), signed (right), trailer (center, caps) ### -->
    <!-- ####################################################################################################### -->
    
    
    <xsl:template match="epigraph">
        <span class="epigraph">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="opener">
            <xsl:apply-templates />
    </xsl:template>
        
    <xsl:template match="dateline">
        <span class="dateline">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="closer">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="salute">
        <span class="salute">
            <xsl:apply-templates />
        </span>
        <br/>        
    </xsl:template>
    
    <xsl:template match="signed">
        <span class="signed">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="trailer">
        <span class="trailer">
            <xsl:apply-templates />
        </span>
        <br/>        
    </xsl:template>
    
    
    
    
    <!-- ################################################/ bibl, title /######################################## -->
    <!-- ####################################################################################################### -->
    <!-- ###  "bibl" (not highlighted), "author" (not highlighted), and "title" (italic or quotes)           ### -->
    <!-- ###                                                                                                 ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="bibl">
            <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="author">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="title">
        <xsl:choose>
            
            <xsl:when test="@rend='article'">
                    <xsl:text>«&#xA0;</xsl:text> 
                    <xsl:apply-templates />
                    <xsl:text>&#xA0;»</xsl:text>
                </xsl:when>
                
                <xsl:when test="@rend='monograph'">
                    <span style="font-style: italic;">
                        <xsl:apply-templates />
                    </span>
                </xsl:when>
                
                <xsl:otherwise>
                    <span style="font-style: normal">
                        <xsl:apply-templates />
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>
    
    
    <!-- ################################################/ quote /############################################## -->
    <!-- ####################################################################################################### -->
    <!-- ###  Three types of quotations: inline italics, inline quotes, block.                               ### -->
    <!-- ####################################################################################################### -->
    
    <xsl:template match="quote">
        <xsl:choose>
            <!-- rend="inline" => Inline with quotes. -->
            <xsl:when test="@rend='inline'">
                <span class="quote inline">
                    <xsl:text>«&#xA0;</xsl:text> 
                        <xsl:apply-templates />
                    <xsl:text>&#xA0;»</xsl:text>
                </span>
            </xsl:when>
            
            <xsl:when test="@rend='italic'">
                <span class="quote italic">
                    <xsl:apply-templates />
                </span>
            </xsl:when>
            
            <!-- rend="block"  => Separate paragraph, smaller, indentation. -->
            <xsl:when test="@rend='block'">
                <span class="quote block"> 
                    <xsl:apply-templates />
                </span>
            </xsl:when>
            
            <xsl:otherwise>
                <span class="quote" style="font-style: normal">
                    <xsl:apply-templates />
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="q">
        <xsl:choose>
            
            <!-- rend="inline" => Inline with quotes. -->
            <xsl:when test="@rend='quotes'">
                <xsl:text>«&#xA0;</xsl:text> 
                <xsl:apply-templates />
                <xsl:text>&#xA0;»</xsl:text>
            </xsl:when>
            
            <xsl:when test="@rend='hyphen'">
                <xsl:text>&#2018;&#xA0;</xsl:text>
                    <xsl:apply-templates />
                    <xsl:text></xsl:text>
            </xsl:when>
            
            <xsl:otherwise>
                <span style="font-style: normal">
                    <xsl:apply-templates />
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- #################################################/ lb /################################################ -->
    <!-- ####################################################################################################### -->
    <!-- ###  Manual line break.                                                                             ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="lb">
        <br />
            <xsl:apply-templates />
    </xsl:template>
    
    
    
    <!-- #################################################/ pb /################################################ -->
    <!-- ####################################################################################################### -->
    <!-- ### New page, with page number for the following page.                                              ### -->
    <!-- ### Displayed in the following manner: [123])                                                         ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="pb">
        <!-- rein zu testzwecken, muss spaeter dynamisch geschehen -->
                <!-- <a href="beispiel_seiten.gif">[p<xsl:value-of select="@n"/>]</a>  -->
  
                <xsl:element name='a'>
                    <xsl:attribute name='id'>
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:attribute name='name'>
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:attribute name='class'>
                        <xsl:text>pagelink</xsl:text>
                    </xsl:attribute>
                    [p.<xsl:value-of select="@n"/>]
                </xsl:element>
    </xsl:template>
    
    

    <!-- ################################################/ ref /################################################ -->
    <!-- ####################################################################################################### -->
    <!-- ###  Internal or external linking. Standard visualization for links.                                ### -->
    <!-- ###                                                                                                 ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="ref">
        <xsl:choose>
            <xsl:when test='starts-with(@target,"http://")'>
                 <xsl:element name='a'>
                    <xsl:attribute name='href'>
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:attribute name='target'>
                        <xsl:text>_blank</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name='class'>
                            <xsl:text>extlink</xsl:text>
                    </xsl:attribute>
                        <xsl:value-of select="."/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name='a'>
                        <xsl:attribute name='href'>
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                        <xsl:attribute name='class'>
                                <xsl:text>intlink</xsl:text>
                        </xsl:attribute>
                            <xsl:value-of select="."/>
                    </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <!-- ###############################################/ lg and l /############################################ -->
    <!-- ####################################################################################################### -->
    <!-- ###  Linegroup and line. Separate paragraph, small indentation to the left, each line gets a line   ### -->
    <!-- ###  break, text size is one step smaller than main text.                                           ### -->
    <!-- ####################################################################################################### -->

    <xsl:template match="lg">
        <span class="lg">
        <xsl:apply-templates />
            <br/>
        </span>
    </xsl:template>

    <xsl:template match="l">
        <xsl:choose>
            <xsl:when test="@rend='indent'">        
                <!--  <br/>  style="font-size:13px;" -->
                <!-- leerzeichen -->
                <span class="ll">&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
                    <xsl:apply-templates />
                    <br/>
                </span>
            </xsl:when>
            <xsl:otherwise>
            <!-- <br/> -->
                <!-- leerzeichen -->
                <span class="ll">
                    <xsl:apply-templates />
                    <br/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <!-- ##################################/ sp speaker stage /################################################# -->
    <!-- ####################################################################################################### -->
    <!-- ###  Speech, speaker and stage: Speech is a separate paragraph (occurs within a "p",                ### -->
    <!-- ###  together with corresponding speaker), stage directions in italics. Only on separate line if lb.### -->
    <!-- ####################################################################################################### -->
    
    <xsl:template match="sp">
        <span class="sp">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="speaker">
        <span class="speaker">
            <xsl:apply-templates />
            &#xA0;: <br/>
        </span>
    </xsl:template>
    
    <xsl:template match="stage">
        <span class="stage">
            <xsl:apply-templates /> 
        </span>
    </xsl:template>
        
</xsl:stylesheet>