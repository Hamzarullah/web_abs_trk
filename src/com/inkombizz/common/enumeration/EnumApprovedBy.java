package com.inkombizz.common.enumeration;

public class EnumApprovedBy {
    public enum ENUM_ApprovedBy{
        TEAMLEADER, 
        ARCO,
        VALIDATOR,
        MANAGEMENT
    }
    
    public static String toString(ENUM_ApprovedBy approvedBY){
        String rValue = "";
        
        if(ENUM_ApprovedBy.TEAMLEADER == approvedBY)
            rValue = "TeamLeader";
                
        else if(ENUM_ApprovedBy.ARCO == approvedBY)
            rValue = "Arco";
        
        else if(ENUM_ApprovedBy.VALIDATOR == approvedBY)
            rValue = "Validator";
        
        else if(ENUM_ApprovedBy.MANAGEMENT == approvedBY)
            rValue = "Management";
        
        return rValue;
    }
    
    public static String toShortString(ENUM_ApprovedBy approvedBY){
        String rValue = "";
        
        if(ENUM_ApprovedBy.TEAMLEADER == approvedBY)
            rValue = "T";
                
        else if(ENUM_ApprovedBy.ARCO == approvedBY)
            rValue = "A";
        
        else if(ENUM_ApprovedBy.VALIDATOR == approvedBY)
            rValue = "V";
        
        else if(ENUM_ApprovedBy.MANAGEMENT == approvedBY)
            rValue = "M";
        
        return rValue;
    }
}
