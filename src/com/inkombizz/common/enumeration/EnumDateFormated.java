package com.inkombizz.common.enumeration;

public class EnumDateFormated {
    public enum ENUM_DateFormated
    {
        DAY_MONTH_YEAR,
        YEAR_MONTH_DAY
    }
    
    public static String toString(ENUM_DateFormated dateFormat){
        String rValue = "";
        
        if(dateFormat == ENUM_DateFormated.DAY_MONTH_YEAR)
            rValue = "DAY_MONTH_YEAR";
        else if(dateFormat == ENUM_DateFormated.YEAR_MONTH_DAY)
            rValue = "YEAR_MONTH_DAY";
        
        return rValue;
    }
}