package com.inkombizz.security.model;

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
@Table(name = "scr_role_authorization")
public class RoleAuthorization implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String code = "";
    private String headerCode = "";
    private Authorization authorization = null;
    private boolean assignAuthority = false;
    private boolean deleteAuthority = false;
    private boolean updateAuthority = false;
    private boolean saveAuthority = false;
    private boolean printAuthority = false;
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
    
    @Column(name="headercode", length = 50)
    public String getHeaderCode(){
        return headerCode;
    }    
    
    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }
        
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "authorizationcode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Authorization getAuthorization() {
        return authorization;
    }
    public void setAuthorization(Authorization authorization) {
        this.authorization = authorization;
    }

    @Column(name = "assignauthority")
    public boolean isAssignAuthority() {
        return assignAuthority;
    }

    public void setAssignAuthority(boolean assignAuthority) {
        this.assignAuthority = assignAuthority;
    }

    @Column(name = "deleteauthority")
    public boolean isDeleteAuthority() {
        return deleteAuthority;
    }

    public void setDeleteAuthority(boolean deleteAuthority) {
        this.deleteAuthority = deleteAuthority;
    }

    @Column(name = "updateauthority")
    public boolean isUpdateAuthority() {
        return updateAuthority;
    }

    public void setUpdateAuthority(boolean updateAuthority) {
        this.updateAuthority = updateAuthority;
    }

    @Column(name = "saveauthority")
    public boolean isSaveAuthority() {
        return saveAuthority;
    }

    public void setSaveAuthority(boolean saveAuthority) {
        this.saveAuthority = saveAuthority;
    }

    @Column(name = "printauthority")
    public boolean isPrintAuthority() {
        return printAuthority;
    }

    public void setPrintAuthority(boolean printAuthority) {
        this.printAuthority = printAuthority;
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