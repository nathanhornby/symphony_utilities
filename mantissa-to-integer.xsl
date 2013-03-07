<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--

  Mantissa to Integer
	************************************************

	- Author: Nathan Hornby @ 3Degrees Agency <http://www.3degreesagency.com>
	- Version: 1.0
	- Release date: 7th March 2013


	What's it for?
	================================================

	'Mantissa to Integer' will convert a decimal to an integer if the characteristic is 0, else return the original value rounded off to two decimal places with the appropriate currency accompaniment.

	i.e. 0.6 becomes 6p, and 3.7 becomes £3.70.


	Parameters
	================================================
	
	1. value    - [required] the value you wish to convert.
	3. suffix   - [optional] defines the suffix to be returned when the value is less than 0.
	4. prefix   - [optional] defines the prefix to be returned when the value is greater than 0.


	Example one
	================================================

	<xsl:call-template name="mantissa-to-integer">
		<xsl:with-param name="value" select="0.6"/>
		<xsl:with-param name="prefix" select="'&#163;'"/>
		<xsl:with-param name="suffix" select="'p'"/>
	</xsl:call-template>

	Returns:

	6p


	Example two
	================================================

	<xsl:call-template name="mantissa-to-integer">
		<xsl:with-param name="value" select="3.7"/>
		<xsl:with-param name="prefix" select="'&#163;'"/>
		<xsl:with-param name="suffix" select="'p'"/>
	</xsl:call-template>

	Returns:

	£3.70

-->

<xsl:template name="mantissa-to-integer">

	<!--  Parameters
	================================================ -->
	<xsl:param name="value"/>
	<xsl:param name="prefix"/>
	<xsl:param name="suffix"/>
	<xsl:param name="decimated-value">
		<xsl:choose>
			<xsl:when test="not(contains($value , '.'))">
				<xsl:value-of select="concat($value , '.00')"/>
			</xsl:when>
			<xsl:when test="string-length(substring-after($value , '.')) = 1">
				<xsl:value-of select="concat($value , '0')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>

	<!--  Output
	================================================ -->
	<xsl:choose>
		<xsl:when test="substring-before($decimated-value, '.') = 0">
			<xsl:variable name="mantissa" select="substring(substring-after($decimated-value, '.'), 1, 2)"/>
			<xsl:choose>
				<xsl:when test="substring($mantissa, 1, 1) = 0">
					<xsl:value-of select="concat(substring($mantissa, 2, 1) , $suffix)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($mantissa , $suffix)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($prefix , substring-before($decimated-value, '.') , '.' , substring(substring-after($decimated-value, '.'), 1, 2))"/>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>
</xsl:stylesheet>
