<?xml version="1.0" encoding="UTF-8"?>
<!--   $Header: fusionapps/fin/iby/bipub/shared/runFormat/reports/DisbursementPaymentFileFormats/ISO20022CGI.xsl /st_fusionapps_pt-v2mib/4 2018/04/04 07:35:17 jswirsky Exp $   
  -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output omit-xml-declaration="no" />
    <xsl:output method="xml" />
    <xsl:template name="while">
        <xsl:param name="VALUE" />
        <xsl:param name="length" />
        <xsl:param name="RefNum" />
        <xsl:param name="ConFig" />
        <xsl:param name="IsSecond" />
        <xsl:variable name="VALUE1" select="$VALUE - 1" />
        <xsl:variable name="VALUE2" select="$length" />
        <xsl:variable name="VALUE3" select="$RefNum" />
        <xsl:variable name="VALUE4" select="$ConFig" />
        <xsl:variable name="VALUE7" select="$IsSecond" />
        <!-- your evaluation -->
        <xsl:choose>
            <xsl:when test="$VALUE1 &gt; 0">
                <xsl:variable name="TMPT1">
                    <xsl:choose>
                        <xsl:when test="($VALUE7 = 'true')">
                            <xsl:value-of select="number(substring($VALUE3,$VALUE1,1)) * 2 " />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="number(substring($VALUE3,$VALUE1,1)) * 1 " />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="VALUE4">
                    <xsl:choose>
                        <xsl:when test="string-length($TMPT1) > 1">
                            <xsl:value-of select="(number(substring($TMPT1,1,1)) + number(substring($TMPT1,2,1))) + $VALUE4" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$TMPT1 + $VALUE4" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:call-template name="while">
                    <xsl:with-param name="VALUE" select="$VALUE1" />
                    <xsl:with-param name="length" select="$VALUE2" />
                    <xsl:with-param name="RefNum" select="$VALUE3" />
                    <xsl:with-param name="ConFig" select="$VALUE4" />
                    <xsl:with-param name="IsSecond" select="not($VALUE7)" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="VALUE5" select="$VALUE4 div 10" />
                <xsl:variable name="VALUE6" select="$VALUE4 mod 10"/>
                <xsl:variable name="ControlFigure">
                    <xsl:choose>
                        <xsl:when test="$VALUE6 &gt;= 1">
                            <xsl:value-of select="(number(substring($VALUE5,1,1)) + 1) * 10"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$VALUE5 * 10"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="concat($VALUE3,($ControlFigure - $VALUE4))" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="OutboundPaymentInstruction">
        <Document
            xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <xsl:variable name="instrid" select="PaymentInstructionInfo/InstructionReferenceNumber" />
            <xsl:variable name="TMPT" />
            <xsl:variable name="VALUE" />
            <xsl:variable name="AccNum" />
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
                    <InitgPty>
                        <Nm>
                            <xsl:value-of select="substring(InstructionGrouping/Payer/LegalEntityName,1,140)" />
                        </Nm>
                    </InitgPty>
                </GrpHdr>
                <xsl:for-each select="OutboundPayment">
                    <xsl:sort select="PaymentNumber/PaymentReferenceNumber" />
                    <!--Start of payment information block-->
                    <xsl:variable name="TMPT">
                        <xsl:choose>
                            <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_PLUSGIRO') and (BankAccount/BankAddress/Country = 'SE') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                <xsl:value-of select="'SE Low Value / Plusgiro'" />
                            </xsl:when>
                            <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'SE') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                <xsl:value-of select="'SE Wire Domestic'" />
                            </xsl:when>
                            <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (BankAccount/BankAddress/Country = 'SE') and ((PayeeBankAccount/BankAddress/Country!=BankAccount/BankAddress/Country) or (BankAccount/BankAccountCurrency/Code!=PaymentAmount/Currency/Code)))">
                                <xsl:value-of select="'SE Wire CrossBorder / FX'" />
                            </xsl:when>
                            <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_BANKGIRO') and (BankAccount/BankAddress/Country = 'SE') and ((PayeeBankAccount/BankAddress/Country=BankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                <xsl:value-of select="'SE Low Value / Bankgiro'" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <PmtInf>
                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                            <PmtInfId>
                                <xsl:choose>
                                    <xsl:when test="(($TMPT='SE Low Value / Plusgiro') or ($TMPT='SE Low Value / Bankgiro'))">
                                        <xsl:value-of select="concat('CITI_CADS_','ELEC_',PaymentNumber/PaymentReferenceNumber,'_',$instrid)" />
                                    </xsl:when>
                                    <xsl:when test="($TMPT='SE Wire Domestic')">
                                        <xsl:value-of select="concat('CITI_CADS_','WIRE_DOM_',PaymentNumber/PaymentReferenceNumber,'_',$instrid)" />
                                    </xsl:when>
                                    <xsl:when test="($TMPT='SE Wire CrossBorder / FX')">
                                        <xsl:value-of select="concat('CITI_CADS_','WIRE_CB_',PaymentNumber/PaymentReferenceNumber,'_',$instrid)" />
                                    </xsl:when>
                                </xsl:choose>
                            </PmtInfId>
                        </xsl:if>
                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                            <PmtMtd>
                                <xsl:text>TRF</xsl:text>
                            </PmtMtd>
                        </xsl:if>
                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                            <PmtTpInf>
                                <xsl:if test="(($TMPT='SE Low Value / Plusgiro') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                    <SvcLvl>
                                        <Cd>
                                            <xsl:choose>
                                                <xsl:when test="(($TMPT='SE Low Value / Plusgiro') or ($TMPT='SE Low Value / Bankgiro'))">
                                                    <xsl:text>NURG</xsl:text>
                                                </xsl:when>
                                                <xsl:when test="($TMPT='SE Wire CrossBorder / FX')">
                                                    <xsl:text>URGP</xsl:text>
                                                </xsl:when>
                                            </xsl:choose>
                                        </Cd>
                                    </SvcLvl>
                                </xsl:if>
                                <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                    <LclInstrm>
                                        <xsl:if test="($TMPT='SE Low Value / Plusgiro')">
                                            <Cd>
                                                <xsl:text>0500</xsl:text>
                                            </Cd>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                            <Prtry>
                                                <xsl:choose>
                                                    <xsl:when test="($TMPT='SE Low Value / Plusgiro')">
                                                        <xsl:text>CITI941</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="($TMPT='SE Wire Domestic')">
                                                        <xsl:text>CITI391</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="($TMPT='SE Wire CrossBorder / FX')">
                                                        <xsl:text>CITI392</xsl:text>
                                                    </xsl:when>
                                                    <xsl:when test="($TMPT='SE Low Value / Bankgiro')">
                                                        <xsl:text>CITI147</xsl:text>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </Prtry>
                                        </xsl:if>
                                    </LclInstrm>
                                </xsl:if>
                            </PmtTpInf>
                        </xsl:if>
                        <!--End of payment type information block-->
                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                            <ReqdExctnDt>
                                <xsl:value-of select="PaymentDate" />
                            </ReqdExctnDt>
                        </xsl:if>
                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro') or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                            <Dbtr>
                                <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                    <Nm>
                                        <xsl:value-of select="substring(Payer/Name,1,35)" />
                                    </Nm>
                                </xsl:if>
                                <xsl:if test="(($TMPT='SE Low Value / Plusgiro') or ($TMPT='SE Wire Domestic'))">
                                    <PstlAdr>
                                        <xsl:if test="($TMPT='SE Low Value / Plusgiro')">
                                            <xsl:if test="not(Payer/Address/PostalCode='')">
                                                <PstCd>
                                                    <xsl:value-of select= "translate(translate(Payer/Address/PostalCode,'-',''),' ','')" />
                                                </PstCd>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="($TMPT='SE Low Value / Plusgiro')">
                                            <xsl:if test="not(Payer/Address/City='')">
                                                <TwnNm>
                                                    <xsl:value-of select="Payer/Address/City" />
                                                </TwnNm>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic'))">
                                            <xsl:if test="not(Payer/Address/AddressLine1='')">
                                                <AdrLine>
                                                    <xsl:value-of select="substring(concat(Payer/Address/AddressLine1,' ',Payer/Address/AddressLine2),1,70)" />
                                                </AdrLine>
                                            </xsl:if>
                                        </xsl:if>
                                    </PstlAdr>
                                </xsl:if>
                            </Dbtr>
                        </xsl:if>
                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                            <DbtrAcct>
                                <Id>
                                    <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                        <Othr>
                                            <xsl:if test="not(BankAccount/BankAccountNumber='')">
                                                <Id>
                                                    <xsl:value-of select="BankAccount/BankAccountNumber" />
                                                </Id>
                                            </xsl:if>
                                            <xsl:if test="(($TMPT='SE Low Value / Plusgiro'))">
                                                <SchmeNm>
                                                    <Cd>
                                                        <xsl:text>BBAN</xsl:text>
                                                    </Cd>
                                                </SchmeNm>
                                            </xsl:if>
                                            <xsl:if test="(($TMPT='SE Low Value / Bankgiro'))">
                                                <SchmeNm>
                                                    <Prtry>
                                                        <xsl:text>BGNR</xsl:text>
                                                    </Prtry>
                                                </SchmeNm>
                                            </xsl:if>
                                        </Othr>
                                    </xsl:if>
                                </Id>
                                <xsl:if test="($TMPT='SE Wire Domestic')">
                                    <Ccy>
                                        <xsl:value-of select="BankAccount/BankAccountCurrency/Code" />
                                    </Ccy>
                                </xsl:if>
                            </DbtrAcct>
                        </xsl:if>
                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                            <DbtrAgt>
                                <FinInstnId>
                                    <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                        <xsl:if test="not(BankAccount/SwiftCode='')">
                                            <BIC>
                                                <xsl:value-of select="BankAccount/SwiftCode" />
                                            </BIC>
                                        </xsl:if>
                                    </xsl:if>
                                </FinInstnId>
                                <xsl:if test="($TMPT='SE Wire Domestic')">
                                    <xsl:if test="not(BankAccount/BranchNumber='')">
                                        <BrnchId>
                                            <Id>
                                                <xsl:value-of select="BankAccount/BranchNumber" />
                                            </Id>
                                        </BrnchId>
                                    </xsl:if>
                                </xsl:if>
                            </DbtrAgt>
                        </xsl:if>
                        <xsl:if test="($TMPT='SE Wire Domestic')">
                            <ChrgBr>
                                <xsl:text>SHAR</xsl:text>
                            </ChrgBr>
                        </xsl:if>
                        <xsl:if test="($TMPT='SE Wire Domestic')">
                            <xsl:if test="not(BankAccount/BankAccountNumber='')">
                                <ChrgsAcct>
                                    <Id>
                                        <Othr>
                                            <Id>
                                                <xsl:value-of select="BankAccount/BankAccountNumber" />
                                            </Id>
                                        </Othr>
                                    </Id>
                                </ChrgsAcct>
                            </xsl:if>
                        </xsl:if>
                        <xsl:variable name="AccNum" select="PayeeBankAccount/BankAccountNumber"/>
                        <!--Start of credit transaction block-->
                        <CdtTrfTxInf>
                            <PmtId>
                                <xsl:if test="($TMPT='SE Wire CrossBorder / FX')">
                                    <InstrId>
                                        <xsl:value-of select="PaymentNumber/PaymentReferenceNumber" />
                                    </InstrId>
                                </xsl:if>
                                <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                    <EndToEndId>
                                        <xsl:value-of select="PaymentNumber/PaymentReferenceNumber" />
                                    </EndToEndId>
                                </xsl:if>
                            </PmtId>
                            <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                <Amt>
                                    <InstdAmt>
                                        <xsl:attribute name="Ccy">
                                            <xsl:value-of select="PaymentAmount/Currency/Code" />
                                        </xsl:attribute>
                                        <xsl:value-of select="format-number(PaymentAmount/Value, '##0.00')" />
                                    </InstdAmt>
                                </Amt>
                            </xsl:if>
                            <xsl:if test="($TMPT='SE Wire CrossBorder / FX')">
                                <xsl:if test="not(BankCharges/BankChargeBearer/Code='')">
                                    <ChrgBr>
                                        <xsl:value-of select="BankCharges/BankChargeBearer/Code" />
                                    </ChrgBr>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="($TMPT='SE Wire Domestic')">
                                <ChrgBr>
                                    <xsl:text>SHAR</xsl:text>
                                </ChrgBr>
                            </xsl:if>
                            <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Low Value / Bankgiro'))">
                                <CdtrAgt>
                                    <FinInstnId>
                                        <xsl:if test="(($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX'))">
                                            <xsl:if test="not(PayeeBankAccount/SwiftCode='')">
                                                <BIC>
                                                    <xsl:value-of select="PayeeBankAccount/SwiftCode" />
                                                </BIC>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro'))">
                                            <ClrSysMmbId>
                                                <xsl:if test="(($TMPT='SE Low Value / Plusgiro'))">
                                                    <ClrSysId>
                                                        <Cd>
                                                            <xsl:text>SESBA</xsl:text>
                                                        </Cd>
                                                    </ClrSysId>
                                                </xsl:if>
                                                <xsl:if test="not(PayeeBankAccount/BankAccountNumber='')">
                                                    <MmbId>
                                                        <xsl:value-of select="PayeeBankAccount/BankAccountNumber" />
                                                    </MmbId>
                                                </xsl:if>
                                            </ClrSysMmbId>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='SE Low Value / Bankgiro'))">
                                            <xsl:if test="not(PayeeBankAccount/BankAccountNumber='')">
                                                <ClrSysMmbId>
                                                    <MmbId>
                                                        <xsl:choose>
                                                            <xsl:when test="string-length(PayeeBankAccount/BankAccountNumber) &lt; 10" >
                                                                <xsl:value-of select="substring(concat('0000000000',PayeeBankAccount/BankAccountNumber), string-length(PayeeBankAccount/BankAccountNumber) + 1, 10)" />
                                                            </xsl:when>
                                                            <xsl:when test="string-length(PayeeBankAccount/BankAccountNumber) >= 10" >
                                                                <xsl:value-of select="PayeeBankAccount/BankAccountNumber" />
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </MmbId>
                                                </ClrSysMmbId>
                                            </xsl:if>
                                        </xsl:if>
                                        <xsl:if test="($TMPT='SE Wire Domestic')">
                                            <xsl:if test="not(PayeeBankAccount/BankAddress/AddressLine1='')">
                                                <PstlAdr>
                                                    <AdrLine>
                                                        <xsl:value-of select="substring(concat(PayeeBankAccount/BankAddress/AddressLine1,' ',PayeeBankAccount/BankAddress/AddressLine2),1,70)" />
                                                    </AdrLine>
                                                </PstlAdr>
                                            </xsl:if>
                                        </xsl:if>
                                    </FinInstnId>
                                </CdtrAgt>
                            </xsl:if>
                            <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX'))">
                                <Cdtr>
                                    <xsl:if test="(($TMPT='SE Low Value / Plusgiro')  or ($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX'))">
                                        <Nm>
                                            <xsl:value-of select="translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(translate(substring(SupplierorParty/Name,1,35),'_',' '),';',' '),'\',' '),'|',' '),']',' '),'[',' '),'=',' '),'*',' '),'^',' '),'%',' '),'$',' '),'#',' '),'@',' '),'!',' '),'~',' '),'&amp;',' '),'`',' '),'&gt;',' '),'&gt;',' ')" />
                                        </Nm>
                                    </xsl:if>
                                    <xsl:if test="(($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX'))">
                                        <PstlAdr>
                                            <xsl:if test="(($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX'))">
                                                <xsl:if test="not(SupplierorParty/Address/Country='')">
                                                    <Ctry>
                                                        <xsl:value-of select="SupplierorParty/Address/Country" />
                                                    </Ctry>
                                                </xsl:if>
                                            </xsl:if>
                                            <xsl:if test="($TMPT='SE Wire Domestic')">
                                                <xsl:if test="not(SupplierorParty/Address/AddressLine1='')">
                                                    <AdrLine>
                                                        <xsl:value-of select="substring(concat(SupplierorParty/Address/AddressLine1,' ',SupplierorParty/Address/AddressLine20),1,70)" />
                                                    </AdrLine>
                                                </xsl:if>
                                            </xsl:if>
                                        </PstlAdr>
                                    </xsl:if>
                                    <xsl:if test="($TMPT='SE Wire Domestic')">
                                        <xsl:if test="not(PayeeBankAccount/SwiftCode='')">
                                            <Id>
                                                <OrgId>
                                                    <BICOrBEI>
                                                        <xsl:value-of select="PayeeBankAccount/SwiftCode" />
                                                    </BICOrBEI>
                                                </OrgId>
                                            </Id>
                                        </xsl:if>
                                    </xsl:if>
                                    <!--employee payments-->
                                </Cdtr>
                            </xsl:if>
                            <xsl:if test="(($TMPT='SE Wire Domestic') or ($TMPT='SE Wire CrossBorder / FX'))">
                                <CdtrAcct>
                                    <Id>
                                        <xsl:if test="(($TMPT='SE Wire CrossBorder / FX') or ($TMPT='SE Wire Domestic'))">
                                            <xsl:choose>
                                                <xsl:when test="not(PayeeBankAccount/IBANNumber = '')">
                                                    <IBAN>
                                                        <xsl:value-of select="translate(PayeeBankAccount/IBANNumber,' ','')" />
                                                    </IBAN>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:if test="not(PayeeBankAccount/BankAccountNumber = '')">
                                                        <Othr>
                                                            <Id>
                                                                <xsl:value-of select="PayeeBankAccount/BankAccountNumber" />
                                                            </Id>
                                                        </Othr>
                                                    </xsl:if>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                    </Id>
                                    <xsl:if test="($TMPT='SE Wire Domestic')">
                                        <xsl:choose>
                                            <xsl:when test="not(PayeeBankAccount/BankName='')">
                                                <xsl:if test="not(PayeeBankAccount/AlternateBankName='')">
                                                    <Nm>
                                                        <xsl:value-of select="substring(PayeeBankAccount/AlternateBankName,1, 140)" />
                                                    </Nm>
                                                </xsl:if>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <Nm>
                                                    <xsl:value-of select="substring(PayeeBankAccount/BankName,1,140)" />
                                                </Nm>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </CdtrAcct>
                            </xsl:if>
                            <xsl:if test="(($TMPT='SE Wire Domestic') or ($TMPT='SE Low Value / Plusgiro') or ($TMPT='SE Low Value / Bankgiro'))">
                                <RmtInf>
                                    <xsl:for-each select="DocumentPayable">
                                        <xsl:if test="($TMPT='SE Wire Domestic')">
                                            <Ustrd>
                                                <xsl:value-of select="DocumentNumber/ReferenceNumber" />
                                            </Ustrd>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='SE Low Value / Plusgiro') or ($TMPT='SE Low Value / Bankgiro'))">
                                            <Strd>
                                                <CdtrRefInf>
                                                    <xsl:if test="(($TMPT='SE Low Value / Plusgiro'))">
                                                        <Tp>
                                                            <CdOrPrtry>
                                                                <Cd>
                                                                    <xsl:text>SCOR</xsl:text>
                                                                </Cd>
                                                            </CdOrPrtry>
                                                        </Tp>
                                                    </xsl:if>
                                                    <xsl:if test="(($TMPT='SE Low Value / Plusgiro') or ($TMPT='SE Low Value / Bankgiro'))">
                                                        <xsl:if test="not(DocumentNumber/ReferenceNumber = '')">
                                                            <Ref>
                                                                <xsl:choose>
                                                                    <xsl:when test="(string-length(translate(translate((DocumentNumber/ReferenceNumber * 1),'N',''),'a',''))) = 0" >
                                                                        <xsl:value-of select="DocumentNumber/ReferenceNumber"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:variable name="VALUE1" select="0"/>
                                                                        <xsl:variable name="LengthFigure" select="(number(string-length(DocumentNumber/ReferenceNumber)) + 2) mod 10"/>
                                                                        <xsl:variable name="REFERENCENum" >
                                                                            <xsl:choose>
                                                                                <xsl:when test="substring($AccNum,1,1)='8'" >
                                                                                    <xsl:value-of select="DocumentNumber/ReferenceNumber"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="concat(DocumentNumber/ReferenceNumber,$LengthFigure)"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:variable>
                                                                        <xsl:variable name="invLength" select="string-length($REFERENCENum)"/>
                                                                        <xsl:if test="$VALUE1 &lt;= $invLength">
                                                                            <xsl:call-template name="while">
                                                                                <xsl:with-param name="VALUE" select="$invLength + 1" />
                                                                                <xsl:with-param name="length" select="$invLength" />
                                                                                <xsl:with-param name="RefNum" select="$REFERENCENum" />
                                                                                <xsl:with-param name="ConFig" select="0" />
                                                                                <xsl:with-param name="IsSecond" select="true()" />
                                                                            </xsl:call-template>
                                                                        </xsl:if>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </Ref>
                                                        </xsl:if>
                                                    </xsl:if>
                                                </CdtrRefInf>
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