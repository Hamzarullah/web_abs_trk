package com.inkombizz.common.enumeration;

public class EnumTransactionAction {

    public enum ENUM_TransactionAction{
        INSERT, 
        UPDATE,
        DELETE,
        PRINT,
        VIEW,
        CONFIRMATION,
        SYNCHRONIZE,
        APPROVE_BY_TEAMLEADER,
        APPROVE_BY_ARCO,
        APPROVE_BY_VALIDATOR,
        APPROVE_BY_MANAGEMENT
    }
    
    public static String toString(ENUM_TransactionAction transactionAction){
        String rValue = "";
        
        if(ENUM_TransactionAction.INSERT == transactionAction)
            rValue = "INSERT";
                
        else if(ENUM_TransactionAction.UPDATE == transactionAction)
            rValue = "UPDATE";
        
        else if(ENUM_TransactionAction.DELETE == transactionAction)
            rValue = "DELETE";
        
        else if(ENUM_TransactionAction.PRINT == transactionAction)
            rValue = "PRINT";
        
        else if(ENUM_TransactionAction.VIEW == transactionAction)
            rValue = "VIEW";
        
        else if(ENUM_TransactionAction.SYNCHRONIZE == transactionAction)
            rValue = "SYNCHRONIZE";
        
        else if(ENUM_TransactionAction.APPROVE_BY_TEAMLEADER == transactionAction)
            rValue = "APPROVE BY TEAMLEADER";
        
        else if(ENUM_TransactionAction.APPROVE_BY_ARCO == transactionAction)
            rValue = "APPROVE BY ARCO";
        
        else if(ENUM_TransactionAction.APPROVE_BY_VALIDATOR == transactionAction)
            rValue = "APPROVE BY VALIDATOR";
        
        else if(ENUM_TransactionAction.APPROVE_BY_MANAGEMENT == transactionAction)
            rValue = "APPROVE BY MANAGEMENT";
        
        else if(ENUM_TransactionAction.CONFIRMATION == transactionAction)
            rValue = "CONFIRMATION";
        
        return rValue;
    }
    
}
