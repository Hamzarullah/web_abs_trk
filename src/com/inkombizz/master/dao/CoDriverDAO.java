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
import com.inkombizz.master.model.CoDriver;
import com.inkombizz.master.model.CoDriverField;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.master.model.CoDriverTemp;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

public class CoDriverDAO {
    private HBMSession hbmSession;
	
    public CoDriverDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    
    public String createCode(CoDriver coDriver){   
        try{
            String acronim = "CODRV";
            DetachedCriteria dc = DetachedCriteria.forClass(CoDriver.class)
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
                concat_qry="AND mst_co_driver.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_co_driver "
                + "WHERE mst_co_driver.code LIKE '%"+code+"%' "
                + "AND mst_co_driver.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CoDriverTemp> findData(String code, String name,String active,int from, int row) {
    try {   
        String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_co_driver.ActiveStatus="+active+" ";
            }
        List<CoDriverTemp> list = (List<CoDriverTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
            + "mst_co_driver.code, "
            + "mst_co_driver.name, "
            + "mst_co_driver.address, "
            + "mst_co_driver.phone1, "
            + "mst_co_driver.phone2, "
            + "mst_co_driver.activeStatus "
            + "FROM mst_co_driver "
            + "WHERE mst_co_driver.code LIKE '%"+code+"%' "
            + "AND mst_co_driver.name LIKE '%"+name+"%' "
            + concat_qry
            + "LIMIT "+from+","+row+"")

            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .addScalar("address", Hibernate.STRING)
            .addScalar("phone1", Hibernate.STRING)
            .addScalar("phone2", Hibernate.STRING)
            .addScalar("activeStatus", Hibernate.BOOLEAN)
            .setResultTransformer(Transformers.aliasToBean(CoDriverTemp.class))
            .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CoDriver> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<CoDriver> findByCriteria(DetachedCriteria dc) {
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

    public CoDriver get(String id) {
        try {
            return (CoDriver) hbmSession.hSession.get(CoDriver.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CoDriver> getDuplicateEntry(String id, String name) throws Exception {
        try {            
            String qry = "FROM " + CoDriverField.BEAN_NAME + "  " +
                         "WHERE " +
                                CoDriverField.ID + "<> :prmId " +
                                "AND (" + CoDriverField.NAME + "= :prmName " + 
                                    ")";
            
            List<CoDriver> listCoDriver = hbmSession.hSession.createQuery(qry)
                                .setParameter("prmId", id)
                                .setParameter("prmName", name)
                                .list();
            
            return listCoDriver;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="Insert, Update, Delete">
    
    private String createId(CoDriver coDriver){        
//     String tempStatus="";
//        if(coDriver.getInternalExternalStatus().equals("INTERNAL")){
//            tempStatus="CK";
//        }else if(coDriver.getInternalExternalStatus().equals("EXTERNAL")){
//            tempStatus="CE";
//        }
//        Date tempDate= new Date();
        String acronim = "CODRV";

        DetachedCriteria dc = DetachedCriteria.forClass(CoDriver.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

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

    public void save(CoDriver coDriver, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            coDriver.setCode(createCode(coDriver));
            coDriver.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            coDriver.setCreatedDate(new Date()); 
            String coDriverId = createId(coDriver);
            coDriver.setCode(coDriverId);
            
            hbmSession.hSession.save(coDriver);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    coDriver.getCode(), "CO_DRIVER"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(CoDriver coDriver, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            coDriver.setCity(coDriver.getEmployee().getCity());
            coDriver.setAddress(coDriver.getEmployee().getAddress());
            hbmSession.hSession.update(coDriver);
            
//            coDriver.setCode(createCode(coDriver));
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    coDriver.getCode(), "CO_DRIVER"));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CoDriverField.BEAN_NAME + " WHERE " + CoDriverField.ID + " = :prmId")
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