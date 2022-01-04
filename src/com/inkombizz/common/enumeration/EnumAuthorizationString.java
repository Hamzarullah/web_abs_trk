package com.inkombizz.common.enumeration;

public class EnumAuthorizationString {
    public enum ENUM_AuthorizationString{
        INSERT, 
        UPDATE,
        DELETE,
        PRINT,
        CONFIRMATION,
        VIEW
    }
    
    public static String toString(ENUM_AuthorizationString authorizationString){
        String rValue = "";
        
        if(ENUM_AuthorizationString.INSERT == authorizationString)
            rValue = "INSERT";
                
        else if(ENUM_AuthorizationString.UPDATE == authorizationString)
            rValue = "UPDATE";
                
        else if(ENUM_AuthorizationString.CONFIRMATION == authorizationString)
            rValue = "CONFIRMATION";
        
        else if(ENUM_AuthorizationString.DELETE == authorizationString)
            rValue = "DELETE";
        
        else if(ENUM_AuthorizationString.PRINT == authorizationString)
            rValue = "PRINT";
        
        else if(ENUM_AuthorizationString.VIEW == authorizationString)
            rValue = "VIEW";
        
        return rValue;
    }
    
    public static String messages(ENUM_AuthorizationString authorizationString){
        String rValue = "You Don't Have Authorization - ";
        
        if(ENUM_AuthorizationString.INSERT == authorizationString)
            rValue += "INSERTED";
                
        else if(ENUM_AuthorizationString.UPDATE == authorizationString)
            rValue += "UPDATED";
                
        else if(ENUM_AuthorizationString.CONFIRMATION == authorizationString)
            rValue += "CONFIRMATION";
        
        else if(ENUM_AuthorizationString.DELETE == authorizationString)
            rValue += "DELETED";
        
        else if(ENUM_AuthorizationString.PRINT == authorizationString)
            rValue += "PRINTED";
        
        else if(ENUM_AuthorizationString.VIEW == authorizationString)
            rValue += "VIEW";
        
        return rValue;
    }
    
}
