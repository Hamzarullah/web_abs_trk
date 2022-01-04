
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.AssetCategory;
import com.inkombizz.master.model.AssetCategoryField;
import com.inkombizz.master.model.AssetCategoryTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;


public class AssetCategoryDAO {
    
    private HBMSession hbmSession;
    
    public AssetCategoryDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_asset_category.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_asset_category "
                + "WHERE mst_asset_category.code LIKE '%"+code+"%' "
                + "AND mst_asset_category.name LIKE '%"+name+"%' "
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
       
    
    public AssetCategoryTemp findData(String code) {
        try {
               AssetCategoryTemp assetCategoryTemp = (AssetCategoryTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_asset_category.Code, "
                + "mst_asset_category.name, "
                + "mst_asset_category.activeStatus, "
                + "mst_asset_category.remark, "
                + "mst_asset_category.inActiveBy, "
                + "mst_asset_category.inActiveDate, "
                + "mst_asset_category.createdBy, "
                + "mst_asset_category.createdDate "
                + "FROM mst_asset_category "
                + "WHERE mst_asset_category.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(AssetCategoryTemp.class))
                .uniqueResult(); 
                 
                return assetCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public AssetCategoryTemp findData(String code,boolean active) {
        try {
            AssetCategoryTemp assetCategoryTemp = (AssetCategoryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_asset_category.Code, "
                + "mst_asset_category.name "
                + "FROM mst_asset_category "
                + "WHERE mst_asset_category.code ='"+code+"' "
                + "AND mst_asset_category.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AssetCategoryTemp.class))
                .uniqueResult(); 
                 
                return assetCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<AssetCategoryTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_asset_category.ActiveStatus="+active+" ";
            }
            List<AssetCategoryTemp> list = (List<AssetCategoryTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_asset_category.Code, "
                + "mst_asset_category.name, "
                + "mst_asset_category.ActiveStatus "
                + "FROM mst_asset_category "
                + "WHERE mst_asset_category.code LIKE '%"+code+"%' "
                + "AND mst_asset_category.name LIKE '%"+name+"%' "
                + concat_qry
                + "ORDER BY mst_asset_category.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(AssetCategoryTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    public void save(AssetCategory assetCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            assetCategory.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            assetCategory.setCreatedDate(new Date());
            hbmSession.hSession.save(assetCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    assetCategory.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            //System.out.println("Error DAO : " + e.getMessage());
            throw e;
        }
    }
    
    public void update(AssetCategory assetCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(assetCategory.isActiveStatus()){
                assetCategory.setInActiveBy("");                
            }else{
                assetCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                assetCategory.setInActiveDate(new Date());
            }
            
            assetCategory.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            assetCategory.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(assetCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    assetCategory.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + AssetCategoryField.BEAN_NAME + " WHERE " + AssetCategoryField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
}
