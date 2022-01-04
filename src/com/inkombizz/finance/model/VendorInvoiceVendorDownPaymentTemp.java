/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author Sukha
 */
public class VendorInvoiceVendorDownPaymentTemp {
    
    private String code = "";
    private Date transactionDate = DateUtils.newDate(1900, 01, 01);
    private String currencyCode = "";
    private BigDecimal exchangeRate = new BigDecimal("0.00");
    private BigDecimal dpAmount = new BigDecimal("0.00");
    private BigDecimal used = new BigDecimal("0.00");
    private BigDecimal balance = new BigDecimal("0.00");
    private BigDecimal applied = new BigDecimal("0.00");
            
    /* SET GET METHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public BigDecimal getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(BigDecimal exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public BigDecimal getDpAmount() {
        return dpAmount;
    }

    public void setDpAmount(BigDecimal dpAmount) {
        this.dpAmount = dpAmount;
    }

    public BigDecimal getUsed() {
        return used;
    }

    public void setUsed(BigDecimal used) {
        this.used = used;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public BigDecimal getApplied() {
        return applied;
    }

    public void setApplied(BigDecimal applied) {
        this.applied = applied;
    }
}
