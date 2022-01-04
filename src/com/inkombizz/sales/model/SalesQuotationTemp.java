
package com.inkombizz.sales.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class SalesQuotationTemp {
    private String code="";
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private String transactionDateTemp="";
    private String salQuoNo="";
    private String revision="";
    private String refSalQUOCode="";
    private String rfqCode = "";
    private String branchCode="";
    private String branchName="";
    private String projectCode="";
    private String projectName="";
    private String subject="";    
    private String orderStatus="";    
    private String customerCode="";
    private String customerName="";
    private String endUserCode="";
    private String endUserName="";
    private String currencyCode="";
    private String currencyName="";
    private String termOfDeliveryCode="";
    private String termOfDeliveryName="";
    private String attn="";
    private String salesPersonCode="";
    private String salesPersonName="";
    private String shipToCode="";
    private String shipToName="";
    private BigDecimal vatPercent=new BigDecimal("0.00");
    private BigDecimal vatAmount=new BigDecimal("0.00");
    private BigDecimal grandTotalAmount=new BigDecimal("0.00");
    private BigDecimal totalTransactionAmount=new BigDecimal("0.00");
    private BigDecimal discountPercent=new BigDecimal("0.00");
    private BigDecimal discountAmount=new BigDecimal("0.00");
    private BigDecimal taxBaseAmount=new BigDecimal("0.00");
    private String refNo="";
    private String remark="";
    private boolean validStatus=false;
    private String salQUOStatus="";
    private String salQUOStatusReason="";
    private String salQUOStatusRemark="";
    private String itemDetail="";
    private Date firstDate= DateUtils.newDate(1900, 1, 1);
    private Date lastDate= DateUtils.newDate(1900, 1, 1);
    private Date settlementDate= DateUtils.newDate(1900, 1, 1);
    private String priceValidity = "";
    private String certificateDocumentation = "";
    private String testing = "";
    private String inspection = "";
    private String painting = "";
    private String packing = "";
    private String tagging = "";
    private String warranty = "";
    private String payment = "";

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

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Date getSettlementDate() {
        return settlementDate;
    }

    public void setSettlementDate(Date settlementDate) {
        this.settlementDate = settlementDate;
    }

    public String getSalQuoNo() {
        return salQuoNo;
    }

    public void setSalQuoNo(String salQuoNo) {
        this.salQuoNo = salQuoNo;
    }

    public String getRevision() {
        return revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }

    public String getRefSalQUOCode() {
        return refSalQUOCode;
    }

    public void setRefSalQUOCode(String refSalQUOCode) {
        this.refSalQUOCode = refSalQUOCode;
    }

    public String getRfqCode() {
        return rfqCode;
    }

    public void setRfqCode(String rfqCode) {
        this.rfqCode = rfqCode;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getEndUserCode() {
        return endUserCode;
    }

    public void setEndUserCode(String endUserCode) {
        this.endUserCode = endUserCode;
    }

    public String getEndUserName() {
        return endUserName;
    }

    public void setEndUserName(String endUserName) {
        this.endUserName = endUserName;
    }

    public String getAttn() {
        return attn;
    }

    public void setAttn(String attn) {
        this.attn = attn;
    }

    public String getSalesPersonCode() {
        return salesPersonCode;
    }

    public void setSalesPersonCode(String salesPersonCode) {
        this.salesPersonCode = salesPersonCode;
    }

    public String getSalesPersonName() {
        return salesPersonName;
    }

    public void setSalesPersonName(String salesPersonName) {
        this.salesPersonName = salesPersonName;
    }

    public String getShipToCode() {
        return shipToCode;
    }

    public void setShipToCode(String shipToCode) {
        this.shipToCode = shipToCode;
    }

    public String getShipToName() {
        return shipToName;
    }

    public void setShipToName(String shipToName) {
        this.shipToName = shipToName;
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

    public boolean isValidStatus() {
        return validStatus;
    }

    public void setValidStatus(boolean validStatus) {
        this.validStatus = validStatus;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getTransactionDateTemp() {
        return transactionDateTemp;
    }

    public void setTransactionDateTemp(String transactionDateTemp) {
        this.transactionDateTemp = transactionDateTemp;
    }

    public String getTermOfDeliveryCode() {
        return termOfDeliveryCode;
    }

    public void setTermOfDeliveryCode(String termOfDeliveryCode) {
        this.termOfDeliveryCode = termOfDeliveryCode;
    }

    public String getTermOfDeliveryName() {
        return termOfDeliveryName;
    }

    public void setTermOfDeliveryName(String termOfDeliveryName) {
        this.termOfDeliveryName = termOfDeliveryName;
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

    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
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

    public String getSalQUOStatus() {
        return salQUOStatus;
    }

    public void setSalQUOStatus(String salQUOStatus) {
        this.salQUOStatus = salQUOStatus;
    }

    public String getSalQUOStatusReason() {
        return salQUOStatusReason;
    }

    public void setSalQUOStatusReason(String salQUOStatusReason) {
        this.salQUOStatusReason = salQUOStatusReason;
    }

    public String getSalQUOStatusRemark() {
        return salQUOStatusRemark;
    }

    public void setSalQUOStatusRemark(String salQUOStatusRemark) {
        this.salQUOStatusRemark = salQUOStatusRemark;
    }

    public BigDecimal getTaxBaseAmount() {
        return taxBaseAmount;
    }

    public void setTaxBaseAmount(BigDecimal taxBaseAmount) {
        this.taxBaseAmount = taxBaseAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Date getFirstDate() {
        return firstDate;
    }

    public void setFirstDate(Date firstDate) {
        this.firstDate = firstDate;
    }

    public Date getLastDate() {
        return lastDate;
    }

    public void setLastDate(Date lastDate) {
        this.lastDate = lastDate;
    }

    public String getItemDetail() {
        return itemDetail;
    }

    public void setItemDetail(String itemDetail) {
        this.itemDetail = itemDetail;
    }

    public String getPriceValidity() {
        return priceValidity;
    }

    public void setPriceValidity(String priceValidity) {
        this.priceValidity = priceValidity;
    }

    public String getCertificateDocumentation() {
        return certificateDocumentation;
    }

    public void setCertificateDocumentation(String certificateDocumentation) {
        this.certificateDocumentation = certificateDocumentation;
    }

    public String getTesting() {
        return testing;
    }

    public void setTesting(String testing) {
        this.testing = testing;
    }

    public String getInspection() {
        return inspection;
    }

    public void setInspection(String inspection) {
        this.inspection = inspection;
    }

    public String getPainting() {
        return painting;
    }

    public void setPainting(String painting) {
        this.painting = painting;
    }

    public String getPacking() {
        return packing;
    }

    public void setPacking(String packing) {
        this.packing = packing;
    }

    public String getTagging() {
        return tagging;
    }

    public void setTagging(String tagging) {
        this.tagging = tagging;
    }

    public String getWarranty() {
        return warranty;
    }

    public void setWarranty(String warranty) {
        this.warranty = warranty;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }
    
}

