/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;

/**
 *
 * @author IKB_CHRISR
 */
public class VendorJnContactTemp {
    
    private String vendorContactCode = "";
    private String vendorContactName = "";
    private String vendorContactPhone = "";
    private Date vendorContactBirthDate = DateUtils.newDate(1900, 1, 1);
    private String vendorContactJobPositionCode = "";
    private String vendorContactJobPositionName = "";

    public String getVendorContactName() {
        return vendorContactName;
    }

    public void setVendorContactName(String vendorContactName) {
        this.vendorContactName = vendorContactName;
    }

    public String getVendorContactPhone() {
        return vendorContactPhone;
    }

    public void setVendorContactPhone(String vendorContactPhone) {
        this.vendorContactPhone = vendorContactPhone;
    }

    public Date getVendorContactBirthDate() {
        return vendorContactBirthDate;
    }

    public void setVendorContactBirthDate(Date vendorContactBirthDate) {
        this.vendorContactBirthDate = vendorContactBirthDate;
    }

    public String getVendorContactJobPositionCode() {
        return vendorContactJobPositionCode;
    }

    public void setVendorContactJobPositionCode(String vendorContactJobPositionCode) {
        this.vendorContactJobPositionCode = vendorContactJobPositionCode;
    }

    public String getVendorContactJobPositionName() {
        return vendorContactJobPositionName;
    }

    public void setVendorContactJobPositionName(String vendorContactJobPositionName) {
        this.vendorContactJobPositionName = vendorContactJobPositionName;
    }

    public String getVendorContactCode() {
        return vendorContactCode;
    }

    public void setVendorContactCode(String vendorContactCode) {
        this.vendorContactCode = vendorContactCode;
    }
    
    
}
