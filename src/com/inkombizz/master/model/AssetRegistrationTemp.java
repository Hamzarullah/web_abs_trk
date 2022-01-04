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
 * @author Tonykeane
 */
public class AssetRegistrationTemp {
    private String code="";
    private String name="";
    private Date acquiredDate;
    private String assetCategoryCode="";
    private String assetCategoryName="";
    private String currencyCode="";
    private String currencyName="";
    private BigDecimal exchangeRate;
    private BigDecimal priceForeign;
    private BigDecimal priceIDR;
    private String serialNo="";
    private String refNo="";
    private String remark="";
    private Boolean activeStatus=false;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);;
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

    public Date getAcquiredDate() {
        return acquiredDate;
    }

    public void setAcquiredDate(Date acquiredDate) {
        this.acquiredDate = acquiredDate;
    }

    public String getAssetCategoryCode() {
        return assetCategoryCode;
    }

    public void setAssetCategoryCode(String assetCategoryCode) {
        this.assetCategoryCode = assetCategoryCode;
    }

    public String getAssetCategoryName() {
        return assetCategoryName;
    }

    public void setAssetCategoryName(String assetCategoryName) {
        this.assetCategoryName = assetCategoryName;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getCurrencyName() {
        return currencyName;
    }

    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public BigDecimal getPriceForeign() {
        return priceForeign;
    }

    public void setPriceForeign(BigDecimal priceForeign) {
        this.priceForeign = priceForeign;
    }

    public BigDecimal getPriceIDR() {
        return priceIDR;
    }

    public void setPriceIDR(BigDecimal priceIDR) {
        this.priceIDR = priceIDR;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Boolean getActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(Boolean activeStatus) {
        this.activeStatus = activeStatus;
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
