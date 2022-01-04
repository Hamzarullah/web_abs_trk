/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common;
import com.inkombizz.action.BaseSession;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.Branch;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.persistence.Table;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Imam
 */
public class AutoGeneradeQuery {
    private static String value = "";
    private static int intValue = 0;
    
    public static String masterCode(Map<String, Object> hMap,int number,HBMSession hbm) {
        try{
            
            String string1 = (String) hMap.get("string1");
            String string2 = (String) hMap.get("string2");
            Class class1 = (Class) hMap.get("class1");
            
//           Create Combination code
            String acronim = string1 +"/"+ string2;
            
            DetachedCriteria dc = DetachedCriteria.forClass(class1)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",  acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbm.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }

            return AutoNumber.generate(acronim, oldID, number);
        }
        catch(HibernateException e){
            throw e;
        }
    }
    
    public static String generadeCode(Map<String, Object> hMap,int number,HBMSession hbm) {
        try{
            
            String string1 = (String) hMap.get("string1");
            Date date1 = (Date) hMap.get("date1");
            int int1 = (int) hMap.get("int1");
            Class class1 = (Class) hMap.get("class1");
            Branch branch = (Branch) hMap.get("branch");
            
//            Get table name 
            Class<?> GC1 = class1;
            Table table1 = GC1.getAnnotation(Table.class);
            String tableName = table1.name();
            
            
//            Formate date and month
            String year =StringUtils.substring(setDateString(date1,"YYYY"),2);
            String month = setDateString(date1,"MM");
            
//            Get accronym alias
            String accrm = (String)hbm.hSession.createSQLQuery(""
                + " SELECT "
                    + "CASE WHEN "+int1+"> 0 THEN mst_branch.vatAcronym "
                    + "ELSE mst_branch.nonVatAcronym END  AS VALUE  "
                + "FROM mst_branch "
                + "WHERE CODE = '"+branch.getCode()+"' "
                + "").uniqueResult();
            
//           Create Combination code
            String acronim = accrm +"/"+ string1 + year + month;
            
            DetachedCriteria dc = DetachedCriteria.forClass(class1)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",  acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbm.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }

            return AutoNumber.generate(acronim, oldID, number);
        }
        catch(HibernateException e){
            throw e;
        }
    }

    public static String generadeBarcodeNew(Map<String, Object> hMap,int number,HBMSession hbm) {
        try{
            
            String string1 = (String) hMap.get("string1");
            String string2 = (String) hMap.get("string2");
            Class class1 = (Class) hMap.get("class1");
            
            
//           Create Combination code
            String acronim = string1+string2;
            
            DetachedCriteria dc = DetachedCriteria.forClass(class1)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",  acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbm.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }

            return AutoNumber.generate(acronim, oldID, number);
        }
        catch(HibernateException e){
            throw e;
        }
    }

    public static String generadeBarcodeUpdate(Map<String, Object> hMap,int number,HBMSession hbm) {
        try{
            
            String string1 = (String) hMap.get("string1");
            String string2 = (String) hMap.get("string2");
            String string3 = (String) hMap.get("string3");
            Class class1 = (Class) hMap.get("class1");
            

            String barcode = "";
            String oldID = "";
//           Create Combination code
            String acronim = string2+string3;
            DetachedCriteria dc;
            Criteria criteria;
            List list;
            
//           Check code
            if(string1.equals("AUTO") || string1.equals("auto") || string1.equals("Auto")){
                
                dc = DetachedCriteria.forClass(class1)
                        .setProjection(Projections.property("code"))
                        .add(Restrictions.eq("code", string1));

                criteria = dc.getExecutableCriteria(hbm.hSession);
                list = criteria.list();

                if(list != null){
                    if (list.size() > 0){
                        if(list.get(0) != null){
                            oldID = list.get(0).toString();
                        }
                    }
                }
            }else{
                oldID = string1;
            }
            
            if(oldID.equals("")){
//              Set code
                dc = DetachedCriteria.forClass(class1)
                        .setProjection(Projections.max("code"))
                        .add(Restrictions.like("code",  acronim + "%" ));

                criteria = dc.getExecutableCriteria(hbm.hSession);
                list = criteria.list();

                if(list != null){
                    if (list.size() > 0){
                        if(list.get(0) != null){
                            oldID = AutoNumber.generate(acronim, list.get(0).toString(), number) ;
                        }else{
                            oldID = AutoNumber.generate(acronim,"", number);
                        }
                    }
                }
            }else{
                oldID = string1;
            }

            return oldID;
        }
        catch(HibernateException e){
            throw e;
        }
    }

