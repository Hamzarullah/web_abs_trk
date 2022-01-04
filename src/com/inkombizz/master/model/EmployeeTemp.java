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
 * @author budi
 */
public class EmployeeTemp {
    
    private String code = "";
    private String nik = "";
    private String name = "";
    private String address = "";
    private String zipCode = "";
    private String cityCode = "";
    private String cityName = "";
    private String provinceCode = "";
    private String provinceName = "";
    private String islandCode = "";
    private String islandName = "";
    private String countryCode = "";
    private String countryName = "";
    private String domicileAddress1 = "";
    private String domicileAddress2 = "";
    private String phone = "";
    private String mobileNo1 = "";
    private String mobileNo2 = "";
    private String emailAddress = "";
    private String gender = "Male";
    private String maritalStatus = "Married";
    private String religionCode = "";
    private String religionName = "";
    private String educationCode = "";
    private String educationName = "";
    private String ktpNo = "";
    private String npwp = "";
    private String npwpName = "";
    private String npwpAddress = "";
    private String npwpCityCode = "";
    private String npwpCityName = "";
    private String npwpProvinceCode = "";
    private String npwpProvinceName = "";
    private String npwpIslandCode = "";
    private String npwpIslandName = "";
    private String npwpCountryCode = "";
    private String npwpCountryName = "";
    private String npwpZipCode = "";
    private String acNo = "";
    private String acName = "";
    private String bankCode = "";
    private String bankName = "";
    private String bankBranch = "";
    private Date joinDate = DateUtils.newDate(1900, 1, 1);
    private Date resignDate = DateUtils.newDate(1900, 1, 1);
    private Date birthDate = DateUtils.newDate(1900, 1, 1);
    private String birthPlace = "";
    private boolean activeStatus =false;
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private String inActiveDateTemp="";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    private String createdDateTemp ="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNik() {
        return nik;
    }

    public void setNik(String nik) {
        this.nik = nik;
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

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
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

    public String getDomicileAddress1() {
        return domicileAddress1;
    }

    public void setDomicileAddress1(String domicileAddress1) {
        this.domicileAddress1 = domicileAddress1;
    }

    public String getDomicileAddress2() {
        return domicileAddress2;
    }

    public void setDomicileAddress2(String domicileAddress2) {
        this.domicileAddress2 = domicileAddress2;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMobileNo1() {
        return mobileNo1;
    }

    public void setMobileNo1(String mobileNo1) {
        this.mobileNo1 = mobileNo1;
    }

    public String getMobileNo2() {
        return mobileNo2;
    }

    public void setMobileNo2(String mobileNo2) {
        this.mobileNo2 = mobileNo2;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public String getReligionCode() {
        return religionCode;
    }

    public void setReligionCode(String religionCode) {
        this.religionCode = religionCode;
    }

    public String getReligionName() {
        return religionName;
    }

    public void setReligionName(String religionName) {
        this.religionName = religionName;
    }

    public String getEducationCode() {
        return educationCode;
    }

    public void setEducationCode(String educationCode) {
        this.educationCode = educationCode;
    }

    public String getEducationName() {
        return educationName;
    }

    public void setEducationName(String educationName) {
        this.educationName = educationName;
    }

    public String getKtpNo() {
        return ktpNo;
    }

    public void setKtpNo(String ktpNo) {
        this.ktpNo = ktpNo;
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

    public String getNpwpZipCode() {
        return npwpZipCode;
    }

    public void setNpwpZipCode(String npwpZipCode) {
        this.npwpZipCode = npwpZipCode;
    }

    public String getAcNo() {
        return acNo;
    }

    public void setAcNo(String acNo) {
        this.acNo = acNo;
    }

    public String getAcName() {
        return acName;
    }

    public void setAcName(String acName) {
        this.acName = acName;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankBranch() {
        return bankBranch;
    }

    public void setBankBranch(String bankBranch) {
        this.bankBranch = bankBranch;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public Date getResignDate() {
        return resignDate;
    }

    public void setResignDate(Date resignDate) {
        this.resignDate = resignDate;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getBirthPlace() {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
    }

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
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

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
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

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
   
    
}
