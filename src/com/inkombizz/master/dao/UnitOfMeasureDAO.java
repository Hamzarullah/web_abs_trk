

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
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.UnitOfMeasure;
import com.inkombizz.master.model.UnitOfMeasureTemp;
import com.inkombizz.master.model.UnitOfMeasureField;



public class UnitOfMeasureDAO {
    
    private HBMSession hbmSession;
    
    public UnitOfMeasureDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_unit_of_measure.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_unit_of_measure "
                + "WHERE mst_unit_of_measure.code LIKE '%"+code+"%' "
                + "AND mst_unit_of_measure.name LIKE '%"+name+"%' "
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
    
    public UnitOfMeasureTemp findData(String code) {
        try {
            UnitOfMeasureTemp unitOfMeasureTemp = (UnitOfMeasureTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_unit_of_measure.Code, "
                + "mst_unit_of_measure.name, "
                + "mst_unit_of_measure.activeStatus, "
                + "mst_unit_of_measure.remark, "
                + "mst_unit_of_measure.InActiveBy, "
                + "mst_unit_of_measure.InActiveDate, "
                + "mst_unit_of_measure.CreatedBy, "
                + "mst_unit_of_measure.CreatedDate "
                + "FROM mst_unit_of_measure "
                + "WHERE mst_unit_of_measure.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(UnitOfMeasureTemp.class))
                .uniqueResult(); 
                 
                return unitOfMeasureTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public UnitOfMeasureTemp findData(String code,boolean active) {
        try {
            UnitOfMeasureTemp unitOfMeasureTemp = (UnitOfMeasureTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_unit_of_measure.Code, "
                + "mst_unit_of_measure.name, "
                + "mst_unit_of_measure.remark "
                + "FROM mst_unit_of_measure "
                + "WHERE mst_unit_of_measure.code ='"+code+"' "
                + "AND mst_unit_of_measure.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(UnitOfMeasureTemp.class))
                .uniqueResult(); 
                 
                return unitOfMeasureTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<UnitOfMeasureTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_unit_of_measure.ActiveStatus="+active+" ";
            }
            List<UnitOfMeasureTemp> list = (List<UnitOfMeasureTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_unit_of_measure.Code, "
                + "mst_unit_of_measure.name, "
                + "mst_unit_of_measure.remark, "
                + "mst_unit_of_measure.ActiveStatus "
                + "FROM mst_unit_of_measure "
                + "WHERE mst_unit_of_measure.code LIKE '%"+code+"%' "
                + "AND mst_unit_of_measure.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(UnitOfMeasureTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     public List <UnitOfMeasure> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    public void save(UnitOfMeasure unitOfMeasure, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(unitOfMeasure.isActiveStatus()){
                unitOfMeasure.setInActiveBy("");                
            }else{
                unitOfMeasure.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                unitOfMeasure.setInActiveDate(new Date());
            }
            
            unitOfMeasure.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            unitOfMeasure.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(unitOfMeasure);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    unitOfMeasure.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(UnitOfMeasure unitOfMeasure, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(unitOfMeasure.isActiveStatus()){
                unitOfMeasure.setInActiveBy("");                
            }else{
                unitOfMeasure.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                unitOfMeasure.setInActiveDate(new Date());
            }
            unitOfMeasure.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            unitOfMeasure.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(unitOfMeasure);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    unitOfMeasure.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + UnitOfMeasureField.BEAN_NAME + " WHERE " + UnitOfMeasureField.CODE + " = :prmCode")
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
