
package com.inkombizz.master.model;

import com.inkombizz.common.BaseEntity;
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
@Table(name="mst_division")
public class Division extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "code")
    private String code = "";
    
    @Column(name = "name")
    private String name = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DepartmentCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    private Department department = null;
    
    @Column(name = "activestatus")
    private boolean activeStatus = true;
    
    @Column(name = "InActiveBy")
    private String inActiveBy = "";
    
    @Column(name = "InActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date inActiveDate = DateUtils.newDate(1900, 01, 01);
    
    @Column(name = "Remark")
    private String remark = "";

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

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
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
        
    
    
    
}