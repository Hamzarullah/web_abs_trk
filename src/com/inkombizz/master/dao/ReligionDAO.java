
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.Religion;
import com.inkombizz.master.model.ReligionField;
import com.inkombizz.master.model.ReligionTemp;


public class ReligionDAO {
    
    private HBMSession hbmSession;

    public ReligionDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <Religion> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<Religion> findByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            return criteria.list();
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
    
    public Religion get(String id) {
        try {
            return (Religion) hbmSession.hSession.get(Religion.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ReligionTemp findData(String code,boolean active) {
        try {
            ReligionTemp religionTemp = (ReligionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_religion.Code, "
                + "mst_religion.name, "
                + "mst_religion.remark "
                + "FROM mst_religion "
                + "WHERE mst_religion.code ='"+code+"' "
                + "AND mst_religion.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ReligionTemp.class))
                .uniqueResult(); 
                 
                return religionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Religion religion, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            religion.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            religion.setCreatedDate(new Date()); 
//            religion.setReligionCode(BaseSession.loadProgramSession().getReligionCode());
//            String Id = religion.getCode();
//            religion.setId(Id);
            hbmSession.hSession.save(religion);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    religion.getCode(), moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(Religion religion, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            religion.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            religion.setUpdatedDate(new Date()); 
            hbmSession.hSession.update(religion);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    religion.getCode(), moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void delete(String id, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + ReligionField.BEAN_NAME + " WHERE " + ReligionField.CODE + " = :prmCode")
                    .setParameter("prmCode", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    } 
    
    public ReligionTemp getMin() {
        try {
            
            String qry = "SELECT mst_religion.code,mst_religion.Name FROM mst_religion ORDER BY mst_religion.code LIMIT 0,1";
            ReligionTemp companyTemp =(ReligionTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ReligionTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ReligionTemp getMax() {
        try {
            
            String qry = "SELECT mst_religion.code,mst_religion.Name FROM mst_religion ORDER BY mst_religion.code DESC LIMIT 0,1";
            ReligionTemp companyTemp =(ReligionTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ReligionTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }

}
