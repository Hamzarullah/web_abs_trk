
package com.inkombizz.master.dao;


import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.Expedition;
import com.inkombizz.master.model.ExpeditionField;
import java.math.BigInteger;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.ExpeditionTemp;
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;


public class ExpeditionDAO {
    
    private HBMSession hbmSession;
    
    public ExpeditionDAO(HBMSession session){
    this.hbmSession=session;
    }
    
    public String createCode(Expedition expedition){   
        try{
            String acronim = "EXP";
            DetachedCriteria dc = DetachedCriteria.forClass(Expedition.class)
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
                concat_qry="AND mst_expedition.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_expedition "
                + "INNER JOIN mst_city ON mst_city.Code = mst_expedition.CityCode  "
                + "WHERE mst_expedition.Code LIKE '%"+code+"%' "
                + "AND mst_expedition.Name LIKE '%"+name+"%' "
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
    
    public ExpeditionTemp findData(String code) {
        try {
                ExpeditionTemp expeditionTemp = (ExpeditionTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_expedition.Code, "
                + "mst_expedition.name, "
                + "mst_expedition.Address, "
                + "mst_expedition.CityCode, "
                + "mst_city.Name AS CityName, "
                + "mst_island.CountryCode AS countryCode, "
                + "mst_country.name AS countryName, "
                + "mst_expedition.zipCode, "
                + "mst_expedition.Phone1, "
                + "mst_expedition.Phone2, "
                + "mst_expedition.Fax, "
                + "mst_expedition.EmailAddress, "
                + "mst_expedition.ContactPerson, "
                + "mst_expedition.remark, "
                + "mst_expedition.activeStatus, "
                + "mst_expedition.inActiveBy, "
                + "mst_expedition.inActiveDate, "
                + "mst_expedition.createdBy, "
                + "mst_expedition.createdDate "
                + "FROM mst_expedition "
                + "INNER JOIN mst_city ON mst_expedition.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_expedition.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)  
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING) 
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ExpeditionTemp.class))
                .uniqueResult(); 
                 
                return expeditionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ExpeditionTemp findData(String code,boolean active) {
        try {
               ExpeditionTemp expeditionTemp = (ExpeditionTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_expedition.Code, "
                + "mst_expedition.name "
                + "FROM mst_expedition "
                + "WHERE mst_expedition.code ='"+code+"' "
                + "AND mst_expedition.ActiveStatus="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ExpeditionTemp.class))
                .uniqueResult(); 
                 
                return expeditionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<ExpeditionTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_expedition.ActiveStatus="+active+" ";
            }
            List<ExpeditionTemp> list = (List<ExpeditionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "mst_expedition.Code, "
                + "mst_expedition.name, "
                + "mst_expedition.address, "
                + "mst_expedition.CityCode, "
                + "mst_city.name AS cityName, "
                + "mst_island.CountryCode AS countryCode, "
                + "mst_country.name AS countryName, "
                + "mst_expedition.zipCode, "
                + "mst_expedition.phone1, "
                + "mst_expedition.phone2, "
                + "mst_expedition.fax, "
                + "mst_expedition.contactPerson, "
                + "mst_expedition.remark, "
                + "mst_expedition.emailAddress,"
                + "mst_expedition.ActiveStatus "
                + "FROM mst_expedition "
                + "INNER JOIN mst_city ON mst_city.Code = mst_expedition.CityCode  "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_expedition.code LIKE '%"+code+"%' "
                + "AND mst_expedition.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)  
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)             
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING) 
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ExpeditionTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Expedition expedition, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            expedition.setCode(createCode(expedition));
            expedition.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            expedition.setCreatedDate(new Date()); 
            hbmSession.hSession.save(expedition);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    expedition.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Expedition expedition, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            expedition.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            expedition.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(expedition);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    expedition.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ExpeditionField.BEAN_NAME + " WHERE " + ExpeditionField.CODE + " = :prmCode")
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
     public ExpeditionTemp getMin() {
        try {
            
            String qry = "SELECT mst_expedition.code,mst_expedition.Name FROM mst_expedition ORDER BY mst_expedition.code LIMIT 0,1";
            ExpeditionTemp expeditionTemp =(ExpeditionTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ExpeditionTemp.class))
                    .uniqueResult();   
            
            return expeditionTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ExpeditionTemp getMax() {
        try {
            
            String qry = "SELECT mst_expedition.code,mst_expedition.Name FROM mst_expedition ORDER BY mst_expedition.code DESC LIMIT 0,1";
            ExpeditionTemp expeditionTemp =(ExpeditionTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(ExpeditionTemp.class))
                    .uniqueResult();   
            
            return expeditionTemp;
            
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
