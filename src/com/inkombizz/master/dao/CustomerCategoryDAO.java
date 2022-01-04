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
import com.inkombizz.master.model.Customer;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.CustomerCategory;
import com.inkombizz.master.model.CustomerCategoryTemp;
import com.inkombizz.master.model.CustomerCategoryField;
import org.hibernate.criterion.Restrictions;



public class CustomerCategoryDAO {
    
    private HBMSession hbmSession;
    
    public CustomerCategoryDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(CustomerCategory customerCategory){   
        try{
            String acronim = "CUSCTG";
            DetachedCriteria dc = DetachedCriteria.forClass(CustomerCategory.class)
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
                concat_qry="AND mst_customer_category.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_customer_category "
                + "WHERE mst_customer_category.code LIKE '%"+code+"%' "
                + "AND mst_customer_category.name LIKE '%"+name+"%' "
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
    
    public CustomerCategoryTemp findData(String code) {
        try {
            CustomerCategoryTemp customerCategoryTemp = (CustomerCategoryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_customer_category.Code, "
                + "mst_customer_category.name, "
                + "mst_customer_category.activeStatus, "
                + "mst_customer_category.remark, "
                + "mst_customer_category.InActiveBy, "
                + "mst_customer_category.InActiveDate, "
                + "mst_customer_category.CreatedBy, "
                + "mst_customer_category.CreatedDate "
                + "FROM mst_customer_category "
                + "WHERE mst_customer_category.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(CustomerCategoryTemp.class))
                .uniqueResult(); 
                 
                return customerCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerCategoryTemp findData(String code,boolean active) {
        try {
            CustomerCategoryTemp customerCategoryTemp = (CustomerCategoryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_customer_category.Code, "
                + "mst_customer_category.name, "
                + "mst_customer_category.remark "
                + "FROM mst_customer_category "
                + "WHERE mst_customer_category.code ='"+code+"' "
                + "AND mst_customer_category.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerCategoryTemp.class))
                .uniqueResult(); 
                 
                return customerCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<CustomerCategoryTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_customer_category.ActiveStatus="+active+" ";
            }
            List<CustomerCategoryTemp> list = (List<CustomerCategoryTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_customer_category.Code, "
                + "mst_customer_category.name, "
                + "mst_customer_category.remark, "
                + "mst_customer_category.ActiveStatus "
                + "FROM mst_customer_category "
                + "WHERE mst_customer_category.code LIKE '%"+code+"%' "
                + "AND mst_customer_category.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CustomerCategoryTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(CustomerCategory customerCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            customerCategory.setCode(createCode(customerCategory));
            if(customerCategory.isActiveStatus()){
                customerCategory.setInActiveBy("");                
            }else{
                customerCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                customerCategory.setInActiveDate(new Date());
            }
            
            customerCategory.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerCategory.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(customerCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    customerCategory.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(CustomerCategory customerCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(customerCategory.isActiveStatus()){
                customerCategory.setInActiveBy("");                
            }else{
                customerCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                customerCategory.setInActiveDate(new Date());
            }
            customerCategory.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerCategory.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(customerCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    customerCategory.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CustomerCategoryField.BEAN_NAME + " WHERE " + CustomerCategoryField.CODE + " = :prmCode")
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
