<?xml version="1.0" encoding="UTF-8"?>
<!--   $Header: fusionapps/fin/iby/bipub/shared/runFormat/reports/DisbursementPaymentFileFormats/ISO20022CGI.xsl /st_fusionapps_pt-v2mib/4 2018/04/04 07:35:17 jswirsky Exp $   
  -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output omit-xml-declaration="no" />
    <xsl:output method="xml" />
    <xsl:key name="contacts-by-PaymentMethodInternalID" match="OutboundPayment" use="PaymentMethod/PaymentMethodInternalID" />
    <xsl:template match="OutboundPaymentInstruction">
        <Document
            xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <xsl:variable name="instrid" select="PaymentInstructionInfo/InstructionReferenceNumber" />
            <xsl:variable name="pymtd" />
            <xsl:variable name="TMPT" />
			<xsl:variable name="INVNUMBERS" />
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
                        <xsl:value-of select="format-number(sum(OutboundPayment/PaymentAmount/Value), '##0.00')" />
                    </CtrlSum>
                    <InitgPty>
                        <Nm>
                            <xsl:text>DocuSign, Inc</xsl:text>
                        </Nm>
                        <Id>
                            <OrgId>
                                <Othr>
                                    <Id>
                                        <xsl:text>DOCUSIGN</xsl:text>
                                    </Id>
                                </Othr>
                            </OrgId>
                        </Id>
                    </InitgPty>
                </GrpHdr>
                <xsl:for-each select="OutboundPayment[count(. | key('contacts-by-PaymentMethodInternalID', PaymentMethod/PaymentMethodInternalID)[1]) = 1]">
                    <xsl:sort select="PaymentMethod/PaymentMethodInternalID" />
                    <!--Start of payment information block-->
                    <xsl:variable name="pymtd">
                        <xsl:choose>
                            <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC')">
                                <xsl:value-of select="'ELEC'" />
                            </xsl:when>
                            <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_WIRE')">
                                <xsl:value-of select="'WIRE'" />
                            </xsl:when>
                            <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_OUTSOURCED_CHK')">
                                <xsl:value-of select="'CKO'" />
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
                            <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and  (BankAccount/BankAddress/Country= 'US') and
                                         ((BankAccount/BankAddress/Country!=PayeeBankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                <xsl:value-of select="'US Wire Cross Border'" />
                            </xsl:when>
                            <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and  (BankAccount/BankAddress/Country= 'US') and
                                         ((BankAccount/BankAddress/Country!=PayeeBankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code!=PaymentAmount/Currency/Code)))">
                                <xsl:value-of select="'US FX WIRE'" />
                            </xsl:when>
                            <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_OUTSOURCED_CHK') and  (PaymentAmount/Currency/Code='USD'))">
                                <xsl:value-of select="'US Outsourced Check'" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <PmtInf>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                            <PmtInfId>
                                <xsl:value-of select="concat('JPM_DSI_',$pymtd,'_',$instrid)" />
                            </PmtInfId>
                        </xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                            <PmtMtd>
                                <xsl:choose>
                                    <xsl:when test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
                                        <xsl:text>TRF</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="($TMPT='US Outsourced Check')">
                                        <xsl:text>CHK</xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                            </PmtMtd>
                        </xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                            <!-- get from new logical table instead -->
                            <NbOfTxs>
                                <xsl:choose>
                                    <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC')">
                                        <xsl:value-of select="count(/OutboundPaymentInstruction/OutboundPayment/PaymentMethod
							[PaymentMethodInternalID='DS_ELECTRONIC'])" />
                                    </xsl:when>
                                    <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_WIRE')">
                                        <xsl:value-of select="count(/OutboundPaymentInstruction/OutboundPayment/PaymentMethod
							[PaymentMethodInternalID='DS_WIRE'])" />
                                    </xsl:when>
                                    <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_OUTSOURCED_CHK')">
                                        <xsl:value-of select="count(/OutboundPaymentInstruction/OutboundPayment/PaymentMethod
							[PaymentMethodInternalID='DS_OUTSOURCED_CHK'])" />
                                    </xsl:when>
                                </xsl:choose>
                            </NbOfTxs>
                        </xsl:if>
						
						
						
						
						
						
						
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
						
						
						<CtrlSum>
    <xsl:choose>
        <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC')">
            <xsl:value-of select="sum(/OutboundPaymentInstruction/OutboundPayment[PaymentMethod/PaymentMethodInternalID ='DS_ELECTRONIC']/PaymentAmount/Value)"/>
        </xsl:when>
        <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_WIRE')">
            <xsl:value-of select="sum(/OutboundPaymentInstruction/OutboundPayment[PaymentMethod/PaymentMethodInternalID ='DS_WIRE']/PaymentAmount/Value)"/>
        </xsl:when>
		 <xsl:when test="(PaymentMethod/PaymentMethodInternalID='DS_OUTSOURCED_CHK')">
            <xsl:value-of select="sum(/OutboundPaymentInstruction/OutboundPayment[PaymentMethod/PaymentMethodInternalID ='DS_OUTSOURCED_CHK']/PaymentAmount/Value)"/>
        </xsl:when>
    </xsl:choose>
