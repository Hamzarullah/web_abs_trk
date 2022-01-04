/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.model;

import com.inkombizz.utils.DateUtils;
import java.util.Date;

/**
 *
 * @author Siswanto
 */
public class BomTemp {
    private String documentOrderCode= "";
    private String documentOrderDetailCode= "";
    private Date transactionDateDoc = DateUtils.newDate(1900, 1, 1);

    public String getDocumentOrderCode() {
        return documentOrderCode;
    }

    public void setDocumentOrderCode(String documentOrderCode) {
        this.documentOrderCode = documentOrderCode;
    }

    public String getDocumentOrderDetailCode() {
        return documentOrderDetailCode;
    }

    public void setDocumentOrderDetailCode(String documentOrderDetailCode) {
        this.documentOrderDetailCode = documentOrderDetailCode;
    }

    public Date getTransactionDateDoc() {
        return transactionDateDoc;
    }

    public void setTransactionDateDoc(Date transactionDateDoc) {
        this.transactionDateDoc = transactionDateDoc;
    }
    
    
}
