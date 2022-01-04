package com.inkombizz.security.dao;

import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.model.Role;
import com.inkombizz.security.model.RoleAuthorizationField;
import com.inkombizz.security.model.RoleField;
import com.inkombizz.security.model.RoleTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

public class RoleDAO {
    private HBMSession hbmSession;
	
    public RoleDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public List<Role> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<Role> findByCriteria(DetachedCriteria dc) {
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
            if (criteria.list().isEmpty())
                return 0;
            else
                return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public Role get(String code) {
        try {
            return (Role) hbmSession.hSession.get(Role.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public RoleTemp findData(String code) {
        try {
            RoleTemp roleTemp = (RoleTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "scr_role.Code, "
                + "scr_role.Name "
                + "FROM scr_role "
                + "WHERE scr_role.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(RoleTemp.class))
                .uniqueResult(); 
                 
                return roleTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Role role, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.save(role);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    role.getCode(), ""));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            //hbmSession.hTransaction.rollback();
            //System.out.println("Error DAO : " + e.getMessage());
            throw e;
        }
    }

    public void update(Role role, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();            
            hbmSession.hSession.update(role);        
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    role.getCode(), ""));

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
            
            hbmSession.hSession.createQuery("DELETE FROM " + RoleAuthorizationField.BEAN_NAME + " WHERE " + RoleAuthorizationField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.createQuery("DELETE FROM " + RoleField.BEAN_NAME + " WHERE " + RoleField.CODE + " = :prmCode")
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