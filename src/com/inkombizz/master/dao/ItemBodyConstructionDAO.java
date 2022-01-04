

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

import com.inkombizz.master.model.ItemBodyConstruction;
import com.inkombizz.master.model.ItemBodyConstructionTemp;
import com.inkombizz.master.model.ItemBodyConstructionField;
import com.inkombizz.master.model.ItemBodyConstruction;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class ItemBodyConstructionDAO {
    
    private HBMSession hbmSession;
    
    public ItemBodyConstructionDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemBodyConstruction itemBodyConstruction){   
        try{
            String acronim = "BDYCTR";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemBodyConstruction.class)
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
    public List <ItemBodyConstruction> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_body_construction.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_body_construction "
                + "WHERE mst_item_body_construction.code LIKE '%"+code+"%' "
                + "AND mst_item_body_construction.name LIKE '%"+name+"%' "
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
    
    public ItemBodyConstructionTemp findData(String code) {
        try {
            ItemBodyConstructionTemp itemBodyConstructionTemp = (ItemBodyConstructionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_body_construction.Code, "
                + "mst_item_body_construction.name, "
                + "mst_item_body_construction.activeStatus, "
                + "mst_item_body_construction.remark, "
                + "mst_item_body_construction.InActiveBy, "
                + "mst_item_body_construction.InActiveDate, "
                + "mst_item_body_construction.CreatedBy, "
                + "mst_item_body_construction.CreatedDate "
                + "FROM mst_item_body_construction "
                + "WHERE mst_item_body_construction.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemBodyConstructionTemp.class))
                .uniqueResult(); 
                 
                return itemBodyConstructionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemBodyConstructionTemp findData(String code,boolean active) {
        try {
            ItemBodyConstructionTemp itemBodyConstructionTemp = (ItemBodyConstructionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_body_construction.Code, "
                + "mst_item_body_construction.name, "
                + "mst_item_body_construction.remark "
                + "FROM mst_item_body_construction "
                + "WHERE mst_item_body_construction.code ='"+code+"' "
                + "AND mst_item_body_construction.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemBodyConstructionTemp.class))
                .uniqueResult(); 
                 
                return itemBodyConstructionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemBodyConstructionTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_body_construction.ActiveStatus="+active+" ";
            }
            List<ItemBodyConstructionTemp> list = (List<ItemBodyConstructionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_body_construction.Code, "
                + "mst_item_body_construction.name, "
                + "mst_item_body_construction.remark, "
                + "mst_item_body_construction.ActiveStatus "
                + "FROM mst_item_body_construction "
                + "WHERE mst_item_body_construction.code LIKE '%"+code+"%' "
                + "AND mst_item_body_construction.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemBodyConstructionTemp.class))
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
    
    public void save(ItemBodyConstruction itemBodyConstruction, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemBodyConstruction.setCode(createCode(itemBodyConstruction));
            if(itemBodyConstruction.isActiveStatus()){
                itemBodyConstruction.setInActiveBy("");                
            }else{
                itemBodyConstruction.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBodyConstruction.setInActiveDate(new Date());
            }
            
            itemBodyConstruction.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemBodyConstruction.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemBodyConstruction);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemBodyConstruction.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemBodyConstruction itemBodyConstruction, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemBodyConstruction.isActiveStatus()){
                itemBodyConstruction.setInActiveBy("");                
            }else{
                itemBodyConstruction.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBodyConstruction.setInActiveDate(new Date());
            }
            itemBodyConstruction.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemBodyConstruction.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemBodyConstruction);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemBodyConstruction.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemBodyConstructionField.BEAN_NAME + " WHERE " + ItemBodyConstructionField.CODE + " = :prmCode")
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
