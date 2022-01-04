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
@Table(name="mst_vendor")
public class Vendor implements Serializable {
	
    private String code = "";
    private String name = "";
    private String address = "";
    private City city = null;
    private String zipCode = "";
    private String phone1 = "";
    private String phone2 = "";
    private String emailAddress = "";
    private String fax = "";
    private VendorCategory vendorCategory = null;
    private boolean activeStatus =false;
    private boolean criticalStatus =false;
    private boolean penaltyStatus =false;
    private BusinessEntity businessEntity = null;
    private PaymentTerm paymentTerm = null;
    private VendorContact defaultContactPerson=null;
    private String localImport = "";
    private String npwp = "";
    private String npwpName = "";
    private String npwpAddress = "";
    private City npwpCity = null;
    private String npwpZipCode = null;
    private String remark = "";
    private String scope = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    @Id
    @Column(name="Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "ActiveStatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    @Column(name = "Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Column(name = "InActiveBy")
    public String getInActiveBy() {
        return inActiveBy;
    }

    public void setInActiveBy(String inActiveBy) {
        this.inActiveBy = inActiveBy;
    }

    @Column(name = "InActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
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

    @Column(name = "Address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CityCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    @Column(name = "ZipCode")
    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    @Column(name = "Phone1")
    public String getPhone1() {
        return phone1;
    }

    public void setPhone1(String phone1) {
        this.phone1 = phone1;
    }

    @Column(name = "Phone2")
    public String getPhone2() {
        return phone2;
    }

    public void setPhone2(String phone2) {
        this.phone2 = phone2;
    }

    @Column(name = "EmailAddress")
    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    @Column(name = "Fax")
    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BusinessEntityCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public BusinessEntity getBusinessEntity() {
        return businessEntity;
    }

    public void setBusinessEntity(BusinessEntity businessEntity) {
        this.businessEntity = businessEntity;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PaymentTermCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public PaymentTerm getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(PaymentTerm paymentTerm) {
        this.paymentTerm = paymentTerm;
    }

    @Column(name = "NPWP")
    public String getNpwp() {
        return npwp;
    }

    public void setNpwp(String npwp) {
        this.npwp = npwp;
    }

    @Column(name = "NPWPName")
    public String getNpwpName() {
        return npwpName;
    }

    public void setNpwpName(String npwpName) {
        this.npwpName = npwpName;
    }

    @Column(name = "NPWPAddress")
    public String getNpwpAddress() {
        return npwpAddress;
    }

    public void setNpwpAddress(String npwpAddress) {
        this.npwpAddress = npwpAddress;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "NPWPCityCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public City getNpwpCity() {
        return npwpCity;
    }

    public void setNpwpCity(City npwpCity) {
        this.npwpCity = npwpCity;
    }

    public String getNpwpZipCode() {
        return npwpZipCode;
    }

    public void setNpwpZipCode(String npwpZipCode) {
        this.npwpZipCode = npwpZipCode;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "VendorCategoryCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public VendorCategory getVendorCategory() {
        return vendorCategory;
    }

    public void setVendorCategory(VendorCategory vendorCategory) {
        this.vendorCategory = vendorCategory;
    }

    @Column(name="LocalImport")
    public String getLocalImport() {
        return localImport;
    }

    public void setLocalImport(String localImport) {
        this.localImport = localImport;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DefaultContactPersonCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
//    @NotFound(action=NotFoundAction.IGNORE)
    public VendorContact getDefaultContactPerson() {
        return defaultContactPerson;
    }

    public void setDefaultContactPerson(VendorContact defaultContactPerson) {
        this.defaultContactPerson = defaultContactPerson;
    }

    public boolean isCriticalStatus() {
        return criticalStatus;
    }

    public void setCriticalStatus(boolean criticalStatus) {
        this.criticalStatus = criticalStatus;
    }

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }

    @Column(name="PenaltyStatus")
    public boolean isPenaltyStatus() {
        return penaltyStatus;
    }

    public void setPenaltyStatus(boolean penaltyStatus) {
        this.penaltyStatus = penaltyStatus;
    }
    
    
    
    
}

