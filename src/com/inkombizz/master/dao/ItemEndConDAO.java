

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

import com.inkombizz.master.model.ItemEndCon;
import com.inkombizz.master.model.ItemEndConTemp;
import com.inkombizz.master.model.ItemEndConField;
import com.inkombizz.master.model.ItemTypeDesign;
import org.hibernate.criterion.Restrictions;



public class ItemEndConDAO {
    
    private HBMSession hbmSession;
    
    public ItemEndConDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemEndCon itemEndCon){   
        try{
            String acronim = "ENDCON";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemEndCon.class)
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
                concat_qry="AND mst_item_end_con.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_end_con "
                + "WHERE mst_item_end_con.code LIKE '%"+code+"%' "
                + "AND mst_item_end_con.name LIKE '%"+name+"%' "
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
    
    public ItemEndConTemp findData(String code) {
        try {
            ItemEndConTemp itemEndConTemp = (ItemEndConTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_end_con.Code, "
                + "mst_item_end_con.name, "
                + "mst_item_end_con.activeStatus, "
                + "mst_item_end_con.remark, "
                + "mst_item_end_con.InActiveBy, "
                + "mst_item_end_con.InActiveDate, "
                + "mst_item_end_con.CreatedBy, "
                + "mst_item_end_con.CreatedDate "
                + "FROM mst_item_end_con "
                + "WHERE mst_item_end_con.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemEndConTemp.class))
                .uniqueResult(); 
                 
                return itemEndConTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemEndConTemp findData(String code,boolean active) {
        try {
            ItemEndConTemp itemEndConTemp = (ItemEndConTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_end_con.Code, "
                + "mst_item_end_con.name, "
                + "mst_item_end_con.remark "
                + "FROM mst_item_end_con "
                + "WHERE mst_item_end_con.code ='"+code+"' "
                + "AND mst_item_end_con.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemEndConTemp.class))
                .uniqueResult(); 
                 
                return itemEndConTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemEndConTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_end_con.ActiveStatus="+active+" ";
            }
            List<ItemEndConTemp> list = (List<ItemEndConTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_end_con.Code, "
                + "mst_item_end_con.name, "
                + "mst_item_end_con.remark, "
                + "mst_item_end_con.ActiveStatus "
                + "FROM mst_item_end_con "
                + "WHERE mst_item_end_con.code LIKE '%"+code+"%' "
                + "AND mst_item_end_con.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemEndConTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemEndCon itemEndCon, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemEndCon.setCode(createCode(itemEndCon));
            if(itemEndCon.isActiveStatus()){
                itemEndCon.setInActiveBy("");                
            }else{
                itemEndCon.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemEndCon.setInActiveDate(new Date());
            }
            
            itemEndCon.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemEndCon.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemEndCon);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemEndCon.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemEndCon itemEndCon, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemEndCon.isActiveStatus()){
                itemEndCon.setInActiveBy("");                
            }else{
                itemEndCon.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemEndCon.setInActiveDate(new Date());
            }
            itemEndCon.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemEndCon.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemEndCon);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemEndCon.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemEndConField.BEAN_NAME + " WHERE " + ItemEndConField.CODE + " = :prmCode")
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
