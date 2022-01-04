
package com.inkombizz.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;


public class CommonFunction {
    
    public Date setDateTime(String dateTime) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
        if(dateTime == null || dateTime.equals("")){
            return new Date();
        }
        Date dateTimeTemp = sdf.parse(dateTime);
        Date getDateTimeTemp = new java.sql.Timestamp(dateTimeTemp.getTime());
        return getDateTimeTemp;
    }
    
    public Date setDate(String dateTime) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy",Locale.ENGLISH);
        if(dateTime == null || dateTime.equals("")){
            return new Date();
        }
        Date dateTimeTemp = sdf.parse(dateTime);
        return dateTimeTemp;
    }
    
}
