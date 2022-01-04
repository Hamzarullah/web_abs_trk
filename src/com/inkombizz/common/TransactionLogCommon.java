package com.inkombizz.common;

import com.inkombizz.action.BaseSession;
import com.inkombizz.system.model.TransactionLog;
import java.util.Date;

public class TransactionLogCommon {
 
    public static TransactionLog newInstance(String moduleCode, String actionType, String transactionCode,
                                             String description) {
        
        TransactionLog trLog = new TransactionLog();
        
        trLog.setCode("AUTO");
        trLog.setModuleCode(moduleCode);
        trLog.setActionType(actionType);
        trLog.setTransactionCode(transactionCode);
        trLog.setLogDate(new Date());
        trLog.setUserCode(BaseSession.loadProgramSession().getUserName());
        trLog.setIpNo("");
        trLog.setDescription(description);
    
        return trLog;
    }

    public static TransactionLog newInstance(String moduleCode, String toString, String code) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
 
}
