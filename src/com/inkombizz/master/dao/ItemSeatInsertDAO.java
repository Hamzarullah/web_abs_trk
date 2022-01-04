

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

import com.inkombizz.master.model.ItemSeatInsert;
import com.inkombizz.master.model.ItemSeatInsertTemp;
import com.inkombizz.master.model.ItemSeatInsertField;
import org.hibernate.criterion.Restrictions;



public class ItemSeatInsertDAO {
    
    private HBMSession hbmSession;
    
    public ItemSeatInsertDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemSeatInsert itemSeatInsert){   
        try{
            String acronim = "STINS";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemSeatInsert.class)
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
                concat_qry="AND mst_item_seat_insert.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_seat_insert "
                + "WHERE mst_item_seat_insert.code LIKE '%"+code+"%' "
                + "AND mst_item_seat_insert.name LIKE '%"+name+"%' "
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
    
    public ItemSeatInsertTemp findData(String code) {
        try {
            ItemSeatInsertTemp itemSeatInsertTemp = (ItemSeatInsertTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seat_insert.Code, "
                + "mst_item_seat_insert.name, "
                + "mst_item_seat_insert.activeStatus, "
                + "mst_item_seat_insert.remark, "
                + "mst_item_seat_insert.InActiveBy, "
                + "mst_item_seat_insert.InActiveDate, "
                + "mst_item_seat_insert.CreatedBy, "
                + "mst_item_seat_insert.CreatedDate "
                + "FROM mst_item_seat_insert "
                + "WHERE mst_item_seat_insert.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemSeatInsertTemp.class))
                .uniqueResult(); 
                 
                return itemSeatInsertTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemSeatInsertTemp findData(String code,boolean active) {
        try {
            ItemSeatInsertTemp itemSeatInsertTemp = (ItemSeatInsertTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seat_insert.Code, "
                + "mst_item_seat_insert.name, "
                + "mst_item_seat_insert.remark "
                + "FROM mst_item_seat_insert "
                + "WHERE mst_item_seat_insert.code ='"+code+"' "
                + "AND mst_item_seat_insert.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemSeatInsertTemp.class))
                .uniqueResult(); 
                 
                return itemSeatInsertTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemSeatInsertTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_seat_insert.ActiveStatus="+active+" ";
            }
            List<ItemSeatInsertTemp> list = (List<ItemSeatInsertTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seat_insert.Code, "
                + "mst_item_seat_insert.name, "
                + "mst_item_seat_insert.remark, "
                + "mst_item_seat_insert.ActiveStatus "
                + "FROM mst_item_seat_insert "
                + "WHERE mst_item_seat_insert.code LIKE '%"+code+"%' "
                + "AND mst_item_seat_insert.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemSeatInsertTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemSeatInsert itemSeatInsert, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemSeatInsert.setCode(createCode(itemSeatInsert));
            if(itemSeatInsert.isActiveStatus()){
                itemSeatInsert.setInActiveBy("");                
            }else{
                itemSeatInsert.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSeatInsert.setInActiveDate(new Date());
            }
            
            itemSeatInsert.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemSeatInsert.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemSeatInsert);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemSeatInsert.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemSeatInsert itemSeatInsert, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemSeatInsert.isActiveStatus()){
                itemSeatInsert.setInActiveBy("");                
            }else{
                itemSeatInsert.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSeatInsert.setInActiveDate(new Date());
            }
            itemSeatInsert.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemSeatInsert.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemSeatInsert);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemSeatInsert.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemSeatInsertField.BEAN_NAME + " WHERE " + ItemSeatInsertField.CODE + " = :prmCode")
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