</CtrlSum>

						
						
						
						
                            
                        </xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
                            <PmtTpInf>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
                                    <SvcLvl>
                                        <Cd>
                                            <xsl:choose>
                                                <xsl:when test="($TMPT='US ACH CCD')">
                                                    <xsl:text>NURG</xsl:text>
                                                </xsl:when>
                                                <xsl:when test="(($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
                                                    <xsl:text>URGP</xsl:text>
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
                        </xsl:if>
                        <!--End of payment type information block-->
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
						<xsl:if test="not(PaymentDate='')">
                            <ReqdExctnDt>
                                <xsl:value-of select="PaymentDate" />
                            </ReqdExctnDt>
                        </xsl:if>
						</xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                            <Dbtr>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                                    <Nm>
                                        <xsl:value-of select="substring(Payer/Name,1,140)" />
                                    </Nm>
                                </xsl:if>
                                <PstlAdr>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
									<xsl:if test="not(Payer/Address/Country='')">
                                        <Ctry>
                                            <xsl:value-of select="Payer/Address/Country" />
                                        </Ctry>
                                    </xsl:if>
									</xsl:if>
                                </PstlAdr>
                                <xsl:if test="($TMPT='US ACH CCD')">
							<xsl:if test="not(BankAccount/EFTUserNumber/AccountLevelEFTNumber='')">
                                    <Id>
                                        <OrgId>
                                            <Othr>
                                                <Id>
                                                    <xsl:value-of select="BankAccount/EFTUserNumber/AccountLevelEFTNumber" />
                                                </Id>
												<xsl:if test="(($TMPT='US ACH CCD') )">
								<SchmeNm>
                                    <Prtry>
                                        <xsl:text>JPMCOID</xsl:text>
                                    </Prtry>
								</SchmeNm>
                                </xsl:if>
                                            </Othr>
                                        </OrgId>
                                    </Id>
                                </xsl:if>
								</xsl:if>
                                
                            </Dbtr>
                        </xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                            <DbtrAcct>
                                <Id>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
									<xsl:if test="not(BankAccount/BankAccountNumber='')">
                                        <Othr>
                                            <Id>
                                                <xsl:value-of select="BankAccount/BankAccountNumber" />
                                            </Id>
                                        </Othr>
                                    </xsl:if>
									</xsl:if>
                                </Id>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
								<xsl:if test="not(BankAccount/BankAccountCurrency/Code='')">
                                    <Ccy>
                                        <xsl:value-of select="BankAccount/BankAccountCurrency/Code" />
                                    </Ccy>
                                </xsl:if>
								</xsl:if>
                            </DbtrAcct>
                        </xsl:if>
                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                            <DbtrAgt>
                                <FinInstnId>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                                        <BIC>
                                            <xsl:text>CHASUS33</xsl:text>
                                        </BIC>
                                    </xsl:if>
                                    <ClrSysMmbId>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
										<xsl:if test="not(BankAccount/EFTUserNumber/AccountLevelEFTNumber='') or not(BankAccount/BranchNumber='') ">
                                            <MmbId>
											<xsl:choose>
											   <xsl:when test="($TMPT='US Outsourced Check')">
											
                                                <xsl:value-of select="BankAccount/EFTUserNumber/AccountLevelEFTNumber" />
												</xsl:when>
												<xsl:otherwise>
											           <xsl:value-of select="BankAccount/BranchNumber" />
												</xsl:otherwise>
												
												</xsl:choose>
												
                                            </MmbId>
                                        </xsl:if>
										</xsl:if>
                                    </ClrSysMmbId>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
									<xsl:if test="not(BankAccount/BankAddress/Country='') ">
                                        <PstlAdr>
                                            <Ctry>
                                                <xsl:value-of select="BankAccount/BankAddress/Country" />
                                            </Ctry>
                                        </PstlAdr>
                                    </xsl:if>
									</xsl:if>
                                </FinInstnId>
                            </DbtrAgt>
                        </xsl:if>
                        
                        <xsl:variable name="paymentdetails" select="PaymentDetails" />
                        <xsl:for-each select="key('contacts-by-PaymentMethodInternalID',PaymentMethod/PaymentMethodInternalID)">
                            <xsl:variable name="TMPT">
                                <xsl:choose>
                                    <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_ELECTRONIC') and (PaymentAmount/Currency/Code='USD') and (BankAccount/BankAddress/Country = 'US') and (PayeeBankAccount/BankAddress/Country='US'))">
                                        <xsl:value-of select="'US ACH CCD'" />
                                    </xsl:when>
                                    <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and (PaymentAmount/Currency/Code='USD')  and (BankAccount/BankAddress/Country = 'US') and (PayeeBankAccount/BankAddress/Country='US'))">
                                        <xsl:value-of select="'US WIRE DOMESTIC'" />
                                    </xsl:when>
                                      <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and  (BankAccount/BankAddress/Country= 'US') and
                                         ((BankAccount/BankAddress/Country!=PayeeBankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code=PaymentAmount/Currency/Code)))">
                                <xsl:value-of select="'US Wire Cross Border'" />
                            </xsl:when>
                            <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_WIRE') and  (BankAccount/BankAddress/Country= 'US') and
                                         ((BankAccount/BankAddress/Country!=PayeeBankAccount/BankAddress/Country) and (BankAccount/BankAccountCurrency/Code!=PaymentAmount/Currency/Code)))">
                                <xsl:value-of select="'US FX WIRE'" />
                            </xsl:when>
                                    <xsl:when test="((PaymentMethod/PaymentMethodInternalID='DS_OUTSOURCED_CHK') and  (PaymentAmount/Currency/Code='USD'))">
                                        <xsl:value-of select="'US Outsourced Check'" />
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:variable>
                            <!--Start of credit transaction block-->
                            <CdtTrfTxInf>
                                <PmtId>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                                        <InstrId>
                                            <xsl:value-of select="PaymentNumber/PaymentReferenceNumber" />
                                        </InstrId>
                                    </xsl:if>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                                        <EndToEndId>
                                            <xsl:value-of select="PaymentNumber/PaymentReferenceNumber" />
                                        </EndToEndId>
                                    </xsl:if>
                                   
                                </PmtId>
								
								
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                                    <Amt>
                                        <InstdAmt>
                                            <xsl:attribute name="Ccy">
                                                <xsl:value-of select="PaymentAmount/Currency/Code" />
                                            </xsl:attribute>
                                            <xsl:value-of select="format-number(PaymentAmount/Value, '##0.00')" />
                                        </InstdAmt>
                                    </Amt>
                                </xsl:if>
								 <xsl:if test="($TMPT='US Outsourced Check')">
								 
                                        <ChqInstr>
										
										<xsl:if test="not(PaymentNumber/PaymentReferenceNumber='')">
                                            <ChqNb> <xsl:value-of select="PaymentNumber/PaymentReferenceNumber" />
											</ChqNb>
                                        </xsl:if>
                                 <DlvryMtd>
                                            <Prtry>
											
											<xsl:choose>
                                    <xsl:when test="not(DocumentPayable/DeliveryChannel/Code='')">
                                        
											<xsl:value-of select="DocumentPayable/DeliveryChannel/Code" />
											</xsl:when>
											<xsl:otherwise>
											<xsl:text>00000</xsl:text>
											</xsl:otherwise>
											</xsl:choose>
											</Prtry>
                                        </DlvryMtd>
										
                                   
                                  
                                       
                                            <FrmsCd>
											<xsl:text>A1</xsl:text>
											</FrmsCd>
                                       
                                   
									</ChqInstr>
									 
									
									 </xsl:if>
									 
                                <xsl:if test="(($TMPT='US Wire Cross Border') or ($TMPT='US FX WIRE'))">
								 <xsl:if test="count(PayeeBankAccount/IntermediaryBankAccount)!= 0">
                                    <IntrmyAgt1>
                                        <FinInstnId>
										<xsl:if test="not(PayeeBankAccount/IntermediaryBankAccount/SwiftCode='')">
                                            <BIC>
												<xsl:value-of select="PayeeBankAccount/IntermediaryBankAccount/SwiftCode" />
											</BIC>
											</xsl:if>
											<xsl:if test="not(PayeeBankAccount/IntermediaryBankAccount/BankName='')">
                                            <Nm>
												<xsl:value-of select="substring(PayeeBankAccount/IntermediaryBankAccount/BankName,1,140)" />
											</Nm>
											</xsl:if>
											<xsl:if test="not(PayeeBankAccount/IntermediaryBankAccount/Country='')">
                                            <PstlAdr>
                                                <Ctry>
													<xsl:value-of select="PayeeBankAccount/IntermediaryBankAccount/Country" />
												</Ctry>
                                            </PstlAdr>
											</xsl:if>
                                        </FinInstnId>
                                    </IntrmyAgt1>
                                </xsl:if>
								</xsl:if>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
                                    <CdtrAgt>
                                        <FinInstnId>
                                            <xsl:if test="(($TMPT='US Wire Cross Border') or ($TMPT='US FX WIRE') )">
											 <xsl:if test="not(PayeeBankAccount/SwiftCode='') ">
                                                <BIC>
												 <xsl:value-of select="PayeeBankAccount/SwiftCode" />
												</BIC>
                                            </xsl:if>
											</xsl:if>
											<xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC'))">
											 <xsl:if test="not(PayeeBankAccount/BranchNumber='') ">
                                            <ClrSysMmbId>
                                                
												
                                                    <MmbId>
                                                        <xsl:value-of select="PayeeBankAccount/BranchNumber" />
                                                    </MmbId>
													
                                                
                                            </ClrSysMmbId>
											</xsl:if>
											</xsl:if>
                                            <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
											<xsl:if test="not(PayeeBankAccount/BranchName='') ">
                                                <Nm>
                                                    <xsl:value-of select="substring(PayeeBankAccount/BranchName,1,140)" />
                                                </Nm>
                                            </xsl:if>
											</xsl:if>
                                            <PstlAdr>
                                                <xsl:if test="($TMPT='US ACH CCD')">
												<xsl:if test="not(PayeeBankAccount/BankAddress/City='') ">
                                                    <TwnNm>
                                                        <xsl:value-of select="PayeeBankAccount/BankAddress/City" />
                                                    </TwnNm>
                                                </xsl:if>
												</xsl:if>
                                                <xsl:if test="($TMPT='US ACH CCD')">
												<xsl:if test="not(PayeeBankAccount/BankAddress/State='') ">
                                                    <CtrySubDvsn>
                                                        <xsl:value-of select="PayeeBankAccount/BankAddress/State" />
                                                    </CtrySubDvsn>
                                                </xsl:if>
												</xsl:if>
                                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
												<xsl:if test="not(PayeeBankAccount/BankAddress/Country='') ">
                                                    <Ctry>
                                                        <xsl:value-of select="PayeeBankAccount/BankAddress/Country" />
                                                    </Ctry>
                                                </xsl:if>
												</xsl:if>
                                                <xsl:if test="(($TMPT='US Wire Cross Border') or ($TMPT='US FX WIRE'))">
												<xsl:if test="not(PayeeBankAccount/BankAddress/AddressLine1='') ">
                                                    <AdrLine>
                                                        <xsl:value-of select="substring(concat(PayeeBankAccount/BankAddress/AddressLine1,' ',PayeeBankAccount/BankAddress/AddressLine2),1,70)" />
                                                    </AdrLine>
													</xsl:if>
                                                </xsl:if>
                                            </PstlAdr>
                                        </FinInstnId>
                                    </CdtrAgt>
                                </xsl:if>
                                <Cdtr>
                                    <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
                                        <Nm>
                                            <xsl:value-of select="substring(SupplierorParty/Name,1,140)" />
                                        </Nm>
                                    </xsl:if>
                                    <PstlAdr>
                                        <xsl:if test="(($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
										<xsl:if test="not(SupplierorParty/Address/AddressLine1='') ">
                                            <StrtNm>
                                                <xsl:value-of select="substring(SupplierorParty/Address/AddressLine1,1,70)" />
                                            </StrtNm>
                                        </xsl:if>
										</xsl:if>
                                        <xsl:if test="(($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
										<xsl:if test="not(SupplierorParty/Address/PostalCode='') ">
                                            <PstCd>
											<xsl:value-of select= "translate(SupplierorParty/Address/PostalCode,'-','')" />
                                                
                                            </PstCd>
											</xsl:if>
                                        </xsl:if>
                                        <xsl:if test="(($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
										<xsl:if test="not(SupplierorParty/Address/City='') ">
                                            <TwnNm>
                                                <xsl:value-of select="SupplierorParty/Address/City" />
                                            </TwnNm>
                                        </xsl:if>
										</xsl:if>
                                        <xsl:if test="(($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
										<xsl:if test="not(SupplierorParty/Address/State='') ">
                                            <CtrySubDvsn>
                                                <xsl:value-of select="SupplierorParty/Address/State" />
                                            </CtrySubDvsn>
                                        </xsl:if>
										</xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
										<xsl:if test="not(SupplierorParty/Address/Country='') ">
                                            <Ctry>
                                                <xsl:value-of select="SupplierorParty/Address/Country" />
                                            </Ctry>
                                        </xsl:if>
										</xsl:if>
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border')) ">
										<xsl:if test="not(SupplierorParty/Address/AddressLine1='') ">
                                            <AdrLine>
                                                <xsl:value-of select="substring(concat(SupplierorParty/Address/AddressLine1,' ',SupplierorParty/Address/AddressLine2)1,70)" />
                                            </AdrLine>
                                        </xsl:if>
										</xsl:if>
										<xsl:if test="($TMPT='US Outsourced Check')">
										<xsl:if test="not(SupplierorParty/Address/AddressLine1='') ">
                                            <AdrLine>
                                                <xsl:value-of select="substring(SupplierorParty/Address/AddressLine1,1,70)" />
                                            </AdrLine>
                                        </xsl:if>
										</xsl:if>
										<xsl:if test="(($TMPT='US FX WIRE') or ($TMPT='US Outsourced Check'))">
										<xsl:if test="not(SupplierorParty/Address/AddressLine2='') ">
                                            <AdrLine>
                                                <xsl:value-of select="substring(SupplierorParty/Address/AddressLine2,1,70)" />
                                            </AdrLine>
                                        </xsl:if>
										</xsl:if>
										<xsl:if test="($TMPT='US Outsourced Check')">
										<xsl:if test="not(SupplierorParty/Address/AddressLine3='') ">
                                            <AdrLine>
                                                <xsl:value-of select="substring(SupplierorParty/Address/AddressLine3,1,70)" />
                                            </AdrLine>
                                        </xsl:if>
										</xsl:if>
										
                                    </PstlAdr>
                                    
                                    <!--employee payments-->
                                </Cdtr>
                                <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
                                    <CdtrAcct>
                                        <Id>
                                            <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
                                                <Othr>
                                                    <Id>
                                                        <xsl:value-of select="PayeeBankAccount/BankAccountNumber" />
                                                    </Id>
                                                </Othr>
                                            </xsl:if>
											</Id>
                                            <xsl:if test="(($TMPT='US ACH CCD'))">
                                                <Tp>
                                                    <Cd>
                                                        <xsl:choose>
                                                            <xsl:when test="(PayeeBankAccount/BankAccountType/Code='CHECKING') or (PayeeBankAccount/BankAccountType/Code='')">
                                                                <xsl:text>CASH</xsl:text>
                                                            </xsl:when>
                                                            <xsl:when test="(PayeeBankAccount/BankAccountType/Code='SAVINGS')">
                                                                <xsl:text>SVGS</xsl:text>
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </Cd>
                                                </Tp>
                                            </xsl:if>
                                        
                                    </CdtrAcct>
                                </xsl:if>
                                
                                <RmtInf>
								<xsl:variable name="INVNUMBERS" >
								 <xsl:for-each select="DocumentPayable">
                                        
                                            
                                                <xsl:value-of select="DocumentNumber/ReferenceNumber" />
												<xsl:text>,</xsl:text>
												</xsl:for-each>
								</xsl:variable>
                                   
                                        <xsl:if test="(($TMPT='US ACH CCD') or ($TMPT='US Wire Cross Border') or ($TMPT='US WIRE DOMESTIC') or ($TMPT='US FX WIRE'))">
                                            <Ustrd>
                                                      <xsl:value-of select="substring($INVNUMBERS,1,140)" />
                                            </Ustrd>
                                        </xsl:if>
										 <xsl:for-each select="DocumentPayable">
                                        <xsl:if test="($TMPT='US Outsourced Check')">
                                            <Strd>
                                                <RfrdDocInf>
                                                    <Tp>
                                                        <CdOrPrtry>
                                                            <Cd>
                                                                <xsl:choose>
                                                                    <xsl:when test="(DocumentType/Code='STANDARD') or 
																	(DocumentType/Code='INTEREST') or (DocumentType/Code='PAYMENT REQUEST')">
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
													
													<xsl:choose>
														<xsl:when test="((DocumentType/Code='STANDARD') or (DocumentType/Code='INTEREST') or (DocumentType/Code='DEBIT'))">
                                                        <xsl:attribute name="Ccy">
                                                            <xsl:value-of select="TotalDocumentAmount/Currency/Code" />
                                                        </xsl:attribute>
                                                        <xsl:value-of select="format-number(TotalDocumentAmount/Value, '##0.00')" />
														</xsl:when>
														<xsl:when test="(DocumentType/Code='CREDIT')">
														 <xsl:attribute name="Ccy">
                                                            <xsl:value-of select="TotalDocumentAmount/Currency/Code" />
                                                        </xsl:attribute>
                                                        <xsl:value-of select="format-number(substring-after(TotalDocumentAmount/Value,'-'), '##0.00')" />
														</xsl:when>
														</xsl:choose>
                                                    </DuePyblAmt>
                                                    <DscntApldAmt>
                                                        <xsl:attribute name="Ccy">
                                                            <xsl:value-of select="DiscountTaken/Amount/Currency/Code" />
                                                        </xsl:attribute>
                                                        <xsl:value-of select="format-number(DiscountTaken/Amount/Value, '##0.00')" />
                                                    </DscntApldAmt>
													<xsl:if test="((DocumentType/Code='STANDARD') or (DocumentType/Code='INTEREST') or (DocumentType/Code='DEBIT'))">
                                                    <RmtdAmt>
                                                        <xsl:attribute name="Ccy">
                                                            <xsl:value-of select="PaymentAmount/Currency/Code" />
                                                        </xsl:attribute>
                                                        <xsl:value-of select="format-number(PaymentAmount/Value, '##0.00')" />
                                                    </RmtdAmt>
													</xsl:if>
													<xsl:if test="(DocumentType/Code='CREDIT')">
													<CdtNoteAmt>
                                                        <xsl:attribute name="Ccy">
                                                            <xsl:value-of select="PaymentAmount/Currency/Code" />
                                                        </xsl:attribute>
                                                        <xsl:value-of select="format-number(substring-after(PaymentAmount/Value,'-'), '##0.00')" />
                                                    </CdtNoteAmt>
													</xsl:if>
                                                </RfrdDocAmt>
                                               <xsl:if test="($TMPT='US Outsourced Check')">
											  
											 <xsl:if test="not(/OutboundPaymentInstruction/OutboundPayment/DocumentPayable/RemittanceMessage='')">
                                            <AddtlRmtInf>
											        <xsl:value-of select="substring(/OutboundPaymentInstruction/OutboundPayment/DocumentPayable/RemittanceMessage,1,140)" />
											</AddtlRmtInf>
                                        </xsl:if>
										
										</xsl:if>
                                            </Strd>
                                        </xsl:if>
                                        
                                    </xsl:for-each>
                                </RmtInf>
								
                            </CdtTrfTxInf>
                        </xsl:for-each>
                    </PmtInf>
                </xsl:for-each>
            </CstmrCdtTrfInitn>
        </Document>
    </xsl:template>
</xsl:stylesheet>