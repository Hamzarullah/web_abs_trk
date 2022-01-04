package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.Driver;
import com.inkombizz.master.model.DriverField;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.master.model.DriverTemp;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

public class DriverDAO {
    private HBMSession hbmSession;
	
    public DriverDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    
    public String createCode(Driver driver){   
        try{
            String acronim = "DRV";
            DetachedCriteria dc = DetachedCriteria.forClass(Driver.class)
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
                concat_qry="AND mst_driver.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_driver "
                + "WHERE mst_driver.code LIKE '%"+code+"%' "
                + "AND mst_driver.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<DriverTemp> findData(String code, String name,String active,int from, int row) {
    try {   
        String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_driver.ActiveStatus="+active+" ";
            }
        List<DriverTemp> list = (List<DriverTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
            + "mst_driver.code, "
            + "mst_driver.name, "
            + "mst_driver.address, "
            + "mst_driver.phone1, "
            + "mst_driver.phone2, "
            + "mst_driver.activeStatus "
            + "FROM mst_driver "
            + "WHERE mst_driver.code LIKE '%"+code+"%' "
            + "AND mst_driver.name LIKE '%"+name+"%' "
            + concat_qry
            + "LIMIT "+from+","+row+"")

            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .addScalar("address", Hibernate.STRING)
            .addScalar("phone1", Hibernate.STRING)
            .addScalar("phone2", Hibernate.STRING)
            .addScalar("activeStatus", Hibernate.BOOLEAN)
            .setResultTransformer(Transformers.aliasToBean(DriverTemp.class))
            .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<Driver> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<Driver> findByCriteria(DetachedCriteria dc) {
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

    public Driver get(String id) {
        try {
            return (Driver) hbmSession.hSession.get(Driver.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<Driver> getDuplicateEntry(String id, String name) throws Exception {
        try {            
            String qry = "FROM " + DriverField.BEAN_NAME + "  " +
                         "WHERE " +
                                DriverField.ID + "<> :prmId " +
                                "AND (" + DriverField.NAME + "= :prmName " + 
                                    ")";
            
            List<Driver> listDriver = hbmSession.hSession.createQuery(qry)
                                .setParameter("prmId", id)
                                .setParameter("prmName", name)
                                .list();
            
            return listDriver;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="Insert, Update, Delete">

    public void save(Driver driver, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
//            driver.setCode(createCode(driver));
            String driverId = createCode(driver);
            driver.setCode(driverId);
            driver.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            driver.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(driver);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    driver.getCode(), "CO_DRIVER"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(Driver driver, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.update(driver);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    driver.getCode(), "CO_DRIVER"));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DriverField.BEAN_NAME + " WHERE " + DriverField.ID + " = :prmId")
                    .setParameter("prmId", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, "CO_DRIVER"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    // </editor-fold> 
}