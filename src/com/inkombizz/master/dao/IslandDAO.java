
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
import com.inkombizz.master.model.Island;
import com.inkombizz.master.model.IslandField;
import com.inkombizz.master.model.IslandTemp;


public class IslandDAO {
    
    private HBMSession hbmSession;

    public IslandDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <Island> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<Island> findByCriteria(DetachedCriteria dc) {
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
    
    public Island get(String id) {
        try {
            return (Island) hbmSession.hSession.get(Island.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public IslandTemp findData(String code,boolean active) {
        try {
               IslandTemp islandTemp = (IslandTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_island.Code, "
                + "mst_island.name, "
                + "mst_island.CountryCode, "
                + "mst_country.Name AS CountryName, "
                + "mst_island.remark, "
                + "mst_island.InActiveBy, "
                + "mst_island.InActiveDate, "
                + "mst_island.activeStatus, "
                + "mst_island.createdBy, "
                + "mst_island.createdDate "
                + "FROM mst_island "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE mst_island.code ='"+code+"' "
                + "AND mst_island.ActiveStatus="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(IslandTemp.class))
                .uniqueResult(); 
                 
                return islandTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public void save(Island island, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            island.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            island.setCreatedDate(new Date()); 
//            island.setIslandCode(BaseSession.loadProgramSession().getIslandCode());
//            String Id = island.getCode();
//            island.setId(Id);
            hbmSession.hSession.save(island);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    island.getCode(), moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(Island island, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.update(island);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    island.getCode(), moduleCode));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + IslandField.BEAN_NAME + " WHERE " + IslandField.CODE + " = :prmCode")
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
    
    public IslandTemp getMin() {
        try {
            
            String qry = "SELECT mst_island.code,mst_island.Name FROM mst_island ORDER BY mst_island.code LIMIT 0,1";
            IslandTemp companyTemp =(IslandTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(IslandTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public IslandTemp getMax() {
        try {
            
            String qry = "SELECT mst_island.code,mst_island.Name FROM mst_island ORDER BY mst_island.code DESC LIMIT 0,1";
            IslandTemp companyTemp =(IslandTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(IslandTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

}
