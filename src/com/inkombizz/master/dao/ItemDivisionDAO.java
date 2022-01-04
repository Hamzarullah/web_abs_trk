

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

import com.inkombizz.master.model.ItemDivision;
import com.inkombizz.master.model.ItemDivisionTemp;
import com.inkombizz.master.model.ItemDivisionField;
import org.hibernate.criterion.Restrictions;



public class ItemDivisionDAO {
    
    private HBMSession hbmSession;
    
    public ItemDivisionDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(ItemDivision itemDivision){   
        try{
            String acronim = "ITMDIV";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemDivision.class)
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
                concat_qry="AND mst_item_division.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_division "
                + "WHERE mst_item_division.code LIKE '%"+code+"%' "
                + "AND mst_item_division.name LIKE '%"+name+"%' "
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
    
    public ItemDivisionTemp findData(String code) {
        try {
            ItemDivisionTemp itemDivisionTemp = (ItemDivisionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_division.Code, "
                + "mst_item_division.name, "
                + "mst_item_division.activeStatus, "
                + "mst_item_division.remark, "
                + "mst_item_division.InActiveBy, "
                + "mst_item_division.InActiveDate, "
                + "mst_item_division.CreatedBy, "
                + "mst_item_division.CreatedDate "
                + "FROM mst_item_division "
                + "WHERE mst_item_division.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemDivisionTemp.class))
                .uniqueResult(); 
                 
                return itemDivisionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemDivisionTemp findData(String code,boolean active) {
        try {
            ItemDivisionTemp itemDivisionTemp = (ItemDivisionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_division.Code, "
                + "mst_item_division.name, "
                + "mst_item_division.remark "
                + "FROM mst_item_division "
                + "WHERE mst_item_division.code ='"+code+"' "
                + "AND mst_item_division.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemDivisionTemp.class))
                .uniqueResult(); 
                 
                return itemDivisionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemDivisionTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_division.ActiveStatus="+active+" ";
            }
            List<ItemDivisionTemp> list = (List<ItemDivisionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_division.Code, "
                + "mst_item_division.name, "
                + "mst_item_division.remark, "
                + "mst_item_division.ActiveStatus "
                + "FROM mst_item_division "
                + "WHERE mst_item_division.code LIKE '%"+code+"%' "
                + "AND mst_item_division.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemDivisionTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemDivision itemDivision, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemDivision.setCode(createCode(itemDivision));
            if(itemDivision.isActiveStatus()){
                itemDivision.setInActiveBy("");                
            }else{
                itemDivision.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemDivision.setInActiveDate(new Date());
            }
            
            itemDivision.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemDivision.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemDivision);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemDivision.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemDivision itemDivision, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemDivision.isActiveStatus()){
                itemDivision.setInActiveBy("");                
            }else{
                itemDivision.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemDivision.setInActiveDate(new Date());
            }
            itemDivision.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemDivision.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemDivision);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemDivision.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemDivisionField.BEAN_NAME + " WHERE " + ItemDivisionField.CODE + " = :prmCode")
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
