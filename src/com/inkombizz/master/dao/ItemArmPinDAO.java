

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
import com.inkombizz.master.model.ItemArmPinTemp;
import com.inkombizz.master.model.ItemArmPinField;
import com.inkombizz.master.model.ItemArmPin;
import org.hibernate.criterion.Restrictions;



public class ItemArmPinDAO {
    
    private HBMSession hbmSession;
    
    public ItemArmPinDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemArmPin itemArmPin){   
        try{
            String acronim = "ARMPIN";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemArmPin.class)
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
    public List <ItemArmPin> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_arm_pin.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_arm_pin "
                + "WHERE mst_item_arm_pin.code LIKE '%"+code+"%' "
                + "AND mst_item_arm_pin.name LIKE '%"+name+"%' "
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
    
    public ItemArmPinTemp findData(String code) {
        try {
            ItemArmPinTemp itemArmPinTemp = (ItemArmPinTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_arm_pin.Code, "
                + "mst_item_arm_pin.name, "
                + "mst_item_arm_pin.activeStatus, "
                + "mst_item_arm_pin.remark, "
                + "mst_item_arm_pin.InActiveBy, "
                + "mst_item_arm_pin.InActiveDate, "
                + "mst_item_arm_pin.CreatedBy, "
                + "mst_item_arm_pin.CreatedDate "
                + "FROM mst_item_arm_pin "
                + "WHERE mst_item_arm_pin.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemArmPinTemp.class))
                .uniqueResult(); 
                 
                return itemArmPinTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemArmPinTemp findData(String code,boolean active) {
        try {
            ItemArmPinTemp itemArmPinTemp = (ItemArmPinTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_arm_pin.Code, "
                + "mst_item_arm_pin.name, "
                + "mst_item_arm_pin.remark "
                + "FROM mst_item_arm_pin "
                + "WHERE mst_item_arm_pin.code ='"+code+"' "
                + "AND mst_item_arm_pin.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemArmPinTemp.class))
                .uniqueResult(); 
                 
                return itemArmPinTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemArmPinTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_arm_pin.ActiveStatus="+active+" ";
            }
            List<ItemArmPinTemp> list = (List<ItemArmPinTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_arm_pin.Code, "
                + "mst_item_arm_pin.name, "
                + "mst_item_arm_pin.remark, "
                + "mst_item_arm_pin.ActiveStatus "
                + "FROM mst_item_arm_pin "
                + "WHERE mst_item_arm_pin.code LIKE '%"+code+"%' "
                + "AND mst_item_arm_pin.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemArmPinTemp.class))
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
    
    public void save(ItemArmPin itemArmPin, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemArmPin.setCode(createCode(itemArmPin));
            if(itemArmPin.isActiveStatus()){
                itemArmPin.setInActiveBy("");                
            }else{
                itemArmPin.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemArmPin.setInActiveDate(new Date());
            }
            
            itemArmPin.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemArmPin.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemArmPin);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemArmPin.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemArmPin itemArmPin, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemArmPin.isActiveStatus()){
                itemArmPin.setInActiveBy("");                
            }else{
                itemArmPin.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemArmPin.setInActiveDate(new Date());
            }
            itemArmPin.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemArmPin.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemArmPin);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemArmPin.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemArmPinField.BEAN_NAME + " WHERE " + ItemArmPinField.CODE + " = :prmCode")
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
