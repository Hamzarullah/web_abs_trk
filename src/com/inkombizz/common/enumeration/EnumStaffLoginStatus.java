package com.inkombizz.common.enumeration;

public class EnumStaffLoginStatus {

    public enum ENUM_StaffLoginStatus {
        GLOBAL,
        TEAMLEADER,
        ARCO
    }

    public static int toInt(ENUM_StaffLoginStatus staffLoginStatus){
        int rValue = 0;
        
        if(staffLoginStatus == ENUM_StaffLoginStatus.ARCO)
            rValue = 1;
        
        else if(staffLoginStatus == ENUM_StaffLoginStatus.TEAMLEADER)
            rValue = 2;
        
        return rValue;                
    }
}
