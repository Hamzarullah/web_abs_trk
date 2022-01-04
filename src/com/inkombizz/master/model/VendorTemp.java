
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;


public class VendorTemp {
    
    private String code="";
    private String name="";
    private String address="";
    private String cityCode="";
    private String cityName="";
    private String provinceCode="";
    private String provinceName="";
    private String islandCode="";
    private String islandName="";
    private String countryCode="";
    private String countryName="";
    private String zipCode="";
    private String phone1="";
    private String phone2="";
    private String emailAddress="";
    private String fax="";
    private String vendorCategoryCode="";
    private String vendorCategoryName="";
    private String businessEntityCode="";
    private String businessEntityName="";
    private String defaultContactPersonCode="";
    private String defaultContactPersonName="";
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
    private String localImport = "";
    private String paymentTermCode="";
    private String paymentTermName="";
    private String paymentTermDays="";
    private Boolean activeStatus=false;
    private Boolean criticalStatus=false;
    private Boolean penaltyStatus=false;
    private String scope = "";
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private String inActiveDateTemp="";
    private String createdBy="";
    private Date createdDate=DateUtils.newDate(1900, 1, 1);;
    private String createdDateTemp="";

    
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

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public String getIslandCode() {
        return islandCode;
    }

    public void setIslandCode(String islandCode) {
        this.islandCode = islandCode;
    }

    public String getIslandName() {
        return islandName;
    }

    public void setIslandName(String islandName) {
        this.islandName = islandName;
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

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getBusinessEntityCode() {
        return businessEntityCode;
    }

    public void setBusinessEntityCode(String businessEntityCode) {
        this.businessEntityCode = businessEntityCode;
    }

    public String getBusinessEntityName() {
        return businessEntityName;
    }

    public void setBusinessEntityName(String businessEntityName) {
        this.businessEntityName = businessEntityName;
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

    public Boolean getActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(Boolean activeStatus) {
        this.activeStatus = activeStatus;
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

    public String getInActiveDateTemp() {
        return inActiveDateTemp;
    }

    public void setInActiveDateTemp(String inActiveDateTemp) {
        this.inActiveDateTemp = inActiveDateTemp;
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

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
    }

    public String getPaymentTermCode() {
        return paymentTermCode;
    }

    public void setPaymentTermCode(String paymentTermCode) {
        this.paymentTermCode = paymentTermCode;
    }

    public String getPaymentTermName() {
        return paymentTermName;
    }

    public void setPaymentTermName(String paymentTermName) {
        this.paymentTermName = paymentTermName;
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

    public String getLocalImport() {
        return localImport;
    }

    public void setLocalImport(String localImport) {
        this.localImport = localImport;
    }

    public String getDefaultContactPersonCode() {
        return defaultContactPersonCode;
    }

    public void setDefaultContactPersonCode(String defaultContactPersonCode) {
        this.defaultContactPersonCode = defaultContactPersonCode;
    }

    public String getDefaultContactPersonName() {
        return defaultContactPersonName;
    }

    public void setDefaultContactPersonName(String defaultContactPersonName) {
        this.defaultContactPersonName = defaultContactPersonName;
    }

    public String getPaymentTermDays() {
        return paymentTermDays;
    }

    public void setPaymentTermDays(String paymentTermDays) {
        this.paymentTermDays = paymentTermDays;
    }

    public Boolean getCriticalStatus() {
        return criticalStatus;
    }

    public void setCriticalStatus(Boolean criticalStatus) {
        this.criticalStatus = criticalStatus;
    }

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }

    public Boolean getPenaltyStatus() {
        return penaltyStatus;
    }

    public void setPenaltyStatus(Boolean penaltyStatus) {
        this.penaltyStatus = penaltyStatus;
    }

    

    
    
}

