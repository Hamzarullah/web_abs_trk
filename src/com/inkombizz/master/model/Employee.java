/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
@Table(name = "mst_employee")

public class Employee implements Serializable {
    
    private String code = "";
    private String nik = "";
    private String name = "";
    private String address = "";
    private String zipCode = "";
    private City city = null;
    private String domicileAddress1 = "";
    private String domicileAddress2 = "";
    private String phone = "";
    private String mobileNo1 = "";
    private String mobileNo2 = "";
    private String emailAddress = "";
    private String gender = "Male";
    private String maritalStatus = "Married";
    private Religion religion = null;
    private Education education = null;
    private String ktpNo = "";
    private String npwp = "";
    private String npwpName = "";
    private String npwpAddress = "";
    private City npwpCity = null;
    private String npwpZipCode = "";
    private String acNo = "";
    private String acName = "";
    private Bank bank = null;
    private String bankBranch = "";
    private Date joinDate = DateUtils.newDate(1900, 1, 1);
    private Date resignDate = DateUtils.newDate(1900, 1, 1);
    private Date birthDate = DateUtils.newDate(1900, 1, 1);
    private String birthPlace = "";
    private boolean activeStatus =false;
    private String remark = "";
    private String inActiveBy = "";
    private Date inActiveDate = DateUtils.newDate(1900, 1, 1);
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    @Id
    @Column(name="Code")
    public String getCode() {
        return code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "NIK")
    public String getNik() {
        return nik;
    }

    public void setNik(String nik) {
        this.nik = nik;
    }

    @Column(name = "Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    @Column(name = "Address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Column(name = "ZipCode")
    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CityCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    @Column(name = "DomicileAddress1")
    public String getDomicileAddress1() {
        return domicileAddress1;
    }

    public void setDomicileAddress1(String domicileAddress1) {
        this.domicileAddress1 = domicileAddress1;
    }

    @Column(name = "DomicileAddress2")
    public String getDomicileAddress2() {
        return domicileAddress2;
    }

    public void setDomicileAddress2(String domicileAddress2) {
        this.domicileAddress2 = domicileAddress2;
    }

    @Column(name = "Phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "MobileNo1")
    public String getMobileNo1() {
        return mobileNo1;
    }

    public void setMobileNo1(String mobileNo1) {
        this.mobileNo1 = mobileNo1;
    }

    @Column(name = "MobileNo2")
    public String getMobileNo2() {
        return mobileNo2;
    }

    public void setMobileNo2(String mobileNo2) {
        this.mobileNo2 = mobileNo2;
    }

    @Column(name = "EmailAddress")
    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    @Column(name = "Gender")
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Column(name = "MaritalStatus")
    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ReligionCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Religion getReligion() {
        return religion;
    }

    public void setReligion(Religion religion) {
        this.religion = religion;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "EducationCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Education getEducation() {
        return education;
    }

    public void setEducation(Education education) {
        this.education = education;
    }

    @Column(name = "KTPNo")
    public String getKtpNo() {
        return ktpNo;
    }

    public void setKtpNo(String ktpNo) {
        this.ktpNo = ktpNo;
    }

    @Column(name = "NPWP")
    public String getNpwp() {
        return npwp;
    }

    public void setNpwp(String npwp) {
        this.npwp = npwp;
    }

    @Column(name = "NPWPName")
    public String getNpwpName() {
        return npwpName;
    }

    public void setNpwpName(String npwpName) {
        this.npwpName = npwpName;
    }

    @Column(name = "NPWPAddress")
    public String getNpwpAddress() {
        return npwpAddress;
    }

    public void setNpwpAddress(String npwpAddress) {
        this.npwpAddress = npwpAddress;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "NPWPCityCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public City getNpwpCity() {
        return npwpCity;
    }

    public void setNpwpCity(City npwpCity) {
        this.npwpCity = npwpCity;
    }
    

    @Column(name = "NPWPZipCode")
    public String getNpwpZipCode() {
        return npwpZipCode;
    }

    public void setNpwpZipCode(String npwpZipCode) {
        this.npwpZipCode = npwpZipCode;
    }

    @Column(name = "ACNo")
    public String getAcNo() {
        return acNo;
    }

    public void setAcNo(String acNo) {
        this.acNo = acNo;
    }

    @Column(name = "ACName")
    public String getAcName() {
        return acName;
    }

    public void setAcName(String acName) {
        this.acName = acName;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BankCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Bank getBank() {
        return bank;
    }

    public void setBank(Bank bank) {
        this.bank = bank;
    }


    @Column(name = "BankBranch")
    public String getBankBranch() {
        return bankBranch;
    }

    public void setBankBranch(String bankBranch) {
        this.bankBranch = bankBranch;
    }

    @Column(name = "JoinDate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    @Column(name = "ResignDate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getResignDate() {
        return resignDate;
    }

    public void setResignDate(Date resignDate) {
        this.resignDate = resignDate;
    }

    @Column(name = "BirthDate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    @Column(name = "BirthPlace")
    public String getBirthPlace() {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
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
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getInActiveDate() {
        return inActiveDate;
    }

    public void setInActiveDate(Date inActiveDate) {
        this.inActiveDate = inActiveDate;
    }

    @Column(name = "CreatedBy")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column(name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.DATE)
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
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
    
}
