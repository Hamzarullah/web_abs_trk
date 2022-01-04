

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

import com.inkombizz.master.model.ItemBore;
import com.inkombizz.master.model.ItemBoreTemp;
import com.inkombizz.master.model.ItemBoreField;
import org.hibernate.criterion.Restrictions;



public class ItemBoreDAO {
    
    private HBMSession hbmSession;
    
    public ItemBoreDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemBore itemBore){   
        try{
            String acronim = "BORE";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemBore.class)
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
                concat_qry="AND mst_item_bore.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_bore "
                + "WHERE mst_item_bore.code LIKE '%"+code+"%' "
                + "AND mst_item_bore.name LIKE '%"+name+"%' "
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
    
    public ItemBoreTemp findData(String code) {
        try {
            ItemBoreTemp itemBoreTemp = (ItemBoreTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_bore.Code, "
                + "mst_item_bore.name, "
                + "mst_item_bore.activeStatus, "
                + "mst_item_bore.remark, "
                + "mst_item_bore.InActiveBy, "
                + "mst_item_bore.InActiveDate, "
                + "mst_item_bore.CreatedBy, "
                + "mst_item_bore.CreatedDate "
                + "FROM mst_item_bore "
                + "WHERE mst_item_bore.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemBoreTemp.class))
                .uniqueResult(); 
                 
                return itemBoreTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemBoreTemp findData(String code,boolean active) {
        try {
            ItemBoreTemp itemBoreTemp = (ItemBoreTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_bore.Code, "
                + "mst_item_bore.name, "
                + "mst_item_bore.remark "
                + "FROM mst_item_bore "
                + "WHERE mst_item_bore.code ='"+code+"' "
                + "AND mst_item_bore.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemBoreTemp.class))
                .uniqueResult(); 
                 
                return itemBoreTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemBoreTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_bore.ActiveStatus="+active+" ";
            }
            List<ItemBoreTemp> list = (List<ItemBoreTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_bore.Code, "
                + "mst_item_bore.name, "
                + "mst_item_bore.remark, "
                + "mst_item_bore.ActiveStatus "
                + "FROM mst_item_bore "
                + "WHERE mst_item_bore.code LIKE '%"+code+"%' "
                + "AND mst_item_bore.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemBoreTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemBore itemBore, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemBore.setCode(createCode(itemBore));
            if(itemBore.isActiveStatus()){
                itemBore.setInActiveBy("");                
            }else{
                itemBore.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBore.setInActiveDate(new Date());
            }
            
            itemBore.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemBore.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemBore);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemBore.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemBore itemBore, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemBore.isActiveStatus()){
                itemBore.setInActiveBy("");                
            }else{
                itemBore.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBore.setInActiveDate(new Date());
            }
            itemBore.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemBore.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemBore);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemBore.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemBoreField.BEAN_NAME + " WHERE " + ItemBoreField.CODE + " = :prmCode")
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
