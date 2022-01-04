

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

import com.inkombizz.master.model.ItemBackseat;
import com.inkombizz.master.model.ItemBackseatTemp;
import com.inkombizz.master.model.ItemBackseatField;
import com.inkombizz.master.model.ItemBackseat;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class ItemBackseatDAO {
    
    private HBMSession hbmSession;
    
    public ItemBackseatDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemBackseat itemBackseat){   
        try{
            String acronim = "BCKST";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemBackseat.class)
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
    public List <ItemBackseat> findByCriteria(DetachedCriteria dc, int from, int size) {
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
                concat_qry="AND mst_item_backseat.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_backseat "
                + "WHERE mst_item_backseat.code LIKE '%"+code+"%' "
                + "AND mst_item_backseat.name LIKE '%"+name+"%' "
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
    
    public ItemBackseatTemp findData(String code) {
        try {
            ItemBackseatTemp itemBackseatTemp = (ItemBackseatTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_backseat.Code, "
                + "mst_item_backseat.name, "
                + "mst_item_backseat.activeStatus, "
                + "mst_item_backseat.remark, "
                + "mst_item_backseat.InActiveBy, "
                + "mst_item_backseat.InActiveDate, "
                + "mst_item_backseat.CreatedBy, "
                + "mst_item_backseat.CreatedDate "
                + "FROM mst_item_backseat "
                + "WHERE mst_item_backseat.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemBackseatTemp.class))
                .uniqueResult(); 
                 
                return itemBackseatTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemBackseatTemp findData(String code,boolean active) {
        try {
            ItemBackseatTemp itemBackseatTemp = (ItemBackseatTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_backseat.Code, "
                + "mst_item_backseat.name, "
                + "mst_item_backseat.remark "
                + "FROM mst_item_backseat "
                + "WHERE mst_item_backseat.code ='"+code+"' "
                + "AND mst_item_backseat.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemBackseatTemp.class))
                .uniqueResult(); 
                 
                return itemBackseatTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemBackseatTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_backseat.ActiveStatus="+active+" ";
            }
            List<ItemBackseatTemp> list = (List<ItemBackseatTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_backseat.Code, "
                + "mst_item_backseat.name, "
                + "mst_item_backseat.remark, "
                + "mst_item_backseat.ActiveStatus "
                + "FROM mst_item_backseat "
                + "WHERE mst_item_backseat.code LIKE '%"+code+"%' "
                + "AND mst_item_backseat.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemBackseatTemp.class))
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
    
    public void save(ItemBackseat itemBackseat, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemBackseat.setCode(createCode(itemBackseat));
            if(itemBackseat.isActiveStatus()){
                itemBackseat.setInActiveBy("");                
            }else{
                itemBackseat.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBackseat.setInActiveDate(new Date());
            }
            
            itemBackseat.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemBackseat.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemBackseat);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemBackseat.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemBackseat itemBackseat, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemBackseat.isActiveStatus()){
                itemBackseat.setInActiveBy("");                
            }else{
                itemBackseat.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemBackseat.setInActiveDate(new Date());
            }
            itemBackseat.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemBackseat.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemBackseat);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemBackseat.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemBackseatField.BEAN_NAME + " WHERE " + ItemBackseatField.CODE + " = :prmCode")
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
