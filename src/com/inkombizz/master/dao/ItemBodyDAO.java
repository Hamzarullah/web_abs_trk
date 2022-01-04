

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

import com.inkombizz.master.model.ItemBody;
import com.inkombizz.master.model.ItemBodyTemp;
import com.inkombizz.master.model.ItemBodyField;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class ItemBodyDAO {
    
    private HBMSession hbmSession;
    
    public ItemBodyDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemBody itemBody){   
        try{
            String acronim = "BDY";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemBody.class)
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
                concat_qry="AND mst_item_body.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_body "
                + "WHERE mst_item_body.code LIKE '%"+code+"%' "
                + "AND mst_item_body.name LIKE '%"+name+"%' "
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
    
    public ItemBodyTemp findData(String code) {
        try {
            ItemBodyTemp itemBodyTemp = (ItemBodyTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_body.Code, "
                + "mst_item_body.name, "
                + "mst_item_body.activeStatus, "
                + "mst_item_body.remark, "
                + "mst_item_body.InActiveBy, "
                + "mst_item_body.InActiveDate, "
                + "mst_item_body.CreatedBy, "
                + "mst_item_body.CreatedDate "
                + "FROM mst_item_body "
                + "WHERE mst_item_body.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemBodyTemp.class))
                .uniqueResult(); 
                 
                return itemBodyTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemBodyTemp findData(String code,boolean active) {
        try {
            ItemBodyTemp itemBodyTemp = (ItemBodyTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_body.Code, "
                + "mst_item_body.name, "
                + "mst_item_body.remark "
                + "FROM mst_item_body "
                + "WHERE mst_item_body.code ='"+code+"' "
                + "AND mst_item_body.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemBodyTemp.class))
                .uniqueResult(); 
                 
                return itemBodyTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemBodyTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_body.ActiveStatus="+active+" ";
            }
            List<ItemBodyTemp> list = (List<ItemBodyTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_body.Code, "
                + "mst_item_body.name, "
                + "mst_item_body.remark, "
                + "mst_item_body.ActiveStatus "
                + "FROM mst_item_body "
                + "WHERE mst_item_body.code LIKE '%"+code+"%' "
                + "AND mst_item_body.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemBodyTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemBody itemBody, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemBody.setCode(createCode(itemBody));
            if(itemBody.isActiveStatus()){
                itemBody.setInActiveBy("");                
            }else{
                itemBody.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBody.setInActiveDate(new Date());
            }
            
            itemBody.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemBody.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemBody);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemBody.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemBody itemBody, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemBody.isActiveStatus()){
                itemBody.setInActiveBy("");                
            }else{
                itemBody.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBody.setInActiveDate(new Date());
            }
            itemBody.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemBody.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemBody);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemBody.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemBodyField.BEAN_NAME + " WHERE " + ItemBodyField.CODE + " = :prmCode")
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
