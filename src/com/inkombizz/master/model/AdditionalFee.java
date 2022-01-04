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
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;


@Entity
@Table(name="mst_additional_fee")
public class AdditionalFee extends BaseEntity implements Serializable{
	
    private String code = "";
    private String name = "";
    private ChartOfAccount purchaseChartOfAccount = null;
    private ChartOfAccount salesChartOfAccount = null;
    private boolean purchaseStatus =false;
    private boolean salesStatus =false;
    private boolean activeStatus =false;
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);

    @Id
    @Column(name="Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "PurchaseChartOfAccountCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ChartOfAccount getPurchaseChartOfAccount() {
        return purchaseChartOfAccount;
    }

    public void setPurchaseChartOfAccount(ChartOfAccount purchaseChartOfAccount) {
        this.purchaseChartOfAccount = purchaseChartOfAccount;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "SalesChartOfAccountCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    public ChartOfAccount getSalesChartOfAccount() {
        return salesChartOfAccount;
    }

    public void setSalesChartOfAccount(ChartOfAccount salesChartOfAccount) {
        this.salesChartOfAccount = salesChartOfAccount;
    }

    @Column(name = "PurchaseStatus")
    public boolean isPurchaseStatus() {
        return purchaseStatus;
    }

    public void setPurchaseStatus(boolean purchaseStatus) {
        this.purchaseStatus = purchaseStatus;
    }

    @Column(name = "SalesStatus")
    public boolean isSalesStatus() {
        return salesStatus;
    }

    public void setSalesStatus(boolean salesStatus) {
        this.salesStatus = salesStatus;
    }

    @Column(name = "ActiveStatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    @Column(name = "Remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Column(name = "InActiveBy")
    public String getInActiveBy() {
        return inActiveBy;
    }

    public void setInActiveBy(String inActiveBy) {
        this.inActiveBy = inActiveBy;
    }

    @Column(name = "InActiveDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
    }
    
}
