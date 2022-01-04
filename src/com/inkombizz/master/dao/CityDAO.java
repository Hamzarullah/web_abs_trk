package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import java.util.List;
import java.util.Date;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.CityField;
import com.inkombizz.system.dao.TransactionLogDAO;

import com.inkombizz.master.model.City;
import com.inkombizz.master.model.CityTemp;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;


public class CityDAO {
    
    private HBMSession hbmSession;
    
    public CityDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_city.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_city "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "WHERE mst_city.code LIKE '%"+code+"%' "
                + "AND mst_city.name LIKE '%"+name+"%' "
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
    
    
    public CityTemp findData(String code) {
        try {
                CityTemp cityTemp = (CityTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_city.Code, "
                + "mst_city.name, "
                + "mst_city.ProvinceCode, "
                + "mst_province.Name AS ProvinceName, "
                + "mst_province.IslandCode AS ProvinceIslandCode, "
                + "mst_island.Name AS ProvinceIslandName, "
                + "mst_island.CountryCode AS provinceCountryCode, "
                + "mst_country.Name AS provinceCountryName, "
                + "mst_city.remark, "
                + "mst_city.InActiveBy, "
                + "mst_city.InActiveDate, "
                + "mst_city.activeStatus, "
                + "mst_city.createdBy, "
                + "mst_city.createdDate "
                + "FROM mst_city "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE mst_city.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("provinceIslandCode", Hibernate.STRING)
                .addScalar("provinceIslandName", Hibernate.STRING)
                .addScalar("provinceCountryCode", Hibernate.STRING)
                .addScalar("provinceCountryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(CityTemp.class))
                .uniqueResult(); 
                 
                return cityTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CityTemp findData(String code,boolean active) {
        try {
               CityTemp cityTemp = (CityTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_city.Code, "
                + "mst_city.name, "
                + "mst_city.ProvinceCode, "
                + "mst_province.Name AS ProvinceName, "
                + "mst_province.IslandCode AS ProvinceIslandCode, "
                + "mst_island.Name AS ProvinceIslandName, "
                + "mst_island.CountryCode AS ProvinceCountryCode, "
                + "mst_country.Name AS ProvinceCountryName, "
                + "mst_city.remark, "
                + "mst_city.InActiveBy, "
                + "mst_city.InActiveDate, "
                + "mst_city.activeStatus, "
                + "mst_city.createdBy, "
                + "mst_city.createdDate "
                + "FROM mst_city "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE mst_city.code ='"+code+"' "
                + "AND mst_city.ActiveStatus="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("provinceIslandCode", Hibernate.STRING)
                .addScalar("provinceIslandName", Hibernate.STRING)
                .addScalar("provinceCountryCode", Hibernate.STRING)
                .addScalar("provinceCountryName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CityTemp.class))
                .uniqueResult(); 
                 
                return cityTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CityTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_city.ActiveStatus="+active+" ";
            }
            List<CityTemp> list = (List<CityTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_city.Code, "
                + "mst_city.name, "
                + "mst_city.ProvinceCode, "
                + "mst_province.Name AS ProvinceName, "
                + "mst_province.IslandCode AS ProvinceIslandCode, "
                + "mst_island.Name AS ProvinceIslandName, "
                + "mst_island.CountryCode AS ProvinceCountryCode, "
                + "mst_country.Name AS ProvinceCountryName, "
                + "mst_city.remark, "
                + "mst_city.InActiveBy, "
                + "mst_city.InActiveDate, "
                + "mst_city.activeStatus, "
                + "mst_city.createdBy, "
                + "mst_city.createdDate "
                + "FROM mst_city "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE mst_city.code LIKE '%"+code+"%' "
                + "AND mst_city.name LIKE '%"+name+"%' "
                + concat_qry
                + "ORDER BY mst_city.code ASC "
                + "LIMIT "+from+","+row+"")
    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("provinceIslandCode", Hibernate.STRING)
                .addScalar("provinceIslandName", Hibernate.STRING)
                .addScalar("provinceCountryCode", Hibernate.STRING)
                .addScalar("provinceCountryName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CityTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(City city, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(city.isActiveStatus()){
                city.setInActiveBy("");                
            }else{
                city.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                city.setInActiveDate(new Date());
            }
            city.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            city.setCreatedDate(new Date()); 
            hbmSession.hSession.save(city);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    city.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(City city, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(city.isActiveStatus()){
                city.setInActiveBy("");                
            }else{
                city.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                city.setInActiveDate(new Date());
            }
            city.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            city.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(city);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    city.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CityField.BEAN_NAME + " WHERE " + CityField.CODE + " = :prmCode")
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
    
//    public int checkIsExistToDeleteCustomer (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_customer ON mst_customer.citycode = mst_city.code  " 
//            + "WHERE mst_customer.citycode = '"+Code+"'  "      ).uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteCustomerDestination (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_customer_destination ON mst_customer_destination.citycode = mst_city.code  " 
//            + "WHERE "        
//            + "mst_customer_destination.citycode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteDriver (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_driver ON mst_driver.citycode = mst_city.code  " 
//            + "WHERE "            
//            + "mst_driver.citycode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteBranch (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_branch ON mst_branch.citycode = mst_city.code  " 
//            + "WHERE "    
//            + "mst_branch.citycode = '"+Code+"' ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteExpedition (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_expedition ON mst_expedition.citycode = mst_city.code  " 
//            + "WHERE "          
//            + "mst_expedition.citycode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteFeeReceiver (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_fee_receiver ON mst_fee_receiver.citycode = mst_city.code  " 
//            + "WHERE "       
//            + "mst_fee_receiver.citycode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteGoodsInvoiceDestination (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_goods_invoice_destination ON mst_goods_invoice_destination.citycode = mst_city.code  " 
//            + "WHERE "       
//            + "mst_goods_invoice_destination.citycode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteHoldingCompany (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_holding_company ON mst_holding_company.citycode = mst_city.code  "
//            + "WHERE "      
//            + "mst_holding_company.citycode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteSupplier (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_supplier ON mst_supplier.citycode = mst_city.code  " 
//            + "WHERE "   
//            + "mst_supplier.citycode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//        
//    }
//    
//    public int checkIsExistToDeleteSalesman (String Code){
//        try{
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(" "
//            + "SELECT COUNT(mst_city.code)  "
//            + "FROM mst_city  "
//            + "INNER JOIN mst_salesman ON mst_salesman.citycode = mst_city.code  " 
//            + "WHERE "       
//            + "mst_salesman.citycode = '"+Code+"'  ").uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//    }
}