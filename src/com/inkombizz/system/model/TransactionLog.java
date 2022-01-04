package com.inkombizz.system.model;

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;

@Entity 
@Table(name = "sys_transaction_log")
public class TransactionLog implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String code = "";
    private String moduleCode = "";
    private String actionType = "";
    private String transactionCode = "";
    private Date logDate = DateUtils.newDate(1900, 1, 1);
    private String userCode = "";
    private String ipNo = "";
    private String description = "";
    
    @Id
    @Column(name = "code", length = 100, unique = true)
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "modulecode", length = 50)
    public String getModuleCode() {
        return moduleCode;
    }

    public void setModuleCode(String moduleCode) {
        this.moduleCode = moduleCode;
    }

    @Column(name = "actiontype", length = 20)
    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    @Column(name = "transactioncode", length = 50)
    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    @Column(name = "logdate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    @Column(name = "usercode", length = 50)
    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    @Column(name = "ipno", length = 20)
    public String getIpNo() {
        return ipNo;
    }

    public void setIpNo(String ipNo) {
        this.ipNo = ipNo;
    }

    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}