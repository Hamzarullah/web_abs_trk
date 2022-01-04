/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;

/**
 *
 * @author jason
 */
public class VendorInvoiceGoodsReceivedNoteTemp {
    
    private String code = "";
    private String headerCode = "";
    private String goodsReceivedNoteCode = "";
    private Date transactionDate = DateUtils.newDate(1900, 01, 01);
 
    /* SET GET mETHOD */

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getGoodsReceivedNoteCode() {
        return goodsReceivedNoteCode;
    }

    public void setGoodsReceivedNoteCode(String goodsReceivedNoteCode) {
        this.goodsReceivedNoteCode = goodsReceivedNoteCode;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    
}
