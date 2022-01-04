

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

import com.inkombizz.master.model.ItemPlates;
import com.inkombizz.master.model.ItemPlatesTemp;
import com.inkombizz.master.model.ItemPlatesField;
import com.inkombizz.master.model.ItemPlates;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class ItemPlatesDAO {
    
    private HBMSession hbmSession;
    
    public ItemPlatesDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemPlates itemPlates){   
        try{
            String acronim = "PLT";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemPlates.class)
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
    public List <ItemPlates> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_plates.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_plates "
                + "WHERE mst_item_plates.code LIKE '%"+code+"%' "
                + "AND mst_item_plates.name LIKE '%"+name+"%' "
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
    
    public ItemPlatesTemp findData(String code) {
        try {
            ItemPlatesTemp itemPlatesTemp = (ItemPlatesTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_plates.Code, "
                + "mst_item_plates.name, "
                + "mst_item_plates.activeStatus, "
                + "mst_item_plates.remark, "
                + "mst_item_plates.InActiveBy, "
                + "mst_item_plates.InActiveDate, "
                + "mst_item_plates.CreatedBy, "
                + "mst_item_plates.CreatedDate "
                + "FROM mst_item_plates "
                + "WHERE mst_item_plates.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemPlatesTemp.class))
                .uniqueResult(); 
                 
                return itemPlatesTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemPlatesTemp findData(String code,boolean active) {
        try {
            ItemPlatesTemp itemPlatesTemp = (ItemPlatesTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_plates.Code, "
                + "mst_item_plates.name, "
                + "mst_item_plates.remark "
                + "FROM mst_item_plates "
                + "WHERE mst_item_plates.code ='"+code+"' "
                + "AND mst_item_plates.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemPlatesTemp.class))
                .uniqueResult(); 
                 
                return itemPlatesTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemPlatesTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_plates.ActiveStatus="+active+" ";
            }
            List<ItemPlatesTemp> list = (List<ItemPlatesTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_plates.Code, "
                + "mst_item_plates.name, "
                + "mst_item_plates.remark, "
                + "mst_item_plates.ActiveStatus "
                + "FROM mst_item_plates "
                + "WHERE mst_item_plates.code LIKE '%"+code+"%' "
                + "AND mst_item_plates.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemPlatesTemp.class))
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
    
    public void save(ItemPlates itemPlates, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemPlates.setCode(createCode(itemPlates));
            if(itemPlates.isActiveStatus()){
                itemPlates.setInActiveBy("");                
            }else{
                itemPlates.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemPlates.setInActiveDate(new Date());
            }
            
            itemPlates.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemPlates.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemPlates);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemPlates.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemPlates itemPlates, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemPlates.isActiveStatus()){
                itemPlates.setInActiveBy("");                
            }else{
                itemPlates.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemPlates.setInActiveDate(new Date());
            }
            itemPlates.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemPlates.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemPlates);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemPlates.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemPlatesField.BEAN_NAME + " WHERE " + ItemPlatesField.CODE + " = :prmCode")
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
