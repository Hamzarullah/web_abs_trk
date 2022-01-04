

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
import com.inkombizz.master.model.ItemHingePinTemp;
import com.inkombizz.master.model.ItemHingePinField;
import com.inkombizz.master.model.ItemHingePin;
import org.hibernate.criterion.Restrictions;



public class ItemHingePinDAO {
    
    private HBMSession hbmSession;
    
    public ItemHingePinDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemHingePin itemHingePin){   
        try{
            String acronim = "ARMPIN";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemHingePin.class)
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
    public List <ItemHingePin> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_hinge_pin.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_hinge_pin "
                + "WHERE mst_item_hinge_pin.code LIKE '%"+code+"%' "
                + "AND mst_item_hinge_pin.name LIKE '%"+name+"%' "
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
    
    public ItemHingePinTemp findData(String code) {
        try {
            ItemHingePinTemp itemHingePinTemp = (ItemHingePinTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_hinge_pin.Code, "
                + "mst_item_hinge_pin.name, "
                + "mst_item_hinge_pin.activeStatus, "
                + "mst_item_hinge_pin.remark, "
                + "mst_item_hinge_pin.InActiveBy, "
                + "mst_item_hinge_pin.InActiveDate, "
                + "mst_item_hinge_pin.CreatedBy, "
                + "mst_item_hinge_pin.CreatedDate "
                + "FROM mst_item_hinge_pin "
                + "WHERE mst_item_hinge_pin.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemHingePinTemp.class))
                .uniqueResult(); 
                 
                return itemHingePinTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemHingePinTemp findData(String code,boolean active) {
        try {
            ItemHingePinTemp itemHingePinTemp = (ItemHingePinTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_hinge_pin.Code, "
                + "mst_item_hinge_pin.name, "
                + "mst_item_hinge_pin.remark "
                + "FROM mst_item_hinge_pin "
                + "WHERE mst_item_hinge_pin.code ='"+code+"' "
                + "AND mst_item_hinge_pin.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemHingePinTemp.class))
                .uniqueResult(); 
                 
                return itemHingePinTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemHingePinTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_hinge_pin.ActiveStatus="+active+" ";
            }
            List<ItemHingePinTemp> list = (List<ItemHingePinTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_hinge_pin.Code, "
                + "mst_item_hinge_pin.name, "
                + "mst_item_hinge_pin.remark, "
                + "mst_item_hinge_pin.ActiveStatus "
                + "FROM mst_item_hinge_pin "
                + "WHERE mst_item_hinge_pin.code LIKE '%"+code+"%' "
                + "AND mst_item_hinge_pin.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemHingePinTemp.class))
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
    
    public void save(ItemHingePin itemHingePin, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemHingePin.setCode(createCode(itemHingePin));
            if(itemHingePin.isActiveStatus()){
                itemHingePin.setInActiveBy("");                
            }else{
                itemHingePin.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemHingePin.setInActiveDate(new Date());
            }
            
            itemHingePin.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemHingePin.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemHingePin);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemHingePin.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemHingePin itemHingePin, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemHingePin.isActiveStatus()){
                itemHingePin.setInActiveBy("");                
            }else{
                itemHingePin.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemHingePin.setInActiveDate(new Date());
            }
            itemHingePin.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemHingePin.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemHingePin);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemHingePin.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemHingePinField.BEAN_NAME + " WHERE " + ItemHingePinField.CODE + " = :prmCode")
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
