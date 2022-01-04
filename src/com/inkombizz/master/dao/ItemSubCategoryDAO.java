

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
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.ItemSubCategory;
import com.inkombizz.master.model.ItemSubCategoryTemp;
import com.inkombizz.master.model.ItemSubCategoryField;
import org.hibernate.criterion.Restrictions;



public class ItemSubCategoryDAO {
    
    private HBMSession hbmSession;
    
    public ItemSubCategoryDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(ItemSubCategory itemSubCategory){   
        try{
            String acronim = "ITMSUB";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemSubCategory.class)
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
                concat_qry="AND mst_item_sub_category.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_sub_category "
                + "WHERE mst_item_sub_category.code LIKE '%"+code+"%' "
                + "AND mst_item_sub_category.name LIKE '%"+name+"%' "
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
    
    public ItemSubCategoryTemp findData(String code) {
        try {
            ItemSubCategoryTemp itemSubCategoryTemp = (ItemSubCategoryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_sub_category.code, "
                + "mst_item_sub_category.name, "
                + "mst_item_category.code AS itemCategoryCode, "
                + "mst_item_category.name AS itemCategoryName, "
                + "mst_item_sub_category.activeStatus, "
                + "mst_item_sub_category.remark, "
                + "mst_item_sub_category.InActiveBy, "
                + "mst_item_sub_category.InActiveDate, "
                + "mst_item_sub_category.CreatedBy, "
                + "mst_item_sub_category.CreatedDate "
                + "FROM mst_item_sub_category "
                + "INNER JOIN mst_item_category ON mst_item_category.code = mst_item_sub_category.itemCategoryCode "                       
                + "WHERE mst_item_sub_category.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemSubCategoryTemp.class))
                .uniqueResult(); 
                 
                return itemSubCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemSubCategoryTemp findData(String code,boolean active) {
        try {
            ItemSubCategoryTemp itemSubCategoryTemp = (ItemSubCategoryTemp)hbmSession.hSession.createSQLQuery(
                     "SELECT "
                + "mst_item_sub_category.code, "
                + "mst_item_sub_category.name, "
                + "mst_item_category.code AS itemCategoryCode, "
                + "mst_item_category.name AS itemCategoryName, "
                + "mst_item_division.`Code` AS itemDivisionCode, "
                + "mst_item_division.`Name` AS itemDivisionName, "
                + "mst_item_sub_category.activeStatus, "
                + "mst_item_sub_category.remark, "
                + "mst_item_sub_category.InActiveBy, "
                + "mst_item_sub_category.InActiveDate, "
                + "mst_item_sub_category.CreatedBy, "
                + "mst_item_sub_category.CreatedDate "
                + "FROM mst_item_sub_category "
                + "INNER JOIN mst_item_category ON mst_item_category.code = mst_item_sub_category.itemCategoryCode "               
                + " LEFT JOIN mst_item_division ON mst_item_division.Code = mst_item_category.ItemDivisionCode "               
                + "WHERE mst_item_sub_category.code ='"+code+"' "
                + "AND mst_item_sub_category.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)  
                .addScalar("itemDivisionCode", Hibernate.STRING)  
                .addScalar("itemDivisionName", Hibernate.STRING)  
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemSubCategoryTemp.class))
                .uniqueResult(); 
                 
                return itemSubCategoryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemSubCategoryTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_sub_category.ActiveStatus="+active+" ";
            }
            List<ItemSubCategoryTemp> list = (List<ItemSubCategoryTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_sub_category.code, "
                + "mst_item_sub_category.name, "
                + "mst_item_category.code AS itemCategoryCode, "
                + "mst_item_category.name AS itemCategoryName, "
                + "mst_item_division.`Code` AS itemDivisionCode, " 
                + "mst_item_division.`Name` AS itemDivisionName,"            
                + "mst_item_sub_category.activeStatus, "
                + "mst_item_sub_category.remark, "
                + "mst_item_sub_category.InActiveBy, "
                + "mst_item_sub_category.InActiveDate, "
                + "mst_item_sub_category.CreatedBy, "
                + "mst_item_sub_category.CreatedDate "
                + "FROM mst_item_sub_category "
                + "INNER JOIN mst_item_category ON mst_item_category.code = mst_item_sub_category.itemCategoryCode "  
                + "LEFT JOIN mst_item_division ON mst_item_division.Code = mst_item_category.ItemDivisionCode "           
                + "WHERE mst_item_sub_category.code LIKE '%"+code+"%' "
                + "AND mst_item_sub_category.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("itemCategoryCode", Hibernate.STRING)
                .addScalar("itemCategoryName", Hibernate.STRING)
                .addScalar("itemDivisionCode", Hibernate.STRING)    
                .addScalar("itemDivisionName", Hibernate.STRING)    
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemSubCategoryTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemSubCategory itemSubCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemSubCategory.setCode(createCode(itemSubCategory));
            if(itemSubCategory.isActiveStatus()){
                itemSubCategory.setInActiveBy("");                
            }else{
                itemSubCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSubCategory.setInActiveDate(new Date());
            }
            
            itemSubCategory.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemSubCategory.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemSubCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemSubCategory.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemSubCategory itemSubCategory, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemSubCategory.isActiveStatus()){
                itemSubCategory.setInActiveBy("");                
            }else{
                itemSubCategory.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSubCategory.setInActiveDate(new Date());
            }
            itemSubCategory.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemSubCategory.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemSubCategory);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemSubCategory.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemSubCategoryField.BEAN_NAME + " WHERE " + ItemSubCategoryField.CODE + " = :prmCode")
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
