/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.purchasing.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.Branch;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity 
@Table(name = "pur_purchase_order_jn_purchase_request")
public class PurchaseOrderPurchaseRequest extends BaseEntity implements Serializable{
    
     @Id
    @Column(name="Code")
    private String code="";
  
    @Column(name="HeaderCode")
    private String headerCode="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private Branch branch=null;

    @Column(name="PurchaseRequestCode")
    private String purchaseRequestCode="";

    @Column(name="PurchaseRequestType")
    private String purchaseRequestType="";
    
    @Transient private Date purchaseRequestTransactionDate=DateUtils.newDate(1900, 1, 1);
    @Transient private String purchaseRequestRefNo="";
    @Transient private String purchaseRequestRemark="";
    @Transient private String purchaseRequestRequestBy="";
    @Transient private String ppoCode="";
    @Transient private String branchCode="";
    @Transient private String branchName="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public String getPurchaseRequestCode() {
        return purchaseRequestCode;
    }

    public void setPurchaseRequestCode(String purchaseRequestCode) {
        this.purchaseRequestCode = purchaseRequestCode;
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

    public Date getPurchaseRequestTransactionDate() {
        return purchaseRequestTransactionDate;
    }

    public void setPurchaseRequestTransactionDate(Date purchaseRequestTransactionDate) {
        this.purchaseRequestTransactionDate = purchaseRequestTransactionDate;
    }

    public String getPurchaseRequestRefNo() {
        return purchaseRequestRefNo;
    }

    public void setPurchaseRequestRefNo(String purchaseRequestRefNo) {
        this.purchaseRequestRefNo = purchaseRequestRefNo;
    }

    public String getPurchaseRequestRemark() {
        return purchaseRequestRemark;
    }

    public void setPurchaseRequestRemark(String purchaseRequestRemark) {
        this.purchaseRequestRemark = purchaseRequestRemark;
    }

    public String getPurchaseRequestRequestBy() {
        return purchaseRequestRequestBy;
    }

    public void setPurchaseRequestRequestBy(String purchaseRequestRequestBy) {
        this.purchaseRequestRequestBy = purchaseRequestRequestBy;
    }   

    public String getPurchaseRequestType() {
        return purchaseRequestType;
    }

    public void setPurchaseRequestType(String purchaseRequestType) {
        this.purchaseRequestType = purchaseRequestType;
    }

    public String getPpoCode() {
        return ppoCode;
    }

    public void setPpoCode(String ppoCode) {
        this.ppoCode = ppoCode;
    }
    
    
    
}
