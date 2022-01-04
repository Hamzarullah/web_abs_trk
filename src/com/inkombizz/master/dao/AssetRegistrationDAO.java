
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import java.util.Date;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.AssetRegistration;
import com.inkombizz.master.model.AssetRegistrationField;
import com.inkombizz.master.model.AssetRegistrationTemp;
import com.inkombizz.utils.DateUtils;
import org.hibernate.criterion.Restrictions;


public class AssetRegistrationDAO {
    
    private HBMSession hbmSession;
    
    public AssetRegistrationDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_asset_registration.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_asset_registration "
                + "WHERE mst_asset_registration.code LIKE '%"+code+"%' "
                + "AND mst_asset_registration.name LIKE '%"+name+"%' "
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
    
 
    public List<AssetRegistrationTemp> findData(String code, String name,String bbmVoucherNo, String ChartOfAccountCode, String ChartOfAccountName,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_asset_registration.ActiveStatus="+active+" ";
            }
            List<AssetRegistrationTemp> list = (List<AssetRegistrationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT " 
                + "mst_asset_registration.Code, "
                + "mst_asset_registration.Name, " 
                + "mst_asset_registration.AcquiredDate, " 
                + "mst_asset_category.code AS AssetCategoryCode, " 
                + "mst_asset_category.name AS AssetCategoryName, " 
                + "mst_currency.code AS CurrencyCode, " 
                + "mst_currency.name AS CurrencyName, " 
                + "mst_asset_registration.ExchangeRate, " 
                + "mst_asset_registration.SerialNo, " 
                + "mst_asset_registration.RefNo, " 
                + "mst_asset_registration.PriceForeign, " 
                + "mst_asset_registration.PriceIDR, "        
                + "mst_asset_registration.Remark," 
                + "mst_asset_registration.ActiveStatus "
                + "FROM mst_asset_registration "
                + "inner join mst_asset_category on mst_asset_category.code = mst_asset_registration.assetCategoryCode "
                + "inner join mst_currency on mst_currency.code = mst_asset_registration.currencyCode "
                + "WHERE mst_asset_registration.code LIKE '%"+code+"%' "
                + "AND mst_asset_registration.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("acquiredDate", Hibernate.DATE)
                .addScalar("assetCategoryCode", Hibernate.STRING)
                .addScalar("assetCategoryName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("priceForeign", Hibernate.BIG_DECIMAL)
                .addScalar("priceIDR", Hibernate.BIG_DECIMAL)
                .addScalar("serialNo", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(AssetRegistrationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
          
    public AssetRegistrationTemp findData(String code){
        try {
            AssetRegistrationTemp assetRegistrationTemp = (AssetRegistrationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_asset_registration.Code, "
                + "mst_asset_registration.name, "
                + "mst_asset_registration.AcquiredDate, " 
                + "mst_asset_category.code AS AssetCategoryCode, " 
                + "mst_asset_category.name AS AssetCategoryName, " 
                + "mst_currency.code AS CurrencyCode, " 
                + "mst_currency.name AS CurrencyName, " 
                + "mst_asset_registration.ExchangeRate, "
                + "mst_asset_registration.PriceForeign, "
                + "mst_asset_registration.PriceIDR, "
                + "mst_asset_registration.SerialNo, " 
                + "mst_asset_registration.RefNo, " 
                + "mst_asset_registration.Remark, " 
                + "mst_asset_registration.ActiveStatus, "
                + "mst_asset_registration.CreatedBy, "
                + "mst_asset_registration.CreatedDate "
                + "FROM mst_asset_registration "
                + "inner join mst_asset_category on mst_asset_category.code = mst_asset_registration.assetCategoryCode "
                + "inner join mst_currency on mst_currency.code = mst_asset_registration.currencyCode "
                + "WHERE mst_asset_registration.code='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("acquiredDate", Hibernate.DATE)
                .addScalar("assetCategoryCode", Hibernate.STRING)
                .addScalar("assetCategoryName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("priceForeign", Hibernate.BIG_DECIMAL)
                .addScalar("priceIDR", Hibernate.BIG_DECIMAL)
                .addScalar("serialNo", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(AssetRegistrationTemp.class))
                .uniqueResult(); 
                 
                return assetRegistrationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public AssetRegistrationTemp findData(String code,boolean active){
        try {
            AssetRegistrationTemp assetRegistrationTemp = (AssetRegistrationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT " 
                +"mst_asset_registration.Code, " 
                + "mst_asset_registration.Name, " 
                + "mst_asset_registration.AcquiredDate, " 
                + "mst_asset_category.code AS AssetCategoryCode, " 
                + "mst_asset_category.name AS AssetCategoryName, " 
                + "mst_currency.code AS CurrencyCode, " 
                + "mst_currency.name AS CurrencyName, " 
                + "mst_asset_registration.ExchangeRate, "
                + "mst_asset_registration.PriceForeign, "
                + "mst_asset_registration.PriceIDR, "
                + "mst_asset_registration.SerialNo, " 
                + "mst_asset_registration.RefNo, " 
                + "mst_asset_registration.Remark, " 
                + "mst_asset_registration.ActiveStatus "
                + "FROM mst_asset_registration "
                + "inner join mst_asset_category on mst_asset_category.code = mst_asset_registration.assetCategoryCode "
                + "inner join mst_currency on mst_currency.code = mst_asset_registration.currencyCode "
                + "WHERE mst_asset_registration.code='"+code+"' "
                + "AND mst_asset_registration.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("acquiredDate", Hibernate.DATE)
                .addScalar("assetCategoryCode", Hibernate.STRING)
                .addScalar("assetCategoryName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)
                .addScalar("priceForeign", Hibernate.BIG_DECIMAL)
                .addScalar("priceIDR", Hibernate.BIG_DECIMAL)
                .addScalar("serialNo", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(AssetRegistrationTemp.class))
                .uniqueResult(); 
                 
                return assetRegistrationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public AssetRegistrationTemp findData2(String code,String active){
        try {
            String concat_qry_active=" ";
            if(!active.equals("")){
                concat_qry_active="AND mst_asset_registration.ActiveStatus="+active+" ";
            }
            AssetRegistrationTemp assetRegistrationTemp = (AssetRegistrationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_asset_registration.Code, "
                + "mst_asset_registration.name, "
                + "mst_asset_registration.ActiveStatus "
                + "FROM mst_asset_registration "
                + "WHERE mst_asset_registration.code='"+code+"' "
                + concat_qry_active)
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AssetRegistrationTemp.class))
                .uniqueResult(); 
                 
                return assetRegistrationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    private String createId(AssetRegistration assetRegistration){    
        String tempStatus="AST";
        Date tempDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
        String acronim = tempStatus+AutoNumber.formatingDate(tempDate, true, true, false);

        DetachedCriteria dc = DetachedCriteria.forClass(AssetRegistration.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

        Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
        List list = criteria.list();

        String oldID = "";
        if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }
        return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_3);
       
    }
    
    public void save(AssetRegistration assetRegistration, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            assetRegistration.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            assetRegistration.setCreatedDate(new Date()); 
//            String id = createId(assetRegistration);
//            assetRegistration.setCode(id);
            
            hbmSession.hSession.save(assetRegistration);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    assetRegistration.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(AssetRegistration assetRegistration, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            assetRegistration.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            assetRegistration.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(assetRegistration);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    assetRegistration.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + AssetRegistrationField.BEAN_NAME + " WHERE " + AssetRegistrationField.CODE + " = :prmCode")
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
    
    public AssetRegistrationTemp min() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_asset_registration.Code, "
                    + "mst_asset_registration.Name "
                    + "FROM mst_asset_registration "
                    + "ORDER BY mst_asset_registration.Code "
                    + "LIMIT 0,1";
            AssetRegistrationTemp assetRegistrationTemp =(AssetRegistrationTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(AssetRegistrationTemp.class))
            .uniqueResult();   
            
            return assetRegistrationTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public AssetRegistrationTemp max() {
        try {
            
            String qry =
                        "SELECT "
                    + "mst_asset_registration.Code, "
                    + "mst_asset_registration.Name "
                    + "FROM mst_asset_registration "
                    + "ORDER BY mst_asset_registration.Code DESC "
                    + "LIMIT 0,1";
            AssetRegistrationTemp assetRegistrationTemp =(AssetRegistrationTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(AssetRegistrationTemp.class))
            .uniqueResult();   
            
            return assetRegistrationTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }       
}
