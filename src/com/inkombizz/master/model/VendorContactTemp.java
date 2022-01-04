/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;


public class VendorContactTemp {
    
    private String code = "";
    private String name = "";
    private String address = "";
    private String cityCode = "";
    private String cityName = "";
    private String countryCode = "";
    private String countryName = "";
    private String contactPerson = "";
    private String defaultContactPersonCode="";
    private String zipCode = "";
    private String phone1 = "";
    private String phone2 = "";  
    private String fax = "";
    private String email = "";
    private String supplayStatus = "";
    private String vendorCategoryCode = "";
    private String vendorCategoryName = "";
    private String vendorCode = "";
    private String vendorName = "";
    private String mobileNo = ""; 
    private String phone = "";
    private Date birthDate = DateUtils.newDate(1900, 1, 1);
    private String birthDateTemp = "";
    private String jobPositionCode="";
    private String jobPositionName="";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1990, 01, 01);
    private boolean activeStatus = Boolean.TRUE;
   
    
    /* SET GET METHOD */

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getPhone1() {
        return phone1;
    }

    public void setPhone1(String phone1) {
        this.phone1 = phone1;
    }

    public String getPhone2() {
        return phone2;
    }

    public void setPhone2(String phone2) {
        this.phone2 = phone2;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSupplayStatus() {
        return supplayStatus;
    }

    public void setSupplayStatus(String supplayStatus) {
        this.supplayStatus = supplayStatus;
    }

    public String getVendorCategoryCode() {
        return vendorCategoryCode;
    }

    public void setVendorCategoryCode(String vendorCategoryCode) {
        this.vendorCategoryCode = vendorCategoryCode;
    }

    public String getVendorCategoryName() {
        return vendorCategoryName;
    }

    public void setVendorCategoryName(String vendorCategoryName) {
        this.vendorCategoryName = vendorCategoryName;
    }

    public String getMobileNo() {
        return mobileNo;
    }

    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getJobPositionCode() {
        return jobPositionCode;
    }

    public void setJobPositionCode(String jobPositionCode) {
        this.jobPositionCode = jobPositionCode;
    }

    public String getJobPositionName() {
        return jobPositionName;
    }

    public void setJobPositionName(String jobPositionName) {
        this.jobPositionName = jobPositionName;
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

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }


    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    public String getVendorName() {
        return vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
    }

    public String getBirthDateTemp() {
        return birthDateTemp;
    }

    public void setBirthDateTemp(String birthDateTemp) {
        this.birthDateTemp = birthDateTemp;
    }

    public String getDefaultContactPersonCode() {
        return defaultContactPersonCode;
    }

    public void setDefaultContactPersonCode(String defaultContactPersonCode) {
        this.defaultContactPersonCode = defaultContactPersonCode;
    }

   
    
    
}
