

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

import com.inkombizz.master.model.Province;
import com.inkombizz.master.model.ProvinceTemp;
import com.inkombizz.master.model.ProvinceField;



public class ProvinceDAO {
    
    private HBMSession hbmSession;
    
    public ProvinceDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_province.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_province "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "WHERE mst_province.code LIKE '%"+code+"%' "
                + "AND mst_province.name LIKE '%"+name+"%' "
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
    
    public ProvinceTemp findData(String code) {
        try {
            ProvinceTemp provinceTemp = (ProvinceTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_province.Code, "
                + "mst_province.name, "
                + "mst_province.IslandCode, "
                + "mst_island.Name AS IslandName, "
                + "mst_island.countryCode, "
                + "mst_country.Name AS countryName, "
                + "mst_province.activeStatus, "
                + "mst_province.remark, "
                + "mst_province.InActiveBy, "
                + "mst_province.InActiveDate, "
                + "mst_province.CreatedBy, "
                + "mst_province.CreatedDate "
                + "FROM mst_province "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE mst_province.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ProvinceTemp.class))
                .uniqueResult(); 
                 
                return provinceTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ProvinceTemp findData(String code,boolean active) {
        try {
            ProvinceTemp provinceTemp = (ProvinceTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_province.Code, "
                + "mst_province.name, "
                + "mst_province.remark,"
                + "mst_province.IslandCode, "
                + "mst_island.Name AS IslandName, "
                + "mst_island.countryCode, "
                + "mst_country.Name AS countryName "
                + "FROM mst_province "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE mst_province.code ='"+code+"' "
                + "AND mst_province.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ProvinceTemp.class))
                .uniqueResult(); 
                 
                return provinceTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ProvinceTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_province.ActiveStatus="+active+" ";
            }
            List<ProvinceTemp> list = (List<ProvinceTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_province.Code, "
                + "mst_province.name, "
                + "mst_province.IslandCode, "
                + "mst_island.Name AS IslandName, "
                + "mst_island.countryCode, "
                + "mst_country.Name AS countryName, "
                + "mst_province.remark, "
                + "mst_province.ActiveStatus "
                + "FROM mst_province "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE mst_province.code LIKE '%"+code+"%' "
                + "AND mst_province.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ProvinceTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Province province, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(province.isActiveStatus()){
                province.setInActiveBy("");                
            }else{
                province.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                province.setInActiveDate(new Date());
            }
            
            province.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            province.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(province);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    province.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Province province, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(province.isActiveStatus()){
                province.setInActiveBy("");                
            }else{
                province.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                province.setInActiveDate(new Date());
            }
            province.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            province.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(province);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    province.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ProvinceField.BEAN_NAME + " WHERE " + ProvinceField.CODE + " = :prmCode")
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