    public static String setWhereUserBranch(String tbl,String values){
        
            String whereQRY = "";
            if(values == null || values.equals("")){
                if(tbl.equalsIgnoreCase("ivt_warehouse_mutation")){
                    whereQRY =     "AND (destinationWarehouse.BranchCode IN (select scr_user_branch.branchCode from scr_user_branch where scr_user_branch.userCode = '"+BaseSession.loadProgramSession().getUserCode()+"') "
                                        + "OR sourceWarehouse.BranchCode IN (select scr_user_branch.branchCode from scr_user_branch where scr_user_branch.userCode = '"+BaseSession.loadProgramSession().getUserCode()+"')) ";
                }else{
                    whereQRY =  "AND "+tbl+".BranchCode IN (select scr_user_branch.branchCode from scr_user_branch where scr_user_branch.userCode = '"+BaseSession.loadProgramSession().getUserCode()+"') ";
                }
            }else{
                String[] strArr = values.split(",");
                if(strArr.length >1){
                    for(int i = 0; i< strArr.length; i++){
                        if(i==0){
                            value = value+"'"+strArr[i]+"'";
                        }else{
                            value = value+",'"+strArr[i]+"'";
                        }
                    }
                    whereQRY =  " AND "+tbl+".BranchCode IN ("+value+") ";
                }else{
                    whereQRY =  " AND "+tbl+".BranchCode IN ('"+values+"') ";
                }
            }
            
           return whereQRY;
    }
    
    public static String setDateString(Date date, String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        if(date != null){
            value = sdf.format(date);
        }else{
            value = " ";
        }
        return value;
    }
    
    public String getUpdateFieldTable(String field, String val,BigDecimal big,Boolean bool, int sub) {
        if(val != null && !val.equals("")){
            if(intValue == 0 ){
                if(bool !=null && (val ==null || val.equals("") || val.equals("1900-01-01") && sub == 0) ){
                   value = " "+field+" = "+bool+" "; 
                }else if((val !=null || !val.equals("") || !val.equals("1900-01-01")) && bool ==null && sub == 0){
                   value = " "+field+" = '"+val+"' "; 
                }else if((val ==null || val.equals("") || val.equals("1900-01-01")) && bool ==null && sub != 0){
                    value = " "+field+" = "+big+" "; 
                }
            }else{
                if(bool !=null && (val ==null || val.equals("") || val.equals("1900-01-01") && sub == 0) ){
                   value = ", "+field+" = "+bool+" "; 
                }else if((val !=null || !val.equals("") || !val.equals("1900-01-01")) && bool ==null && sub == 0){
                   value = ", "+field+" = '"+val+"' "; 
                }else if((val ==null || val.equals("") || val.equals("1900-01-01")) && bool ==null && sub != 0){
                    value = ", "+field+" = "+big+" "; 
                }
            }
            intValue = sub;
        }else{
            value = "";
        }
        return value;
    }
    
    public String setEqualData(String alias,String tableEx, String val) {
        if(val != null && !val.equals("")){
            value = alias+" "+tableEx+" = '"+val+"' ";
        }else{
            value = " ";
        }
        return value;
    }
    
    
    public Date setDateTime(String times) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
        if(times == null || times.equals("")){
            return new Date();
        }
        Date transactionDateTemp = sdf.parse(times);
        Date getDateTemp = new java.sql.Timestamp(transactionDateTemp.getTime());
        return getDateTemp;
    }
    
}
