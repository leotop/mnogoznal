<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:key name="senses" match="/rwn/senses/sense" use="@id"/>
  <xsl:key name="synsets" match="/rwn/senses/sense" use="@synset_id"/>
  <xsl:key name="relations" match="/rwn/relations/relation" use="@parent_id"/>
  <xsl:template match="/">
    <xsl:for-each select="/rwn/synsets/synset">
      <!-- id -->
      <xsl:value-of select="@id"/>
      <xsl:text>&#9;</xsl:text>
      <!-- count -->
      <xsl:value-of select="count(./sense)"/>
      <xsl:text>&#9;</xsl:text>
      <!-- synonyms -->
      <xsl:for-each select="./sense">
        <xsl:if test="position() &gt; 1">
          <xsl:text>|</xsl:text>
        </xsl:if>
        <xsl:value-of select="key('senses', @id)/@name"/>
      </xsl:for-each>
      <xsl:text>&#9;</xsl:text>
      <!-- count -->
      <xsl:value-of select="count(key('synsets', key('relations', @id)[@name = &quot;hypernym&quot; or @name = &quot;part holonym&quot;]/@child_id))"/>
      <xsl:text>&#9;</xsl:text>
      <!-- relations -->
      <xsl:for-each select="key('synsets', key('relations', @id)[@name = &quot;hypernym&quot; or @name = &quot;part holonym&quot;]/@child_id)">
        <xsl:if test="position() &gt; 1">
          <xsl:text>|</xsl:text>
        </xsl:if>
        <xsl:value-of select="@name"/>
      </xsl:for-each>
      <xsl:text>&#10;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
