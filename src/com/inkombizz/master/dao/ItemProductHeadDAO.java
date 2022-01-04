
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.ItemProductHead;
import com.inkombizz.master.model.ItemProductHeadField;
import com.inkombizz.master.model.ItemProductHeadTemp;


public class ItemProductHeadDAO {
    
    private HBMSession hbmSession;

    public ItemProductHeadDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <ItemProductHead> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<ItemProductHead> findByCriteria(DetachedCriteria dc) {
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
    
    public ItemProductHead get(String id) {
        try {
            return (ItemProductHead) hbmSession.hSession.get(ItemProductHead.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public ItemProductHeadTemp findData(String code,boolean active) {
        try {
               ItemProductHeadTemp itemProductHeadTemp = (ItemProductHeadTemp) hbmSession.hSession.createSQLQuery(
                   "SELECT" 
                + "mst_item_product_category.Code,"
                + "mst_item_product_category.Name, "
                + "mst_item_product_category.ItemDivisionCode," 
                + "mst_item_division.Name AS ItemDivisionName," 
                + "mst_item_product_category.Remark, "
                + "mst_item_product_category.InActiveBy, "
                + "mst_item_product_category.InActiveDate, "
                + "mst_item_product_category.ActiveStatus, "
                + "mst_item_product_category.CreatedBy, "
                + "mst_item_product_category.CreatedDate "
                + "FROM mst_item_product_category "
                + "INNER JOIN mst_item_division ON mst_item_product_category.ItemDivisionCode = mst_item_division.Code "
                + "WHERE mst_item_product_category.Code ='"+code+"'"
                + "AND mst_item_product_category.ActiveStatus="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)
                .addScalar("itemDivisionName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemProductHeadTemp.class))
                .uniqueResult(); 
                 
                return itemProductHeadTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public void save(ItemProductHead itemProductHead, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            itemProductHead.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemProductHead.setCreatedDate(new Date()); 
//            itemProductHead.setItemProductHeadCode(BaseSession.loadProgramSession().getItemProductHeadCode());
//            String Id = itemProductHead.getCode();
//            itemProductHead.setId(Id);
            hbmSession.hSession.save(itemProductHead);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    itemProductHead.getCode(), moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(ItemProductHead itemProductHead, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.update(itemProductHead);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    itemProductHead.getCode(), moduleCode));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemProductHeadField.BEAN_NAME + " WHERE " + ItemProductHeadField.CODE + " = :prmCode")
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
    
    public ItemProductHeadTemp getMin() {
        try {
            
            String qry = "SELECT mst_item_product_category.Code,mst_item_product_category.Name FROM mst_item_product_category ORDER BY mst_item_product_category.Code LIMIT 0,1";
            ItemProductHeadTemp companyTemp =(ItemProductHeadTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ItemProductHeadTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemProductHeadTemp getMax() {
        try {
            
            String qry = "SELECT mst_item_product_category.Code,mst_item_product_category.Name FROM mst_item_product_category ORDER BY mst_item_product_category.Code DESC LIMIT 0,1";
            ItemProductHeadTemp companyTemp =(ItemProductHeadTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ItemProductHeadTemp.class))
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
