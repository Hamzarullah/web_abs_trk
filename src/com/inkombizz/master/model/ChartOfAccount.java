package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;


@Entity 
@Table(name = "mst_chart_of_account")
public class ChartOfAccount implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String code = "";
    private String name = "";
    private String accountType = "";
    private Currency currency = null;
    private boolean activeStatus=true;
    private boolean bbmStatus=false;
//    private boolean bbkStatus=false;
    private boolean bkmStatus=false;
//    private boolean bkkStatus=false;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900,1,1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900,1,1);
    
    
    
    @Id
    @Column(name = "Code")
    public String getCode() {
        return this.code;
    }
    public void setCode(String code) {
        this.code = code;
    }

    
    @Column(name = "Name")
    public String getName() {
        return this.name;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "AccountType")
    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }
    
    @Column(name = "ActiveStatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }
    
    @Column(name = "BBMStatus")
    public boolean isBbmStatus() {
        return bbmStatus;
    }

    public void setBbmStatus(boolean bbmStatus) {
        this.bbmStatus = bbmStatus;
    }

//    @Column(name = "BBKStatus")
//    public boolean isBbkStatus() {
//        return bbkStatus;
//    }
//
//    public void setBbkStatus(boolean bbkStatus) {
//        this.bbkStatus = bbkStatus;
//    }

    @Column(name = "BKMStatus")
    public boolean isBkmStatus() {
        return bkmStatus;
    }

    public void setBkmStatus(boolean bkmStatus) {
        this.bkmStatus = bkmStatus;
    }

//    @Column(name = "BKKStatus")
//    public boolean isBkkStatus() {
//        return bkkStatus;
//    }
//
//    public void setBkkStatus(boolean bkkStatus) {
//        this.bkkStatus = bkkStatus;
//    }
    
    @Column (name = "CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    
    @Column (name = "CreatedDate")
    @Temporal (javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    
    @Column (name = "UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }
    

    @Column (name = "UpdatedDate")
    @Temporal (javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    
    
}