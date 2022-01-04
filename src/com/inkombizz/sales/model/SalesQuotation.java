
package com.inkombizz.sales.model;

import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.City;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.Project;
import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.SalesPerson;
import com.inkombizz.master.model.TermOfDelivery;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "sal_sales_quotation")
public class SalesQuotation implements Serializable{
    
    private String code="";
    private String salQuoNo="";
    private String revision="";
    private String refSalQUOCode="";
    private Branch branch = null;
    private Project project = null;
    private String subject = "";
    private String attn = "";
    private Currency currency = null;
    private Customer customer = null;
    private Customer endUser = null;
    private SalesPerson salesPerson = null;
    private RequestForQuotation requestForQuotation = null;
    private String orderStatus = "BLANKET_ORDER";
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    private City city=null; 
    private TermOfDelivery termOfDelivery = null;
    private String refNo="";
    private String remark="";
    private boolean validStatus=false;
    private String salQuoStatus="NO_STATUS";
    private Reason reason= null;
    private String salQuoRemark="";
    private BigDecimal totalTransactionAmount=new BigDecimal("0.00");
    private BigDecimal discountPercent=new BigDecimal("0.00");
    private BigDecimal discountAmount=new BigDecimal("0.00");
    private BigDecimal vatPercent=new BigDecimal("0.00");
    private BigDecimal vatAmount=new BigDecimal("0.00");
    private BigDecimal grandTotalAmount=new BigDecimal("0.00");
    private BigDecimal taxBaseAmount = new BigDecimal("0.00");
    private String createdBy="";
    private Date createdDate=DateUtils.newDate(1900, 1, 1);
    private String updatedBy="";
    private Date updatedDate=DateUtils.newDate(1900, 1, 1);
    private String priceValidity = "";
    private String certificateDocumentation = "";
    private String testing = "";
    private String inspection = "";
    private String painting = "";
    private String packing = "";
    private String tagging = "";
    private String warranty = "";
    private String payment = "";
    
    @Id
    @Column(name = "Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "RefNo")
    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    @Column(name = "Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Column(name = "CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Column(name = "UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ShipToCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "TermOfDeliveryCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public TermOfDelivery getTermOfDelivery() {
        return termOfDelivery;
    }

    public void setTermOfDelivery(TermOfDelivery termOfDelivery) {
        this.termOfDelivery = termOfDelivery;
    }
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }
    @Column(name = "TotalTransactionAmount")
    public BigDecimal getTotalTransactionAmount() {
        return totalTransactionAmount;
    }

    public void setTotalTransactionAmount(BigDecimal totalTransactionAmount) {
        this.totalTransactionAmount = totalTransactionAmount;
    }
    @Column(name = "DiscountPercent")
    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }
    @Column(name = "DiscountAmount")
    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }
    @Column(name = "VatPercent")
    public BigDecimal getVatPercent() {
        return vatPercent;
    }

    public void setVatPercent(BigDecimal vatPercent) {
        this.vatPercent = vatPercent;
    }
    @Column(name = "VatAmount")
    public BigDecimal getVatAmount() {
        return vatAmount;
    }

    public void setVatAmount(BigDecimal vatAmount) {
        this.vatAmount = vatAmount;
    }
    @Column(name = "GrandTotalAmount")
    public BigDecimal getGrandTotalAmount() {
        return grandTotalAmount;
    }

    public void setGrandTotalAmount(BigDecimal grandTotalAmount) {
        this.grandTotalAmount = grandTotalAmount;
    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "RFQCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public RequestForQuotation getRequestForQuotation() {
        return requestForQuotation;
    }

    public void setRequestForQuotation(RequestForQuotation requestForQuotation) {
        this.requestForQuotation = requestForQuotation;
    }
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ProjectCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }
    @Column(name="Subject")
    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }
    @Column(name="Attn")
    public String getAttn() {
        return attn;
    }

    public void setAttn(String attn) {
        this.attn = attn;
    }
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CustomerCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "EndUserCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Customer getEndUser() {
        return endUser;
    }

    public void setEndUser(Customer endUser) {
        this.endUser = endUser;
    }
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesPersonCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public SalesPerson getSalesPerson() {
        return salesPerson;
    }

    public void setSalesPerson(SalesPerson salesPerson) {
        this.salesPerson = salesPerson;
    }
    @Column(name="SALQUONo")
    public String getSalQuoNo() {
        return salQuoNo;
    }

    public void setSalQuoNo(String salQuoNo) {
        this.salQuoNo = salQuoNo;
    }

    @Column(name="Revision")
    public String getRevision() {
        return revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }
    @Column(name="ValidStatus")
    public boolean isValidStatus() {
        return validStatus;
    }

    public void setValidStatus(boolean validStatus) {
        this.validStatus = validStatus;
    }
    
   @Column(name="RefSalQUOCode")
   public String getRefSalQUOCode() {
        return refSalQUOCode;
    }

    public void setRefSalQUOCode(String refSalQUOCode) {
        this.refSalQUOCode = refSalQUOCode;
    }

    @Column(name="SALQUOStatus")
    public String getSalQuoStatus() {
        return salQuoStatus;
    }

    public void setSalQuoStatus(String salQuoStatus) {
        this.salQuoStatus = salQuoStatus;
    }

    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SALQUOStatusReason", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public Reason getReason() {
        return reason;
    }

    public void setReason(Reason reason) {
        this.reason = reason;
    }
   
    @Column(name="SALQUOStatusRemark")
     public String getSalQuoRemark() {
        return salQuoRemark;
    }

    public void setSalQuoRemark(String salQuoRemark) {
        this.salQuoRemark = salQuoRemark;
    }
    
    @Column(name = "TaxBaseAmount")
    public BigDecimal getTaxBaseAmount() {
        return taxBaseAmount;
    }

    public void setTaxBaseAmount(BigDecimal taxBaseAmount) {
        this.taxBaseAmount = taxBaseAmount;
    }

    @Column(name = "OrderStatus")
    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    @Column(name = "PriceValidity")
    public String getPriceValidity() {
        return priceValidity;
    }

    public void setPriceValidity(String priceValidity) {
        this.priceValidity = priceValidity;
    }

    @Column(name = "CertificateDocumentation")
    public String getCertificateDocumentation() {
        return certificateDocumentation;
    }

    public void setCertificateDocumentation(String certificateDocumentation) {
        this.certificateDocumentation = certificateDocumentation;
    }

    @Column(name = "Testing")
    public String getTesting() {
        return testing;
    }

    public void setTesting(String testing) {
        this.testing = testing;
    }

    @Column(name = "Inspection")
    public String getInspection() {
        return inspection;
    }

    public void setInspection(String inspection) {
        this.inspection = inspection;
    }

    @Column(name = "Painting")
    public String getPainting() {
        return painting;
    }

    public void setPainting(String painting) {
        this.painting = painting;
    }

    @Column(name = "Packing")
    public String getPacking() {
        return packing;
    }

    public void setPacking(String packing) {
        this.packing = packing;
    }

    @Column(name = "Tagging")
    public String getTagging() {
        return tagging;
    }

    public void setTagging(String tagging) {
        this.tagging = tagging;
    }

    @Column(name = "Warranty")
    public String getWarranty() {
        return warranty;
    }

    public void setWarranty(String warranty) {
        this.warranty = warranty;
    }

    @Column(name = "Payment")
    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }
    
    

}
