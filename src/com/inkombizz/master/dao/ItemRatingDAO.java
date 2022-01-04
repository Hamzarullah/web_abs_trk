

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

import com.inkombizz.master.model.ItemRating;
import com.inkombizz.master.model.ItemRatingTemp;
import com.inkombizz.master.model.ItemRatingField;
import org.hibernate.criterion.Restrictions;



public class ItemRatingDAO {
    
    private HBMSession hbmSession;
    
    public ItemRatingDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemRating itemRating){   
        try{
            String acronim = "RTG";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemRating.class)
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
                concat_qry="AND mst_item_rating.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_rating "
                + "WHERE mst_item_rating.code LIKE '%"+code+"%' "
                + "AND mst_item_rating.name LIKE '%"+name+"%' "
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
    
    public ItemRatingTemp findData(String code) {
        try {
            ItemRatingTemp itemRatingTemp = (ItemRatingTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_rating.Code, "
                + "mst_item_rating.name, "
                + "mst_item_rating.activeStatus, "
                + "mst_item_rating.remark, "
                + "mst_item_rating.InActiveBy, "
                + "mst_item_rating.InActiveDate, "
                + "mst_item_rating.CreatedBy, "
                + "mst_item_rating.CreatedDate "
                + "FROM mst_item_rating "
                + "WHERE mst_item_rating.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemRatingTemp.class))
                .uniqueResult(); 
                 
                return itemRatingTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemRatingTemp findData(String code,boolean active) {
        try {
            ItemRatingTemp itemRatingTemp = (ItemRatingTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_rating.Code, "
                + "mst_item_rating.name, "
                + "mst_item_rating.remark "
                + "FROM mst_item_rating "
                + "WHERE mst_item_rating.code ='"+code+"' "
                + "AND mst_item_rating.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemRatingTemp.class))
                .uniqueResult(); 
                 
                return itemRatingTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemRatingTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_rating.ActiveStatus="+active+" ";
            }
            List<ItemRatingTemp> list = (List<ItemRatingTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_rating.Code, "
                + "mst_item_rating.name, "
                + "mst_item_rating.remark, "
                + "mst_item_rating.ActiveStatus "
                + "FROM mst_item_rating "
                + "WHERE mst_item_rating.code LIKE '%"+code+"%' "
                + "AND mst_item_rating.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemRatingTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemRating itemRating, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemRating.setCode(createCode(itemRating));
            if(itemRating.isActiveStatus()){
                itemRating.setInActiveBy("");                
            }else{
                itemRating.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemRating.setInActiveDate(new Date());
            }
            
            itemRating.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemRating.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemRating);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemRating.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemRating itemRating, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemRating.isActiveStatus()){
                itemRating.setInActiveBy("");                
            }else{
                itemRating.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemRating.setInActiveDate(new Date());
            }
            itemRating.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemRating.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemRating);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemRating.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemRatingField.BEAN_NAME + " WHERE " + ItemRatingField.CODE + " = :prmCode")
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
