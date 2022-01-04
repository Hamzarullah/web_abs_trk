

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

import com.inkombizz.master.model.ItemTypeDesign;
import com.inkombizz.master.model.ItemTypeDesignTemp;
import com.inkombizz.master.model.ItemTypeDesignField;
import org.hibernate.criterion.Restrictions;



public class ItemTypeDesignDAO {
    
    private HBMSession hbmSession;
    
    public ItemTypeDesignDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemTypeDesign itemTypeDesign){   
        try{
            String acronim = "ITMTYPDSG";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemTypeDesign.class)
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
                concat_qry="AND mst_item_type_design.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_type_design "
                + "WHERE mst_item_type_design.code LIKE '%"+code+"%' "
                + "AND mst_item_type_design.name LIKE '%"+name+"%' "
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
    
    public ItemTypeDesignTemp findData(String code) {
        try {
            ItemTypeDesignTemp itemTypeDesignTemp = (ItemTypeDesignTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_type_design.Code, "
                + "mst_item_type_design.name, "
                + "mst_item_type_design.activeStatus, "
                + "mst_item_type_design.remark, "
                + "mst_item_type_design.InActiveBy, "
                + "mst_item_type_design.InActiveDate, "
                + "mst_item_type_design.CreatedBy, "
                + "mst_item_type_design.CreatedDate "
                + "FROM mst_item_type_design "
                + "WHERE mst_item_type_design.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemTypeDesignTemp.class))
                .uniqueResult(); 
                 
                return itemTypeDesignTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemTypeDesignTemp findData(String code,boolean active) {
        try {
            ItemTypeDesignTemp itemTypeDesignTemp = (ItemTypeDesignTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_type_design.Code, "
                + "mst_item_type_design.name, "
                + "mst_item_type_design.remark "
                + "FROM mst_item_type_design "
                + "WHERE mst_item_type_design.code ='"+code+"' "
                + "AND mst_item_type_design.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemTypeDesignTemp.class))
                .uniqueResult(); 
                 
                return itemTypeDesignTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemTypeDesignTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_type_design.ActiveStatus="+active+" ";
            }
            List<ItemTypeDesignTemp> list = (List<ItemTypeDesignTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_type_design.Code, "
                + "mst_item_type_design.name, "
                + "mst_item_type_design.remark, "
                + "mst_item_type_design.ActiveStatus "
                + "FROM mst_item_type_design "
                + "WHERE mst_item_type_design.code LIKE '%"+code+"%' "
                + "AND mst_item_type_design.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemTypeDesignTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemTypeDesign itemTypeDesign, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemTypeDesign.setCode(createCode(itemTypeDesign));
            if(itemTypeDesign.isActiveStatus()){
                itemTypeDesign.setInActiveBy("");                
            }else{
                itemTypeDesign.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemTypeDesign.setInActiveDate(new Date());
            }
            
            itemTypeDesign.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemTypeDesign.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemTypeDesign);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemTypeDesign.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemTypeDesign itemTypeDesign, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemTypeDesign.isActiveStatus()){
                itemTypeDesign.setInActiveBy("");                
            }else{
                itemTypeDesign.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemTypeDesign.setInActiveDate(new Date());
            }
            itemTypeDesign.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemTypeDesign.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemTypeDesign);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemTypeDesign.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemTypeDesignField.BEAN_NAME + " WHERE " + ItemTypeDesignField.CODE + " = :prmCode")
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
