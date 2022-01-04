package com.inkombizz.dao.common;

import com.inkombizz.common.CommonConst;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumDateFormated;
import com.inkombizz.common.enumeration.EnumDayFormated;
import com.inkombizz.common.enumeration.EnumMonth;
import com.inkombizz.common.enumeration.EnumMonthFormated;
import com.inkombizz.common.enumeration.EnumYearFormated;

import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.commons.lang.StringUtils;

/*
 *  PadLef >> Di JAVA G MANA
 */

public class AutoNumber {    
    public static final int DEFAULT_TRANSACTION_LENGTH = 5;
    public static final int DEFAULT_TRANSACTION_LENGTH_3 = 3;
    public static final int DEFAULT_TRANSACTION_LENGTH_2 = 2;
    public static final int DEFAULT_TRANSACTION_LENGTH_4 = 4;
    public static final int DEFAULT_TRANSACTION_LENGTH_5 = 5;
    public static final int DEFAULT_DETAIL_TRANSACTION_LENGTH = 5;
    public static final int DEFAULT_MASTER_LENGTH = 7;

    public static final int DEFAULT_TAXINVOICE_LENGTH = 8;
    public static final int DEFAULT_STOCK_LENGTH = 10;
         
    public static String getYear(Date transactionDate, boolean isYearFullLength)
    {
        //SimpleDateFormat simpleDateFormat = new SimpleDateFormat(EnumYearFormated.YYYY.toString());
        SimpleDateFormat simpleDateFormat;
        
        if(isYearFullLength)
            simpleDateFormat = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YYYY));
        else
            simpleDateFormat = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YY));
        
        return simpleDateFormat.format(transactionDate).toString();
    }

    public static String getMonth(Date transactionDate, boolean  isMonthUsingRomawi)
    {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(EnumMonthFormated.toString(EnumMonthFormated.ENUM_MonthFormated.MM));
                
        String sMonth = simpleDateFormat.format(transactionDate).toString();
        int iMonth =  Integer.parseInt(sMonth);
                
        if (isMonthUsingRomawi)
            sMonth = EnumMonth.toRomawi(iMonth);

        return sMonth; 
    }
    
    public static String formatingDate4Digits(Date transactionDate, boolean  isUsingYear,
            boolean isUsingMonth, boolean isUsingDay)
    {
        String fDate = "";

        SimpleDateFormat simpleDateFormat;
        
        if (isUsingYear){
            simpleDateFormat = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YYYY));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        if (isUsingMonth){
            simpleDateFormat = new SimpleDateFormat(EnumMonthFormated.toString(EnumMonthFormated.ENUM_MonthFormated.MMMM));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        if (isUsingDay){
            simpleDateFormat = new SimpleDateFormat(EnumDayFormated.toString(EnumDayFormated.ENUM_DayFormated.DD));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        return fDate;
    }

    public static String formatingDate(Date transactionDate, boolean  isUsingYear,
            boolean isUsingMonth, boolean isUsingDay)
    {
        String fDate = "";

        SimpleDateFormat simpleDateFormat;
        
        if (isUsingYear){
            simpleDateFormat = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YY));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        if (isUsingMonth){
            simpleDateFormat = new SimpleDateFormat(EnumMonthFormated.toString(EnumMonthFormated.ENUM_MonthFormated.MM));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        if (isUsingDay){
            simpleDateFormat = new SimpleDateFormat(EnumDayFormated.toString(EnumDayFormated.ENUM_DayFormated.DD));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        return fDate;
    }

    public static String formatingDateCustom(Date transactionDate, boolean  isUsingYear,
            boolean isUsingMonth, boolean isUsingDay)
    {
        String fDate = "";

        SimpleDateFormat simpleDateFormat;
        
        if (isUsingYear){
            simpleDateFormat = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YYYY));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        if (isUsingMonth){
            simpleDateFormat = new SimpleDateFormat(EnumMonthFormated.toString(EnumMonthFormated.ENUM_MonthFormated.MM));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        if (isUsingDay){
            simpleDateFormat = new SimpleDateFormat(EnumDayFormated.toString(EnumDayFormated.ENUM_DayFormated.DD));
            fDate += simpleDateFormat.format(transactionDate);
        }
        
        return fDate;
    }
    
    public static String formatingDate(Date transactionDate, boolean isUsingYear,
            boolean isUsingMonth, boolean isUsingDay, EnumDateFormated.ENUM_DateFormated dateFormated,
            String placeHolder, boolean isYearFullLength, boolean isMonthUsingRomawi)
    {
        String fDate = "";
        String dDay = "";
        String dMonth = "";
        String dYear = "";

        SimpleDateFormat simpleDateFormat;
        
        if (isUsingYear)
        {
            simpleDateFormat = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YY));
            String tempYear = simpleDateFormat.format(transactionDate);
            
            if(isYearFullLength){
                simpleDateFormat = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YYYY));
                tempYear = simpleDateFormat.format(transactionDate);                
            }
            
            dYear = tempYear + placeHolder;
            if(dateFormated == EnumDateFormated.ENUM_DateFormated.DAY_MONTH_YEAR)
                dYear = placeHolder + tempYear;            
        }

        if (isUsingMonth){
            simpleDateFormat = new SimpleDateFormat(EnumMonthFormated.toString(EnumMonthFormated.ENUM_MonthFormated.MM));
            dMonth = simpleDateFormat.format(transactionDate);
            
            if(isMonthUsingRomawi){
                int tempMonth = Integer.parseInt(dMonth);
                dMonth = EnumMonth.toRomawi(tempMonth);
            }
        }

        if (isUsingDay)
        {
            simpleDateFormat = new SimpleDateFormat(EnumDayFormated.toString(EnumDayFormated.ENUM_DayFormated.DD));
            String tempDay = simpleDateFormat.format(transactionDate);
            
            dDay = tempDay + placeHolder;
            if(dateFormated == EnumDateFormated.ENUM_DateFormated.DAY_MONTH_YEAR)
                dDay = placeHolder + tempDay;
        }

        if (dateFormated == EnumDateFormated.ENUM_DateFormated.DAY_MONTH_YEAR)
            fDate = dDay + dMonth + dYear;
        else
            fDate = dYear + dMonth + dDay;

        return fDate;
    }

    public static String generate(String oldCode, String prefiks, Date transactionDate, boolean isUsingYear,
            boolean isUsingMonth, boolean isUsingDay, int transactionLength)
    {
        if(oldCode.isEmpty())
            return prefiks + formatingDate(transactionDate, isUsingYear, isUsingMonth, isUsingDay) +  StringUtils.leftPad("1", transactionLength, "0");
                    
        String strNo = oldCode.substring(oldCode.length() - transactionLength, transactionLength);
        int intNo = Integer.parseInt(strNo) + 1;
        
        return prefiks + formatingDate(transactionDate, isUsingYear, isUsingMonth, isUsingDay) + intNo;
        // return prefiks + AutoNumber.FormatingDate(transactionDate, isUsingYear, isUsingMonth, isUsingDay) + intNo.ToString().PadLeft(transactionLength, '0');
    }

    public static String generate(String acronim, String oldCode, int transactionLength)
    {
        /*
            acronim = "GRN-1101-"
         */
        
        if ((oldCode.isEmpty()) || ("".equals(oldCode)))
        {
            return acronim + StringUtils.leftPad("1", transactionLength, "0");
        }

        String strNo = oldCode.substring(oldCode.length() - transactionLength, oldCode.length());
        int intNo = Integer.parseInt(strNo) + 1;

        return acronim + StringUtils.leftPad(Integer.toString(intNo), transactionLength, "0");
    }
    
    public static String generate_rev(EnumActivity.ENUM_Activity enumActivity,String acronim, String oldCode, int transactionLength)
    {
        /*
            acronim = "JKT/BOD/19020001_REV_00"
         */
        
        String resultCode="";
        if ((oldCode.isEmpty()) || ("".equals(oldCode)))
        {
            return acronim + StringUtils.leftPad("1", transactionLength, "0")+CommonConst.spliterNoRev +"00";
        }

        String strNo = oldCode.substring(oldCode.length() - transactionLength, oldCode.length());
        int intNo = Integer.parseInt(strNo) + 1;
        
        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
            resultCode= acronim + StringUtils.leftPad(Integer.toString(intNo), transactionLength, "0")+CommonConst.spliterNoRev +"00";
        }
        
        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
            resultCode=acronim + StringUtils.leftPad(Integer.toString(intNo), transactionLength, "0");
        }

        return resultCode;
    }
    
    public static String generate_revNew(EnumActivity.ENUM_Activity enumActivity, int transactionLength, String acronim, String oldCode)
    {
        /*
            acronim = "0001/SO/2021_REV.00"
         */
        
        String resultCode="";
        if ((oldCode.isEmpty()) || ("".equals(oldCode)))
        {
            return  StringUtils.leftPad("1", transactionLength, "0")+acronim+CommonConst.spliterNoRev +"00";
        }

        String strNo = oldCode.substring(0, transactionLength);
        int intNo = Integer.parseInt(strNo) + 1;
        
        
        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
            resultCode=StringUtils.leftPad(Integer.toString(intNo), transactionLength, "0")+acronim + CommonConst.spliterNoRev+"00";
        }
        
        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
            resultCode=StringUtils.leftPad(Integer.toString(intNo), transactionLength, "0")+acronim ;
        }

        return resultCode;
    }
    
    public static String generateCode(int transactionLength, String acronim, String oldCode)
    {
        /*
            acronim = "0001/Q/2019_Rev.01"
         */
        
        if ((oldCode.isEmpty()) || ("".equals(oldCode)))
        {
            return StringUtils.leftPad("1", transactionLength, "0")+acronim;
        }

        
        String strNo = oldCode.substring(0, transactionLength);
        int intNo = Integer.parseInt(strNo) + 1;

        return StringUtils.leftPad(Integer.toString(intNo), transactionLength, "0")+acronim ;
    }

    public static String generate(String acronimLeft, String acronimRight, String oldCode, int transactionLength)
    {
        /*
            acronim = "GRN-1101-xxxx-Dept"
         */
                
        if (oldCode.isEmpty())
        {
            return acronimLeft + StringUtils.leftPad("1", transactionLength, "0");
        }

        String strNo = oldCode.substring(acronimLeft.length(), acronimLeft.length() + transactionLength);
        int intNo = Integer.parseInt(strNo) + 1;

        return acronimLeft + intNo + acronimRight;
        //return acronimLeft + intNo.ToString().PadLeft(transactionLength, '0') + acronimRight;
    }
    
    public static String generate_serial(String acronim, String oldCode, int transactionLength)
    {
        /*
            acronim = "GRN-1101-"
         */
        
        if ((oldCode.isEmpty()) || ("".equals(oldCode)))
        {
            return acronim +"-"+ StringUtils.leftPad("1", transactionLength, "0");
        }

        String strNo = oldCode.substring(oldCode.length() - transactionLength, oldCode.length());
        int intNo = Integer.parseInt(strNo) + 1;

        return acronim +"-"+ StringUtils.leftPad(Integer.toString(intNo), transactionLength, "0");
    }

}
