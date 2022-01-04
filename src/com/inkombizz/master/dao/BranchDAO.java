
package com.inkombizz.master.dao;


import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.BranchField;
import java.math.BigInteger;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.BranchTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;


public class BranchDAO {
    
    private HBMSession hbmSession;
    
    public BranchDAO(HBMSession session){
    this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_branch.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_branch "
                + "INNER JOIN mst_city ON mst_city.Code = mst_branch.CityCode  "
                + "WHERE mst_branch.Code LIKE '%"+code+"%' "
                + "AND mst_branch.Name LIKE '%"+name+"%' "
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
    
    public int countSearchDataWithArray(String code, String name, String concat){
        try{
            
            String[] x  = concat.split(",");
            String concatTemp = "";
            for(int i = 0; i <x.length; i++){
                if(i == 0){
                    concatTemp += "'" + x[i] + "'";
                }else{
                    concatTemp += ",'" + x[i] + "'";
                }
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                    + "SELECT COUNT(mst_branch.Code) "
                    + "FROM mst_branch "
                    + "WHERE mst_branch.code LIKE '%"+code+"%' "
                    + "AND mst_branch.name LIKE '%"+name+"%' "
                    + "AND mst_branch.code IN("+concatTemp+") "
                    + "AND mst_branch.ActiveStatus=TRUE")
                    .uniqueResult();
            
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public BranchTemp findData(String code) {
        try {
                BranchTemp branchTemp = (BranchTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_branch.Code, "
                + "mst_branch.name, "
                + "mst_branch.Address, "
                + "mst_branch.CityCode, "
                + "mst_city.Name AS CityName, "
                + "mst_island.CountryCode AS countryCode, "
                + "mst_country.name AS countryName, "
                + "mst_branch.zipCode, "
                + "mst_branch.Phone1, "
                + "mst_branch.Phone2, "
                + "mst_branch.Fax, "
                + "mst_branch.EmailAddress, "
                + "mst_branch.ContactPerson, "
                + "mst_branch.remark, "
                + "mst_branch.activeStatus, "
                + "mst_branch.inActiveBy, "
                + "mst_branch.inActiveDate, "
                + "mst_branch.createdBy, "
                + "mst_branch.createdDate, "
                            
                + " billTo.Code AS billToCode, "
                + "	billTo.Name AS billToName, "
                + "	billTo.Address AS billToAddress, "
                + "	billTo.ContactPerson AS billToContactPerson, "
                + "	billTo.Phone1 AS billToPhone1, "
                + "	 "
                + "	shipTo.Code AS shipToCode, "
                + "	shipTo.Name AS shipToName, "
                + "	shipTo.Address AS shipToAddress, "
                + "	shipTo.ContactPerson AS shipToContactPerson, "
                + "	shipTo.Phone1 AS shipToPhone1 "
                            
                + "FROM mst_branch "
                + "INNER JOIN mst_city ON mst_branch.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + " INNER JOIN mst_purchase_destination billTo ON mst_branch.DefaultBillToCode = billTo.Code "
                + " INNER JOIN mst_purchase_destination shipTo ON mst_branch.DefaultShipToCode = shipTo.Code "
                + "WHERE mst_branch.code ='"+code+"'")
                    
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
                        
                .addScalar("billToCode", Hibernate.STRING)
                .addScalar("billToName", Hibernate.STRING)
                .addScalar("billToAddress", Hibernate.STRING)
                .addScalar("billToContactPerson", Hibernate.STRING)
                .addScalar("billToPhone1", Hibernate.STRING)
                        
                .addScalar("shipToCode", Hibernate.STRING)
                .addScalar("shipToName", Hibernate.STRING)
                .addScalar("shipToAddress", Hibernate.STRING)
                .addScalar("shipToContactPerson", Hibernate.STRING)
                .addScalar("shipToPhone1", Hibernate.STRING)
                        
                .setResultTransformer(Transformers.aliasToBean(BranchTemp.class))
                .uniqueResult(); 
                 
                return branchTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public BranchTemp findData(String code,boolean active) {
        try {
               BranchTemp branchTemp = (BranchTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_branch.Code, "
                + "mst_branch.name "
                + "FROM mst_branch "
                + "WHERE mst_branch.code ='"+code+"' "
                + "AND mst_branch.ActiveStatus="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(BranchTemp.class))
                .uniqueResult(); 
                 
                return branchTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BranchTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_branch.ActiveStatus="+active+" ";
            }
            List<BranchTemp> list = (List<BranchTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "mst_branch.Code, "
                + "mst_branch.name, "
                + "mst_branch.address, "
                + "mst_branch.CityCode, "
                + "mst_city.name AS cityName, "
                + "mst_island.CountryCode AS countryCode, "
                + "mst_country.name AS countryName, "
                + "mst_branch.zipCode, "
                + "mst_branch.phone1, "
                + "mst_branch.phone2, "
                + "mst_branch.fax, "
                + "mst_branch.contactPerson, "
                + "mst_branch.remark, "
                + "mst_branch.emailAddress,"
                + "mst_branch.ActiveStatus "
                + "FROM mst_branch "
                + "INNER JOIN mst_city ON mst_city.Code = mst_branch.CityCode  "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_branch.code LIKE '%"+code+"%' "
                + "AND mst_branch.name LIKE '%"+name+"%' "
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
                .setResultTransformer(Transformers.aliasToBean(BranchTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BranchTemp> findSearchDataWithArray(String code, String name, String concat, int from, int row) {
        try {   
            
            String[] x  = concat.split(",");
            String concatTemp = "";
            for(int i = 0; i <x.length; i++){
                if(i == 0){
                    concatTemp += "'" + x[i] + "'";
                }else{
                    concatTemp += ",'" + x[i] + "'";
                }
            }
            
            List<BranchTemp> list = (List<BranchTemp>)hbmSession.hSession.createSQLQuery(""
                    + "SELECT "
                    + "mst_branch.Code, "
                    + "mst_branch.name "
                    + "FROM mst_branch "
                    + "WHERE mst_branch.code LIKE '%"+code+"%' "
                    + "AND mst_branch.name LIKE '%"+name+"%' "
                    + "AND mst_branch.code IN("+concatTemp+") "
                    + "AND mst_branch.ActiveStatus=TRUE "
                    + "LIMIT "+from+","+row+"")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(BranchTemp.class))
                    .list(); 
            
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BranchTemp> findAllBranchForDeposit() {
        try {   
            
            List<BranchTemp> list = (List<BranchTemp>)hbmSession.hSession.createSQLQuery(""
                    + "SELECT "
                    + "mst_branch.Code, "
                    + "mst_branch.name "
                    + "FROM mst_branch "
                    + "WHERE mst_branch.ActiveStatus=TRUE "
                    )
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(BranchTemp.class))
                    .list(); 
            
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Branch branch, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            branch.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            branch.setCreatedDate(new Date()); 
            hbmSession.hSession.save(branch);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    branch.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Branch branch, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            branch.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            branch.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(branch);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    branch.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + BranchField.BEAN_NAME + " WHERE " + BranchField.CODE + " = :prmCode")
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
     public BranchTemp getMin() {
        try {
            
            String qry = "SELECT mst_branch.code,mst_branch.Name FROM mst_branch ORDER BY mst_branch.code LIMIT 0,1";
            BranchTemp branchTemp =(BranchTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(BranchTemp.class))
                    .uniqueResult();   
            
            return branchTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public BranchTemp getMax() {
        try {
            
            String qry = "SELECT mst_branch.code,mst_branch.Name FROM mst_branch ORDER BY mst_branch.code DESC LIMIT 0,1";
            BranchTemp branchTemp =(BranchTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(BranchTemp.class))
                    .uniqueResult();   
            
            return branchTemp;
            
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
