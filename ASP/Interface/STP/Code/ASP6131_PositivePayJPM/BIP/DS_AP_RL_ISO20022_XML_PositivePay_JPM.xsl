<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:output omit-xml-declaration="no" />
   <xsl:output method="xml" />
      <xsl:key name="contacts-by-PaymentStatus_Code" match="OutboundPayment" use="PaymentStatus/Code" />
   <xsl:template match="PositivePayDataExtract">

      <Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03 file:///H:/schema/pain.001.001.03.xsd">
        <xsl:variable name="instrid" select="OutboundPayment/PaymentSourceInfo/PaymentServiceRequestID" /> 
			<CstmrCdtTrfInitn>
			<GrpHdr>
			<MsgId>
			<xsl:value-of select="$instrid" />
			</MsgId>
			<CreDtTm>
			<xsl:value-of select="OutboundPayment/RecordHistory/CreationDate" />
			</CreDtTm>
			<NbOfTxs>
			<xsl:value-of select="count(OutboundPayment)" />
			</NbOfTxs>
			<CtrlSum>
			<xsl:value-of select="format-number(sum(OutboundPayment/PaymentAmount/Value), '##0.00')" />
			</CtrlSum>
			<InitgPty>
			<Nm>
			<xsl:value-of select="OutboundPayment/Payer/Name" />
			</Nm>
			</InitgPty>
			</GrpHdr>

		     <xsl:for-each select="OutboundPayment[count(. | key('contacts-by-PaymentStatus_Code',PaymentStatus/Code)[1]) = 1]">
			<PmtInf>
			<PmtInfId>
			<xsl:value-of select="concat('JPM','_','DSI','_','PP','_',$instrid,'_',PaymentStatus/Code)" /></PmtInfId>
			<PmtMtd>CHK</PmtMtd>
			
			
			
			<NbOfTxs>
                                <xsl:choose>
                                    <xsl:when test="(PaymentStatus/Code='ISSUED')">
                                        <xsl:value-of select="count(/PositivePayDataExtract/OutboundPayment/PaymentStatus
							[Code='VOID'])" />
                                    </xsl:when>
                                    <xsl:when test="(PaymentStatus/Code='VOID')">
                                        <xsl:value-of select="count(/PositivePayDataExtract/OutboundPayment/PaymentStatus
							[Code='VOID'])" />
                                    </xsl:when>
                                   
                                </xsl:choose>
                            </NbOfTxs>
			
			
			<CtrlSum>
    <xsl:choose>
        <xsl:when test="(PaymentStatus/Code='ISSUED')">
            <xsl:value-of select="format-number(sum(/PositivePayDataExtract/OutboundPayment[PaymentStatus/Code='ISSUED']/PaymentAmount/Value),'##0.00')"/>
        </xsl:when>
        <xsl:when test="(PaymentStatus/Code='VOID')">
            <xsl:value-of select="format-number(sum(/PositivePayDataExtract/OutboundPayment[PaymentStatus/Code='VOID']/PaymentAmount/Value),'##0.00')"/>
        </xsl:when>
		
    </xsl:choose>
</CtrlSum>
			
			
			
			
			
			
			<PmtTpInf>
				<LclInstrm>
				<Prtry>
				<xsl:choose>
				 <xsl:when test="PaymentStatus/Code='ISSUED'">
					<xsl:text>CII</xsl:text>
					</xsl:when>
					<xsl:when test="PaymentStatus/Code='VOID'">
					<xsl:text>VOID</xsl:text>
					
					</xsl:when>
					</xsl:choose>
					</Prtry>
				</LclInstrm>
			</PmtTpInf>
			<ReqdExctnDt><xsl:value-of select="PaymentDate" /></ReqdExctnDt>
			<Dbtr>
			<Nm><xsl:value-of select="Payer/Name" /></Nm>
			<xsl:if test="not(Payer/Address/Country='')">
			<PstlAdr>
			
					<Ctry><xsl:value-of select="Payer/Address/Country" /></Ctry>
						
				</PstlAdr>
				</xsl:if>
			</Dbtr>
			<DbtrAcct>
			<xsl:if test="not(BankAccount/BankAccountNumber='')">
				<Id>
					<Othr>
					<Id><xsl:value-of select="BankAccount/BankAccountNumber" /></Id>
					</Othr>
				</Id>
				</xsl:if>
				<xsl:if test="not(BankAccount/BankAccountCurrency/Code='')">
				<Ccy><xsl:value-of select="BankAccount/BankAccountCurrency/Code" /></Ccy>
				</xsl:if>
			</DbtrAcct>
			<DbtrAgt>
				<FinInstnId>
				<BIC>CHASUS33</BIC>
				<xsl:if test="not(BankAccount/BranchNumber='')">
				<ClrSysMmbId>
				<MmbId><xsl:value-of select="BankAccount/BranchNumber" /></MmbId>
				</ClrSysMmbId>
				</xsl:if>
				<xsl:if test="not(BankAccount/BankAddress/Country='')">
				<PstlAdr>
				<Ctry><xsl:value-of select="BankAccount/BankAddress/Country" /></Ctry>
				</PstlAdr>
				</xsl:if>
				</FinInstnId>
			</DbtrAgt>
			 <xsl:for-each select="key('contacts-by-PaymentStatus_Code',PaymentStatus/Code)">
						<CdtTrfTxInf>
				<PmtId>
					<EndToEndId><xsl:value-of select="PaymentNumber/PaymentReferenceNumber" /></EndToEndId>
				</PmtId>
				<Amt>
					<InstdAmt>
					 <xsl:attribute name="Ccy">
                        <xsl:value-of select="PaymentAmount/Currency/Code" />
                      </xsl:attribute>
						<xsl:value-of select="format-number(PaymentAmount/Value,'##0.00')" />			
					</InstdAmt>
				</Amt>
				<ChqInstr>
				<ChqTp>CCHQ</ChqTp>
				<ChqNb><xsl:value-of select="PaymentNumber/CheckNumber" /></ChqNb>
				</ChqInstr>
				<Cdtr>
					<Nm><xsl:value-of select="substring(Payee/Name,1,140)" /></Nm>
					<PstlAdr>
					<xsl:if test="not(Payee/Address/AddressLine1='')">
						<StrtNm><xsl:value-of select="Payee/Address/AddressLine1" /></StrtNm>
						</xsl:if>
						<xsl:if test="not(Payee/Address/PostalCode='')">
						<PstCd><xsl:value-of select="Payee/Address/PostalCode" /></PstCd>
						</xsl:if>
						<xsl:if test="not(Payee/Address/City='')">
						<TwnNm><xsl:value-of select="Payee/Address/City" /></TwnNm>
						</xsl:if>
						<xsl:if test="not(Payee/Address/State='')">
						<CtrySubDvsn><xsl:value-of select="Payee/Address/State" /></CtrySubDvsn>
						</xsl:if>
						<xsl:if test="not(Payee/Address/Country='')">
						<Ctry><xsl:value-of select="Payee/Address/Country" /></Ctry>
						</xsl:if>
						
					</PstlAdr>
					</Cdtr>
		</CdtTrfTxInf>
		</xsl:for-each>
			</PmtInf>
			 </xsl:for-each>
			</CstmrCdtTrfInitn>
      </Document>
   </xsl:template>
</xsl:stylesheet>