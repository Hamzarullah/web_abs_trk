/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.security.model;

//import com.inkombizz.master.model.VendorCategory;
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

/**
 *
 * @author IKB_CHRISR
 */
@Entity
@Table(name = "scr_user_vendor_category")
public class UserVendorCategory implements Serializable{
    
    private String code;
    private User user;
//    private VendorCategory vendorCategory = null;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    @Id
    @Column(name = "code", length = 50)
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "UserCode", referencedColumnName = "code")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

//    @ManyToOne(fetch = FetchType.EAGER)
//    @JoinColumn(name = "VendorCategoryCode", referencedColumnName = "code")
//    public VendorCategory getVendorCategory() {
//        return vendorCategory;
//    }
//
//    public void setVendorCategory(VendorCategory vendorCategory) {
//        this.vendorCategory = vendorCategory;
//    }

    @Column (name = "createdby", length = 50)
    public String getCreatedBy() {
        return createdBy;
    }

    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column (name = "createddate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Column (name = "updatedby", length = 50)
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column (name = "updateddate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
    
}
