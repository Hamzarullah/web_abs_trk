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
@Table(name = "mst_customer_jn_address")
public class CustomerAddress implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CustomerCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Customer customer = null;
  
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
    
    @Column(name = "Fax")
    private String fax = "";
    
    @Column(name = "EmailAddress")
    private String emailAddress= "";
    
    @Column(name = "ContactPerson")
    private String contactPerson= "";
    
    @Column(name = "remark")
    private String remark = "";
    
    @Column(name = "inActiveBy")
    private String inActiveBy = "";
    
    @Column(name = "inActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "activeStatus")
    private boolean activeStatus=false;
    
    @Column(name = "createdBy")
    private String createdBy = "";
    
    @Column(name = "createdDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "updatedBy")
    private String updatedBy = "";
    
    @Column(name = "updatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "shipToStatus")
    private boolean shipToStatus=false;
    
    @Column(name = "billToStatus")
    private boolean billToStatus=false;
    
    @Column(name = "npwpStatus")
    private boolean npwpStatus = false;
    
    @Column(name = "Npwp")
    private String npwp = "";
    
    @Column(name = "NpwpName")
    private String npwpName = "";
    
    @Column(name = "NpwpAddress")
    private String npwpAddress = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "NPWPCityCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private City npwpCity = null ;
    
    @Column(name = "NpwpZipCode")
    private String npwpZipCode = "";

    
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
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

   

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

//    public PriceType getPriceType() {
//        return priceType;
//    }
//
//    public void setPriceType(PriceType priceType) {
//        this.priceType = priceType;
//    }

//    public SalesPerson getSalesPerson() {
//        return salesPerson;
//    }
//
//    public void setSalesPerson(SalesPerson salesPerson) {
//        this.salesPerson = salesPerson;
//    }
    
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

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
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

    public boolean isShipToStatus() {
        return shipToStatus;
    }

    public void setShipToStatus(boolean shipToStatus) {
        this.shipToStatus = shipToStatus;
    }

    public boolean isBillToStatus() {
        return billToStatus;
    }

    public void setBillToStatus(boolean billToStatus) {
        this.billToStatus = billToStatus;
    }

    public boolean isNpwpStatus() {
        return npwpStatus;
    }

    public void setNpwpStatus(boolean npwpStatus) {
        this.npwpStatus = npwpStatus;
    }

    public String getNpwp() {
        return npwp;
    }

    public void setNpwp(String npwp) {
        this.npwp = npwp;
    }

    public String getNpwpName() {
        return npwpName;
    }

    public void setNpwpName(String npwpName) {
        this.npwpName = npwpName;
    }

    public String getNpwpAddress() {
        return npwpAddress;
    }

    public void setNpwpAddress(String npwpAddress) {
        this.npwpAddress = npwpAddress;
    }

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
    
    
}