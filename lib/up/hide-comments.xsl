<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:t="http://lmnl-markup.org/ns/luminescent/tokens"
  xmlns:local="http://lmnl-markup.org/ns/local"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <!-- Hides comments from subsequent processing -->


  <!-- If $lmnl-file is provided, it is read as plain text. Otherwise,
       the data value of the input document is read. -->
  <xsl:param name="lmnl-file" as="xs:string*"/>
  
  <xsl:param name="base-uri" select="false()"/>
  
  <xsl:variable name="source">
    <xsl:choose>
      <xsl:when test="normalize-space($lmnl-file)">
        <xsl:sequence select="unparsed-text($lmnl-file)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="/string()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:template name="start" match="/">
    <t:root>
      <xsl:attribute name="base-uri" select="if ($base-uri) then $base-uri else resolve-uri($lmnl-file)"/>
      <xsl:analyze-string select="$source" regex="\[!--(.*?)--\]" flags="s">
        <xsl:matching-substring>
          <t:comment>
            <xsl:value-of select="local:eol(.)"/>
          </t:comment>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:value-of select="local:eol(.)"/>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
      </t:root>
  </xsl:template>
   
   <!-- EOL of LF, CR, or CRLF are all normalized to LF (&#xA;) -->
   <xsl:function name="local:eol" as="xs:string?">
     <xsl:param name="in" as="xs:string?"/>
     <xsl:sequence select="replace($in,'&#xA;|(&#xD;&#xA;?)','&#xA;')"/>
   </xsl:function>

</xsl:stylesheet>