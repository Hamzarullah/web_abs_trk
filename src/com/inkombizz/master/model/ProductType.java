package com.inkombizz.master.model;

import com.inkombizz.common.BaseEntity;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;


@Entity
@Table(name="mst_product_type")
public class ProductType extends BaseEntity implements Serializable {

    @Id
    @Column(name="Code")
    private String code = "";
    
    @Column(name = "Name")
    private String name = "";
    
    @Column(name = "Remark")
    private String remark = "";
    
    @Column(name = "ActiveStatus")
    private boolean activeStatus =false;
    
    @Column(name = "InActiveBy")
    private String inActiveBy = "";
    
    @Column(name = "InActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);

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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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
    
    
}
