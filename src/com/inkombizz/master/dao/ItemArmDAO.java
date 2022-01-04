

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
import com.inkombizz.master.model.ItemArmTemp;
import com.inkombizz.master.model.ItemArmField;
import com.inkombizz.master.model.ItemArm;
import org.hibernate.criterion.Restrictions;



public class ItemArmDAO {
    
    private HBMSession hbmSession;
    
    public ItemArmDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemArm itemArm){   
        try{
            String acronim = "ARM";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemArm.class)
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
    public List <ItemArm> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_arm.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_arm "
                + "WHERE mst_item_arm.code LIKE '%"+code+"%' "
                + "AND mst_item_arm.name LIKE '%"+name+"%' "
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
    
    public ItemArmTemp findData(String code) {
        try {
            ItemArmTemp itemArmTemp = (ItemArmTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_arm.Code, "
                + "mst_item_arm.name, "
                + "mst_item_arm.activeStatus, "
                + "mst_item_arm.remark, "
                + "mst_item_arm.InActiveBy, "
                + "mst_item_arm.InActiveDate, "
                + "mst_item_arm.CreatedBy, "
                + "mst_item_arm.CreatedDate "
                + "FROM mst_item_arm "
                + "WHERE mst_item_arm.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemArmTemp.class))
                .uniqueResult(); 
                 
                return itemArmTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemArmTemp findData(String code,boolean active) {
        try {
            ItemArmTemp itemArmTemp = (ItemArmTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_arm.Code, "
                + "mst_item_arm.name, "
                + "mst_item_arm.remark "
                + "FROM mst_item_arm "
                + "WHERE mst_item_arm.code ='"+code+"' "
                + "AND mst_item_arm.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemArmTemp.class))
                .uniqueResult(); 
                 
                return itemArmTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemArmTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_arm.ActiveStatus="+active+" ";
            }
            List<ItemArmTemp> list = (List<ItemArmTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_arm.Code, "
                + "mst_item_arm.name, "
                + "mst_item_arm.remark, "
                + "mst_item_arm.ActiveStatus "
                + "FROM mst_item_arm "
                + "WHERE mst_item_arm.code LIKE '%"+code+"%' "
                + "AND mst_item_arm.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemArmTemp.class))
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
    
    public void save(ItemArm itemArm, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemArm.setCode(createCode(itemArm));
            if(itemArm.isActiveStatus()){
                itemArm.setInActiveBy("");                
            }else{
                itemArm.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemArm.setInActiveDate(new Date());
            }
            
            itemArm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemArm.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemArm);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemArm.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemArm itemArm, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemArm.isActiveStatus()){
                itemArm.setInActiveBy("");                
            }else{
                itemArm.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemArm.setInActiveDate(new Date());
            }
            itemArm.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemArm.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemArm);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemArm.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemArmField.BEAN_NAME + " WHERE " + ItemArmField.CODE + " = :prmCode")
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
