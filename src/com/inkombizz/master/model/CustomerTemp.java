
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;


public class CustomerTemp implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String code = "";
    private String name= "";
    private String address= "";
    private String companyCode= "";
    private String companyName= "";
    private String cityCode= "";
    private String cityName= "";
    private String customerCategoryCode= "";
    private String customerCategoryName= "";
    private String billToCode= "";
    private String billToName= "";
    private String billToAddress= "";
    private String billToContactPerson= "";
    private String shipToCode= "";
    private String shipToName= "";
    private String shipToAddress= "";
    private String shipToContactPerson= "";
    private String provinceCode= "";
    private String provinceName= "";
    private String islandCode= "";
    private String islandName= "";
    private String countryCode= "";
    private String countryName= "";
    private String paymentTermCode= "";
    private String paymentTermName= "";
    private String businessEntityCode= "";
    private String businessEntityName= "";
    private String defaultContactPersonCode= "";
    private String defaultContactPersonName= "";
    private String zipCode= "";
    private String phone1= "";
    private String phone2= "";
    private String fax= "";
    private String taxCode = "";
    private String contactPerson= "";
    private String remark= "";
    private String emailAddress= "";
    private boolean activeStatus=Boolean.TRUE;
    private boolean customerStatus=Boolean.TRUE;
    private boolean endUserStatus=Boolean.TRUE;
    private String customerStatusCust="";
    private String endUserStatusCust="";
    private String inActiveBy= "";
    private Date inActiveDate= DateUtils.newDate(1990, 01, 01);
    private String inActiveDateTemp= "";
    private String createdBy= "";
    private Date createdDate= DateUtils.newDate(1990, 01, 01);
    private String createdDateTemp= "";

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

    public String getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(String companyCode) {
        this.companyCode = companyCode;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    public String getBillToCode() {
        return billToCode;
    }

    public void setBillToCode(String billToCode) {
        this.billToCode = billToCode;
    }

    public String getBillToName() {
        return billToName;
    }

    public void setBillToName(String billToName) {
        this.billToName = billToName;
    }

    public String getBillToAddress() {
        return billToAddress;
    }

    public void setBillToAddress(String billToAddress) {
        this.billToAddress = billToAddress;
    }

    public String getBillToContactPerson() {
        return billToContactPerson;
    }

    public void setBillToContactPerson(String billToContactPerson) {
        this.billToContactPerson = billToContactPerson;
    }

    public String getShipToCode() {
        return shipToCode;
    }

    public void setShipToCode(String shipToCode) {
        this.shipToCode = shipToCode;
    }

    public String getShipToName() {
        return shipToName;
    }

    public void setShipToName(String shipToName) {
        this.shipToName = shipToName;
    }

    public String getShipToAddress() {
        return shipToAddress;
    }

    public void setShipToAddress(String shipToAddress) {
        this.shipToAddress = shipToAddress;
    }

    public String getShipToContactPerson() {
        return shipToContactPerson;
    }

    public void setShipToContactPerson(String shipToContactPerson) {
        this.shipToContactPerson = shipToContactPerson;
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

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
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

    public String getTaxCode() {
        return taxCode;
    }

    public void setTaxCode(String taxCode) {
        this.taxCode = taxCode;
    }

    public boolean isCustomerStatus() {
        return customerStatus;
    }

    public void setCustomerStatus(boolean customerStatus) {
        this.customerStatus = customerStatus;
    }

    public boolean isEndUserStatus() {
        return endUserStatus;
    }

    public void setEndUserStatus(boolean endUserStatus) {
        this.endUserStatus = endUserStatus;
    }

    public String getCustomerStatusCust() {
        return customerStatusCust;
    }

    public void setCustomerStatusCust(String customerStatusCust) {
        this.customerStatusCust = customerStatusCust;
    }

    public String getEndUserStatusCust() {
        return endUserStatusCust;
    }

    public void setEndUserStatusCust(String endUserStatusCust) {
        this.endUserStatusCust = endUserStatusCust;
    }

    public String getCustomerCategoryCode() {
        return customerCategoryCode;
    }

    public void setCustomerCategoryCode(String customerCategoryCode) {
        this.customerCategoryCode = customerCategoryCode;
    }

    public String getCustomerCategoryName() {
        return customerCategoryName;
    }

    public void setCustomerCategoryName(String customerCategoryName) {
        this.customerCategoryName = customerCategoryName;
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
    
    
}
