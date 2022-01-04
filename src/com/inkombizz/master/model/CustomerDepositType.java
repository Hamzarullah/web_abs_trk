/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author CHRIST
 */
@Entity
@Table(name = "mst_customer_deposit_type")
public class CustomerDepositType extends BaseEntity implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @Column(name = "Name")
    private String name = "";
    
    @Column(name = "ActiveStatus")
    private boolean activeStatus=false;
    
    @Column(name = "Remark")
    private String remark = "";
    
    @Column(name = "InActiveBy")
    private String inActiveBy = "";
    
    @Column(name = "InActiveDate")
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    
    @Transient
    private String chartOfAccountCode = "";
    
    @Transient
    private String chartOfAccountName = "";
    
    @Transient
    private String branchCode = "";
    

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

    public String getChartOfAccountCode() {
        return chartOfAccountCode;
    }

    public void setChartOfAccountCode(String chartOfAccountCode) {
        this.chartOfAccountCode = chartOfAccountCode;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getChartOfAccountName() {
        return chartOfAccountName;
    }

    public void setChartOfAccountName(String chartOfAccountName) {
        this.chartOfAccountName = chartOfAccountName;
    }
    
    
    
}
