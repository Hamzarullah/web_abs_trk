

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

import com.inkombizz.master.model.ItemShaft;
import com.inkombizz.master.model.ItemShaftTemp;
import com.inkombizz.master.model.ItemShaftField;
import com.inkombizz.master.model.ItemShaft;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class ItemShaftDAO {
    
    private HBMSession hbmSession;
    
    public ItemShaftDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemShaft itemShaft){   
        try{
            String acronim = "SHFT";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemShaft.class)
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
    public List <ItemShaft> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_shaft.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_shaft "
                + "WHERE mst_item_shaft.code LIKE '%"+code+"%' "
                + "AND mst_item_shaft.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
       
//    public int countByCriteria(DetachedCriteria dc) {
//        try {
//            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
//            criteria.setProjection(Projections.rowCount());
//            if (criteria.list().size() == 0)
//            	return 0;
//            else
//            	return ((Integer) criteria.list().get(0)).intValue();
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    public ItemShaftTemp findData(String code) {
        try {
            ItemShaftTemp itemShaftTemp = (ItemShaftTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_shaft.Code, "
                + "mst_item_shaft.name, "
                + "mst_item_shaft.activeStatus, "
                + "mst_item_shaft.remark, "
                + "mst_item_shaft.InActiveBy, "
                + "mst_item_shaft.InActiveDate, "
                + "mst_item_shaft.CreatedBy, "
                + "mst_item_shaft.CreatedDate "
                + "FROM mst_item_shaft "
                + "WHERE mst_item_shaft.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemShaftTemp.class))
                .uniqueResult(); 
                 
                return itemShaftTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemShaftTemp findData(String code,boolean active) {
        try {
            ItemShaftTemp itemShaftTemp = (ItemShaftTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_shaft.Code, "
                + "mst_item_shaft.name, "
                + "mst_item_shaft.remark "
                + "FROM mst_item_shaft "
                + "WHERE mst_item_shaft.code ='"+code+"' "
                + "AND mst_item_shaft.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemShaftTemp.class))
                .uniqueResult(); 
                 
                return itemShaftTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemShaftTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_shaft.ActiveStatus="+active+" ";
            }
            List<ItemShaftTemp> list = (List<ItemShaftTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_shaft.Code, "
                + "mst_item_shaft.name, "
                + "mst_item_shaft.remark, "
                + "mst_item_shaft.ActiveStatus "
                + "FROM mst_item_shaft "
                + "WHERE mst_item_shaft.code LIKE '%"+code+"%' "
                + "AND mst_item_shaft.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemShaftTemp.class))
                .list(); 
                 
                return list;
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
    
    public void save(ItemShaft itemShaft, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemShaft.setCode(createCode(itemShaft));
            if(itemShaft.isActiveStatus()){
                itemShaft.setInActiveBy("");                
            }else{
                itemShaft.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemShaft.setInActiveDate(new Date());
            }
            
            itemShaft.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemShaft.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemShaft);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemShaft.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemShaft itemShaft, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemShaft.isActiveStatus()){
                itemShaft.setInActiveBy("");                
            }else{
                itemShaft.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemShaft.setInActiveDate(new Date());
            }
            itemShaft.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemShaft.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemShaft);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemShaft.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemShaftField.BEAN_NAME + " WHERE " + ItemShaftField.CODE + " = :prmCode")
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
