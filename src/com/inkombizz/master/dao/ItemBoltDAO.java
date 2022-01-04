

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.ItemBolt;
import com.inkombizz.master.model.ItemBoltTemp;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class ItemBoltDAO {
    
    private HBMSession hbmSession;
    
    public ItemBoltDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(ItemBolt itemBolt){   
        try{
            String acronim = "BLT";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemBolt.class)
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
                concat_qry="AND mst_item_bolt.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_bolt "
                + "WHERE mst_item_bolt.code LIKE '%"+code+"%' "
                + "AND mst_item_bolt.name LIKE '%"+name+"%' "
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
    
    public ItemBoltTemp findData(String code) {
        try {
            ItemBoltTemp itemBoltTemp = (ItemBoltTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_bolt.Code, "
                + "mst_item_bolt.name, "
                + "mst_item_bolt.activeStatus, "
                + "mst_item_bolt.remark, "
                + "mst_item_bolt.InActiveBy, "
                + "mst_item_bolt.InActiveDate, "
                + "mst_item_bolt.CreatedBy, "
                + "mst_item_bolt.CreatedDate "
                + "FROM mst_item_bolt "
                + "WHERE mst_item_bolt.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemBoltTemp.class))
                .uniqueResult(); 
                 
                return itemBoltTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemBoltTemp findData(String code,boolean active) {
        try {
            ItemBoltTemp itemBoltTemp = (ItemBoltTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_bolt.Code, "
                + "mst_item_bolt.name, "
                + "mst_item_bolt.remark "
                + "FROM mst_item_bolt "
                + "WHERE mst_item_bolt.code ='"+code+"' "
                + "AND mst_item_bolt.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemBoltTemp.class))
                .uniqueResult(); 
                 
                return itemBoltTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemBoltTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_bolt.ActiveStatus="+active+" ";
            }
            List<ItemBoltTemp> list = (List<ItemBoltTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_bolt.Code, "
                + "mst_item_bolt.name, "
                + "mst_item_bolt.remark, "
                + "mst_item_bolt.ActiveStatus "
                + "FROM mst_item_bolt "
                + "WHERE mst_item_bolt.code LIKE '%"+code+"%' "
                + "AND mst_item_bolt.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemBoltTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemBolt itemBolt, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemBolt.setCode(createCode(itemBolt));
            if(itemBolt.isActiveStatus()){
                itemBolt.setInActiveBy("");                
            }else{
                itemBolt.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBolt.setInActiveDate(new Date());
            }
            
            itemBolt.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemBolt.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemBolt);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemBolt.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemBolt itemBolt, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemBolt.isActiveStatus()){
                itemBolt.setInActiveBy("");                
            }else{
                itemBolt.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBolt.setInActiveDate(new Date());
            }
            itemBolt.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemBolt.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemBolt);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemBolt.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemBoltField.BEAN_NAME + " WHERE " + ItemBoltField.CODE + " = :prmCode")
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
