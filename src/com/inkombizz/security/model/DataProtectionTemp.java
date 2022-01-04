/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.security.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

public class DataProtectionTemp {
    
    private String code = "";
    private String createdBy = "";
    private BigDecimal monthPeriod = new BigDecimal("0.00");
    private BigDecimal yearPeriod = new BigDecimal("0.00");
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public BigDecimal getMonthPeriod() {
        return monthPeriod;
    }

    public void setMonthPeriod(BigDecimal monthPeriod) {
        this.monthPeriod = monthPeriod;
    }

    public BigDecimal getYearPeriod() {
        return yearPeriod;
    }

    public void setYearPeriod(BigDecimal yearPeriod) {
        this.yearPeriod = yearPeriod;
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
    
    
    
}
