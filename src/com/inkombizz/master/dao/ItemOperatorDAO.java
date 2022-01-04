

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

import com.inkombizz.master.model.ItemOperator;
import com.inkombizz.master.model.ItemOperatorTemp;
import com.inkombizz.master.model.ItemOperatorField;
import org.hibernate.criterion.Restrictions;



public class ItemOperatorDAO {
    
    private HBMSession hbmSession;
    
    public ItemOperatorDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ItemOperator itemOperator){   
        try{
            String acronim = "OPR";
            DetachedCriteria dc = DetachedCriteria.forClass(ItemOperator.class)
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
                concat_qry="AND mst_item_operator.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_item_operator "
                + "WHERE mst_item_operator.code LIKE '%"+code+"%' "
                + "AND mst_item_operator.name LIKE '%"+name+"%' "
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
    
    public ItemOperatorTemp findData(String code) {
        try {
            ItemOperatorTemp itemOperatorTemp = (ItemOperatorTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_operator.Code, "
                + "mst_item_operator.name, "
                + "mst_item_operator.activeStatus, "
                + "mst_item_operator.remark, "
                + "mst_item_operator.InActiveBy, "
                + "mst_item_operator.InActiveDate, "
                + "mst_item_operator.CreatedBy, "
                + "mst_item_operator.CreatedDate "
                + "FROM mst_item_operator "
                + "WHERE mst_item_operator.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ItemOperatorTemp.class))
                .uniqueResult(); 
                 
                return itemOperatorTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ItemOperatorTemp findData(String code,boolean active) {
        try {
            ItemOperatorTemp itemOperatorTemp = (ItemOperatorTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_operator.Code, "
                + "mst_item_operator.name, "
                + "mst_item_operator.remark "
                + "FROM mst_item_operator "
                + "WHERE mst_item_operator.code ='"+code+"' "
                + "AND mst_item_operator.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemOperatorTemp.class))
                .uniqueResult(); 
                 
                return itemOperatorTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ItemOperatorTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_operator.ActiveStatus="+active+" ";
            }
            List<ItemOperatorTemp> list = (List<ItemOperatorTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_operator.Code, "
                + "mst_item_operator.name, "
                + "mst_item_operator.remark, "
                + "mst_item_operator.ActiveStatus "
                + "FROM mst_item_operator "
                + "WHERE mst_item_operator.code LIKE '%"+code+"%' "
                + "AND mst_item_operator.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ItemOperatorTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ItemOperator itemOperator, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemOperator.setCode(createCode(itemOperator));
            if(itemOperator.isActiveStatus()){
                itemOperator.setInActiveBy("");                
            }else{
                itemOperator.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemOperator.setInActiveDate(new Date());
            }
            
            itemOperator.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemOperator.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(itemOperator);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    itemOperator.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemOperator itemOperator, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(itemOperator.isActiveStatus()){
                itemOperator.setInActiveBy("");                
            }else{
                itemOperator.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemOperator.setInActiveDate(new Date());
            }
            itemOperator.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemOperator.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemOperator);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    itemOperator.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ItemOperatorField.BEAN_NAME + " WHERE " + ItemOperatorField.CODE + " = :prmCode")
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
