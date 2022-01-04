package com.inkombizz.system.model;

import com.inkombizz.master.model.Branch;
//import com.inkombizz.master.model.Company;
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
@Table(name = "sys_module")
public class Module implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String code = "";
    private String name = "";
    private boolean activeStatus = false;
    private Branch branch = null;
//    private Company company = null;
    private boolean moduleInputStatus = false;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    @Id
    @Column(name = "code", length = 50, unique = true)
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
    public void setName(String name) {
        this.name = name;
    }
    
    @Column(name = "activestatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }
    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.LAZY)
    @JoinColumn (name = "BranchCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

//    @ManyToOne (cascade = {}, fetch = FetchType.LAZY)
//    @JoinColumn (name = "CompanyCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
//    public Company getCompany() {
//        return company;
//    }
//
//    public void setCompany(Company company) {
//        this.company = company;
//    }

    @Column(name = "ModuleInputStatus")
    public boolean isModuleInputStatus() {
        return moduleInputStatus;
    }

    public void setModuleInputStatus(boolean moduleInputStatus) {
        this.moduleInputStatus = moduleInputStatus;
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