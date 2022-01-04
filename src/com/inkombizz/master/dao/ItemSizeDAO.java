

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

import com.inkombizz.master.model.ItemSize;
import com.inkombizz.master.model.ItemSizeTemp;
import com.inkombizz.master.model.ItemSizeField;
import org.hibernate.criterion.Restrictions;



public class ItemSizeDAO {
    
    private HBMSession hbmSession;
    
    public ItemSizeDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemSize itemSize){   
        try{
            String acronim = "SIZE";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemSize.class)
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
                concat_qry="AND mst_item_size.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_size "
                + "WHERE mst_item_size.code LIKE '%"+code+"%' "
                + "AND mst_item_size.name LIKE '%"+name+"%' "
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
    
    public ItemSizeTemp findData(String code) {
        try {
            ItemSizeTemp itemSizeTemp = (ItemSizeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_size.Code, "
                + "mst_item_size.name, "
                + "mst_item_size.activeStatus, "
                + "mst_item_size.remark, "
                + "mst_item_size.InActiveBy, "
                + "mst_item_size.InActiveDate, "
                + "mst_item_size.CreatedBy, "
                + "mst_item_size.CreatedDate "
                + "FROM mst_item_size "
                + "WHERE mst_item_size.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemSizeTemp.class))
                .uniqueResult(); 
                 
                return itemSizeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemSizeTemp findData(String code,boolean active) {
        try {
            ItemSizeTemp itemSizeTemp = (ItemSizeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_size.Code, "
                + "mst_item_size.name, "
                + "mst_item_size.remark "
                + "FROM mst_item_size "
                + "WHERE mst_item_size.code ='"+code+"' "
                + "AND mst_item_size.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemSizeTemp.class))
                .uniqueResult(); 
                 
                return itemSizeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemSizeTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_size.ActiveStatus="+active+" ";
            }
            List<ItemSizeTemp> list = (List<ItemSizeTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_size.Code, "
                + "mst_item_size.name, "
                + "mst_item_size.remark, "
                + "mst_item_size.ActiveStatus "
                + "FROM mst_item_size "
                + "WHERE mst_item_size.code LIKE '%"+code+"%' "
                + "AND mst_item_size.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemSizeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemSize itemSize, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemSize.setCode(createCode(itemSize));
            if(itemSize.isActiveStatus()){
                itemSize.setInActiveBy("");                
            }else{
                itemSize.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSize.setInActiveDate(new Date());
            }
            
            itemSize.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemSize.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemSize);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemSize.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemSize itemSize, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemSize.isActiveStatus()){
                itemSize.setInActiveBy("");                
            }else{
                itemSize.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemSize.setInActiveDate(new Date());
            }
            itemSize.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemSize.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemSize);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemSize.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemSizeField.BEAN_NAME + " WHERE " + ItemSizeField.CODE + " = :prmCode")
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
