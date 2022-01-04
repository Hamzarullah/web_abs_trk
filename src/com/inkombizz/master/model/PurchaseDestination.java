
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


@Entity
@Table(name = "mst_purchase_destination")
public class PurchaseDestination implements Serializable {
    
    private static final long serialVersionUID = 1L;
       
    
    private String code = "";
    private String name = "";
    private String address = "";
    private String zipCode = "";
    private City city = null;
    private String phone1 = "";
    private String phone2 = "";
    private String fax = "";
    private String emailAddress= "";
    private String contactPerson= "";
    private boolean shipToStatus=false;
    private boolean billToStatus=false;
    private boolean activeStatus=false;
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    
    
    @Id
    @Column(name = "Code")
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
    
    @Column(name = "Address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    @Column(name = "ZipCode")
    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
    
        
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CityCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
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

    
    @Column(name = "Fax")
    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }
    
    @Column(name = "EmailAddress")
     public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
//    @Column(name = "ZipCode")
//    public String getZipCode() {
//        return zipCode;
//    }
//
//    public void setZipCode(String zipCode) {
//        this.zipCode = zipCode;
//    }
    
    
    @Column(name = "ContactPerson")
    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    @Column(name = "ShipToStatus")
    public boolean isShipToStatus() {
        return shipToStatus;
    }

    public void setShipToStatus(boolean shipToStatus) {
        this.shipToStatus = shipToStatus;
    }

    @Column(name = "BillToStatus")
    public boolean isBillToStatus() {
        return billToStatus;
    }

    public void setBillToStatus(boolean billToStatus) {
        this.billToStatus = billToStatus;
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


    
    

}
