
package com.inkombizz.master.model;

import java.util.Date;


public class ChartOfAccountTemp {
    
    private String code = "";
    private String name = "";
    private String accountType = "";
    private Boolean activeStatus=false;
    private Boolean bbmStatus=false;
    private Boolean bbkStatus=false;
    private Boolean bkmStatus=false;
    private Boolean bkkStatus=false;
    private Boolean budgetStatus=false;
    private String createdBy = "";
    private Date createdDate;

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

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public Boolean getActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(Boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    public Boolean getBbmStatus() {
        return bbmStatus;
    }

    public void setBbmStatus(Boolean bbmStatus) {
        this.bbmStatus = bbmStatus;
    }

    public Boolean getBbkStatus() {
        return bbkStatus;
    }

    public void setBbkStatus(Boolean bbkStatus) {
        this.bbkStatus = bbkStatus;
    }

    public Boolean getBkmStatus() {
        return bkmStatus;
    }

    public void setBkmStatus(Boolean bkmStatus) {
        this.bkmStatus = bkmStatus;
    }

    public Boolean getBkkStatus() {
        return bkkStatus;
    }

    public void setBkkStatus(Boolean bkkStatus) {
        this.bkkStatus = bkkStatus;
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

    public Boolean getBudgetStatus() {
        return budgetStatus;
    }

    public void setBudgetStatus(Boolean budgetStatus) {
        this.budgetStatus = budgetStatus;
    }
    
    
    
    
}
