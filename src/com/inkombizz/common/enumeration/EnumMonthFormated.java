package com.inkombizz.common.enumeration;

/*
     MMMM >> January
     MMM  >> Jan
     MM   >> 01
     M    >> 1
 */
public class EnumMonthFormated {
    public enum ENUM_MonthFormated {
        MMMM,
        MMM,
        MM,
        M
    }
    
    public static String toString(ENUM_MonthFormated monthFormat){
        String rValue = "";
        
        if(monthFormat == ENUM_MonthFormated.M)
            rValue = "M";        
        else if(monthFormat == ENUM_MonthFormated.MM)
            rValue = "MM";
        if(monthFormat == ENUM_MonthFormated.MMM)
            rValue = "MMM";
        if(monthFormat == ENUM_MonthFormated.MMMM)
            rValue = "MMMM";
        
        return rValue;
    }
}
