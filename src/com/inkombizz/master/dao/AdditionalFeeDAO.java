

package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.AdditionalFee;
import com.inkombizz.master.model.AdditionalFeeTemp;
import com.inkombizz.master.model.AdditionalFeeField;



public class AdditionalFeeDAO {
    
    private HBMSession hbmSession;
    
    public AdditionalFeeDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_additional_fee.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_additional_fee "
                + "WHERE mst_additional_fee.code LIKE '%"+code+"%' "
                + "AND mst_additional_fee.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataFeePurchase(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_additional_fee.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_additional_fee "
                + "WHERE mst_additional_fee.code LIKE '%"+code+"%' "
                + "AND mst_additional_fee.name LIKE '%"+name+"%' "
                + "AND mst_additional_fee.purchaseStatus = TRUE "            
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataFeeSales(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_additional_fee.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_additional_fee "
                + "WHERE mst_additional_fee.code LIKE '%"+code+"%' "
                + "AND mst_additional_fee.name LIKE '%"+name+"%' "
                + "AND mst_additional_fee.salesStatus = TRUE "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
       
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public AdditionalFeeTemp findData(String code) {
        try {
            AdditionalFeeTemp additionalFeeTemp = (AdditionalFeeTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_additional_fee.code, "
                +" mst_additional_fee.name, "
                +" coa1.code AS purchaseChartOfAccountCode, "
                +" coa1.name AS purchaseChartOfAccountName, "
                +" coa2.code AS salesChartOfAccountCode, "
                +" coa2.name AS salesChartOfAccountName, "
                +" mst_additional_fee.purchaseStatus, "
                +" mst_additional_fee.salesStatus, "
                +" mst_additional_fee.activeStatus, "
                +" mst_additional_fee.remark "
                + "FROM mst_additional_fee "
                + "LEFT JOIN mst_chart_of_account coa1 ON coa1.code = mst_additional_fee.purchaseChartOfAccountCode "
                + "LEFT JOIN mst_chart_of_account coa2 ON coa2.code = mst_additional_fee.salesChartOfAccountCode "
                + "WHERE mst_additional_fee.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountCode", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountName", Hibernate.STRING)
                .addScalar("salesChartOfAccountCode", Hibernate.STRING)
                .addScalar("salesChartOfAccountName", Hibernate.STRING)
                .addScalar("purchaseStatus", Hibernate.BOOLEAN)
                .addScalar("salesStatus", Hibernate.BOOLEAN)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(AdditionalFeeTemp.class))
                .uniqueResult(); 
                 
                return additionalFeeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public AdditionalFeeTemp findData(String code,boolean active) {
        try {
            AdditionalFeeTemp additionalFeeTemp = (AdditionalFeeTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_additional_fee.code, "
                +" mst_additional_fee.name, "
                +" coa1.code AS purchaseChartOfAccountCode, "
                +" coa1.name AS purchaseChartOfAccountName, "
                +" coa2.code AS salesChartOfAccountCode, "
                +" coa2.name AS salesChartOfAccountName, "
                +" mst_additional_fee.purchaseStatus, "
                +" mst_additional_fee.salesStatus, "
                +" mst_additional_fee.activeStatus, "
                +" mst_additional_fee.remark "
                + "FROM mst_additional_fee "
                + "LEFT JOIN mst_chart_of_account coa1 ON coa1.code = mst_additional_fee.purchaseChartOfAccountCode "
                + "LEFT JOIN mst_chart_of_account coa2 ON coa2.code = mst_additional_fee.salesChartOfAccountCode "
                + "WHERE mst_additional_fee.code ='"+code+"' "
                + "AND mst_additional_fee.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountCode", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountName", Hibernate.STRING)
                .addScalar("salesChartOfAccountCode", Hibernate.STRING)
                .addScalar("salesChartOfAccountName", Hibernate.STRING)
                .addScalar("purchaseStatus", Hibernate.BOOLEAN)
                .addScalar("salesStatus", Hibernate.BOOLEAN)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdditionalFeeTemp.class))
                .uniqueResult(); 
                 
                return additionalFeeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    public AdditionalFeeTemp findData(String code,boolean active, boolean status) {
        try {
            AdditionalFeeTemp additionalFeeTemp = (AdditionalFeeTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_additional_fee.code, "
                +" mst_additional_fee.name, "
                +" coa1.code AS purchaseChartOfAccountCode, "
                +" coa1.name AS purchaseChartOfAccountName, "
                +" coa2.code AS salesChartOfAccountCode, "
                +" coa2.name AS salesChartOfAccountName, "
                +" mst_additional_fee.purchaseStatus, "
                +" mst_additional_fee.salesStatus, "
                +" mst_additional_fee.activeStatus, "
                +" mst_additional_fee.remark "
                + "FROM mst_additional_fee "
                + "LEFT JOIN mst_chart_of_account coa1 ON coa1.code = mst_additional_fee.purchaseChartOfAccountCode "
                + "LEFT JOIN mst_chart_of_account coa2 ON coa2.code = mst_additional_fee.salesChartOfAccountCode "
                + "WHERE mst_additional_fee.code ='"+code+"' "
                + "AND mst_additional_fee.ActiveStatus ="+active+" "
                + "AND mst_additional_fee.salesStatus ="+status+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountCode", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountName", Hibernate.STRING)
                .addScalar("salesChartOfAccountCode", Hibernate.STRING)
                .addScalar("salesChartOfAccountName", Hibernate.STRING)
                .addScalar("purchaseStatus", Hibernate.BOOLEAN)
                .addScalar("salesStatus", Hibernate.BOOLEAN)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdditionalFeeTemp.class))
                .uniqueResult(); 
                 
                return additionalFeeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<AdditionalFeeTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_additional_fee.ActiveStatus="+active+" ";
            }
            List<AdditionalFeeTemp> list = (List<AdditionalFeeTemp>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_additional_fee.code, "
                +" mst_additional_fee.name, "
                +" coa1.code AS purchaseChartOfAccountCode, "
                +" coa1.name AS purchaseChartOfAccountName, "
                +" coa2.code AS salesChartOfAccountCode, "
                +" coa2.name AS salesChartOfAccountName, "
                +" CASE "
                    + " WHEN mst_additional_fee.purchaseStatus = TRUE THEN 'YES' "
                    + " WHEN mst_additional_fee.purchaseStatus = FALSE THEN 'NO' " 
                + " END AS purchaseStatus," 
                +" CASE "
                    + " WHEN mst_additional_fee.salesStatus = TRUE THEN 'YES' " 
                    + " WHEN mst_additional_fee.salesStatus = FALSE THEN 'NO' " 
                + " END AS salesStatus,"    
                +" mst_additional_fee.activeStatus, "
                +" mst_additional_fee.remark "
                + "FROM mst_additional_fee "
                + "LEFT JOIN mst_chart_of_account coa1 ON coa1.code = mst_additional_fee.purchaseChartOfAccountCode "
                + "LEFT JOIN mst_chart_of_account coa2 ON coa2.code = mst_additional_fee.salesChartOfAccountCode "
                + "WHERE mst_additional_fee.code LIKE '%"+code+"%' "
                + "AND mst_additional_fee.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountCode", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountName", Hibernate.STRING)
                .addScalar("salesChartOfAccountCode", Hibernate.STRING)
                .addScalar("salesChartOfAccountName", Hibernate.STRING)
                .addScalar("purchaseStatus", Hibernate.BOOLEAN)
                .addScalar("salesStatus", Hibernate.BOOLEAN)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdditionalFeeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AdditionalFeeTemp> findDataPurchase(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_additional_fee.ActiveStatus="+active+" ";
            }
            List<AdditionalFeeTemp> list = (List<AdditionalFeeTemp>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_additional_fee.code, "
                +" mst_additional_fee.name, "
                +" coa1.code AS purchaseChartOfAccountCode, "
                +" coa1.name AS purchaseChartOfAccountName, "
                +" coa2.code AS salesChartOfAccountCode, "
                +" coa2.name AS salesChartOfAccountName, "
                +" CASE "
                    + " WHEN mst_additional_fee.purchaseStatus = TRUE THEN 'YES' "
                    + " WHEN mst_additional_fee.purchaseStatus = FALSE THEN 'NO' " 
                + " END AS purchaseStatus," 
                +" CASE "
                    + " WHEN mst_additional_fee.salesStatus = TRUE THEN 'YES' " 
                    + " WHEN mst_additional_fee.salesStatus = FALSE THEN 'NO' " 
                + " END AS salesStatus,"    
                +" mst_additional_fee.activeStatus, "
                +" mst_additional_fee.remark "
                + "FROM mst_additional_fee "
                + "LEFT JOIN mst_chart_of_account coa1 ON coa1.code = mst_additional_fee.purchaseChartOfAccountCode "
                + "LEFT JOIN mst_chart_of_account coa2 ON coa2.code = mst_additional_fee.salesChartOfAccountCode "
                + "WHERE mst_additional_fee.code LIKE '%"+code+"%' "
                + "AND mst_additional_fee.name LIKE '%"+name+"%' "
                + "AND mst_additional_fee.purchaseStatus = TRUE "      
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountCode", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountName", Hibernate.STRING)
                .addScalar("salesChartOfAccountCode", Hibernate.STRING)
                .addScalar("salesChartOfAccountName", Hibernate.STRING)
                .addScalar("purchaseStatus", Hibernate.BOOLEAN)
                .addScalar("salesStatus", Hibernate.BOOLEAN)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdditionalFeeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AdditionalFeeTemp> findDataSales(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_additional_fee.ActiveStatus="+active+" ";
            }
            List<AdditionalFeeTemp> list = (List<AdditionalFeeTemp>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_additional_fee.code, "
                +" mst_additional_fee.name, "
                +" coa1.code AS purchaseChartOfAccountCode, "
                +" coa1.name AS purchaseChartOfAccountName, "
                +" coa2.code AS salesChartOfAccountCode, "
                +" coa2.name AS salesChartOfAccountName, "
                +" CASE "
                    + " WHEN mst_additional_fee.purchaseStatus = TRUE THEN 'YES' "
                    + " WHEN mst_additional_fee.purchaseStatus = FALSE THEN 'NO' " 
                + " END AS purchaseStatus," 
                +" CASE "
                    + " WHEN mst_additional_fee.salesStatus = TRUE THEN 'YES' " 
                    + " WHEN mst_additional_fee.salesStatus = FALSE THEN 'NO' " 
                + " END AS salesStatus,"    
                +" mst_additional_fee.activeStatus, "
                +" mst_additional_fee.remark "
                + "FROM mst_additional_fee "
                + "LEFT JOIN mst_chart_of_account coa1 ON coa1.code = mst_additional_fee.purchaseChartOfAccountCode "
                + "LEFT JOIN mst_chart_of_account coa2 ON coa2.code = mst_additional_fee.salesChartOfAccountCode "
                + "WHERE mst_additional_fee.code LIKE '%"+code+"%' "
                + "AND mst_additional_fee.name LIKE '%"+name+"%' "
                + "AND mst_additional_fee.salesStatus = TRUE "   
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountCode", Hibernate.STRING)
                .addScalar("purchaseChartOfAccountName", Hibernate.STRING)
                .addScalar("salesChartOfAccountCode", Hibernate.STRING)
                .addScalar("salesChartOfAccountName", Hibernate.STRING)
                .addScalar("purchaseStatus", Hibernate.BOOLEAN)
                .addScalar("salesStatus", Hibernate.BOOLEAN)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdditionalFeeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(AdditionalFee additionalFee, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(additionalFee.isActiveStatus()){
                additionalFee.setInActiveBy("");                
            }else{
                additionalFee.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                additionalFee.setInActiveDate(new Date());
            }
            
            additionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            additionalFee.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(additionalFee);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    additionalFee.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(AdditionalFee additionalFee, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(additionalFee.isActiveStatus()){
                additionalFee.setInActiveBy("");                
            }else{
                additionalFee.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                additionalFee.setInActiveDate(new Date());
            }
            additionalFee.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            additionalFee.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(additionalFee);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    additionalFee.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + AdditionalFeeField.BEAN_NAME + " WHERE " + AdditionalFeeField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    
}
