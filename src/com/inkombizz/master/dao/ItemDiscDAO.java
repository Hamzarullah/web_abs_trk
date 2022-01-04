

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

import com.inkombizz.master.model.ItemDisc;
import com.inkombizz.master.model.ItemDiscTemp;
import com.inkombizz.master.model.ItemDiscField;
import com.inkombizz.master.model.ItemDisc;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class ItemDiscDAO {
    
    private HBMSession hbmSession;
    
    public ItemDiscDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemDisc itemDisc){   
        try{
            String acronim = "DISC";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemDisc.class)
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
    public List <ItemDisc> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_disc.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_disc "
                + "WHERE mst_item_disc.code LIKE '%"+code+"%' "
                + "AND mst_item_disc.name LIKE '%"+name+"%' "
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
    
    public ItemDiscTemp findData(String code) {
        try {
            ItemDiscTemp itemDiscTemp = (ItemDiscTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_disc.Code, "
                + "mst_item_disc.name, "
                + "mst_item_disc.activeStatus, "
                + "mst_item_disc.remark, "
                + "mst_item_disc.InActiveBy, "
                + "mst_item_disc.InActiveDate, "
                + "mst_item_disc.CreatedBy, "
                + "mst_item_disc.CreatedDate "
                + "FROM mst_item_disc "
                + "WHERE mst_item_disc.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemDiscTemp.class))
                .uniqueResult(); 
                 
                return itemDiscTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemDiscTemp findData(String code,boolean active) {
        try {
            ItemDiscTemp itemDiscTemp = (ItemDiscTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_disc.Code, "
                + "mst_item_disc.name, "
                + "mst_item_disc.remark "
                + "FROM mst_item_disc "
                + "WHERE mst_item_disc.code ='"+code+"' "
                + "AND mst_item_disc.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemDiscTemp.class))
                .uniqueResult(); 
                 
                return itemDiscTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemDiscTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_disc.ActiveStatus="+active+" ";
            }
            List<ItemDiscTemp> list = (List<ItemDiscTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_disc.Code, "
                + "mst_item_disc.name, "
                + "mst_item_disc.remark, "
                + "mst_item_disc.ActiveStatus "
                + "FROM mst_item_disc "
                + "WHERE mst_item_disc.code LIKE '%"+code+"%' "
                + "AND mst_item_disc.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemDiscTemp.class))
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
    
    public void save(ItemDisc itemDisc, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemDisc.setCode(createCode(itemDisc));
            if(itemDisc.isActiveStatus()){
                itemDisc.setInActiveBy("");                
            }else{
                itemDisc.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemDisc.setInActiveDate(new Date());
            }
            
            itemDisc.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemDisc.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemDisc);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemDisc.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemDisc itemDisc, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemDisc.isActiveStatus()){
                itemDisc.setInActiveBy("");                
            }else{
                itemDisc.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemDisc.setInActiveDate(new Date());
            }
            itemDisc.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemDisc.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemDisc);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemDisc.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemDiscField.BEAN_NAME + " WHERE " + ItemDiscField.CODE + " = :prmCode")
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
