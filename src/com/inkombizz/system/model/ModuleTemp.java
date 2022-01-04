

package com.inkombizz.system.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;


public class ModuleTemp {
    
    private String code = "";
    private String name = "";
    private boolean activeStatus = false;
    private String branchCode = "";
    private String branchName = "";
    private String companyCode = "";
    private String companyName = "";
    private boolean moduleInputStatus = false;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);

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

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(String companyCode) {
        this.companyCode = companyCode;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public boolean isModuleInputStatus() {
        return moduleInputStatus;
    }

    public void setModuleInputStatus(boolean moduleInputStatus) {
        this.moduleInputStatus = moduleInputStatus;
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
    
    
}
