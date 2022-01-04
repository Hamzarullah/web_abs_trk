package com.inkombizz.security.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.model.Authorization;
import com.inkombizz.security.model.AuthorizationField;

public class AuthorizationDAO {
    private HBMSession hbmSession;
	
    public AuthorizationDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public List<Authorization> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<Authorization> findByCriteria(DetachedCriteria dc) {
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

    public Authorization get(String code) {
        try {
            return (Authorization) hbmSession.hSession.get(Authorization.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public void save(Authorization authorization) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.save(authorization);
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            //hbmSession.hTransaction.rollback();
            //System.out.println("Error DAO : " + e.getMessage());
            throw e;
        }
    }

    public void update(Authorization authorization) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.update(authorization);
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void delete(String code) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + AuthorizationField.BEAN_NAME + " WHERE " + AuthorizationField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
}