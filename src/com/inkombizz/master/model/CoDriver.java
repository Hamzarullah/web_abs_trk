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
@Table(name = "mst_co_driver")
public class CoDriver implements Serializable {
    
    @Id
    @Column(name = "code", length = 50)
    private String code = "";
    
    @Column(name = "name", length = 50)
    private String name = "";
    
    @Column(name = "address", length = 50)
    private String address = "";
    
    @Column(name = "phone1", length = 50)
    private String phone1 = "";
    
    @Column(name = "phone2", length = 50)
    private String phone2 = "";
    
    @Column(name = "zipCode", length = 50)
    private String zipCode = "";
    
    @Column(name = "fax", length = 50)
    private String fax = "";
    
    @Column(name = "emailAddress", length = 50)
    private String email = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CityCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private City city = null;
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "EmployeeCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    private Employee employee = null;
    
    @Column(name = "internalExternalStatus", length = 50)
    private String internalExternalStatus="INTERNAL";
    
    @Column(name = "activeStatus", length = 50)
    private boolean activeStatus = true;
    
    @Column(name = "inActiveBy", length = 50)
    private String inActiveBy = "";
    
    @Column(name = "inActiveDate", length = 50)
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date inActiveDate = DateUtils.newDate(1990, 01, 01);
    
    @Column(name = "remark", length = 50)
    private String remark = "";
    
    @Column(name = "createdBy", length = 50)
    private String createdBy = "";
    
    @Column(name = "createdDate", length = 50)
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "updatedBy", length = 50)
    private String updatedBy = "";
    
    @Column(name = "updatedDate", length = 50)
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

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

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public String getInternalExternalStatus() {
        return internalExternalStatus;
    }

    public void setInternalExternalStatus(String internalExternalStatus) {
        this.internalExternalStatus = internalExternalStatus;
    }

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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
  
    
}