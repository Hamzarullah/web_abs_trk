package com.inkombizz.master.model;

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
@Table(name = "mst_sales_person_jn_distribution_channel")
public class SalesPersonDistributionChannel implements Serializable {
    
    private static final long serialVersionUID = 1L;
       
    private String code = "";
    private String SalesPersonCode = "";
    private DistributionChannel distributionChannel = null;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    @Id
    @Column(name = "Code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

   @Column(name = "SalesPersonCode")
    public String getSalesPersonCode() {
        return SalesPersonCode;
    }

    public void setSalesPersonCode(String SalesPersonCode) {
        this.SalesPersonCode = SalesPersonCode;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "DistributionChannelCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public DistributionChannel getDistributionChannel() {
        return distributionChannel;
    }

    public void setDistributionChannel(DistributionChannel distributionChannel) {
        this.distributionChannel = distributionChannel;
    }

   @Column(name = "CreatedBy")
   public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

   @Column(name = "CreatedDate")
   @Temporal(javax.persistence.TemporalType.TIMESTAMP)
   public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

   @Column(name = "UpdatedBy")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column(name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

}