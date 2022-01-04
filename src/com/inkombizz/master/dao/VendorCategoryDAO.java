

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
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBolt;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.VendorCategory;
import com.inkombizz.master.model.VendorCategoryTemp;
import com.inkombizz.master.model.VendorCategoryField;
import org.hibernate.criterion.Restrictions;



public class VendorCategoryDAO {
    
    private HBMSession hbmSession;
    
    public VendorCategoryDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(VendorCategory vendorCategory){   
        try{
            String acronim = "VDRCTG";
            DetachedCriteria dc = DetachedCriteria.forClass(VendorCategory.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",  acronim + "%" ));
            
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();
            
            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_5);
        }        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_vendor_category.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_vendor_category "
                + "WHERE mst_vendor_category.code LIKE '%"+code+"%' "
                + "AND mst_vendor_category.name LIKE '%"+name+"%' "
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
    
    public VendorCategoryTemp findData(String code) {
        try {
            VendorCategoryTemp vendorCategoryTemp = (VendorCategoryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_vendor_category.Code, "
                + "mst_vendor_category.name, "
                + "mst_vendor_category.activeStatus, "
                + "mst_vendor_category.remark, "
                + "mst_vendor_category.InActiveBy, "
                + "mst_vendor_category.InActiveDate, "
                + "mst_vendor_category.CreatedBy, "
                + "mst_vendor_category.CreatedDate "
                + "FROM mst_vendor_category "
                + "WHERE mst_vendor_category.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(VendorCategoryTemp.class))
                .uniqueResult(); 
                 
                return vendorCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public VendorCategoryTemp findData(String code,boolean active) {
        try {
            VendorCategoryTemp vendorCategoryTemp = (VendorCategoryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_vendor_category.Code, "
                + "mst_vendor_category.name, "
                + "mst_vendor_category.remark "
                + "FROM mst_vendor_category "
                + "WHERE mst_vendor_category.code ='"+code+"' "
                + "AND mst_vendor_category.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorCategoryTemp.class))
                .uniqueResult(); 
                 
                return vendorCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<VendorCategoryTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_vendor_category.ActiveStatus="+active+" ";
            }
            List<VendorCategoryTemp> list = (List<VendorCategoryTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_vendor_category.Code, "
                + "mst_vendor_category.name, "
                + "mst_vendor_category.remark, "
                + "mst_vendor_category.ActiveStatus "
                + "FROM mst_vendor_category "
                + "WHERE mst_vendor_category.code LIKE '%"+code+"%' "
                + "AND mst_vendor_category.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(VendorCategoryTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(VendorCategory vendorCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            vendorCategory.setCode(createCode(vendorCategory));
            if(vendorCategory.isActiveStatus()){
                vendorCategory.setInActiveBy("");                
            }else{
                vendorCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                vendorCategory.setInActiveDate(new Date());
            }
            
            vendorCategory.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorCategory.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(vendorCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    vendorCategory.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(VendorCategory vendorCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(vendorCategory.isActiveStatus()){
                vendorCategory.setInActiveBy("");                
            }else{
                vendorCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                vendorCategory.setInActiveDate(new Date());
            }
            vendorCategory.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorCategory.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(vendorCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    vendorCategory.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + VendorCategoryField.BEAN_NAME + " WHERE " + VendorCategoryField.CODE + " = :prmCode")
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
