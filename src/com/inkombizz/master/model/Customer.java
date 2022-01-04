
package com.inkombizz.master.model;


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
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;


@Entity
@Table(name = "mst_customer")
public class Customer implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @Column(name = "Name")
    private String name = "";
    
    @Column(name = "Address")
    private String address = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CityCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private City city = null;
    
    @Column(name = "ZipCode")
    private String zipCode= "";
    
    @Column(name = "Phone1")
    private String phone1 = "";
    
    @Column(name = "Phone2")
    private String phone2 = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PaymentTermCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private PaymentTerm paymentTerm = null;
    
    @Column(name = "Fax")
    private String fax = "";
    
    @Column(name = "EmailAddress")
    private String emailAddress= "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CustomerCategoryCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private CustomerCategory customerCategory = null;
   
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BusinessEntityCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    private BusinessEntity businessEntity = null;
       
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DefaultContactPersonCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private CustomerContact defaultContactPerson= null;
    
    @Column(name = "DefaultShipToCode")
    private String defaultShipToCode= "";
    
    @Column(name = "DefaultBillToCode")
    private String defaultBillToCode= "";
    
    @Column(name = "TaxCode")
    private String taxCode= "";
    
    @Column(name = "CustomerStatus")
    private boolean customerStatus=false;
    
    @Column(name = "EndUserStatus")
    private boolean endUserStatus=false;
    
    @Column(name = "ActiveStatus")
    private boolean activeStatus=false;
    
    @Column(name = "Remark")
    private String remark= "";
    
    @Column(name = "InActiveBy")
    private String inActiveBy = "";
    
    @Column(name = "InActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "CreatedBy")
    private String createdBy = "";
    
    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "UpdatedBy")
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    //Getter Setter

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public String getPhone1() {
        return phone1;
    }

    public void setPhone1(String phone1) {
        this.phone1 = phone1;
    }

    public String getPhone2() {
        return phone2;
    }

    public void setPhone2(String phone2) {
        this.phone2 = phone2;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public PaymentTerm getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(PaymentTerm paymentTerm) {
        this.paymentTerm = paymentTerm;
    }

    public CustomerContact getDefaultContactPerson() {
        return defaultContactPerson;
    }

    public void setDefaultContactPerson(CustomerContact defaultContactPerson) {
        this.defaultContactPerson = defaultContactPerson;
    }

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getInActiveBy() {
        return inActiveBy;
    }

    public void setInActiveBy(String inActiveBy) {
        this.inActiveBy = inActiveBy;
    }

    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
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

    public String getDefaultShipToCode() {
        return defaultShipToCode;
    }

    public void setDefaultShipToCode(String defaultShipToCode) {
        this.defaultShipToCode = defaultShipToCode;
    }

    public String getDefaultBillToCode() {
        return defaultBillToCode;
    }

    public void setDefaultBillToCode(String defaultBillToCode) {
        this.defaultBillToCode = defaultBillToCode;
    }

    public boolean isCustomerStatus() {
        return customerStatus;
    }

    public void setCustomerStatus(boolean customerStatus) {
        this.customerStatus = customerStatus;
    }

    public boolean isEndUserStatus() {
        return endUserStatus;
    }

    public void setEndUserStatus(boolean endUserStatus) {
        this.endUserStatus = endUserStatus;
    }

    public String getTaxCode() {
        return taxCode;
    }

    public void setTaxCode(String taxCode) {
        this.taxCode = taxCode;
    }

    public CustomerCategory getCustomerCategory() {
        return customerCategory;
    }

    public void setCustomerCategory(CustomerCategory customerCategory) {
        this.customerCategory = customerCategory;
    }

    public BusinessEntity getBusinessEntity() {
        return businessEntity;
    }

    public void setBusinessEntity(BusinessEntity businessEntity) {
        this.businessEntity = businessEntity;
    }
}
