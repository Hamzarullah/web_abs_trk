

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

import com.inkombizz.master.model.TermOfDelivery;
import com.inkombizz.master.model.TermOfDeliveryTemp;
import com.inkombizz.master.model.TermOfDeliveryField;
import org.hibernate.criterion.Restrictions;



public class TermOfDeliveryDAO {
    
    private HBMSession hbmSession;
    
    public TermOfDeliveryDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(TermOfDelivery termOfDelivery){   
        try{
            String acronim = "TOD";
            DetachedCriteria dc = DetachedCriteria.forClass(TermOfDelivery.class)
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
                concat_qry="AND mst_term_of_delivery.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_term_of_delivery "
                + "WHERE mst_term_of_delivery.code LIKE '%"+code+"%' "
                + "AND mst_term_of_delivery.name LIKE '%"+name+"%' "
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
    
    public TermOfDeliveryTemp findData(String code) {
        try {
            TermOfDeliveryTemp termOfDeliveryTemp = (TermOfDeliveryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_term_of_delivery.Code, "
                + "mst_term_of_delivery.name, "
                + "mst_term_of_delivery.activeStatus, "
                + "mst_term_of_delivery.remark, "
                + "mst_term_of_delivery.InActiveBy, "
                + "mst_term_of_delivery.InActiveDate, "
                + "mst_term_of_delivery.CreatedBy, "
                + "mst_term_of_delivery.CreatedDate "
                + "FROM mst_term_of_delivery "
                + "WHERE mst_term_of_delivery.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(TermOfDeliveryTemp.class))
                .uniqueResult(); 
                 
                return termOfDeliveryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public TermOfDeliveryTemp findData(String code,boolean active) {
        try {
            TermOfDeliveryTemp termOfDeliveryTemp = (TermOfDeliveryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_term_of_delivery.Code, "
                + "mst_term_of_delivery.name, "
                + "mst_term_of_delivery.remark "
                + "FROM mst_term_of_delivery "
                + "WHERE mst_term_of_delivery.code ='"+code+"' "
                + "AND mst_term_of_delivery.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(TermOfDeliveryTemp.class))
                .uniqueResult(); 
                 
                return termOfDeliveryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<TermOfDeliveryTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_term_of_delivery.ActiveStatus="+active+" ";
            }
            List<TermOfDeliveryTemp> list = (List<TermOfDeliveryTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_term_of_delivery.Code, "
                + "mst_term_of_delivery.name, "
                + "mst_term_of_delivery.remark, "
                + "mst_term_of_delivery.ActiveStatus "
                + "FROM mst_term_of_delivery "
                + "WHERE mst_term_of_delivery.code LIKE '%"+code+"%' "
                + "AND mst_term_of_delivery.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(TermOfDeliveryTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(TermOfDelivery termOfDelivery, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            termOfDelivery.setCode(createCode(termOfDelivery));
            if(termOfDelivery.isActiveStatus()){
                termOfDelivery.setInActiveBy("");                
            }else{
                termOfDelivery.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                termOfDelivery.setInActiveDate(new Date());
            }
            
            termOfDelivery.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            termOfDelivery.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(termOfDelivery);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    termOfDelivery.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(TermOfDelivery termOfDelivery, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(termOfDelivery.isActiveStatus()){
                termOfDelivery.setInActiveBy("");                
            }else{
                termOfDelivery.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                termOfDelivery.setInActiveDate(new Date());
            }
            termOfDelivery.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            termOfDelivery.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(termOfDelivery);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    termOfDelivery.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + TermOfDeliveryField.BEAN_NAME + " WHERE " + TermOfDeliveryField.CODE + " = :prmCode")
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
