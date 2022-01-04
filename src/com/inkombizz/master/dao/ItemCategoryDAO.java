

package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBoltField;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.ItemCategory;
import com.inkombizz.master.model.ItemCategoryField;
import com.inkombizz.master.model.ItemCategoryTemp;
import java.math.BigInteger;
import org.hibernate.criterion.Restrictions;

public class ItemCategoryDAO {
    
    private HBMSession hbmSession;

    public ItemCategoryDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public String createCode(ItemCategory itemCategory){   
        try{
            String acronim = "ITMCTG";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemCategory.class)
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
    
    
    public List <ItemCategory> findByCriteria(DetachedCriteria dc, int from, int size) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setFirstResult(from);
            criteria.setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ItemCategory> findByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            
            List countData = criteria.list();
            
            if (countData.isEmpty())
                return 0;
            else {
                return  ( Integer.parseInt(countData.get(0).toString()) ) ;
            }
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemCategory get(String id) {
        try {
            return (ItemCategory) hbmSession.hSession.get(ItemCategory.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public ItemCategoryTemp findData(String code,boolean active) {
        try {
               ItemCategoryTemp itemCategoryTemp = (ItemCategoryTemp) hbmSession.hSession.createSQLQuery(
                "SELECT "
                 +"mst_item_category.Code," 
                 +"mst_item_category.Name, "
                 +"mst_item_category.ItemDivisionCode AS itemDivisionCode, "
                 +"mst_item_division.Name AS itemDivisionName, "
                 +"mst_item_category.Remark, "
                 +"mst_item_category.InActiveBy, "
                 +"mst_item_category.InActiveDate, "
                 +"mst_item_category.ActiveStatus, "
                 +"mst_item_category.CreatedBy, "
                 +"mst_item_category.CreatedDate "
                 +"FROM mst_item_category "
                 +"INNER JOIN mst_item_division ON mst_item_category.ItemDivisionCode = mst_item_division.Code "
                 +"WHERE mst_item_category.Code = '"+code+"'"
                 +"AND mst_item_category.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemCategoryTemp.class))
                .uniqueResult(); 
                 
                return itemCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public void save(ItemCategory itemCategory, String moduleCode){
        try {
            hbmSession.hSession.beginTransaction();
            
            itemCategory.setCode(createCode(itemCategory));
            itemCategory.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemCategory.setCreatedDate(new Date()); 
//            itemCategory.setItemCategoryCode(BaseSession.loadProgramSession().getItemCategoryCode());
//            String Id = itemCategory.getCode();
//            itemCategory.setId(Id);
            hbmSession.hSession.save(itemCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    itemCategory.getCode(), moduleCode));
          
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(ItemCategory itemCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemCategory.isActiveStatus()){
                itemCategory.setInActiveBy("");                
            }else{
                itemCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemCategory.setInActiveDate(new Date());
            }
            itemCategory.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemCategory.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    itemCategory.getCode(), moduleCode));
            
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void delete(String id, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + ItemCategoryField.BEAN_NAME + " WHERE " + ItemCategoryField.CODE + " = :prmCode")
                    .setParameter("prmCode", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    } 
    
    public ItemCategoryTemp getMin() {
        try {
            
            String qry = "SELECT mst_item_category.Code, mst_item_category.Name FROM mst_item_category ORDER BY mst_item_category.Code LIMIT 0,1";
            ItemCategoryTemp companyTemp =(ItemCategoryTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ItemCategoryTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemCategoryTemp getMax() {
        try {
            
            String qry = "SELECT mst_item_category.Code, mst_item_category.Name FROM mst_item_category ORDER BY mst_item_category.Code DESC LIMIT 0,1";
            ItemCategoryTemp companyTemp =(ItemCategoryTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ItemCategoryTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
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
