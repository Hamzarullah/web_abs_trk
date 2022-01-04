

package com.inkombizz.master.dao;

import java.math.BigInteger;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.master.model.ProductType;
import com.inkombizz.master.model.ProductTypeField;
import com.inkombizz.master.model.ProductTypeTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import org.hibernate.criterion.Restrictions;



public class ProductTypeDAO {
    
    private HBMSession hbmSession;
    
    public ProductTypeDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ProductType productType){   
        try{
            String acronim = "PRDTYP";
            DetachedCriteria dc = DetachedCriteria.forClass(ProductType.class)
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
                concat_qry="AND mst_product_type.ActiveStatus="+active+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_product_type "
                + "WHERE mst_product_type.code LIKE '%"+code+"%' "
                + "AND mst_product_type.name LIKE '%"+name+"%' "
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
    
    public ProductTypeTemp findData(String code) {
        try {
            ProductTypeTemp productTypeTemp = (ProductTypeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_product_type.Code, "
                + "mst_product_type.name, "
                + "mst_product_type.activeStatus, "
                + "mst_product_type.remark, "
                + "mst_product_type.InActiveBy, "
                + "mst_product_type.InActiveDate, "
                + "mst_product_type.CreatedBy, "
                + "mst_product_type.CreatedDate "
                + "FROM mst_product_type "
                + "WHERE mst_product_type.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ProductTypeTemp.class))
                .uniqueResult(); 
                 
                return productTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ProductTypeTemp findData(String code,boolean active) {
        try {
            ProductTypeTemp productTypeTemp = (ProductTypeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_product_type.Code, "
                + "mst_product_type.name, "
                + "mst_product_type.remark "
                + "FROM mst_product_type "
                + "WHERE mst_product_type.code ='"+code+"' "
                + "AND mst_product_type.ActiveStatus ="+active+" ")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ProductTypeTemp.class))
                .uniqueResult(); 
                 
                return productTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ProductTypeTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_product_type.ActiveStatus="+active+" ";
            }
            List<ProductTypeTemp> list = hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_product_type.Code, "
                + "mst_product_type.name, "
                + "mst_product_type.remark, "
                + "mst_product_type.ActiveStatus "
                + "FROM mst_product_type "
                + "WHERE mst_product_type.code LIKE '%"+code+"%' "
                + "AND mst_product_type.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ProductTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ProductType productType, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            productType.setCode(createCode(productType));
            if(productType.isActiveStatus()){
                productType.setInActiveBy("");                
            }else{
                productType.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                productType.setInActiveDate(new Date());
            }
            
            productType.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            productType.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(productType);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    productType.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ProductType productType, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(productType.isActiveStatus()){
                productType.setInActiveBy("");                
            }else{
                productType.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                productType.setInActiveDate(new Date());
            }
            productType.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            productType.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(productType);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    productType.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ProductTypeField.BEAN_NAME + " WHERE " + ProductTypeField.CODE + " = :prmCode")
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    
    
}
