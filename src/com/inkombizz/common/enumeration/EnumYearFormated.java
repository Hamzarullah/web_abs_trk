package com.inkombizz.common.enumeration;

/*
     YYYY >> 2011
     YY   >> 01
 */

public class EnumYearFormated{
    
    public enum ENUM_YearFormated {
        YYYY,
        YY
    }
    
    public static String toString(ENUM_YearFormated yearFormat){
        String rValue = "";
        
        if(yearFormat == ENUM_YearFormated.YY)
            rValue = "yy";
        else if (yearFormat == ENUM_YearFormated.YYYY)
            rValue = "yyyy";
        
        return rValue;
    }
    
    
}
