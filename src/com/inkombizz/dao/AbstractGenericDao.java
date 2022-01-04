package com.inkombizz.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.AbstractModel;
import com.inkombizz.common.BaseEntity;
import com.inkombizz.common.EntityConfig;
import com.inkombizz.utils.DateUtils;
import java.util.ArrayList;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

@SuppressWarnings("unchecked")
public abstract class AbstractGenericDao<C, I extends Serializable> {

    private static final Log log = LogFactory.getLog(AbstractGenericDao.class);
    Class<C> entityClass;

    {
        entityClass = (Class<C>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
    }
    protected HBMSession hbmSession;

    public List<C> getAll() {
        try {
            return hbmSession.hSession.createCriteria(entityClass).list();
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<C> getAll(int from, int size) {
        try {
            return hbmSession.hSession.createCriteria(entityClass).setFirstResult(from).setMaxResults(size).list();
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<C> getAllByCriteria(DetachedCriteria dc, int from, int size) {
        try {
//            System.out.println("FROM : "+from+" SIZE : "+size);
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            
            criteria.setFirstResult(from);
            criteria.setMaxResults(size);
            return criteria.list();
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public Integer getCount() {
        try {
            Criteria criteria = hbmSession.hSession.createCriteria(entityClass).setProjection(Projections.rowCount());
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public Integer getCountByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        } catch (HibernateException e) {
            throw e;
        }
    }

    public C get(I id) {
        try {
            return (C) hbmSession.hSession.get(entityClass, id);
        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public Boolean save(C entity) {
        try {
            hbmSession.hSession.beginTransaction();
            ((BaseEntity) entity).setCreatedDate(DateUtils.newDateComplete());
            ((BaseEntity) entity).setCreatedBy(BaseSession.loadProgramSession().getUserName());
            hbmSession.hSession.save(entity);
            return Boolean.TRUE;
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            return Boolean.FALSE;
        }        
    }

    public void update(C entity) {
        try {
            hbmSession.hSession.beginTransaction();
            ((BaseEntity) entity).setUpdatedDate(DateUtils.newDateComplete());
            ((BaseEntity) entity).setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            hbmSession.hSession.update(entity);
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void delete(I id) {
        try {
            C entity = get(id);
            if (entity instanceof AbstractModel) {
                EntityConfig ec = (EntityConfig) entity.getClass()
                        .getAnnotation(EntityConfig.class);
                if (ec != null) {
                    if (ec.permanentDelete()) {
                        hbmSession.hSession.delete(entity);
                    } else {
                        ((AbstractModel) entity).setActiveStatus(Boolean.FALSE);
                        hbmSession.hSession.update(entity);
                    }
                } else {
                    ((AbstractModel) entity).setActiveStatus(Boolean.FALSE);
                    hbmSession.hSession.update(entity);
                }
            } else {
                hbmSession.hSession.delete(entity);
            }

        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public boolean executeByHql(String hql) throws Exception {
        boolean cek = false;
        try {
            Query q = hbmSession.hSession.createQuery(hql);
            q.executeUpdate();
            cek = true;
        } catch (Exception e) {
            hbmSession.hSession.getTransaction().rollback();
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
        return cek;
    }

    @SuppressWarnings("unchecked")
    public Object getListByHql(String hql) {
        List<Object> lst = new ArrayList<Object>();
        Query q = hbmSession.hSession.createQuery(hql)
                .setCacheable(true)
                .setCacheRegion("frontpages");
        lst = (List<Object>) q.list();
        hbmSession.hSession.clear();
        hbmSession.hSession.close();
        return lst;
    }

    /**
     * commit and clear
     */
    public void commitAndClear() {
        hbmSession.hSession.getTransaction().commit();
        hbmSession.hSession.clear();
        hbmSession.hSession.close();
    }

    /**
     * rollback and close
     */
    public void RollbackAndClear() {
        hbmSession.hSession.getTransaction().rollback();
        hbmSession.hSession.clear();
        hbmSession.hSession.close();
    }
}
