/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.Transient;

/**
 *
 * @author Sukha
 */
@Entity
@Table(name = "fin_vendor_invoice_jn_vendor_down_payment")
public class VendorInvoiceVendorDownPayment implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @Column(name = "HeaderCode")
    private String headerCode = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "VendorDownPaymentCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private VendorDownPayment vendorDownPayment = null;
    
    @Column(name = "Amount")
    private BigDecimal amount= new BigDecimal(BigInteger.ZERO);
    
    @Column(name = "CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 01, 01);
    
    @Column(name = "UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 01, 01);
    
    private @Transient String vendorDownPaymentCode="";
    
    /* SET GET METHOD */

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

    public VendorDownPayment getVendorDownPayment() {
        return vendorDownPayment;
    }

    public void setVendorDownPayment(VendorDownPayment vendorDownPayment) {
        this.vendorDownPayment = vendorDownPayment;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
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

    public String getVendorDownPaymentCode() {
        return vendorDownPaymentCode;
    }

    public void setVendorDownPaymentCode(String vendorDownPaymentCode) {
        this.vendorDownPaymentCode = vendorDownPaymentCode;
    }
    
}
