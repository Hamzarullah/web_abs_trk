
package com.inkombizz.sales.model;

import com.inkombizz.common.BaseEntity;
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
@Table(name = "sal_customer_sales_order_jn_sales_quotation")
public class CustomerSalesOrderSalesQuotation extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
    private String headerCode="";
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesQuotationCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private SalesQuotation salesQuotation=null;

    
    @Transient private String salesQuotationCode="";
    @Transient private Date salesQuotationTransactionDate= DateUtils.newDate(1900, 1, 1);
    @Transient private String salesQuotationCustomerCode="";
    @Transient private String salesQuotationCustomerName="";
    @Transient private String salesQuotationEndUserCode="";
    @Transient private String salesQuotationEndUserName="";
    @Transient private String salesQuotationRfqCode="";
    @Transient private String salesQuotationProject="";
    @Transient private String salesQuotationAttn="";
    @Transient private String salesQuotationRefNo="";
    @Transient private String salesQuotationRemark="";
    @Transient private String salesQuotationSubject="";
    
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

    public String getSalesQuotationCode() {
        return salesQuotationCode;
    }

    public void setSalesQuotationCode(String salesQuotationCode) {
        this.salesQuotationCode = salesQuotationCode;
    }

    public Date getSalesQuotationTransactionDate() {
        return salesQuotationTransactionDate;
    }

    public void setSalesQuotationTransactionDate(Date salesQuotationTransactionDate) {
        this.salesQuotationTransactionDate = salesQuotationTransactionDate;
    }

    public String getSalesQuotationCustomerCode() {
        return salesQuotationCustomerCode;
    }

    public void setSalesQuotationCustomerCode(String salesQuotationCustomerCode) {
        this.salesQuotationCustomerCode = salesQuotationCustomerCode;
    }

    public String getSalesQuotationCustomerName() {
        return salesQuotationCustomerName;
    }

    public void setSalesQuotationCustomerName(String salesQuotationCustomerName) {
        this.salesQuotationCustomerName = salesQuotationCustomerName;
    }

    public String getSalesQuotationRfqCode() {
        return salesQuotationRfqCode;
    }

    public void setSalesQuotationRfqCode(String salesQuotationRfqCode) {
        this.salesQuotationRfqCode = salesQuotationRfqCode;
    }

    public String getSalesQuotationProject() {
        return salesQuotationProject;
    }

    public void setSalesQuotationProject(String salesQuotationProject) {
        this.salesQuotationProject = salesQuotationProject;
    }

    public String getSalesQuotationAttn() {
        return salesQuotationAttn;
    }

    public void setSalesQuotationAttn(String salesQuotationAttn) {
        this.salesQuotationAttn = salesQuotationAttn;
    }

    public String getSalesQuotationRefNo() {
        return salesQuotationRefNo;
    }

    public void setSalesQuotationRefNo(String salesQuotationRefNo) {
        this.salesQuotationRefNo = salesQuotationRefNo;
    }

    public String getSalesQuotationRemark() {
        return salesQuotationRemark;
    }

    public void setSalesQuotationRemark(String salesQuotationRemark) {
        this.salesQuotationRemark = salesQuotationRemark;
    }

    public String getSalesQuotationEndUserCode() {
        return salesQuotationEndUserCode;
    }

    public void setSalesQuotationEndUserCode(String salesQuotationEndUserCode) {
        this.salesQuotationEndUserCode = salesQuotationEndUserCode;
    }

    public String getSalesQuotationEndUserName() {
        return salesQuotationEndUserName;
    }

    public void setSalesQuotationEndUserName(String salesQuotationEndUserName) {
        this.salesQuotationEndUserName = salesQuotationEndUserName;
    }

    public String getSalesQuotationSubject() {
        return salesQuotationSubject;
    }

    public void setSalesQuotationSubject(String salesQuotationSubject) {
        this.salesQuotationSubject = salesQuotationSubject;
    }

    
    
    
    
}
