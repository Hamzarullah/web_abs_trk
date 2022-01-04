/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.sales.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;


public class RequestForQuotationTemp {
    
    private String code = "";
    private String rfqNo = "";
    private String revision = "";
    private String refRfqCode= "";
    private String tenderNo = "";
    private String orderStatus = "";
    private String branchCode = "";
    private String branchName = "";
    private Date transactionDate = DateUtils.newDate(1990, 01, 01);
    private Date registeredDate = DateUtils.newDate(1990, 01, 01);
    private String reviewedStatus = "";
    private Date preBidMeetingDate = DateUtils.newDate(1990, 01, 01);
    private Date sendToFactoryDate = DateUtils.newDate(1990, 01, 01);
    private Date submittedDateToCustomer = DateUtils.newDate(1990, 01, 01);
    private String scopeOfSupply = "";
    private String currencyCode = "";
    private String currencyName = "";
    private String customerCode = "";
    private String customerName = "";
    private String endUserCode = "";
    private String endUserName = "";
    private String attn = "";
    private String salesPersonCode = "";
    private String salesPersonName = "";
    private String projectCode = "";
    private String projectName = "";
    private String subject = "";
    private String refNo = "";
    private String remark = "";
    private String validStatus = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1990, 01, 01);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1990, 01, 01);
    private String approvalStatus = "";
    private Date approvalDate = DateUtils.newDate(1990, 01, 01);
    private String approvalBy = "";
    private String approvalReasonCode = "";
    private String approvalReasonName = "";
    private String approvalRemark = "";
    private boolean reviewedStatusRfq = false;
    private boolean validStatusRfq = true;
    private String closingStatus = "";
    private String closingBy = "";
    private Date closingDate = DateUtils.newDate(1990, 01, 01);
    private String rfqCode="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getRfqNo() {
        return rfqNo;
    }

    public void setRfqNo(String rfqNo) {
        this.rfqNo = rfqNo;
    }

    public String getRevision() {
        return revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }

    public String getRefRfqCode() {
        return refRfqCode;
    }

    public void setRefRfqCode(String refRfqCode) {
        this.refRfqCode = refRfqCode;
    }

    public String getTenderNo() {
        return tenderNo;
    }

    public void setTenderNo(String tenderNo) {
        this.tenderNo = tenderNo;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
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

    public Date getRegisteredDate() {
        return registeredDate;
    }

    public void setRegisteredDate(Date registeredDate) {
        this.registeredDate = registeredDate;
    }

    public Date getPreBidMeetingDate() {
        return preBidMeetingDate;
    }

    public void setPreBidMeetingDate(Date preBidMeetingDate) {
        this.preBidMeetingDate = preBidMeetingDate;
    }

    public Date getSendToFactoryDate() {
        return sendToFactoryDate;
    }

    public void setSendToFactoryDate(Date sendToFactoryDate) {
        this.sendToFactoryDate = sendToFactoryDate;
    }

    public Date getSubmittedDateToCustomer() {
        return submittedDateToCustomer;
    }

    public void setSubmittedDateToCustomer(Date submittedDateToCustomer) {
        this.submittedDateToCustomer = submittedDateToCustomer;
    }

    public String getScopeOfSupply() {
        return scopeOfSupply;
    }

    public void setScopeOfSupply(String scopeOfSupply) {
        this.scopeOfSupply = scopeOfSupply;
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

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getApprovalBy() {
        return approvalBy;
    }

    public void setApprovalBy(String approvalBy) {
        this.approvalBy = approvalBy;
    }

    public String getApprovalRemark() {
        return approvalRemark;
    }

    public void setApprovalRemark(String approvalRemark) {
        this.approvalRemark = approvalRemark;
    }

    public String getApprovalReasonCode() {
        return approvalReasonCode;
    }

    public void setApprovalReasonCode(String approvalReasonCode) {
        this.approvalReasonCode = approvalReasonCode;
    }

    public String getApprovalReasonName() {
        return approvalReasonName;
    }

    public void setApprovalReasonName(String approvalReasonName) {
        this.approvalReasonName = approvalReasonName;
    }

    public String getReviewedStatus() {
        return reviewedStatus;
    }

    public void setReviewedStatus(String reviewedStatus) {
        this.reviewedStatus = reviewedStatus;
    }

    public String getValidStatus() {
        return validStatus;
    }

    public void setValidStatus(String validStatus) {
        this.validStatus = validStatus;
    }

    public boolean isReviewedStatusRfq() {
        return reviewedStatusRfq;
    }

    public void setReviewedStatusRfq(boolean reviewedStatusRfq) {
        this.reviewedStatusRfq = reviewedStatusRfq;
    }

    public boolean isValidStatusRfq() {
        return validStatusRfq;
    }

    public void setValidStatusRfq(boolean validStatusRfq) {
        this.validStatusRfq = validStatusRfq;
    }

    public String getClosingStatus() {
        return closingStatus;
    }

    public void setClosingStatus(String closingStatus) {
        this.closingStatus = closingStatus;
    }

    public String getClosingBy() {
        return closingBy;
    }

    public void setClosingBy(String closingBy) {
        this.closingBy = closingBy;
    }

    public Date getClosingDate() {
        return closingDate;
    }

    public void setClosingDate(Date closingDate) {
        this.closingDate = closingDate;
    }

    public String getRfqCode() {
        return rfqCode;
    }

    public void setRfqCode(String rfqCode) {
        this.rfqCode = rfqCode;
    }
    
}
