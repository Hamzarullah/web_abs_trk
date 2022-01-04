
package com.inkombizz.sales.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.PaymentTerm;
import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;


@Entity
@Table(name = "sal_customer_purchase_order_payment_term")
public class CustomerPurchaseOrderPaymentTerm extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
    private String headerCode="";
    
    @Column(name = "SortNo")
    private BigDecimal sortNo=new BigDecimal("0");
            
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PaymentTermCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private PaymentTerm paymentTerm=null;
    
    @Column(name = "Percentage")
    private BigDecimal percentage=new BigDecimal("0.00");
            
    @Column(name = "Remark")
    private String remark="";
    
    @Transient private String paymentTermCode="";
    @Transient private String paymentTermName="";

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

    public BigDecimal getSortNo() {
        return sortNo;
    }

    public void setSortNo(BigDecimal sortNo) {
        this.sortNo = sortNo;
    }

    public PaymentTerm getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(PaymentTerm paymentTerm) {
        this.paymentTerm = paymentTerm;
    }

    public BigDecimal getPercentage() {
        return percentage;
    }

    public void setPercentage(BigDecimal percentage) {
        this.percentage = percentage;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

}
