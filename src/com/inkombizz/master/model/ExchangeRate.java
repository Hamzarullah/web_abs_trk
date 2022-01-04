
package com.inkombizz.master.model;


import java.io.Serializable;
import com.inkombizz.utils.DateUtils;
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
@Table(name = "mst_exchange_rate_goods_received_note")
public class ExchangeRate implements Serializable{
    
   private static final long serialVersionUID = 1L;
    
    private String code = "";
    private Currency currency =null;
    private Date transactionDate;
    private String exchangeRate=""; 
    private String activeStatus = "";
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    
    
    @Id
    @Column(name = "Code")
    public String getCode() {
        return code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    
    @Column (name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    
    @Column (name = "ExchangeRate")
    public String getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(String exchangeRate) {
        this.exchangeRate = exchangeRate;
    }
    
    
    @Column (name = "ActiveStatus")
    public String getActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(String activeStatus) {
        this.activeStatus = activeStatus;
    }
    
    
    @Column (name = "CreatedBy")
    public String getCreatedBy(){
        return createdBy;
    }

    public void setCreatedBy(String createdby){
        this.createdBy = createdby;
    }
    
    @Column (name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate(){
        return createdDate;
    }
    public void setCreatedDate(Date createdDate){
        this.createdDate = createdDate;
    }
    
    @Column (name = "UpdatedBy")
    public String getUpdatedBy(){
        return updatedBy;
    }
    public void setUpdatedBy(String updatedby){
        this.updatedBy = updatedby;
    }
    
    @Column (name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate(){
        return updatedDate;
    }
    public void setUpdatedDate(Date updatedDate){
        this.updatedDate = updatedDate;
    }
    
    
}