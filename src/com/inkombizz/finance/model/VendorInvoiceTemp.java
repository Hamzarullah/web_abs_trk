/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;

/**
 *
 * @author Sukha
 */
public class VendorInvoiceTemp {
    
    private String code = "";
    private String branchCode = "";
    private String branchName = "";
    private Date transactionDate = DateUtils.newDate(1900, 01, 01);
    private String purchaseOrderCode = "";
    private String currencyCode = "";
    private String currencyName = "";
    private String vendorCode = "";
    private String vendorName = "";
    private String vendorContactPerson = "";
    private String vendorAddress = "";
    private String vendorPhone1 = "";
    private String vendorPhone2 = "";
    private String vendorNPWP = "";
    private boolean goodsSupplyStatus = false;
    private boolean serviceSupplyStatus = false;
    private BigDecimal exchangeRate = new BigDecimal(BigInteger.ZERO);
    private String paymentTermCode = "";
    private String paymentTermName = "";
    private BigDecimal paymentTermDays = new BigDecimal(BigInteger.ZERO);
    private Date contraBonDate = DateUtils.newDate(1900, 01, 01);
    private Date dueDate = DateUtils.newDate(1900, 01, 01);
    private BigDecimal dueDays = new BigDecimal(BigInteger.ZERO);
    private String vendorInvoiceNo = "";
    private Date vendorInvoiceDate = DateUtils.newDate(1900, 01, 01);
    private String vendorTaxInvoiceNo = "";
    private Date vendorTaxInvoiceDate = DateUtils.newDate(1900, 01, 01);
    private String refNo = "";
    private String remark = "";
    private BigDecimal totalTransactionAmount = new BigDecimal(BigInteger.ZERO);
    private BigDecimal discountPercent = new BigDecimal(BigInteger.ZERO);
    private BigDecimal discountAmount = new BigDecimal(BigInteger.ZERO);
    private String discountChartOfAccountCode = "";
    private String discountChartOfAccountName = "";
    private String discountDescription = "";
    private BigDecimal paidAmount = new BigDecimal(BigInteger.ZERO);
    private Date settlementDate = DateUtils.newDate(1900, 01, 01);
    private String settlementDocumentNo = "";
    private BigDecimal downPaymentAmount = new BigDecimal(BigInteger.ZERO);
    private BigDecimal vatPercent = new BigDecimal(BigInteger.ZERO);
    private BigDecimal vatAmount = new BigDecimal(BigInteger.ZERO);
    private BigDecimal pphPercent = new BigDecimal("0.00");
    private BigDecimal pphAmount = new BigDecimal("0.00");
    private String pphChartOfAccountCode = "";
    private String pphChartOfAccountName = "";
    private String pphDescription = "";
    private BigDecimal otherFeeAmount = new BigDecimal(BigInteger.ZERO);
    private String otherFeeChartOfAccountCode = "";
    private String otherFeeChartOfAccountName = "";
    private String otherFeeDescription = "";
    private String otherFeeRemark = "";
    private String otherFeeBudgetTypeCode = "";
    private String otherFeeBudgetTypeName = "";
    private BigDecimal grandTotalAmount = new BigDecimal(BigInteger.ZERO);
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 01, 01);
    
    private BigDecimal pph23Percent = new BigDecimal(BigInteger.ZERO);
    private BigDecimal totalTransactionAmountHeader = new BigDecimal(BigInteger.ZERO);
    private BigDecimal discountPercentHeader = new BigDecimal(BigInteger.ZERO);
    private BigDecimal discountAmountHeader = new BigDecimal(BigInteger.ZERO);
    private BigDecimal downPaymentAmountHeader = new BigDecimal(BigInteger.ZERO);
    private BigDecimal vatPercentHeader = new BigDecimal(BigInteger.ZERO);
    private BigDecimal vatAmountHeader = new BigDecimal(BigInteger.ZERO);
    private BigDecimal grandTotalAmountHeader = new BigDecimal(BigInteger.ZERO);
    
    private BigDecimal postedTotalTransactionAmount = new BigDecimal(BigInteger.ZERO);
    private BigDecimal postedDiscountPercent = new BigDecimal(BigInteger.ZERO);
    private BigDecimal postedDiscountAmount = new BigDecimal(BigInteger.ZERO);
    private BigDecimal postedDownPaymentAmount = new BigDecimal(BigInteger.ZERO);
    private BigDecimal postedVatPercent = new BigDecimal(BigInteger.ZERO);
    private BigDecimal postedVatAmount = new BigDecimal(BigInteger.ZERO);
    private BigDecimal postedGrandTotalAmount = new BigDecimal(BigInteger.ZERO);
    
    private String statusInvoice="";
    private String documentCode="";
    private String documentType="";
    private String currenctCode="";
    private String currenctName="";
    private String taxInvoiceNo="";
    private Date taxInvoiceDate = DateUtils.newDate(1900, 01, 01);
    private BigDecimal taxBaseAmount = new BigDecimal(BigInteger.ZERO);
    private BigDecimal balanceAmount = new BigDecimal(BigInteger.ZERO);
    private String paymentType="BANK";
    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getPurchaseOrderCode() {
        return purchaseOrderCode;
    }

    public void setPurchaseOrderCode(String purchaseOrderCode) {
        this.purchaseOrderCode = purchaseOrderCode;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getCurrencyName() {
        return currencyName;
    }

    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public String getPaymentTermCode() {
        return paymentTermCode;
    }

    public void setPaymentTermCode(String paymentTermCode) {
        this.paymentTermCode = paymentTermCode;
    }

    public String getPaymentTermName() {
        return paymentTermName;
    }

    public void setPaymentTermName(String paymentTermName) {
        this.paymentTermName = paymentTermName;
    }

    public Date getContraBonDate() {
        return contraBonDate;
    }

    public void setContraBonDate(Date contraBonDate) {
        this.contraBonDate = contraBonDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getVendorTaxInvoiceNo() {
        return vendorTaxInvoiceNo;
    }

    public void setVendorTaxInvoiceNo(String vendorTaxInvoiceNo) {
        this.vendorTaxInvoiceNo = vendorTaxInvoiceNo;
    }

    public Date getVendorTaxInvoiceDate() {
        return vendorTaxInvoiceDate;
    }

    public void setVendorTaxInvoiceDate(Date vendorTaxInvoiceDate) {
        this.vendorTaxInvoiceDate = vendorTaxInvoiceDate;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    public Date getSettlementDate() {
        return settlementDate;
    }

    public void setSettlementDate(Date settlementDate) {
        this.settlementDate = settlementDate;
    }

    public String getSettlementDocumentNo() {
        return settlementDocumentNo;
    }

    public void setSettlementDocumentNo(String settlementDocumentNo) {
        this.settlementDocumentNo = settlementDocumentNo;
    }

    public BigDecimal getDownPaymentAmount() {
        return downPaymentAmount;
    }

    public void setDownPaymentAmount(BigDecimal downPaymentAmount) {
        this.downPaymentAmount = downPaymentAmount;
    }

    public BigDecimal getVatPercent() {
        return vatPercent;
    }

    public void setVatPercent(BigDecimal vatPercent) {
        this.vatPercent = vatPercent;
    }

    public BigDecimal getVatAmount() {
        return vatAmount;
    }

    public void setVatAmount(BigDecimal vatAmount) {
        this.vatAmount = vatAmount;
    }

    public BigDecimal getOtherFeeAmount() {
        return otherFeeAmount;
    }

    public void setOtherFeeAmount(BigDecimal otherFeeAmount) {
        this.otherFeeAmount = otherFeeAmount;
    }

    public String getOtherFeeRemark() {
        return otherFeeRemark;
    }

    public void setOtherFeeRemark(String otherFeeRemark) {
        this.otherFeeRemark = otherFeeRemark;
    }

    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getVendorName() {
        return vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
    }

    public String getOtherFeeBudgetTypeCode() {
        return otherFeeBudgetTypeCode;
    }

    public void setOtherFeeBudgetTypeCode(String otherFeeBudgetTypeCode) {
        this.otherFeeBudgetTypeCode = otherFeeBudgetTypeCode;
    }

    public String getOtherFeeBudgetTypeName() {
        return otherFeeBudgetTypeName;
    }

    public void setOtherFeeBudgetTypeName(String otherFeeBudgetTypeName) {
        this.otherFeeBudgetTypeName = otherFeeBudgetTypeName;
    }

    public String getVendorContactPerson() {
        return vendorContactPerson;
    }

    public void setVendorContactPerson(String vendorContactPerson) {
        this.vendorContactPerson = vendorContactPerson;
    }

    public String getVendorAddress() {
        return vendorAddress;
    }

    public void setVendorAddress(String vendorAddress) {
        this.vendorAddress = vendorAddress;
    }

    public String getVendorPhone1() {
        return vendorPhone1;
    }

    public void setVendorPhone1(String vendorPhone1) {
        this.vendorPhone1 = vendorPhone1;
    }

    public String getVendorPhone2() {
        return vendorPhone2;
    }

    public void setVendorPhone2(String vendorPhone2) {
        this.vendorPhone2 = vendorPhone2;
    }

    public String getVendorNPWP() {
        return vendorNPWP;
    }

    public void setVendorNPWP(String vendorNPWP) {
        this.vendorNPWP = vendorNPWP;
    }

    public boolean isGoodsSupplyStatus() {
        return goodsSupplyStatus;
    }

    public void setGoodsSupplyStatus(boolean goodsSupplyStatus) {
        this.goodsSupplyStatus = goodsSupplyStatus;
    }

    public boolean isServiceSupplyStatus() {
        return serviceSupplyStatus;
    }

    public void setServiceSupplyStatus(boolean serviceSupplyStatus) {
        this.serviceSupplyStatus = serviceSupplyStatus;
    }

    public BigDecimal getPph23Percent() {
        return pph23Percent;
    }

    public void setPph23Percent(BigDecimal pph23Percent) {
        this.pph23Percent = pph23Percent;
    }

    public BigDecimal getTotalTransactionAmountHeader() {
        return totalTransactionAmountHeader;
    }

    public void setTotalTransactionAmountHeader(BigDecimal totalTransactionAmountHeader) {
        this.totalTransactionAmountHeader = totalTransactionAmountHeader;
    }

    public BigDecimal getDiscountPercentHeader() {
        return discountPercentHeader;
    }

    public void setDiscountPercentHeader(BigDecimal discountPercentHeader) {
        this.discountPercentHeader = discountPercentHeader;
    }

    public BigDecimal getDiscountAmountHeader() {
        return discountAmountHeader;
    }

    public void setDiscountAmountHeader(BigDecimal discountAmountHeader) {
        this.discountAmountHeader = discountAmountHeader;
    }

    public BigDecimal getDownPaymentAmountHeader() {
        return downPaymentAmountHeader;
    }

    public void setDownPaymentAmountHeader(BigDecimal downPaymentAmountHeader) {
        this.downPaymentAmountHeader = downPaymentAmountHeader;
    }

    public BigDecimal getVatPercentHeader() {
        return vatPercentHeader;
    }

    public void setVatPercentHeader(BigDecimal vatPercentHeader) {
        this.vatPercentHeader = vatPercentHeader;
    }

    public BigDecimal getVatAmountHeader() {
        return vatAmountHeader;
    }

    public void setVatAmountHeader(BigDecimal vatAmountHeader) {
        this.vatAmountHeader = vatAmountHeader;
    }

    public BigDecimal getGrandTotalAmountHeader() {
        return grandTotalAmountHeader;
    }

    public void setGrandTotalAmountHeader(BigDecimal grandTotalAmountHeader) {
        this.grandTotalAmountHeader = grandTotalAmountHeader;
    }

    public BigDecimal getPostedTotalTransactionAmount() {
        return postedTotalTransactionAmount;
    }

    public void setPostedTotalTransactionAmount(BigDecimal postedTotalTransactionAmount) {
        this.postedTotalTransactionAmount = postedTotalTransactionAmount;
    }

    public BigDecimal getPostedDiscountPercent() {
        return postedDiscountPercent;
    }

    public void setPostedDiscountPercent(BigDecimal postedDiscountPercent) {
        this.postedDiscountPercent = postedDiscountPercent;
    }

    public BigDecimal getPostedDiscountAmount() {
        return postedDiscountAmount;
    }

    public void setPostedDiscountAmount(BigDecimal postedDiscountAmount) {
        this.postedDiscountAmount = postedDiscountAmount;
    }

    public BigDecimal getPostedDownPaymentAmount() {
        return postedDownPaymentAmount;
    }

    public void setPostedDownPaymentAmount(BigDecimal postedDownPaymentAmount) {
        this.postedDownPaymentAmount = postedDownPaymentAmount;
    }

    public BigDecimal getPostedVatPercent() {
        return postedVatPercent;
    }

    public void setPostedVatPercent(BigDecimal postedVatPercent) {
        this.postedVatPercent = postedVatPercent;
    }

    public BigDecimal getPostedVatAmount() {
        return postedVatAmount;
    }

    public void setPostedVatAmount(BigDecimal postedVatAmount) {
        this.postedVatAmount = postedVatAmount;
    }

    public BigDecimal getPostedGrandTotalAmount() {
        return postedGrandTotalAmount;
    }

    public void setPostedGrandTotalAmount(BigDecimal postedGrandTotalAmount) {
        this.postedGrandTotalAmount = postedGrandTotalAmount;
    }

    public String getDocumentCode() {
        return documentCode;
    }

    public void setDocumentCode(String documentCode) {
        this.documentCode = documentCode;
    }

    public String getCurrenctCode() {
        return currenctCode;
    }

    public void setCurrenctCode(String currenctCode) {
        this.currenctCode = currenctCode;
    }

    public String getCurrenctName() {
        return currenctName;
    }

    public void setCurrenctName(String currenctName) {
        this.currenctName = currenctName;
    }

    public String getTaxInvoiceNo() {
        return taxInvoiceNo;
    }

    public void setTaxInvoiceNo(String taxInvoiceNo) {
        this.taxInvoiceNo = taxInvoiceNo;
    }

    public Date getTaxInvoiceDate() {
        return taxInvoiceDate;
    }

    public void setTaxInvoiceDate(Date taxInvoiceDate) {
        this.taxInvoiceDate = taxInvoiceDate;
    }

    public BigDecimal getTaxBaseAmount() {
        return taxBaseAmount;
    }

    public void setTaxBaseAmount(BigDecimal taxBaseAmount) {
        this.taxBaseAmount = taxBaseAmount;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    public BigDecimal getPaymentTermDays() {
        return paymentTermDays;
    }

    public void setPaymentTermDays(BigDecimal paymentTermDays) {
        this.paymentTermDays = paymentTermDays;
    }

    public BigDecimal getDueDays() {
        return dueDays;
    }

    public void setDueDays(BigDecimal dueDays) {
        this.dueDays = dueDays;
    }

    public String getStatusInvoice() {
        return statusInvoice;
    }

    public void setStatusInvoice(String statusInvoice) {
        this.statusInvoice = statusInvoice;
    }

    public BigDecimal getBalanceAmount() {
        return balanceAmount;
    }

    public void setBalanceAmount(BigDecimal balanceAmount) {
        this.balanceAmount = balanceAmount;
    }

    public String getVendorInvoiceNo() {
        return vendorInvoiceNo;
    }

    public void setVendorInvoiceNo(String vendorInvoiceNo) {
        this.vendorInvoiceNo = vendorInvoiceNo;
    }

    public Date getVendorInvoiceDate() {
        return vendorInvoiceDate;
    }

    public void setVendorInvoiceDate(Date vendorInvoiceDate) {
        this.vendorInvoiceDate = vendorInvoiceDate;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getDiscountChartOfAccountCode() {
        return discountChartOfAccountCode;
    }

    public void setDiscountChartOfAccountCode(String discountChartOfAccountCode) {
        this.discountChartOfAccountCode = discountChartOfAccountCode;
    }

    public String getDiscountChartOfAccountName() {
        return discountChartOfAccountName;
    }

    public void setDiscountChartOfAccountName(String discountChartOfAccountName) {
        this.discountChartOfAccountName = discountChartOfAccountName;
    }

    public String getDiscountDescription() {
        return discountDescription;
    }

    public void setDiscountDescription(String discountDescription) {
        this.discountDescription = discountDescription;
    }

    public BigDecimal getPphPercent() {
        return pphPercent;
    }

    public void setPphPercent(BigDecimal pphPercent) {
        this.pphPercent = pphPercent;
    }

    public BigDecimal getPphAmount() {
        return pphAmount;
    }

    public void setPphAmount(BigDecimal pphAmount) {
        this.pphAmount = pphAmount;
    }

    public String getPphChartOfAccountCode() {
        return pphChartOfAccountCode;
    }

    public void setPphChartOfAccountCode(String pphChartOfAccountCode) {
        this.pphChartOfAccountCode = pphChartOfAccountCode;
    }

    public String getPphChartOfAccountName() {
        return pphChartOfAccountName;
    }

    public void setPphChartOfAccountName(String pphChartOfAccountName) {
        this.pphChartOfAccountName = pphChartOfAccountName;
    }

    public String getPphDescription() {
        return pphDescription;
    }

    public void setPphDescription(String pphDescription) {
        this.pphDescription = pphDescription;
    }

    public String getOtherFeeChartOfAccountCode() {
        return otherFeeChartOfAccountCode;
    }

    public void setOtherFeeChartOfAccountCode(String otherFeeChartOfAccountCode) {
        this.otherFeeChartOfAccountCode = otherFeeChartOfAccountCode;
    }

    public String getOtherFeeChartOfAccountName() {
        return otherFeeChartOfAccountName;
    }

    public void setOtherFeeChartOfAccountName(String otherFeeChartOfAccountName) {
        this.otherFeeChartOfAccountName = otherFeeChartOfAccountName;
    }

    public String getOtherFeeDescription() {
        return otherFeeDescription;
    }

    public void setOtherFeeDescription(String otherFeeDescription) {
        this.otherFeeDescription = otherFeeDescription;
    }
    
}
