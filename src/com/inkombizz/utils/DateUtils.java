package com.inkombizz.utils;

import com.inkombizz.common.StringValue;
import com.inkombizz.common.enumeration.EnumMonth;
import com.inkombizz.common.enumeration.EnumDayFormated;
import com.inkombizz.common.enumeration.EnumMonthFormated;
import com.inkombizz.common.enumeration.EnumYearFormated;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DateUtils {  
    public static final String DATE_FORMAT_COMPLETE = "yyyy-MM-dd HH:mm:ss";
    public static final String DATE_FORMAT = "yyyy-MM-dd";
    public static final String DATE_FORMAT_D_M_Y = "dd-MM-yyyy";
    public static final String DATE_FORMAT_D_MMM_Y = "dd MMM yyyy";
    public static final String DATE_FORMAT_D_MMMM_Y = "dd MMMM yyyy";
    public static final String DATE_FORMAT_FORM = "MM/dd/yyyy";

    
    private StringValue stringValue = new StringValue();
    
    /*
    public static Date now() {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_COMPLETE);
        try {
            Calendar currentDate = Calendar.getInstance();
            return sdf.parse(currentDate.getTime().toString());
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    */
    
    public static Date newDateTime(Date date,boolean newTime) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        SimpleDateFormat sdf2 = new SimpleDateFormat(DATE_FORMAT_COMPLETE);
        Date newDate;
        try {                
            String now = sdf2.format(new Date());
            String _date=sdf.format(date);
//            Date transactionDate=sdf2.parse(_date +" "+ now.split(" ")[1]);
            if(newTime){
                newDate=sdf2.parse(_date +" "+ now.split(" ")[1]);
            }else{
                newDate=sdf2.parse(sdf2.format(date));
            }
            return newDate;
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    
    public static Date newDate() {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        try {
            Calendar currentDate = Calendar.getInstance();
            return sdf.parse(currentDate.getTime().toString());
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    
    public static Date newDate(int year, int month) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        try {            
            Calendar currentDate = Calendar.getInstance();
            Date tempDate = currentDate.getTime();
            
            SimpleDateFormat sdf2 = new SimpleDateFormat("dd");
            String sDay = sdf2.format(tempDate);
            
            return sdf.parse(Integer.toString(year) + "-" + Integer.toString(month) + "-" + sDay);
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    
    public static Date getExistingDate(Date datetime) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
       
        try {            
            
            String sDate = sdf.format(datetime);
            
            return sdf.parse(sDate);
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    
    public static Date newDateComplete() {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_COMPLETE);
        try {
            String now = sdf.format(new Date());
            return sdf.parse(now);
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    
    public static Date newDate(int year, int month, int day) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        try {
            return sdf.parse(Integer.toString(year) + "-" + Integer.toString(month) + "-" + Integer.toString(day));
        }
        catch (ParseException ex) {
            return getLastDateOfMonth(year, month);
        }
    }
    
    public static Date getFirstDateOfMonth(int year, int month) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        try {                        
            return sdf.parse(Integer.toString(year) + "-" + Integer.toString(month) + "-1");
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    
    public static String getFirstDateOfMonth_Form(int year, int month) {
        String tempMonth = Integer.toString(month);

        if(month<10)
            tempMonth = "0" + tempMonth;

        return tempMonth + "/01/" + Integer.toString(year);
    }
        
    public static Date getLastDateOfMonth(int year, int month) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        try {            
            Calendar currentDate = Calendar.getInstance();
            
            currentDate.set(year, month-1, 1);
            
            int maxDay = currentDate.getActualMaximum(Calendar.DAY_OF_MONTH);
            
            return sdf.parse(Integer.toString(year) + "-" + Integer.toString(month) + "-" + Integer.toString(maxDay));
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
          
    public static String getLastDateOfMonth_Form(int year, int month) {
        String tempMonth = Integer.toString(month);
        String tempDay = "";
                
        Calendar currentDate = Calendar.getInstance();
            
        currentDate.set(year, month-1, 1);

        int maxDay = currentDate.getActualMaximum(Calendar.DAY_OF_MONTH);
        tempDay = Integer.toString(maxDay);
        
        if(maxDay<10)
            tempDay = "0" + tempDay;
        
        if(month<10)
            tempMonth = "0" + tempMonth;

        return tempMonth + "/" + tempDay + "/" + Integer.toString(year);
    }
          
    public static Date getFirstDate() {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        try {
            Calendar currentDate = Calendar.getInstance();
            Date tempDate = currentDate.getTime();
                        
            SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy");
            String sYear = sdf2.format(tempDate);
            
            sdf2 = new SimpleDateFormat("MM");
            String sMonth = sdf2.format(tempDate);
                        
            return sdf.parse(sYear + "-" + sMonth + "-1");
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    
    public static Date getLastDate() {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        try {
            Calendar currentDate = Calendar.getInstance();
            Date tempDate = currentDate.getTime();
                        
            SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy");
            String sYear = sdf2.format(tempDate);
            
            sdf2 = new SimpleDateFormat("MM");
            String sMonth = sdf2.format(tempDate);
                        
            int maxDay = currentDate.getActualMaximum(Calendar.DAY_OF_MONTH);
            
            return sdf.parse(sYear + "-" + sMonth + "-" + Integer.toString(maxDay));
        }
        catch (ParseException ex) {
            return new Date();
        }
    }
    
    public static String getYearRight(Date transactionDate){
        SimpleDateFormat sdf = new SimpleDateFormat("yy"); // Just the year, with 2 digits
        String formattedDate = sdf.format(Calendar.getInstance().getTime());
        return formattedDate;
    }
    
    public static int getYear() {
        SimpleDateFormat sdf = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YYYY));
        Calendar currentDate = Calendar.getInstance();
        Date tempDate = currentDate.getTime();

        return Integer.parseInt(sdf.format(tempDate));  
    }
    
    public static int getYear(Date transactionDate) {
        SimpleDateFormat sdf = new SimpleDateFormat(EnumYearFormated.toString(EnumYearFormated.ENUM_YearFormated.YYYY));
        return Integer.parseInt(sdf.format(transactionDate));        
    }
    
    public static int getMonth() {
        SimpleDateFormat sdf = new SimpleDateFormat(EnumMonthFormated.toString(EnumMonthFormated.ENUM_MonthFormated.MM));
        Calendar currentDate = Calendar.getInstance();
        Date tempDate = currentDate.getTime();

        return Integer.parseInt(sdf.format(tempDate));  
    }
    
    public static int getMonth(Date transactionDate) {
        SimpleDateFormat sdf = new SimpleDateFormat(EnumMonthFormated.toString(EnumMonthFormated.ENUM_MonthFormated.MM));
        return Integer.parseInt(sdf.format(transactionDate));        
    }
    
    public static int getDay() {
        SimpleDateFormat sdf = new SimpleDateFormat(EnumDayFormated.toString(EnumDayFormated.ENUM_DayFormated.DD));
        Calendar currentDate = Calendar.getInstance();
        Date tempDate = currentDate.getTime();

        return Integer.parseInt(sdf.format(tempDate));  
    }
    
    public static int getDay(Date transactionDate) {
        SimpleDateFormat sdf = new SimpleDateFormat(EnumDayFormated.toString(EnumDayFormated.ENUM_DayFormated.DD));
        return Integer.parseInt(sdf.format(transactionDate));        
    }
    
    public static int getMaxDayOfMonth() {
        //SimpleDateFormat sdf = new SimpleDateFormat(EnumDayFormated.toString(EnumDayFormated.ENUM_DayFormated.DD));
        Calendar currentDate = Calendar.getInstance();
        
        return currentDate.getActualMaximum(Calendar.DAY_OF_MONTH);
    }
    
    public static int toInt(Date transactionDate) {        
        return getYear(transactionDate) + (getMonth(transactionDate) * 10) + getDay(transactionDate);
    }
    
    public static List<StringValue> getMonthlyList(){
        List<StringValue> monthlyList = new ArrayList<StringValue>();
        
        for(int i=1;i<=12;i++){
            StringValue sv = new StringValue();

            sv.setCode(Integer.toString(i));
            sv.setName(EnumMonth.toString(i,false));

            monthlyList.add(sv);
        }
        
        return monthlyList;
        
    }
        
    public static List<StringValue> getYearList(){
        List<StringValue> yearList = new ArrayList<StringValue>();
        
        for(int i=2010;i<=2035;i++){
            StringValue sv = new StringValue();

            sv.setCode(Integer.toString(i));
            sv.setName(Integer.toString(i));

            yearList.add(sv);
        }
        
        return yearList;
        
    }
    
    public static String toString(Date date, String formatDate) {
        SimpleDateFormat sdf = new SimpleDateFormat(formatDate);
        return sdf.format(date);
    }
    
}