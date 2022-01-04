
package com.inkombizz.sales.model;

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
import javax.persistence.Temporal;
import javax.persistence.Transient;

@Entity
@Table(name = "sal_contract_review_jn_quotation")
public class ContractReviewSalesQuotation implements Serializable{
    @Id
    @Column (name="Code")
    private String code = "";
    
    @Column (name="Headercode")
    private String headerCode = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesQuotationCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private SalesQuotation salesQuotation = null;
    
    @Column (name="CreatedBy")
    private String createdBy = "";
    
    @Column (name="CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column (name="UpdatedBy")
    private String updatedBy = "";
    
    @Column (name="UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    private @Transient String salesQuotationCode="";
    private @Transient String salesQuotationName="";
    private @Transient String salesQuotationSubject="";
    private @Transient Date salesQuotationTransactionDate= DateUtils.newDate(1900, 1, 1);

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

    public SalesQuotation getSalesQuotation() {
        return salesQuotation;
    }

    public void setSalesQuotation(SalesQuotation salesQuotation) {
        this.salesQuotation = salesQuotation;
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

    public String getSalesQuotationCode() {
        return salesQuotationCode;
    }

    public void setSalesQuotationCode(String salesQuotationCode) {
        this.salesQuotationCode = salesQuotationCode;
    }

    public String getSalesQuotationName() {
        return salesQuotationName;
    }

    public void setSalesQuotationName(String salesQuotationName) {
        this.salesQuotationName = salesQuotationName;
    }

    public String getSalesQuotationSubject() {
        return salesQuotationSubject;
    }

    public void setSalesQuotationSubject(String salesQuotationSubject) {
        this.salesQuotationSubject = salesQuotationSubject;
    }

    public Date getSalesQuotationTransactionDate() {
        return salesQuotationTransactionDate;
    }

    public void setSalesQuotationTransactionDate(Date salesQuotationTransactionDate) {
        this.salesQuotationTransactionDate = salesQuotationTransactionDate;
    }
    
}
