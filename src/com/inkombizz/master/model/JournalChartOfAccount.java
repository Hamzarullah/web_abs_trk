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
@Table(name="mst_journal_chart_of_account")
public class JournalChartOfAccount implements Serializable {	
   
    private String code = "";
    private Journal journal = null;
    private Currency currency = null;
    private String automaticJournalSetupCode = "";
    private ChartOfAccount chartOfAccount = null;
    private String automaticJournalType = "";
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
    @JoinColumn (name = "JournalCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Journal getJournal() {
        return journal;
    }

    public void setJournal(Journal journal) {
        this.journal = journal;
    }

    @Column(name = "AutomaticJournalSetupCode")
    public String getAutomaticJournalSetupCode() {
        return automaticJournalSetupCode;
    }

    public void setAutomaticJournalSetupCode(String automaticJournalSetupCode) {
        this.automaticJournalSetupCode = automaticJournalSetupCode;
    }

    @Column(name = "AutomaticJournalType")
    public String getAutomaticJournalType() {
        return automaticJournalType;
    }

    public void setAutomaticJournalType(String automaticJournalType) {
        this.automaticJournalType = automaticJournalType;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.LAZY)
    @JoinColumn (name = "AccountCode", referencedColumnName = "code", unique = false, nullable = true, insertable = true, updatable = true)
    public ChartOfAccount getChartOfAccount() {
        return chartOfAccount;
    }

    public void setChartOfAccount(ChartOfAccount chartOfAccount) {
        this.chartOfAccount = chartOfAccount;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "CurrencyCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
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

