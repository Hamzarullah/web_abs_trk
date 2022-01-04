

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.Country;
import com.inkombizz.master.model.CountryTemp;
import com.inkombizz.master.model.CountryField;



public class CountryDAO {
    
    private HBMSession hbmSession;
    
    public CountryDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_country.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_country "
                + "WHERE mst_country.code LIKE '%"+code+"%' "
                + "AND mst_country.name LIKE '%"+name+"%' "
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
    
    public CountryTemp findData(String code) {
        try {
            CountryTemp countryTemp = (CountryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_country.Code, "
                + "mst_country.name, "
                + "mst_country.activeStatus, "
                + "mst_country.remark, "
                + "mst_country.InActiveBy, "
                + "mst_country.InActiveDate, "
                + "mst_country.CreatedBy, "
                + "mst_country.CreatedDate "
                + "FROM mst_country "
                + "WHERE mst_country.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(CountryTemp.class))
                .uniqueResult(); 
                 
                return countryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CountryTemp findData(String code,boolean active) {
        try {
            CountryTemp countryTemp = (CountryTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_country.Code, "
                + "mst_country.name, "
                + "mst_country.remark "
                + "FROM mst_country "
                + "WHERE mst_country.code ='"+code+"' "
                + "AND mst_country.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CountryTemp.class))
                .uniqueResult(); 
                 
                return countryTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<CountryTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_country.ActiveStatus="+active+" ";
            }
            List<CountryTemp> list = (List<CountryTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_country.Code, "
                + "mst_country.name, "
                + "mst_country.remark, "
                + "mst_country.ActiveStatus "
                + "FROM mst_country "
                + "WHERE mst_country.code LIKE '%"+code+"%' "
                + "AND mst_country.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CountryTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Country country, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(country.isActiveStatus()){
                country.setInActiveBy("");                
            }else{
                country.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                country.setInActiveDate(new Date());
            }
            
            country.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            country.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(country);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    country.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Country country, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(country.isActiveStatus()){
                country.setInActiveBy("");                
            }else{
                country.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                country.setInActiveDate(new Date());
            }
            country.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            country.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(country);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    country.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CountryField.BEAN_NAME + " WHERE " + CountryField.CODE + " = :prmCode")
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
