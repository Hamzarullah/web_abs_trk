

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

import com.inkombizz.master.model.ItemSeal;
import com.inkombizz.master.model.ItemSealTemp;
import com.inkombizz.master.model.ItemSealField;
import org.hibernate.criterion.Restrictions;



public class ItemSealDAO {
    
    private HBMSession hbmSession;
    
    public ItemSealDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemSeal itemSeal){   
        try{
            String acronim = "SEAL";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemSeal.class)
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
                concat_qry="AND mst_item_seal.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_seal "
                + "WHERE mst_item_seal.code LIKE '%"+code+"%' "
                + "AND mst_item_seal.name LIKE '%"+name+"%' "
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
    
    public ItemSealTemp findData(String code) {
        try {
            ItemSealTemp itemSealTemp = (ItemSealTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seal.Code, "
                + "mst_item_seal.name, "
                + "mst_item_seal.activeStatus, "
                + "mst_item_seal.remark, "
                + "mst_item_seal.InActiveBy, "
                + "mst_item_seal.InActiveDate, "
                + "mst_item_seal.CreatedBy, "
                + "mst_item_seal.CreatedDate "
                + "FROM mst_item_seal "
                + "WHERE mst_item_seal.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemSealTemp.class))
                .uniqueResult(); 
                 
                return itemSealTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemSealTemp findData(String code,boolean active) {
        try {
            ItemSealTemp itemSealTemp = (ItemSealTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seal.Code, "
                + "mst_item_seal.name, "
                + "mst_item_seal.remark "
                + "FROM mst_item_seal "
                + "WHERE mst_item_seal.code ='"+code+"' "
                + "AND mst_item_seal.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemSealTemp.class))
                .uniqueResult(); 
                 
                return itemSealTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemSealTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_seal.ActiveStatus="+active+" ";
            }
            List<ItemSealTemp> list = (List<ItemSealTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_seal.Code, "
                + "mst_item_seal.name, "
                + "mst_item_seal.remark, "
                + "mst_item_seal.ActiveStatus "
                + "FROM mst_item_seal "
                + "WHERE mst_item_seal.code LIKE '%"+code+"%' "
                + "AND mst_item_seal.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemSealTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemSeal itemSeal, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemSeal.setCode(createCode(itemSeal));
            if(itemSeal.isActiveStatus()){
                itemSeal.setInActiveBy("");                
            }else{
                itemSeal.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSeal.setInActiveDate(new Date());
            }
            
            itemSeal.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemSeal.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemSeal);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemSeal.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemSeal itemSeal, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemSeal.isActiveStatus()){
                itemSeal.setInActiveBy("");                
            }else{
                itemSeal.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSeal.setInActiveDate(new Date());
            }
            itemSeal.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemSeal.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemSeal);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemSeal.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemSealField.BEAN_NAME + " WHERE " + ItemSealField.CODE + " = :prmCode")
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
