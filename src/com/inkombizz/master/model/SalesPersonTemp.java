
package com.inkombizz.master.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;


public class SalesPersonTemp {

    private String code = "";
    private String name = "";
    private String employeeCode = "";
    private String employeeName = "";
    private String employeeAddress = "";
    private String employeeZipCode = "";
    private String employeeCityCode = "";
    private String employeeCityName = "";
    private String employeeProvinceCode = "";
    private String employeeProvinceName = "";
    private String employeeIslandCode = "";
    private String employeeIslandName = "";
    private String employeeCountryCode = "";
    private String employeeCountryName = "";
    private String employeePhone1 = "";
    private String employeePhone2 = "";
    private String employeeFax = "";
    private String employeeEmail = "";
    private boolean activeStatus=false;
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


    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getEmployeeAddress() {
        return employeeAddress;
    }

    public void setEmployeeAddress(String employeeAddress) {
        this.employeeAddress = employeeAddress;
    }

    public String getEmployeeZipCode() {
        return employeeZipCode;
    }

    public void setEmployeeZipCode(String employeeZipCode) {
        this.employeeZipCode = employeeZipCode;
    }

    public String getEmployeeCityCode() {
        return employeeCityCode;
    }

    public void setEmployeeCityCode(String employeeCityCode) {
        this.employeeCityCode = employeeCityCode;
    }

    public String getEmployeeCityName() {
        return employeeCityName;
    }

    public void setEmployeeCityName(String employeeCityName) {
        this.employeeCityName = employeeCityName;
    }

    public String getEmployeeProvinceCode() {
        return employeeProvinceCode;
    }

    public void setEmployeeProvinceCode(String employeeProvinceCode) {
        this.employeeProvinceCode = employeeProvinceCode;
    }

    public String getEmployeeProvinceName() {
        return employeeProvinceName;
    }

    public void setEmployeeProvinceName(String employeeProvinceName) {
        this.employeeProvinceName = employeeProvinceName;
    }

    public String getEmployeeIslandCode() {
        return employeeIslandCode;
    }

    public void setEmployeeIslandCode(String employeeIslandCode) {
        this.employeeIslandCode = employeeIslandCode;
    }

    public String getEmployeeIslandName() {
        return employeeIslandName;
    }

    public void setEmployeeIslandName(String employeeIslandName) {
        this.employeeIslandName = employeeIslandName;
    }

    public String getEmployeeCountryCode() {
        return employeeCountryCode;
    }

    public void setEmployeeCountryCode(String employeeCountryCode) {
        this.employeeCountryCode = employeeCountryCode;
    }

    public String getEmployeeCountryName() {
        return employeeCountryName;
    }

    public void setEmployeeCountryName(String employeeCountryName) {
        this.employeeCountryName = employeeCountryName;
    }

    public String getEmployeePhone1() {
        return employeePhone1;
    }

    public void setEmployeePhone1(String employeePhone1) {
        this.employeePhone1 = employeePhone1;
    }

    public String getEmployeePhone2() {
        return employeePhone2;
    }

    public void setEmployeePhone2(String employeePhone2) {
        this.employeePhone2 = employeePhone2;
    }

    public String getEmployeeFax() {
        return employeeFax;
    }

    public void setEmployeeFax(String employeeFax) {
        this.employeeFax = employeeFax;
    }

    public String getEmployeeEmail() {
        return employeeEmail;
    }

    public void setEmployeeEmail(String employeeEmail) {
        this.employeeEmail = employeeEmail;
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

    public String getCreatedDateTemp() {
        return createdDateTemp;
    }

    public void setCreatedDateTemp(String createdDateTemp) {
        this.createdDateTemp = createdDateTemp;
    }
}
