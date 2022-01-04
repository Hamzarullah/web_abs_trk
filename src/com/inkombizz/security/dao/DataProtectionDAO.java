
package com.inkombizz.security.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.model.DataProtection;
import java.math.BigInteger;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;
import com.inkombizz.security.model.DataProtectionTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
//import static com.sun.jmx.snmp.EnumRowStatus.active;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;


public class DataProtectionDAO {
    
    private HBMSession hbmSession;
    
    public DataProtectionDAO(HBMSession session){
    this.hbmSession=session;
    }
    
    public int countData(String code){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM sys_data_protection "
                + "WHERE sys_data_protection.Code LIKE '%"+code+"%' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<DataProtectionTemp> findData(String code,int from, int row) {
        try {   
            
            List<DataProtectionTemp> list = (List<DataProtectionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                +"sys_data_protection.Code,  "
                +"sys_data_protection.MonthPeriod,  "
                +"sys_data_protection.YearPeriod "
                    +"FROM "
                +"sys_data_protection "
                + "WHERE sys_data_protection.Code LIKE '%"+code+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("monthPeriod", Hibernate.BIG_DECIMAL)
                .addScalar("YearPeriod", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(DataProtectionTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataIsExist(BigDecimal monthPeriod,BigDecimal yearPeriod, Date salesOrderTransactionDate){
        try{
            
            SimpleDateFormat DATE_FORMAT_MONTH = new SimpleDateFormat("MM");
            SimpleDateFormat DATE_FORMAT_YEAR = new SimpleDateFormat("yyyy");
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
            String nullDate = DATE_FORMAT.format(salesOrderTransactionDate);
                
            String month = DATE_FORMAT_MONTH.format(salesOrderTransactionDate);
            String year = DATE_FORMAT_YEAR.format(salesOrderTransactionDate);
            
            String concat_qry="";
            
            if( !nullDate.equals("1900-01-01") ){
                concat_qry=
                        "UNION ALL "
                        + "SELECT "
                            + "sys_data_protection.Code "
                        + "FROM "
                            + "sys_data_protection "
                        + "WHERE sys_data_protection.MonthPeriod = "+month+" "
                        + "AND sys_data_protection.YearPeriod = "+year+" "
                        ;
            }else {
                concat_qry= " ";
            }
            
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) "
                + "FROM( "
                    + "SELECT "
                        + "sys_data_protection.Code "
                    + "FROM "
                        + "sys_data_protection "
                    + "WHERE sys_data_protection.MonthPeriod="+monthPeriod+" "
                    + "AND sys_data_protection.YearPeriod ="+yearPeriod+" "
                    + concat_qry
                + ") AS month "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public void save(BigDecimal monthPeriod, BigDecimal yearPeriod,String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            DataProtection dataProtection = new DataProtection();
            
            dataProtection.setCode(monthPeriod+"-"+yearPeriod);
            dataProtection.setMonthPeriod(monthPeriod);
            dataProtection.setYearPeriod(yearPeriod);
            dataProtection.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            dataProtection.setCreatedDate(new Date()); 
            dataProtection.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            dataProtection.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.save(dataProtection);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    dataProtection.getCode(), "DATA PROTECTION"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(BigDecimal monthPeriod,BigDecimal yearPeriod,String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
                        
            hbmSession.hSession.createSQLQuery(
                    "DELETE FROM sys_data_protection "
                + "WHERE sys_data_protection.MonthPeriod =" + monthPeriod + " "
                + "AND sys_data_protection.YearPeriod="+yearPeriod+"")
                    .executeUpdate();
            
            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    monthPeriod+"-"+yearPeriod, "DATA PROTECTION"));
            
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
}
