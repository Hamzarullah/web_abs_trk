

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

import com.inkombizz.master.model.ItemSeatDesign;
import com.inkombizz.master.model.ItemSeatDesignTemp;
import com.inkombizz.master.model.ItemSeatDesignField;
import org.hibernate.criterion.Restrictions;



public class ItemSeatDesignDAO {
    
    private HBMSession hbmSession;
    
    public ItemSeatDesignDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemSeatDesign itemSeatDesign){   
        try{
            String acronim = "STDSG";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemSeatDesign.class)
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
                concat_qry="AND mst_item_seat_design.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_seat_design "
                + "WHERE mst_item_seat_design.code LIKE '%"+code+"%' "
                + "AND mst_item_seat_design.name LIKE '%"+name+"%' "
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
    
    public ItemSeatDesignTemp findData(String code) {
        try {
            ItemSeatDesignTemp itemSeatDesignTemp = (ItemSeatDesignTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seat_design.Code, "
                + "mst_item_seat_design.name, "
                + "mst_item_seat_design.activeStatus, "
                + "mst_item_seat_design.remark, "
                + "mst_item_seat_design.InActiveBy, "
                + "mst_item_seat_design.InActiveDate, "
                + "mst_item_seat_design.CreatedBy, "
                + "mst_item_seat_design.CreatedDate "
                + "FROM mst_item_seat_design "
                + "WHERE mst_item_seat_design.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemSeatDesignTemp.class))
                .uniqueResult(); 
                 
                return itemSeatDesignTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemSeatDesignTemp findData(String code,boolean active) {
        try {
            ItemSeatDesignTemp itemSeatDesignTemp = (ItemSeatDesignTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seat_design.Code, "
                + "mst_item_seat_design.name, "
                + "mst_item_seat_design.remark "
                + "FROM mst_item_seat_design "
                + "WHERE mst_item_seat_design.code ='"+code+"' "
                + "AND mst_item_seat_design.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemSeatDesignTemp.class))
                .uniqueResult(); 
                 
                return itemSeatDesignTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemSeatDesignTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_seat_design.ActiveStatus="+active+" ";
            }
            List<ItemSeatDesignTemp> list = (List<ItemSeatDesignTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seat_design.Code, "
                + "mst_item_seat_design.name, "
                + "mst_item_seat_design.remark, "
                + "mst_item_seat_design.ActiveStatus "
                + "FROM mst_item_seat_design "
                + "WHERE mst_item_seat_design.code LIKE '%"+code+"%' "
                + "AND mst_item_seat_design.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemSeatDesignTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemSeatDesign itemSeatDesign, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemSeatDesign.setCode(createCode(itemSeatDesign));
            if(itemSeatDesign.isActiveStatus()){
                itemSeatDesign.setInActiveBy("");                
            }else{
                itemSeatDesign.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSeatDesign.setInActiveDate(new Date());
            }
            
            itemSeatDesign.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemSeatDesign.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemSeatDesign);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemSeatDesign.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemSeatDesign itemSeatDesign, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemSeatDesign.isActiveStatus()){
                itemSeatDesign.setInActiveBy("");                
            }else{
                itemSeatDesign.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSeatDesign.setInActiveDate(new Date());
            }
            itemSeatDesign.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemSeatDesign.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemSeatDesign);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemSeatDesign.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemSeatDesignField.BEAN_NAME + " WHERE " + ItemSeatDesignField.CODE + " = :prmCode")
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
