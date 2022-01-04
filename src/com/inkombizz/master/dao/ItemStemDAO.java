

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

import com.inkombizz.master.model.ItemStem;
import com.inkombizz.master.model.ItemStemTemp;
import com.inkombizz.master.model.ItemStemField;
import org.hibernate.criterion.Restrictions;



public class ItemStemDAO {
    
    private HBMSession hbmSession;
    
    public ItemStemDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemStem itemStem){   
        try{
            String acronim = "STM";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemStem.class)
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
                concat_qry="AND mst_item_stem.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_stem "
                + "WHERE mst_item_stem.code LIKE '%"+code+"%' "
                + "AND mst_item_stem.name LIKE '%"+name+"%' "
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
    
    public ItemStemTemp findData(String code) {
        try {
            ItemStemTemp itemStemTemp = (ItemStemTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_stem.Code, "
                + "mst_item_stem.name, "
                + "mst_item_stem.activeStatus, "
                + "mst_item_stem.remark, "
                + "mst_item_stem.InActiveBy, "
                + "mst_item_stem.InActiveDate, "
                + "mst_item_stem.CreatedBy, "
                + "mst_item_stem.CreatedDate "
                + "FROM mst_item_stem "
                + "WHERE mst_item_stem.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemStemTemp.class))
                .uniqueResult(); 
                 
                return itemStemTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemStemTemp findData(String code,boolean active) {
        try {
            ItemStemTemp itemStemTemp = (ItemStemTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_stem.Code, "
                + "mst_item_stem.name, "
                + "mst_item_stem.remark "
                + "FROM mst_item_stem "
                + "WHERE mst_item_stem.code ='"+code+"' "
                + "AND mst_item_stem.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemStemTemp.class))
                .uniqueResult(); 
                 
                return itemStemTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemStemTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_stem.ActiveStatus="+active+" ";
            }
            List<ItemStemTemp> list = (List<ItemStemTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_stem.Code, "
                + "mst_item_stem.name, "
                + "mst_item_stem.remark, "
                + "mst_item_stem.ActiveStatus "
                + "FROM mst_item_stem "
                + "WHERE mst_item_stem.code LIKE '%"+code+"%' "
                + "AND mst_item_stem.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemStemTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemStem itemStem, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemStem.setCode(createCode(itemStem));
            if(itemStem.isActiveStatus()){
                itemStem.setInActiveBy("");                
            }else{
                itemStem.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemStem.setInActiveDate(new Date());
            }
            
            itemStem.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemStem.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemStem);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemStem.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemStem itemStem, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemStem.isActiveStatus()){
                itemStem.setInActiveBy("");                
            }else{
                itemStem.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemStem.setInActiveDate(new Date());
            }
            itemStem.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemStem.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemStem);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemStem.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemStemField.BEAN_NAME + " WHERE " + ItemStemField.CODE + " = :prmCode")
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
