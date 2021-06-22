<?xml version="1.0" encoding="UTF-8"?>
<!--   $Header: fusionapps/fin/iby/bipub/shared/runFormat/reports/DisbursementPaymentFileFormats/ISO20022CGI.xsl /st_fusionapps_pt-v2mib/4 2018/04/04 07:35:17 jswirsky Exp $   
  -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output omit-xml-declaration="no" />
    <xsl:output method="xml" />
    
    <xsl:param name="daysDiff" select="'1'"/>
    <xsl:template name="JDN">
        <xsl:param name="date"/>
        <xsl:param name="year" select="substring($date, 1, 4)"/>
        <xsl:param name="month" select="substring($date, 6, 2)"/>
        <xsl:param name="day" select="substring($date, 9, 2)"/>
        <xsl:param name="a" select="floor((14 - $month) div 12)"/>
        <xsl:param name="y" select="$year + 4800 - $a"/>
        <xsl:param name="m" select="$month + 12*$a - 3"/>
        <xsl:value-of select="$day + floor((153*$m + 2) div 5) + 365*$y + floor($y div 4) - floor($y div 100) + floor($y div 400) - 32045" />
    </xsl:template>
    <xsl:template name="GD">
        <xsl:param name="JDN"/>
        <xsl:param name="f" select="$JDN + 1401 + floor((floor((4 * $JDN + 274277) div 146097) * 3) div 4) - 38"/>
        <xsl:param name="e" select="4*$f + 3"/>
        <xsl:param name="g" select="floor(($e mod 1461) div 4)"/>
        <xsl:param name="h" select="5*$g + 2"/>
        <xsl:param name="D" select="floor(($h mod 153) div 5 ) + 1"/>
        <xsl:param name="M" select="(floor($h div 153) + 2) mod 12 + 1"/>
        <xsl:param name="Y" select="floor($e div 1461) - 4716 + floor((14 - $M) div 12)"/>
        <xsl:param name="MM" select="substring(100 + $M, 2)"/>
        <xsl:param name="DD" select="substring(100 + $D, 2)"/>
        <xsl:value-of select="concat($Y, '-', $MM, '-', $DD)" />
    </xsl:template>
    <xsl:template match="OutboundPaymentInstruction">
        <Document
            xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <xsl:variable name="instrid" select="PaymentInstructionInfo/InstructionReferenceNumber" />
            <xsl:variable name="pymtd" />
            <xsl:variable name="TMPT" />
            <xsl:variable name="JDN" />
			<xsl:variable name="BankCountry" />
			
            <CstmrCdtTrfInitn>
                <GrpHdr>
                    <MsgId>
                        <xsl:value-of select="$instrid" />
                    </MsgId>
                    <CreDtTm>
                        <xsl:choose>
                            <xsl:when test="contains(PaymentInstructionInfo/InstructionCreationDate , '+')">
                                <xsl:value-of select="substring(PaymentInstructionInfo/InstructionCreationDate , 1, string-length(PaymentInstructionInfo/InstructionCreationDate)-6)" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="PaymentInstructionInfo/InstructionCreationDate" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </CreDtTm>
                    <NbOfTxs>
                        <xsl:value-of select="InstructionTotals/PaymentCount" />
                    </NbOfTxs>
                    <CtrlSum>
					 <xsl:value-of select="format-number(sum(/OutboundPaymentInstruction/OutboundPayment[BankAccount/BankAddress/Country!='AU']/PaymentAmount/Value) + sum(/OutboundPaymentInstruction/OutboundPayment[BankAccount/BankAddress/Country='AU']/DocumentPayable/TotalDocumentAmount/Value) , '##0.00')"/>
					</CtrlSum>
					 
                    <InitgPty>
                        <Nm>
						 <xsl:choose>
                                <xsl:when test="InstructionGrouping/Payer/Address/Country='JP'">
                                    <xsl:value-of select="substring(upper-case(InstructionGrouping/Payer/LegalEntityName),1,140)" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring(InstructionGrouping/Payer/LegalEntityName,1,140)" />
                                </xsl:otherwise>
                            </xsl:choose>
                            
                        </Nm>
                        <xsl:if test="InstructionGrouping/Payer/Address/Country='SG'">
                            <PstlAdr>
                                <xsl:if test="not(InstructionGrouping/Payer/Address/AddressLine2='')">
                                    <StrtNm>
                                        <xsl:value-of select="substring(InstructionGrouping/Payer/Address/AddressLine2,1,70)" />
                                    </StrtNm>
                                </xsl:if>
								
                                <xsl:if test="not(InstructionGrouping/Payer/Address/PostalCode='')">
                                    <PstCd>
                                        
                                <xsl:value-of select= "translate(InstructionGrouping/Payer/Address/PostalCode,'-','')" />
                                           
                                    </PstCd>
                                </xsl:if>
                                <xsl:if test="not(InstructionGrouping/Payer/Address/City='')">
                                    <TwnNm>
                                        <xsl:value-of select="InstructionGrouping/Payer/Address/City" />
                                    </TwnNm>
                                </xsl:if>
                                <xsl:if test="not(InstructionGrouping/Payer/Address/Country='')">
                                    <Ctry>
                                        <xsl:value-of select="InstructionGrouping/Payer/Address/Country" />
                                    </Ctry>
                                </xsl:if>
                            </PstlAdr>
                        </xsl:if>
                        <Id>
                            <OrgId>
                                <Othr>
                                    <Id>
                                        <xsl:text>DOCUSIGN</xsl:text>
                                    </Id>
                                    <xsl:if test="((InstructionGrouping/Payer/Address/Country='US') or (InstructionGrouping/Payer/Address/Country='AU') or (InstructionGrouping/Payer/Address/Country='JP'))">
                                        <SchmeNm>
                                            <Cd>
                                                <xsl:text>CUST</xsl:text>
                                            </Cd>
                                        </SchmeNm>
                                    </xsl:if>
                                </Othr>
                            </OrgId>
                        </Id>
                    </InitgPty>
                </GrpHdr>
                <xsl:for-each select="OutboundPayment">
                    <xsl:sort select="PaymentMethod/PaymentMethodInternalID" />
                    <!--Start of payment information block-->
                    <PmtInf>
                        <xsl:variable name="pymtd">
                            <xsl:choose>
                                <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC')">
                                    <xsl:value-of select="'ELE'" />
                                </xsl:when>
                                <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_WIRE')">
                                    <xsl:value-of select="'WIR'" />
                                </xsl:when>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="TMPT">
                            <xsl:choose>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC') and (PaymentAmount/Currency/Code='USD') and (BankAccount/BankAddress/Country = 'US') and (PayeeBankAccount/BankAddress/Country='US'))">
                                    <xsl:value-of select="'US ACH CCD'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (PaymentAmount/Currency/Code='USD')  and (BankAccount/BankAddress/Country = 'US') and (PayeeBankAccount/BankAddress/Country='US'))">
                                    <xsl:value-of select="'US WIRE DOMESTIC'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country= 'US') and
                                         (((PayeeBankAccount/BankAddress/Country!='US') and (PaymentAmount/Currency/Code='USD')) or
                                         ((PayeeBankAccount/BankAddress/Country='US') and (PaymentAmount/Currency/Code!='USD')) or
                                         ((PayeeBankAccount/BankAddress/Country!='US') and (PaymentAmount/Currency/Code!='USD'))))">
                                    <xsl:value-of select="'US Wire Cross Border / US Wire FX'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC') and ((BankAccount/BankAddress/Country = 'IE') or (BankAccount/BankAddress/Country = 'FR') or (BankAccount/BankAddress/Country = 'DE')) and (((PayeeBankAccount/BankAddress/Country='AX') or (PayeeBankAccount/BankAddress/Country='AD') or (PayeeBankAccount/BankAddress/Country='AT') or (PayeeBankAccount/BankAddress/Country='PT') or (PayeeBankAccount/BankAddress/Country='BE') or (PayeeBankAccount/BankAddress/Country='BG') or (PayeeBankAccount/BankAddress/Country='ES') or (PayeeBankAccount/BankAddress/Country='HR') or (PayeeBankAccount/BankAddress/Country='CY') or (PayeeBankAccount/BankAddress/Country='CZ') or (PayeeBankAccount/BankAddress/Country='DK') or (PayeeBankAccount/BankAddress/Country='EE') or (PayeeBankAccount/BankAddress/Country='FI') or (PayeeBankAccount/BankAddress/Country='FR') or (PayeeBankAccount/BankAddress/Country='GF') or (PayeeBankAccount/BankAddress/Country='DE') or (PayeeBankAccount/BankAddress/Country='GI') or (PayeeBankAccount/BankAddress/Country='GR') or (PayeeBankAccount/BankAddress/Country='GP') or (PayeeBankAccount/BankAddress/Country='GG') or (PayeeBankAccount/BankAddress/Country='HU') or (PayeeBankAccount/BankAddress/Country='IE') or (PayeeBankAccount/BankAddress/Country='IS') or (PayeeBankAccount/BankAddress/Country='IM') or (PayeeBankAccount/BankAddress/Country='IT') or (PayeeBankAccount/BankAddress/Country='LT') or (PayeeBankAccount/BankAddress/Country='LU') or (PayeeBankAccount/BankAddress/Country='JE') or (PayeeBankAccount/BankAddress/Country='LV') or (PayeeBankAccount/BankAddress/Country='LI') or (PayeeBankAccount/BankAddress/Country='PT') or (PayeeBankAccount/BankAddress/Country='MT') or (PayeeBankAccount/BankAddress/Country='YT') or (PayeeBankAccount/BankAddress/Country='MC') or (PayeeBankAccount/BankAddress/Country='NL') or (PayeeBankAccount/BankAddress/Country='NO') or (PayeeBankAccount/BankAddress/Country='PL') or (PayeeBankAccount/BankAddress/Country='RE') or (PayeeBankAccount/BankAddress/Country='RO') or (PayeeBankAccount/BankAddress/Country='BL') or (PayeeBankAccount/BankAddress/Country='MF') or (PayeeBankAccount/BankAddress/Country='PM') or (PayeeBankAccount/BankAddress/Country='SM') or (PayeeBankAccount/BankAddress/Country='SK') or (PayeeBankAccount/BankAddress/Country='SI') or (PayeeBankAccount/BankAddress/Country='ES') or (PayeeBankAccount/BankAddress/Country='SE') or (PayeeBankAccount/BankAddress/Country='CH') or (PayeeBankAccount/BankAddress/Country='GB') or (PayeeBankAccount/BankAddress/Country='VA') or (PayeeBankAccount/BankAddress/Country='MQ')) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'IE / FR / DE SEPA'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and ((BankAccount/BankAddress/Country = 'IE') or (BankAccount/BankAddress/Country = 'FR') or (BankAccount/BankAddress/Country = 'DE')) and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'IE / FR / DE Wire Domestic'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and ((BankAccount/BankAddress/Country = 'IE') or (BankAccount/BankAddress/Country = 'FR') or (BankAccount/BankAddress/Country = 'DE') or (BankAccount/BankAddress/Country = 'GB')) and ((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) or (BankAccount/BankAccountCurrency/Code!=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'IE / FR / DE / GB Wire Cross Border/FX'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC') and (BankAccount/BankAddress/Country = 'GB') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'GB BACS'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'GB') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'GB CHAPS'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC') and (BankAccount/BankAddress/Country = 'JP') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'JP PAYACH'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'JP') and (((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) or (PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country)) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'JP Wire Domestic/International'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'JP') and ((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code!=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'JP Wire CrossBorder FX'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC') and (BankAccount/BankAddress/Country = 'AU') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=DocumentPayable/TotalDocumentAmount/Currency/Code)))">
                                    <xsl:value-of select="'AU ACH Low Value'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'AU') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=DocumentPayable/TotalDocumentAmount/Currency/Code)))">
                                    <xsl:value-of select="'AU Wire Domestic'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'AU') and ((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) or (BankAccount/BankAccountCurrency/Code!=DocumentPayable/TotalDocumentAmount/Currency/Code)))">
                                    <xsl:value-of select="'AU Wire CrossBorder/FX'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC') and (BankAccount/BankAddress/Country = 'CA') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'CA PAYACH'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'CA') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'CA Wire Domestic (PAYEFT)'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'CA') and ((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'CA SWIFT Wire (CrossBorder)'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'CA') and (((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) or (PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country)) and (BankAccount/BankAccountCurrency/Code!=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'CA FX SWIFT Wire (FXP)'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC') and (BankAccount/BankAddress/Country = 'SG') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'SG PAYACH'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'SG') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'SG Wire Domestic (PAYEFT)'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'SG') and (((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) or (PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country)) and (BankAccount/BankAccountCurrency/Code!=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'SG FX WIRE (PAYIWT)'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'SG') and ((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                    <xsl:value-of select="'SG INTERNATIONAL WIRE'" />
                                </xsl:when>
                                <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and ((BankAccount/BankAddress/Country = 'IL') and ((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) or (BankAccount/BankAccountCurrency/Code!=PaymentAmount/Currency/Code)) or ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code))))">
                                    <xsl:value-of select="'Leumi Domestic Wire/Cross Border/International/FX'" />
                                </xsl:when>
                            </xsl:choose>
                        </xsl:variable>
						
						
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                            <PmtInfId>
                                <xsl:choose>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign, Inc.')">
                                        <xsl:value-of select="concat('BOA_DSI_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign International (EMEA) Limited (Ireland)')">
                                        <xsl:value-of select="concat('BOA_DIE_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign International, Inc.')">
                                        <xsl:value-of select="concat('BOA_DII_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Canada Ltd.')">
                                        <xsl:value-of select="concat('BOA_DSC_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='ARX Inc.')">
                                        <xsl:value-of select="concat('BOA_ARX_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='SpringCM Inc.')">
                                        <xsl:value-of select="concat('BOA_SCM_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Brazil LLC-')">
                                        <xsl:value-of select="concat('BOA_DBS_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='Seal Software Inc (US)')">
                                        <xsl:value-of select="concat('BOA_SSI_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='Liveoak Technologies, Inc')">
                                        <xsl:value-of select="concat('BOA_LOT_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign International (Asia-Pacific) Pte Ltd')">
                                        <xsl:value-of select="concat('BOA_DIP_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DII Australia Branch')">
                                        <xsl:value-of select="concat('BOA_DAB_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Japan KK')">
                                        <xsl:value-of select="concat('BOA_DSJ_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign UK Ltd')">
                                        <xsl:value-of select="concat('BOA_DUK_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Germany GmbH')">
                                        <xsl:value-of select="concat('BOA_DSG_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DS France SAS')">
                                        <xsl:value-of select="concat('BOA_DSF_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='Seal Software Group (Holding) Ltd')">
                                        <xsl:value-of select="concat('BOA_SSG_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='Seal Software Limited (UK)')">
                                        <xsl:value-of select="concat('BOA_SSL_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='Contract Analytics Development Sweden')">
                                        <xsl:value-of select="concat('BOA_CAD_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='Seal Software Norway AS')">
                                        <xsl:value-of select="concat('BOA_SSN_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Acquisition Ltd.')">
                                        <xsl:value-of select="concat('BOA_DSA_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Israel Ltd.')">
                                        <xsl:value-of select="concat('BOA_DIS_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='Seal Software Egypt LLC')">
                                        <xsl:value-of select="concat('BOA_SSE_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Brasil Participacoes Ltda')">
                                        <xsl:value-of select="concat('BOA_DBP_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Brasil Solucoes em Tecnologia Ltda.')">
                                        <xsl:value-of select="concat('BOA_DSS_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                    <xsl:when test="(Payer/LegalEntityName='DocuSign Mexico')">
                                        <xsl:value-of select="concat('BOA_DSM_',$pymtd,'_',$instrid,'_',PaymentNumber/PaymentReferenceNumber)" />
                                    </xsl:when>
                                </xsl:choose>
                            </PmtInfId>
                        </xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS')or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                            <PmtMtd>
                                <xsl:text>TRF</xsl:text>
                            </PmtMtd>
                        </xsl:if>
                        <xsl:if test="(($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX')or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                            <BtchBookg>
                                <xsl:text>false</xsl:text>
                            </BtchBookg>
                        </xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX')or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
                            <!-- get from new logical table instead -->
                            <NbOfTxs>
                                
                                        <xsl:value-of select="'1'" />
                                   
                            </NbOfTxs>
                        </xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX')or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
                            <!-- get from new logical table instead -->
                            <CtrlSum>
                                
                                        <xsl:value-of select="format-number(PaymentAmount/Value, '##0.00')"/>
                                    
                               
                            </CtrlSum>
                        </xsl:if>
                        <xsl:if test="(($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                            <!-- get from new logical table instead -->
                            <CtrlSum>
                                
                              
                                        <xsl:value-of select="format-number(DocumentPayable/TotalDocumentAmount/Value, '##0.00')"/>
                                   
                            </CtrlSum>
                        </xsl:if>
                        <PmtTpInf>
                            <xsl:if test="(($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                <InstrPrty>
                                    <xsl:text>NORM</xsl:text>
                                </InstrPrty>
                            </xsl:if>
                            <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA')or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX'))">
                                <SvcLvl>
                                    <Cd>
                                        <xsl:choose>
                                            <xsl:when test="(($TMPT='US ACH CCD')or($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='AU ACH Low Value') or ($TMPT='CA PAYACH') or ($TMPT='SG PAYACH'))">
                                                <xsl:text>NURG</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="(($TMPT='US WIRE DOMESTIC')or ($TMPT='GB CHAPS')or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX') or ($TMPT='GB CHAPS') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX'))">
                                                <xsl:text>URGP</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="($TMPT='IE / FR / DE SEPA')">
                                                <xsl:text>SEPA</xsl:text>
                                            </xsl:when>
                                        </xsl:choose>
                                    </Cd>
                                </SvcLvl>
                            </xsl:if>
                            <xsl:if test="($TMPT='US ACH CCD')">
                                <LclInstrm>
                                    <Cd>
                                        <xsl:text>CCD</xsl:text>
                                    </Cd>
                                </LclInstrm>
                            </xsl:if>
                        </PmtTpInf>
                        <!--End of payment type information block-->
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                            <xsl:if test="not(PaymentDate='')">
                                <ReqdExctnDt>
                                    <xsl:choose>
                                        <xsl:when test="(($TMPT='US ACH CCD') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)'))">
                                            <xsl:variable name="JDN">
                                                <xsl:call-template name="JDN">
                                                    <xsl:with-param name="date" select="PaymentDate" />
                                                </xsl:call-template>
                                            </xsl:variable>
                                            <xsl:call-template name="GD">
                                                <xsl:with-param name="JDN" select="$JDN + $daysDiff" />
                                            </xsl:call-template>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="PaymentDate" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </ReqdExctnDt>
                            </xsl:if>
                        </xsl:if>
                        <Dbtr>
                            <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                <Nm>
                                    <xsl:choose>
                                        
										<xsl:when test="(($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
                                            <xsl:value-of select="substring(upper-case(Payer/Name),1,140)" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="substring(Payer/Name,1,140)" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </Nm>
                            </xsl:if>
                            <PstlAdr>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic')  or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX ')or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
                                    <xsl:if test="not(Payer/Address/AddressLine1='')">
                                        <StrtNm>
                                            <xsl:value-of select="substring(Payer/Address/AddressLine1,1,70)" />
                                        </StrtNm>
                                    </xsl:if>
                                </xsl:if>
								 <xsl:if test="(($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') )">
                                    <xsl:if test="not(Payer/Address/AddressLine2='')">
                                        <StrtNm>
                                            <xsl:value-of select="substring(Payer/Address/AddressLine2,1,70)" />
                                        </StrtNm>
                                    </xsl:if>
                                </xsl:if>
								<xsl:if test="not(Payer/Address/AddressLine1='')">
								<xsl:if test="(($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
								<BldgNb>
								         <xsl:value-of select="substring(translate(Payer/Address/AddressLine1,'#',''),1,70)" />
								</BldgNb>
								 </xsl:if>
                                </xsl:if>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS')  or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                    <xsl:if test="not(Payer/Address/PostalCode='')">
                                        <PstCd>
										
										<xsl:choose>
										<xsl:when test="(($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
										<xsl:value-of select= "Payer/Address/PostalCode" />
                                        </xsl:when> 
										<xsl:otherwise>
										     <xsl:value-of select= "translate(Payer/Address/PostalCode,'-','')" />
										</xsl:otherwise>
										</xsl:choose>
                                        </PstCd>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                    <xsl:if test="not(Payer/Address/City='')">
                                        <TwnNm>
                                            <xsl:value-of select="Payer/Address/City" />
                                        </TwnNm>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)'))">
                                    <xsl:if test="not(Payer/Address/State='')">
                                        <CtrySubDvsn>
                                            <xsl:value-of select="Payer/Address/State" />
                                        </CtrySubDvsn>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                    <xsl:if test="not(Payer/Address/Country='')">
                                        <Ctry>
                                            <xsl:value-of select="Payer/Address/Country" />
                                        </Ctry>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="(($TMPT='IE / FR / DE SEPA') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                                    
                                        
										<xsl:choose>
										<xsl:when test="(($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
										<xsl:if test="not(Payer/Address/AddressLine2='')">
										<AdrLine>
                                            <xsl:value-of select="substring(Payer/Address/AddressLine2,1,70)" />
										</AdrLine>
										</xsl:if>
										</xsl:when>
										<xsl:otherwise>
										<xsl:if test="not(Payer/Address/AddressLine1='')">
										<AdrLine>
										<xsl:value-of select="substring(concat(Payer/Address/AddressLine1,' ',Payer/Address/AddressLine2),1,70)" />
										</AdrLine>
										</xsl:if>
										</xsl:otherwise>
										</xsl:choose>
                                        
                                    
                                </xsl:if>
                            </PstlAdr>
                            <xsl:if test="($TMPT='US ACH CCD')">
                                <Id>
                                    <OrgId>
                                        <Othr>
                                            <xsl:if test="not(BankAccount/EFTUserNumber/AccountLevelEFTNumber='')">
                                                <Id>
                                                    <xsl:value-of select="BankAccount/EFTUserNumber/AccountLevelEFTNumber" />
                                                </Id>
                                            </xsl:if>
                                            <SchmeNm>
                                                <Cd>
                                                    <xsl:text>CHID</xsl:text>
                                                </Cd>
                                            </SchmeNm>
                                        </Othr>
                                    </OrgId>
                                </Id>
                            </xsl:if>
                            <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
                                <xsl:if test="not(Payer/Address/Country='')">
                                    <CtryOfRes>
                                        <xsl:value-of select="Payer/Address/Country" />
                                    </CtryOfRes>
                                </xsl:if>
                            </xsl:if>
                        </Dbtr>
                        <DbtrAcct>
                            <xsl:if test="(not(BankAccount/BankAccountNumber='') or not(BankAccount/IBANNumber=''))">
                                <Id>
                                    <xsl:if test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                        <xsl:if test="not(BankAccount/IBANNumber='')">
                                            <IBAN>
                                                <xsl:value-of select="translate(BankAccount/IBANNumber,' ','')" />
                                            </IBAN>
                                        </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
                                        <xsl:if test="not(BankAccount/BankAccountNumber='')">
                                            <Othr>
                                                <Id>
												<xsl:choose>
												<xsl:when test="(($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
                                                    <xsl:value-of select="substring(BankAccount/BankAccountNumber,5)" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="BankAccount/BankAccountNumber" />
												</xsl:otherwise>
												</xsl:choose>
                                                </Id>
                                            </Othr>
                                        </xsl:if>
                                    </xsl:if>
                                </Id>
                            </xsl:if>
                            <xsl:if test="(($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)'))">
                                <xsl:if test="not(BankAccount/BankAccountType/Code='')">
                                    <Tp>
                                        <Cd>
                                            <xsl:value-of select="BankAccount/BankAccountType/Code" />
                                        </Cd>
                                    </Tp>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                <xsl:if test="not(BankAccount/BankAccountCurrency/Code='')">
                                    <Ccy>
                                        <xsl:value-of select="BankAccount/BankAccountCurrency/Code" />
                                    </Ccy>
                                </xsl:if>
                            </xsl:if>
                        </DbtrAcct>
                        <DbtrAgt>
                            <FinInstnId>
                                <xsl:if test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                    <xsl:if test="not(BankAccount/SwiftCode='')">
                                        <BIC>
                                            <xsl:value-of select="BankAccount/SwiftCode" />
                                        </BIC>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC')or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                                    <ClrSysMmbId>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC'))">
                                            <ClrSysId>
                                                <Cd>
                                                    <xsl:text>USABA</xsl:text>
                                                </Cd>
                                            </ClrSysId>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                                            <xsl:if test="not(BankAccount/BranchNumber='')">
                                                <MmbId>
                                                    <xsl:value-of select="BankAccount/BranchNumber" />
                                                </MmbId>
                                            </xsl:if>
                                        </xsl:if>
                                    </ClrSysMmbId>
                                </xsl:if>
								<xsl:if test="($TMPT='IE / FR / DE / GB Wire Cross Border/FX')">
								<xsl:if test="not(BankAccount/BranchNumber='')">
                                    <ClrSysMmbId>
                                       
                                       
                                            
                                                <MmbId>
                                                    <xsl:value-of select="BankAccount/BranchNumber" />
                                                </MmbId>
                                            
                                       
                                    </ClrSysMmbId>
									</xsl:if>
								 </xsl:if>
                             
                                <xsl:if test="(($TMPT='GB CHAPS') or ($TMPT='GB BACS'))">
                                    <xsl:if test="not(BankAccount/BankName='')">
                                        <Nm>
                                            <xsl:value-of select="substring(BankAccount/BankName,1,140)" />
                                        </Nm>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                    <xsl:if test="not(BankAccount/BankAddress/Country='')">
                                        <PstlAdr>
                                            <Ctry>
                                                <xsl:value-of select="BankAccount/BankAddress/Country" />
                                            </Ctry>
                                        </PstlAdr>
                                    </xsl:if>
                                </xsl:if>
                            </FinInstnId>
                            <xsl:if test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                <xsl:if test="not(BankAccount/BankAccountNumber='')">
                                    <BrnchId>
                                        <Id>
                                            <xsl:choose>
                                                <xsl:when test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
                                                    <xsl:value-of select="substring(BankAccount/BankAccountNumber,1,4)" />
                                                </xsl:when>
                                                <xsl:when test="($TMPT='Leumi Domestic Wire/Cross Border/International/FX')">
                                                    <xsl:text>9999</xsl:text>
                                                </xsl:when>
                                            </xsl:choose>
                                        </Id>
                                    </BrnchId>
                                </xsl:if>
                            </xsl:if>
                        </DbtrAgt>
                        <xsl:if test="(($TMPT='GB BACS') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                            <ChrgBr>
                                <xsl:choose>
                                    <xsl:when test="($TMPT='AU ACH Low Value')">
                                        <xsl:text>DEBT</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="not(BankCharges/BankChargeBearer/Code='')">
                                        <xsl:value-of select="BankCharges/BankChargeBearer/Code" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>SHAR</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </ChrgBr>
                        </xsl:if>
                        <xsl:variable name="paymentdetails" select="PaymentDetails" />
                    
                           
                            <CdtTrfTxInf>
                                <PmtId>
                                    <xsl:if test="(($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                        <InstrId>
                                            <xsl:value-of select="PaymentNumber/PaymentReferenceNumber" />
                                        </InstrId>
                                    </xsl:if>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                        <EndToEndId>
                                            <xsl:value-of select="PaymentNumber/PaymentReferenceNumber" />
                                        </EndToEndId>
                                    </xsl:if>
                                </PmtId>
                               
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                    <Amt>
                                        <InstdAmt>
                                            <xsl:attribute name="Ccy">
                                                <xsl:value-of select="PaymentAmount/Currency/Code" />
                                            </xsl:attribute>
                                            <xsl:value-of select="format-number(PaymentAmount/Value, '##0.00')" />
                                        </InstdAmt>
                                    </Amt>
                                </xsl:if>
                                <xsl:if test="(($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                                    <Amt>
                                        <InstdAmt>
                                            <xsl:attribute name="Ccy">
                                                <xsl:value-of select="DocumentPayable/TotalDocumentAmount/Currency/Code" />
                                            </xsl:attribute>
                                            <xsl:value-of select="format-number(DocumentPayable/TotalDocumentAmount/Value, '##0.00')" />
                                        </InstdAmt>
                                    </Amt>
                                </xsl:if>
                                <xsl:if test="(($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
                                    <ChrgBr>
                                        <xsl:choose>
                                            <xsl:when test="not(BankCharges/BankChargeBearer/Code='')">
                                                <xsl:value-of select="BankCharges/BankChargeBearer/Code" />
                                            </xsl:when>
                                            <xsl:otherwise>SHAR</xsl:otherwise>
                                        </xsl:choose>
                                    </ChrgBr>
                                </xsl:if>
                                <CdtrAgt>
                                    <FinInstnId>
                                        <xsl:if test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX') or ($TMPT='US Wire Cross Border / US Wire FX'))">
                                            <xsl:if test="not(PayeeBankAccount/SwiftCode='')">
                                                <BIC>
                                                    <xsl:value-of select="PayeeBankAccount/SwiftCode" />
                                                </BIC>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD')or ($TMPT='US WIRE DOMESTIC')  or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)'))">
                                            <ClrSysMmbId>
                                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)')) ">
                                                    <ClrSysId>
                                                        <Cd>
                                                            <xsl:choose>
                                                                <xsl:when test="(($TMPT='US ACH CCD') or ($TMPT='US WIRE DOMESTIC'))">
                                                                    <xsl:text>USABA</xsl:text>
                                                                </xsl:when>
                                                                <xsl:when test="(($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)'))">
                                                                    <xsl:text>CACPA</xsl:text>
                                                                </xsl:when>
                                                                <xsl:when test="(($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic'))">
                                                                    <xsl:text>AUBSB</xsl:text>
                                                                </xsl:when>
                                                            </xsl:choose>
                                                        </Cd>
                                                    </ClrSysId>
                                                </xsl:if>
                                                <xsl:if test="(($TMPT='US ACH CCD')or ($TMPT='US WIRE DOMESTIC') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)'))">
                                                    <xsl:if test="not(PayeeBankAccount/BranchNumber='')">
                                                        <MmbId>
                                                            <xsl:value-of select="PayeeBankAccount/BranchNumber" />
                                                        </MmbId>
                                                    </xsl:if>
                                                </xsl:if>
                                            </ClrSysMmbId>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
                                            <Nm>
                                                <xsl:value-of select="substring(PayeeBankAccount/BankName,1,140)" />
                                            </Nm>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX') or ($TMPT='IE / FR / DE Wire Domestic'))">
                                            <PstlAdr>
                                                <xsl:if test="(($TMPT='US WIRE DOMESTIC') or ($TMPT='US Wire Cross Border / US Wire FX'))">
                                                    <xsl:if test="not(PayeeBankAccount/BankAddress/PostalCode='')">
                                                        <PstCd>
														<xsl:value-of select= "translate(PayeeBankAccount/BankAddress/PostalCode,'-','')" />
                                                            
                                                        </PstCd>
                                                    </xsl:if>
                                                </xsl:if>
                                                <xsl:if test="(($TMPT='US WIRE DOMESTIC') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                                                    <xsl:if test="not(PayeeBankAccount/BankAddress/City='')">
                                                        <TwnNm>
                                                            <xsl:value-of select="PayeeBankAccount/BankAddress/City" />
                                                        </TwnNm>
                                                    </xsl:if>
                                                </xsl:if>
                                                <xsl:if test="(($TMPT='US WIRE DOMESTIC') or ($TMPT='US Wire Cross Border / US Wire FX'))">
                                                    <xsl:if test="not(PayeeBankAccount/BankAddress/State='')">
                                                        <CtrySubDvsn>
                                                            <xsl:value-of select="PayeeBankAccount/BankAddress/State" />
                                                        </CtrySubDvsn>
                                                    </xsl:if>
                                                </xsl:if>
                                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX') or ($TMPT='IE / FR / DE Wire Domestic'))">
                                                    <xsl:if test="not(PayeeBankAccount/BankAddress/Country='')">
                                                        <Ctry>
                                                            <xsl:value-of select="PayeeBankAccount/BankAddress/Country" />
                                                        </Ctry>
                                                    </xsl:if>
                                                </xsl:if>
                                                <xsl:if test="(($TMPT='US WIRE DOMESTIC') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                                                    <xsl:if test="not(PayeeBankAccount/BankAddress/AddressLine1='')">
                                                        <AdrLine>
                                                            <xsl:value-of select="substring(concat(PayeeBankAccount/BankAddress/AddressLine1,' ',PayeeBankAccount/BankAddress/AddressLine2),1,70)" />
                                                        </AdrLine>
                                                    </xsl:if>
                                                </xsl:if>
                                            </PstlAdr>
                                        </xsl:if>
                                    </FinInstnId>
                                </CdtrAgt>
                                <Cdtr>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                        
                                            <Nm>
                                                <xsl:value-of select="substring(SupplierorParty/Name,1,140)" />
                                            </Nm>
                                        </xsl:if>
                                    
                                    <PstlAdr>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS'))">
                                            <xsl:if test="not(SupplierorParty/Address/AddressLine1='')">
                                                <StrtNm>
                                                    <xsl:value-of select="substring(SupplierorParty/Address/AddressLine1,1,70)" />
                                                </StrtNm>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC')  or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP Wire Domestic/International') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
                                            <xsl:if test="not(SupplierorParty/Address/PostalCode='')">
                                                <PstCd>
												<xsl:value-of select= "translate(SupplierorParty/Address/PostalCode,'-','')" />
                                                    
                                                </PstCd>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE'))">
                                            <xsl:if test="not(SupplierorParty/Address/City='')">
                                                <TwnNm>
                                                    <xsl:value-of select="SupplierorParty/Address/City" />
                                                </TwnNm>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX')or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)'))">
                                            <xsl:if test="not(SupplierorParty/Address/State='')">
                                                <CtrySubDvsn>
                                                    <xsl:value-of select="SupplierorParty/Address/State" />
                                                </CtrySubDvsn>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                            <xsl:if test="not(SupplierorParty/Address/Country='')">
                                                <Ctry>
                                                    <xsl:value-of select="SupplierorParty/Address/Country" />
                                                </Ctry>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                            <xsl:if test="not(SupplierorParty/Address/AddressLine1='')">
                                                <AdrLine>
                                                    <xsl:value-of select="substring(concat(SupplierorParty/Address/AddressLine1,' ',SupplierorParty/Address/AddressLine2),1,70)" />
                                                </AdrLine>
                                            </xsl:if>
                                        </xsl:if>
                                    </PstlAdr>
									<xsl:if test="($TMPT='JP PAYACH')">
									<Id>
									<OrgId>
									<Othr>
									<Id>
										<xsl:value-of select="SupplierorParty/SupplierNumber" />
									</Id>
									</Othr>
									</OrgId>
									</Id>
									</xsl:if>
                                    <!--employee payments-->
                                </Cdtr>
                                <CdtrAcct>
                                    <Id>
                                        <xsl:if test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE SEPA'))">
                                            <xsl:if test="not(PayeeBankAccount/IBANNumber='')">
                                                <IBAN>
                                                    <xsl:value-of select="translate(PayeeBankAccount/IBANNumber,' ','')" />
                                                </IBAN>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='Leumi Domestic Wire/Cross Border/International/FX') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX'))">
                                            <xsl:choose>
                                                <xsl:when test="not(PayeeBankAccount/IBANNumber='')">
                                                    <IBAN>
                                                        <xsl:value-of select="translate(PayeeBankAccount/IBANNumber,' ','')" />
                                                    </IBAN>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <Othr>
                                                        <Id>
                                                            <xsl:value-of select="PayeeBankAccount/BankAccountNumber" />
                                                        </Id>
                                                    </Othr>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or  ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                                            <xsl:if test="not(PayeeBankAccount/BankAccountNumber='')">
                                                <Othr>
                                                    <Id>
                                                        <xsl:value-of select="PayeeBankAccount/BankAccountNumber" />
                                                    </Id>
                                                </Othr>
                                            </xsl:if>
                                        </xsl:if>
                                    </Id>
                                    <xsl:if test="(($TMPT='US ACH CCD')  or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC'))">
                                        <Tp>
                                            <Cd>
                                                <xsl:choose>
                                                    <xsl:when test="(PayeeBankAccount/BankAccountType/Code='CHECKING') or (PayeeBankAccount/BankAccountType/Code='') or (PayeeBankAccount/BankAccountType/Code='UNKNOWN')">
                                                        <xsl:text>CASH</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="(PayeeBankAccount/BankAccountType/Code='SAVINGS')">
                                                        <xsl:text>SVGS</xsl:text>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </Cd>
                                        </Tp>
                                    </xsl:if>
									 <xsl:if test="(($TMPT='JP PAYACH'))">
                                        <Tp>
                                            <Cd>
                                                <xsl:choose>
                                                    <xsl:when test="(PayeeBankAccount/BankAccountType/Code='CHECKING') or (PayeeBankAccount/BankAccountType/Code='') or (PayeeBankAccount/BankAccountType/Code='UNKNOWN')">
                                                        <xsl:text>CACC</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="(PayeeBankAccount/BankAccountType/Code='SAVINGS')">
                                                        <xsl:text>SVGS</xsl:text>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </Cd>
                                        </Tp>
                                    </xsl:if>
									
									
									
                                    <xsl:if test="(($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)'))">
                                        <Ccy>
                                            <xsl:value-of select="PayeeBankAccount/BankAccountCurrency/Code" />
                                        </Ccy>
                                    </xsl:if>
                                    <xsl:if test="(($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX'))">
                                        <Nm>
                                            <xsl:value-of select="substring(PayeeBankAccount/BankName,1,140)" />
                                        </Nm>
                                    </xsl:if>
                                </CdtrAcct>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
                                    <InstrForCdtrAgt>
                                        <InstrInf>
                                            <xsl:choose>
                                                <xsl:when test="($TMPT='US ACH CCD')">
                                                    <xsl:text>DocuSign</xsl:text>
                                                </xsl:when>
                                                <xsl:when test="(($TMPT='JP PAYACH') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
                                                    <xsl:text>/ACC/NNKNI</xsl:text>
                                                </xsl:when>
                                            </xsl:choose>
                                        </InstrInf>
                                    </InstrForCdtrAgt>
                                </xsl:if>
                                <xsl:if test="(($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
                                    <RgltryRptg>
                                        <DbtCdtRptgInd>
                                            <xsl:text>DEBT</xsl:text>
                                        </DbtCdtRptgInd>
                                        <Dtls>
                                            <Tp>PaymentTypeCode</Tp>
                                            <Inf>NTR</Inf>
                                        </Dtls>
                                        <Dtls>
                                            <Tp>PurposeOfPayment</Tp>
                                            <Inf>9999</Inf>
                                        </Dtls>
                                    </RgltryRptg>
                                </xsl:if>
								<xsl:variable name="BankCountry">
									<xsl:value-of select="BankAccount/BankAddress/Country" />
								</xsl:variable>
								
								 <xsl:if test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)')  or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='US ACH CCD'))">
								
                                <RmtInf>
                                    <xsl:for-each select="DocumentPayable">
									
									
									
                                        <xsl:if test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)')  or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                            <Ustrd>
                                                <xsl:choose>
                                                    <xsl:when test="(($TMPT='US Wire Cross Border / US Wire FX') or ($TMPT='US WIRE DOMESTIC'))">
                                                        <xsl:text>WPBD</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="(($TMPT='IE / FR / DE Wire Domestic') or ($TMPT='IE / FR / DE SEPA') or ($TMPT='AU ACH Low Value') or ($TMPT='AU Wire Domestic') or ($TMPT='AU Wire CrossBorder/FX') or ($TMPT='CA PAYACH') or ($TMPT='CA Wire Domestic (PAYEFT)') or ($TMPT='CA SWIFT Wire (CrossBorder)') or ($TMPT='CA FX SWIFT Wire (FXP)') or ($TMPT='SG PAYACH') or ($TMPT='SG Wire Domestic (PAYEFT)') or ($TMPT='SG FX WIRE (PAYIWT)') or ($TMPT='SG INTERNATIONAL WIRE') or ($TMPT='IE / FR / DE / GB Wire Cross Border/FX') or ($TMPT='GB CHAPS') or ($TMPT='GB BACS') or ($TMPT='Leumi Domestic Wire/Cross Border/International/FX'))">
                                                        <xsl:value-of select="DocumentNumber/ReferenceNumber" />
                                                    </xsl:when>
                                                    <xsl:when test="(($TMPT='JP Wire Domestic/International') or ($TMPT='JP Wire CrossBorder FX'))">
                                                        <xsl:text>NNKNI</xsl:text>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </Ustrd>
                                        </xsl:if>
                                        <xsl:if test="($TMPT='SG FX WIRE (PAYIWT)')">
                                            <Ustrd>
                                                <xsl:choose>
                                                    <xsl:when test="(($BankCountry='SG') and (PaymentReason/Code='CONCUR'))">
                                                        <xsl:text>OTHR</xsl:text>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:text>SUPP</xsl:text>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </Ustrd>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD'))">
                                            <Strd>
                                                <RfrdDocInf>
                                                    <Tp>
                                                        <CdOrPrtry>
                                                            <Cd>
                                                                <xsl:choose>
                                                                    <xsl:when test="(DocumentType/Code='STANDARD') or (DocumentType/Code='INTEREST')">
                                                                        <xsl:text>CINV</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:when test="(DocumentType/Code='CREDIT')">
                                                                        <xsl:text>CREN</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:when test="(DocumentType/Code='DEBIT')">
                                                                        <xsl:text>DEBN</xsl:text>
                                                                    </xsl:when>
                                                                </xsl:choose>
                                                            </Cd>
                                                        </CdOrPrtry>
                                                    </Tp>
                                                    <Nb>
                                                        <xsl:value-of select="DocumentNumber/ReferenceNumber" />
                                                    </Nb>
                                                    <RltdDt>
                                                        <xsl:value-of select="DocumentDate" />
                                                    </RltdDt>
                                                </RfrdDocInf>
                                                <RfrdDocAmt>
                                                    <DuePyblAmt>
                                                        <xsl:attribute name="Ccy">
                                                            <xsl:value-of select="TotalDocumentAmount/Currency/Code" />
                                                        </xsl:attribute>
                                                        <xsl:value-of select="format-number(TotalDocumentAmount/Value, '##0.00')" />
                                                    </DuePyblAmt>
                                                    <DscntApldAmt>
                                                        <xsl:attribute name="Ccy">
                                                            <xsl:value-of select="DiscountTaken/Amount/Currency/Code" />
                                                        </xsl:attribute>
                                                        <xsl:value-of select="format-number(DiscountTaken/Amount/Value, '##0.00')" />
                                                    </DscntApldAmt>
                                                    <RmtdAmt>
                                                        <xsl:attribute name="Ccy">
                                                            <xsl:value-of select="PaymentAmount/Currency/Code" />
                                                        </xsl:attribute>
                                                        <xsl:value-of select="format-number(PaymentAmount/Value, '##0.00')" />
                                                    </RmtdAmt>
                                                </RfrdDocAmt>
                                            </Strd>
                                        </xsl:if>
                                    </xsl:for-each>
                                </RmtInf>
								</xsl:if>
                            </CdtTrfTxInf>
                       
                    </PmtInf>
                </xsl:for-each>
            </CstmrCdtTrfInitn>
        </Document>
    </xsl:template>
</xsl:stylesheet>