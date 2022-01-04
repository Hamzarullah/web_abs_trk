/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author De4RagiL
 */
public class CustomerAddressTemp {
    
    private String code = "";
    private String customerCode = "";
    private String customerName = "";
    private String name = "";
    private String address = "";
    private String cityCode="";
    private String cityName="";
    private String countryCode="";
    private String countryName="";
    private String zipCode= "";
    private String phone1 = "";
    private String phone2 = "";
    private String fax = "";
    private String emailAddress= "";
    private String contactPerson= "";
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private boolean activeStatus=false;
    private boolean shipToStatus=false;
    private boolean billToStatus=false;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    private String customerSubTypeCode="";
    private String customerSubTypeName="";
    private String customerTypeCode="";
    private String customerTypeName="";
    private String customerAddress="";
    private String customerPhone1="";
    private String customerPhone2="";
    private String customerFax="";
    private String customerEmailAddress="";
    private String customerContactPerson="";
    private String customerCityCode="";
    private String customerCityName="";
    private String customerCountryCode="";
    private String customerCountryName="";
    private boolean npwpStatus = false;
    private String npwpStatusNew ="";
    private String npwp="";
    private String npwpName="";
    private String npwpAddress="";
    private String npwpCityCode="";
    private String npwpCityName="";
    private String npwpProvinceCode="";
    private String npwpProvinceName="";
    private String npwpIslandCode="";
    private String npwpIslandName="";
    private String npwpCountryCode="";
    private String npwpCountryName="";
    private String npwpZipCode="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
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

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    public boolean isShipToStatus() {
        return shipToStatus;
    }

    public void setShipToStatus(boolean shipToStatus) {
        this.shipToStatus = shipToStatus;
    }

    public boolean isBillToStatus() {
        return billToStatus;
    }

    public void setBillToStatus(boolean billToStatus) {
        this.billToStatus = billToStatus;
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

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getCustomerSubTypeCode() {
        return customerSubTypeCode;
    }

    public void setCustomerSubTypeCode(String customerSubTypeCode) {
        this.customerSubTypeCode = customerSubTypeCode;
    }

    public String getCustomerSubTypeName() {
        return customerSubTypeName;
    }

    public void setCustomerSubTypeName(String customerSubTypeName) {
        this.customerSubTypeName = customerSubTypeName;
    }

    public String getCustomerTypeCode() {
        return customerTypeCode;
    }

    public void setCustomerTypeCode(String customerTypeCode) {
        this.customerTypeCode = customerTypeCode;
    }

    public String getCustomerTypeName() {
        return customerTypeName;
    }

    public void setCustomerTypeName(String customerTypeName) {
        this.customerTypeName = customerTypeName;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getCustomerPhone1() {
        return customerPhone1;
    }

    public void setCustomerPhone1(String customerPhone1) {
        this.customerPhone1 = customerPhone1;
    }

    public String getCustomerPhone2() {
        return customerPhone2;
    }

    public void setCustomerPhone2(String customerPhone2) {
        this.customerPhone2 = customerPhone2;
    }

    public String getCustomerFax() {
        return customerFax;
    }

    public void setCustomerFax(String customerFax) {
        this.customerFax = customerFax;
    }

    public String getCustomerEmailAddress() {
        return customerEmailAddress;
    }

    public void setCustomerEmailAddress(String customerEmailAddress) {
        this.customerEmailAddress = customerEmailAddress;
    }

    public String getCustomerContactPerson() {
        return customerContactPerson;
    }

    public void setCustomerContactPerson(String customerContactPerson) {
        this.customerContactPerson = customerContactPerson;
    }

    public String getCustomerCityCode() {
        return customerCityCode;
    }

    public void setCustomerCityCode(String customerCityCode) {
        this.customerCityCode = customerCityCode;
    }

    public String getCustomerCityName() {
        return customerCityName;
    }

    public void setCustomerCityName(String customerCityName) {
        this.customerCityName = customerCityName;
    }

    public String getCustomerCountryCode() {
        return customerCountryCode;
    }

    public void setCustomerCountryCode(String customerCountryCode) {
        this.customerCountryCode = customerCountryCode;
    }

    public String getCustomerCountryName() {
        return customerCountryName;
    }

    public void setCustomerCountryName(String customerCountryName) {
        this.customerCountryName = customerCountryName;
    }

    public boolean isNpwpStatus() {
        return npwpStatus;
    }

    public void setNpwpStatus(boolean npwpStatus) {
        this.npwpStatus = npwpStatus;
    }

    public String getNpwp() {
        return npwp;
    }

    public void setNpwp(String npwp) {
        this.npwp = npwp;
    }

    public String getNpwpName() {
        return npwpName;
    }

    public void setNpwpName(String npwpName) {
        this.npwpName = npwpName;
    }

    public String getNpwpAddress() {
        return npwpAddress;
    }

    public void setNpwpAddress(String npwpAddress) {
        this.npwpAddress = npwpAddress;
    }

    public String getNpwpCityCode() {
        return npwpCityCode;
    }

    public void setNpwpCityCode(String npwpCityCode) {
        this.npwpCityCode = npwpCityCode;
    }

    public String getNpwpCityName() {
        return npwpCityName;
    }

    public void setNpwpCityName(String npwpCityName) {
        this.npwpCityName = npwpCityName;
    }

    public String getNpwpProvinceCode() {
        return npwpProvinceCode;
    }

    public void setNpwpProvinceCode(String npwpProvinceCode) {
        this.npwpProvinceCode = npwpProvinceCode;
    }

    public String getNpwpProvinceName() {
        return npwpProvinceName;
    }

    public void setNpwpProvinceName(String npwpProvinceName) {
        this.npwpProvinceName = npwpProvinceName;
    }

    public String getNpwpIslandCode() {
        return npwpIslandCode;
    }

    public void setNpwpIslandCode(String npwpIslandCode) {
        this.npwpIslandCode = npwpIslandCode;
    }

    public String getNpwpIslandName() {
        return npwpIslandName;
    }

    public void setNpwpIslandName(String npwpIslandName) {
        this.npwpIslandName = npwpIslandName;
    }

    public String getNpwpCountryCode() {
        return npwpCountryCode;
    }

    public void setNpwpCountryCode(String npwpCountryCode) {
        this.npwpCountryCode = npwpCountryCode;
    }

    public String getNpwpCountryName() {
        return npwpCountryName;
    }

    public void setNpwpCountryName(String npwpCountryName) {
        this.npwpCountryName = npwpCountryName;
    }

    public String getNpwpZipCode() {
        return npwpZipCode;
    }

    public void setNpwpZipCode(String npwpZipCode) {
        this.npwpZipCode = npwpZipCode;
    }

    public String getNpwpStatusNew() {
        return npwpStatusNew;
    }

    public void setNpwpStatusNew(String npwpStatusNew) {
        this.npwpStatusNew = npwpStatusNew;
    }

    
}
