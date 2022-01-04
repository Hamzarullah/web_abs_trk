package com.inkombizz.master.model;

//import com.inkombizz.utils.DateUtils;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;
//import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
//import javax.persistence.Temporal;

@Entity
@Table(name="mst_distribution_channel")
public class DistributionChannel implements Serializable {
    
    private String code = "";
    private String name = "";
//    private Country country; 
    private boolean activeStatus = true;
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1990, 01, 01);
    private String remark = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    @Id
    @Column(name = "code", length = 50)
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "name", length = 100)
    public String getName() {
        return name;
    }
    public void setName(String Name) {
        this.name = Name;
    }

//    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
//    @JoinColumn (name = "CountryCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
//    public Country getCountry() {
//        return country;
//    }
//
//    public void setCountry(Country country) {
//        this.country = country;
//    }

    @Column(name = "activestatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }
    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    @Column(name = "InActiveBy")
    public String getInActiveBy() {
        return inActiveBy;
    }

    public void setInActiveBy(String inActiveBy) {
        this.inActiveBy = inActiveBy;
    }

    @Column(name = "InActiveDate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
    }

    @Column(name = "Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    @Column(name = "createdby", length = 50)
    public String getCreatedBy() {
        return createdBy;
    }
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column(name = "createddate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getCreatedDate() {
        return createdDate;
    }
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Column(name = "updatedby", length = 50)
    public String getUpdatedBy() {
        return updatedBy;
    }
    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column(name = "updateddate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getUpdatedDate() {
        return updatedDate;
    }
    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
    
}