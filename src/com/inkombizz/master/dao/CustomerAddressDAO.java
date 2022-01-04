/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.bll.CustomerBLL;
import java.util.Date;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.CustomerAddress;
import com.inkombizz.master.model.CustomerAddressField;
import com.inkombizz.master.model.CustomerAddressTemp;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author De4RagiL
 */

public class CustomerAddressDAO {
    
    private HBMSession hbmSession;

    public CustomerAddressDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    
    public String createCode(CustomerAddress customerAddress){   
        try{
            String acronim = "CUSADDR";
            DetachedCriteria dc = DetachedCriteria.forClass(CustomerAddress.class)
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
    
    private String executeStatus(String val){
        
            String value="";
            if((val.equals("Active")) || (val.equals("YES"))){
                value=" AND mst_customer_jn_address.ActiveStatus = 1 ";
            }else if((val.equals("InActive")) || (val.equals("NO"))){
                value=" AND mst_customer_jn_address.ActiveStatus = 0 ";
            }else{
                value=" ";
            }
            
        return value;
    }
    
    private String status(String val){
        
            String value="";
            if((val.equals("BillTo")) || (val.equals("billTo"))){
                value=" AND mst_customer_jn_address.BillToStatus = 1 ";
            }else if((val.equals("ShipTo")) || (val.equals("shipTo"))){
                value=" AND mst_customer_jn_address.ShipToStatus = 1 ";
            }else{
                value=" ";
            }
            
        return value;
    }
    
    private String executeParentPriceType(String val){
        
            String value="";
            if((val.equals("Active")) || (val.equals("YES"))){
                value=" AND mst_customer_jn_address.ParentPriceType = 1 ";
            }else if((val.equals("InActive")) || (val.equals("NO"))){
                value=" AND mst_customer_jn_address.ParentPriceType = 0 ";
            }else{
                value=" ";
            }
            
        return value;
    }
    
    public int countByQuery(String code,String name,String status){
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                + "COUNT(*) " 
                + "FROM mst_customer_jn_address "
                + "WHERE 1=1 "
                    + " AND mst_customer_jn_address.code LIKE :prmCode "
                    + " AND mst_customer_jn_address.name LIKE :prmName "
                    + executeStatus(status))
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataSearch(String customerCode,String code,String name,String status){
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_customer_jn_address.CustomerCode=:prmCustomerCode "
                + "AND mst_customer_jn_address.Code LIKE :prmCode "
                + "AND mst_customer_jn_address.Name LIKE :prmName "
                + executeStatus(status))
                .setParameter("prmCustomerCode", customerCode)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public int countDataSearch2(String customerCode,String code,String name,String status){
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
                + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_customer_jn_address.CustomerCode=:prmCustomerCode "
                + "AND mst_customer_jn_address.Code LIKE :prmCode "
                + "AND mst_customer_jn_address.Name LIKE :prmName "
                + executeStatus(status))
                .setParameter("prmCustomerCode", customerCode)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     
    public int countDataSearchByWarehouse(String code,String name,String status){
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(*) "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
                + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_customer_jn_address.Code LIKE :prmCode "
                + "AND mst_customer_jn_address.Name LIKE :prmName "
                + executeStatus(status))
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
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
                    + "SELECT COUNT(*) "
                    + "FROM mst_customer_jn_address "
                    + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                    + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                    + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
                    + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
                    + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                    + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer_jn_address.PriceTypeCode "
                    + "LEFT JOIN mst_sales_person ON mst_sales_person.code=mst_customer_jn_address.SalesPersonCode "
                    + "WHERE mst_customer_jn_address.Code LIKE '%"+code+"%' "
                        + "AND mst_customer_jn_address.Name LIKE '%"+name+"%' "
                        + "AND mst_customer_jn_address.code IN("+concatTemp+") ")
                    .uniqueResult();
            
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int isExisByQuery(String code, String status){
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                + "COUNT(*) " 
                + "FROM mst_customer_jn_address "
                + "WHERE 1=1 "
                    + " AND mst_customer_jn_address.code = :prmCode "
                    + executeStatus(status))
                .setParameter("prmCode", ""+code+"")
                .uniqueResult();
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
    
    public List<CustomerAddressTemp> findData(String code, String name, String customerCode, String status) {
        try {   
            
            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_customer_jn_address.Code AS code, "
                    + "mst_customer_jn_address.name AS name, "
                    + "mst_customer_jn_address.CustomerCode AS customerCode,"
                    + "mst_customer.name AS customerName, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.Address, "
                    + "mst_customer_jn_address.CityCode AS cityCode, "
                    + "mst_city.name AS cityName, "
                    + "mst_country.code AS countryCode, "
                    + "mst_country.name AS countryName, "
                    + "mst_customer_jn_address.shipToStatus, "
                    + "mst_customer_jn_address.billToStatus, "
                    + "mst_customer_jn_address.Phone1 AS phone1, "
                    + "mst_customer_jn_address.Phone2 AS phone2, "
                    + "mst_customer_jn_address.Fax AS fax, "
                    + "mst_customer_jn_address.EmailAddress AS emailAddress, "
                    + "mst_customer_jn_address.ContactPerson AS contactPerson, "
                    + "mst_customer_jn_address.Remark AS remark, "
                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_customer_jn_address.code LIKE :prmCode "
                    + " AND mst_customer_jn_address.name LIKE :prmName "
                    + " AND mst_customer_jn_address.customerCode = :prmCustomerCode "
                    + executeStatus(status)
                + "ORDER BY mst_customer_jn_address.code ASC "
                + "")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setParameter("prmCustomerCode", customerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    public int countDataSalesPersonCustomerAddress(String customerCode, String customerName,String salesPersonCode, String salesPersonName, String status) {
//        try {
//            
//               BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
//                 + "SELECT "
//                    + "COUNT(*) "
//                + "FROM mst_customer_jn_address "
//                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
//                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
//                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
//                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
//                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
//                + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer_jn_address.PriceTypeCode "
//                + "LEFT JOIN mst_sales_person ON mst_sales_person.code=mst_customer_jn_address.SalesPersonCode "
//                + "WHERE 1=1 "
//                    + " AND mst_customer_jn_address.CustomerCode LIKE :prmCustomerCode "
//                    + " AND mst_customer.name LIKE :prmCustomerName "
//                    + " AND IFNULL(mst_customer_jn_address.SalesPersonCode,'') LIKE :prmSalesPersonCode "
//                    + " AND IFNULL(mst_sales_person.name,'') LIKE :prmSalesPersonName "
//                    + executeStatus(status))
//                .setParameter("prmCustomerCode", "%"+customerCode+"%")
//                .setParameter("prmCustomerName", "%"+customerName+"%")
//                .setParameter("prmSalesPersonCode", "%"+salesPersonCode+"%")
//                .setParameter("prmSalesPersonName", "%"+salesPersonName+"%")
//                .uniqueResult();
//               
//            return temp.intValue();
//
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
//    
//    public List<CustomerAddressTemp> findDataSalesPersonCustomerAddress(String customerCode, String customerName,String salesPersonCode, String salesPersonName, String status,
//            int from ,int to) {
//        try {   
//            
//            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(""
//                + "SELECT "
//                    + "mst_customer_jn_address.Code AS code, "
//                    + "mst_customer_jn_address.name AS name, "
//                    + "mst_customer_jn_address.customerRegistrationId AS customerRegistrationId, "
//                    + "mst_customer_jn_address.CustomerCode AS customerCode,"
//                    + "mst_customer.name AS customerName, "
//                    + "mst_customer_jn_address.ActiveStatus, "
//                    + "mst_customer_jn_address.Address, "
//                    + "mst_customer_jn_address.CityCode AS cityCode, "
//                    + "mst_city.name AS cityName, "
//                    + "mst_country.code AS countryCode, "
//                    + "mst_country.name AS countryName, "
//                    + "mst_customer_jn_address.longitude, "
//                    + "mst_customer_jn_address.latitude, "
//                    + "mst_customer_jn_address.shipToStatus, "
//                    + "mst_customer_jn_address.billToStatus, "
//                    + "mst_customer_jn_address.defaultBillToCode, "
//                    + "mst_customer_jn_address.defaultShipToCode, "
//                    + "mst_customer_jn_address.Remark AS remark, "
//                    + "mst_customer_jn_address.PriceTypeCode AS priceTypeCode, "
//                    + "mst_price_type.name AS priceTypeName, "
//                    + "IFNULL(mst_customer_jn_address.SalesPersonCode,'') AS salesPersonCode, "
//                    + "IFNULL(mst_sales_person.name,'') AS salesPersonName, "
//                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
//                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
//                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
//                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
//                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
//                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
//                + "FROM mst_customer_jn_address "
//                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
//                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
//                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
//                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
//                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
//                + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer_jn_address.PriceTypeCode "
//                + "LEFT JOIN mst_sales_person ON mst_sales_person.code=mst_customer_jn_address.SalesPersonCode "
//                + "WHERE 1=1 "
//                    + " AND mst_customer_jn_address.CustomerCode LIKE :prmCustomerCode "
//                    + " AND mst_customer.name LIKE :prmCustomerName "
//                    + " AND IFNULL(mst_customer_jn_address.SalesPersonCode,'') LIKE :prmSalesPersonCode "
//                    + " AND IFNULL(mst_sales_person.name,'') LIKE :prmSalesPersonName "
//                    + executeStatus(status)
//                + "ORDER BY mst_customer_jn_address.code ASC "
//                + "")
//                    
//                .addScalar("code", Hibernate.STRING)
//                .addScalar("name", Hibernate.STRING)
//                .addScalar("customerRegistrationId", Hibernate.STRING)
//                .addScalar("customerCode", Hibernate.STRING)
//                .addScalar("customerName", Hibernate.STRING)
//                .addScalar("cityCode", Hibernate.STRING)
//                .addScalar("cityName", Hibernate.STRING)
//                .addScalar("address", Hibernate.STRING)
//                .addScalar("countryCode", Hibernate.STRING)
//                .addScalar("countryName", Hibernate.STRING)
//                .addScalar("salesPersonCode", Hibernate.STRING)
//                .addScalar("salesPersonName", Hibernate.STRING)
//                .addScalar("priceTypeCode", Hibernate.STRING)
//                .addScalar("priceTypeName", Hibernate.STRING)
//                .addScalar("longitude", Hibernate.BIG_DECIMAL)
//                .addScalar("latitude", Hibernate.BIG_DECIMAL)
//                .addScalar("activeStatus", Hibernate.BOOLEAN)
//                .addScalar("shipToStatus", Hibernate.BOOLEAN)
//                .addScalar("billToStatus", Hibernate.BOOLEAN)
//                .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
//                .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
//                .addScalar("remark", Hibernate.STRING)
//                .addScalar("inActiveBy", Hibernate.STRING)
//                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
//                .addScalar("createdBy", Hibernate.STRING)
//                .addScalar("createdDate", Hibernate.TIMESTAMP)
//                .addScalar("updatedDate", Hibernate.TIMESTAMP)
//                .setParameter("prmCustomerCode", "%"+customerCode+"%")
//                .setParameter("prmCustomerName", "%"+customerName+"%")
//                .setParameter("prmSalesPersonCode", "%"+salesPersonCode+"%")
//                .setParameter("prmSalesPersonName", "%"+salesPersonName+"%")
//                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
//                .setFirstResult(from)
//                .setMaxResults(to)
//                .list(); 
//                 
//                return list;
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
//    
//    public int countDataPriceListCustomerAddress(String customerCode, String customerName,String priceTypeCode, String priceTypeName, String status, String parentPriceType) {
//        try {   
//            
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
//                + "SELECT "
//                    + "COUNT(*) "
//                + "FROM mst_customer_jn_address "
//                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
//                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
//                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
//                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
//                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
//                + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer_jn_address.PriceTypeCode "
//                + "LEFT JOIN mst_sales_person ON mst_sales_person.code=mst_customer_jn_address.SalesPersonCode "
//                + "WHERE 1=1 "
//                    + " AND mst_customer_jn_address.CustomerCode LIKE :prmCustomerCode "
//                    + " AND mst_customer.name LIKE :prmCustomerName "
//                    + " AND mst_customer_jn_address.PriceTypeCode LIKE :prmPriceTypeCode "
//                    + " AND IFNULL(mst_price_type.name,'') LIKE :prmPriceTypeName "
//                    + executeStatus(status)
//                    + executeParentPriceType(parentPriceType)
//                + "ORDER BY mst_customer_jn_address.code ASC ")
//                    
//                .setParameter("prmCustomerCode", "%"+customerCode+"%")
//                .setParameter("prmCustomerName", "%"+customerName+"%")
//                .setParameter("prmPriceTypeCode", "%"+priceTypeCode+"%")
//                .setParameter("prmPriceTypeName", "%"+priceTypeName+"%")
//                .uniqueResult();
//                 
//                return temp.intValue();
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
//    
//    public List<CustomerAddressTemp> findDataPriceListCustomerAddress(String customerCode, String customerName,String priceTypeCode, String priceTypeName, String status, String parentPriceType,int from, int row) {
//        try {   
//            
//            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(""
//                + "SELECT "
//                    + "mst_customer_jn_address.Code AS code, "
//                    + "mst_customer_jn_address.name AS name, "
//                    + "mst_customer_jn_address.customerRegistrationId AS customerRegistrationId, "
//                    + "mst_customer_jn_address.CustomerCode AS customerCode,"
//                    + "mst_customer.name AS customerName, "
//                    + "mst_customer_jn_address.ActiveStatus, "
//                    + "mst_customer_jn_address.Address AS address, "
//                    + "mst_customer_jn_address.CityCode AS cityCode, "
//                    + "mst_city.name AS cityName, "
//                    + "mst_country.code AS countryCode, "
//                    + "mst_country.name AS countryName, "
//                    + "mst_customer_jn_address.shipToStatus, "
//                    + "mst_customer_jn_address.billToStatus, "
//                    + "mst_customer_jn_address.longitude, "
//                    + "mst_customer_jn_address.latitude, "
//                    + "mst_customer_jn_address.defaultBillToCode, "
//                    + "mst_customer_jn_address.defaultShipToCode, "
//                    + "mst_customer_jn_address.Remark AS remark, "
//                    + "mst_customer_jn_address.PriceTypeCode AS priceTypeCode, "
//                    + "mst_price_type.name AS priceTypeName, "
//                    + "mst_customer_jn_address.SalesPersonCode AS salesPersonCode, "
//                    + "mst_sales_person.name AS salesPersonName, "
//                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
//                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
//                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
//                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
//                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
//                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
//                + "FROM mst_customer_jn_address "
//                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
//                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
//                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
//                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
//                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
//                + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer_jn_address.PriceTypeCode "
//                + "LEFT JOIN mst_sales_person ON mst_sales_person.code=mst_customer_jn_address.SalesPersonCode "
//                + "WHERE 1=1 "
//                    + " AND mst_customer_jn_address.CustomerCode LIKE :prmCustomerCode "
//                    + " AND mst_customer.name LIKE :prmCustomerName "
//                    + " AND mst_customer_jn_address.PriceTypeCode LIKE :prmPriceTypeCode "
//                    + " AND IFNULL(mst_price_type.name,'') LIKE :prmPriceTypeName "
//                    + executeStatus(status)
//                    + executeParentPriceType(parentPriceType)
//                + "ORDER BY mst_customer_jn_address.code ASC "
//                + "")
//                    
//                .addScalar("code", Hibernate.STRING)
//                .addScalar("name", Hibernate.STRING)
//                .addScalar("customerCode", Hibernate.STRING)
//                .addScalar("customerName", Hibernate.STRING)
//                .addScalar("customerRegistrationId", Hibernate.STRING)
//                .addScalar("cityCode", Hibernate.STRING)
//                .addScalar("cityName", Hibernate.STRING)
//                .addScalar("address", Hibernate.STRING)
//                .addScalar("countryCode", Hibernate.STRING)
//                .addScalar("countryName", Hibernate.STRING)
//                .addScalar("salesPersonCode", Hibernate.STRING)
//                .addScalar("salesPersonName", Hibernate.STRING)
//                .addScalar("longitude", Hibernate.BIG_DECIMAL)
//                .addScalar("latitude", Hibernate.BIG_DECIMAL)
//                .addScalar("priceTypeCode", Hibernate.STRING)
//                .addScalar("priceTypeName", Hibernate.STRING)
//                .addScalar("activeStatus", Hibernate.BOOLEAN)
//                .addScalar("shipToStatus", Hibernate.BOOLEAN)
//                .addScalar("billToStatus", Hibernate.BOOLEAN)
//                .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
//                .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
//                .addScalar("remark", Hibernate.STRING)
//                .addScalar("inActiveBy", Hibernate.STRING)
//                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
//                .addScalar("createdBy", Hibernate.STRING)
//                .addScalar("createdDate", Hibernate.TIMESTAMP)
//                .addScalar("updatedDate", Hibernate.TIMESTAMP)
//                .setParameter("prmCustomerCode", "%"+customerCode+"%")
//                .setParameter("prmCustomerName", "%"+customerName+"%")
//                .setParameter("prmPriceTypeCode", "%"+priceTypeCode+"%")
//                .setParameter("prmPriceTypeName", "%"+priceTypeName+"%")
//                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
//                .setFirstResult(from)
//                .setMaxResults(row)
//                .list(); 
//                 
//                return list;
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    public List<CustomerAddressTemp> findData(String customerCode,String code, String name, String status,int from, int row) {
        try {   
            
            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                + "mst_customer_jn_address.Code, "
                + "mst_customer_jn_address.CustomerCode, "
                + "mst_customer_jn_address.Name, "
                + "mst_customer_jn_address.Address, "
                + "mst_customer_jn_address.CityCode, "
                + "mst_city.Name AS CityName, "
                + "mst_customer_jn_address.ZipCode, "
                + "mst_customer_jn_address.shipToStatus, "
                + "mst_customer_jn_address.billToStatus, "
                + "mst_customer_jn_address.Phone1, "
                + "mst_customer_jn_address.Phone2, "
                + "mst_customer_jn_address.Fax, "
                + "mst_customer_jn_address.EmailAddress, "
                + "mst_customer_jn_address.contactperson AS contactPerson "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_city ON mst_customer_jn_address.CityCode=mst_city.Code "
                + "WHERE mst_customer_jn_address.CustomerCode=:prmCustomerCode "
                + "AND mst_customer_jn_address.Code LIKE :prmCode "
                + "AND mst_customer_jn_address.Name LIKE :prmName "
                + executeStatus(status)
                + "ORDER BY mst_customer_jn_address.code ASC")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)                
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .setParameter("prmCustomerCode", customerCode)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<CustomerAddressTemp> findData2(String customerCode,String code, String name, String status,int from, int row) {
        try {   
            
            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_customer_jn_address.Code, "
                + "mst_customer_jn_address.CustomerCode, "
                + "mst_customer_jn_address.Name, "
                + "mst_customer_jn_address.Address, "
                + "mst_customer_jn_address.CityCode, "
                + "mst_city.Name AS CityName, "
                + "mst_country.code AS countryCode, "
                + "mst_country.name AS countryName, "
                + "mst_customer_jn_address.ZipCode, "
                + "mst_customer_jn_address.shipToStatus, "
                + "mst_customer_jn_address.billToStatus, "
                + "mst_customer_jn_address.Phone1, "
                + "mst_customer_jn_address.Phone2, "
                + "mst_customer_jn_address.Fax, "
                + "mst_customer_jn_address.EmailAddress, "
                + "mst_customer_jn_address.contactperson AS contactPerson "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_city ON mst_customer_jn_address.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
                + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_country.Code = mst_island.CountryCode "
                + "WHERE mst_customer_jn_address.CustomerCode=:prmCustomerCode "
                + "AND mst_customer_jn_address.Code LIKE :prmCode "
                + "AND mst_customer_jn_address.Name LIKE :prmName "
//                + "AND mst_customer_jn_address.BillToStatus = 1 "
                + executeStatus(status)
                + "ORDER BY mst_customer_jn_address.code ASC")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .setParameter("prmCustomerCode", customerCode)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    public List<CustomerAddressTemp> findDataByWarehouse(String code, String name, String status,int from, int row) {
//        try {   
//            
//            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(
//                    "SELECT "
//                + "mst_customer_jn_address.Code, "
//                + "mst_customer_jn_address.CustomerCode, "
//                + "mst_customer_jn_address.Name, "
//                + "mst_customer_jn_address.customerRegistrationId, "
//                + "mst_customer_jn_address.Address, "
//                + "mst_customer_jn_address.CityCode, "
//                + "mst_city.Name AS CityName, "
//                + "mst_island.Code AS IslandCode, "
//                + "mst_island.Name AS IslandName, "
//                + "mst_customer_jn_address.ZipCode, "
//                + "mst_customer_jn_address.shipToStatus, "
//                + "mst_customer_jn_address.billToStatus, "
//                + "mst_customer_jn_address.longitude, "
//                + "mst_customer_jn_address.latitude, "
//                + "mst_customer_jn_address.defaultBillToCode, "
//                + "mst_customer_jn_address.defaultShipToCode, "
//                + "mst_customer_jn_address.Phone1, "
//                + "mst_customer_jn_address.Phone2, "
//                + "mst_customer_jn_address.Fax, "
//                + "mst_customer_jn_address.EmailAddress, "
//                + "mst_customer_jn_address.contactperson AS contactPerson, "
//                + "mst_customer_jn_address.PriceTypeCode, "
//                + "mst_price_type.Name AS PriceTypeName, "
//                + "mst_customer_jn_address.SalesPersonCode, "
//                + "mst_sales_person.Name AS salesPersonName "
//                + "FROM mst_customer_jn_address "
//                + "INNER JOIN mst_city ON mst_customer_jn_address.CityCode=mst_city.Code "
//                + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
//                + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
//                + "LEFT JOIN mst_price_type ON mst_customer_jn_address.PriceTypeCode=mst_price_type.Code "
//                + "LEFT JOIN mst_sales_person ON mst_customer_jn_address.SalesPersonCode=mst_sales_person.Code "
//                + "WHERE mst_customer_jn_address.Code LIKE :prmCode "
//                + "AND mst_customer_jn_address.Name LIKE :prmName "
////                + "AND mst_customer_jn_address.BillToStatus = 1 "
//                + executeStatus(status)
//                + "ORDER BY mst_customer_jn_address.code ASC")
//                    
//                .addScalar("code", Hibernate.STRING)
//                .addScalar("customerCode", Hibernate.STRING)
//                .addScalar("name", Hibernate.STRING)
//                .addScalar("customerRegistrationId", Hibernate.STRING)
//                .addScalar("address", Hibernate.STRING)
//                .addScalar("cityCode", Hibernate.STRING)
//                .addScalar("cityName", Hibernate.STRING)
//                .addScalar("islandCode", Hibernate.STRING)
//                .addScalar("islandName", Hibernate.STRING)
//                .addScalar("zipCode", Hibernate.STRING)
//                .addScalar("phone1", Hibernate.STRING)
//                .addScalar("phone2", Hibernate.STRING)
//                .addScalar("fax", Hibernate.STRING)
//                .addScalar("emailAddress", Hibernate.STRING)
//                .addScalar("longitude", Hibernate.BIG_DECIMAL)
//                .addScalar("latitude", Hibernate.BIG_DECIMAL)    
//                .addScalar("contactPerson", Hibernate.STRING)
//                .addScalar("priceTypeCode", Hibernate.STRING)
//                .addScalar("priceTypeName", Hibernate.STRING)
//                .addScalar("salesPersonCode", Hibernate.STRING)
//                .addScalar("salesPersonName", Hibernate.STRING)
//                .addScalar("shipToStatus", Hibernate.BOOLEAN)
//                .addScalar("billToStatus", Hibernate.BOOLEAN)
//                .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
//                .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
//                .setParameter("prmCode", "%"+code+"%")
//                .setParameter("prmName", "%"+name+"%")
//                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
//                .setFirstResult(from)
//                .setMaxResults(row)
//                .list(); 
//                 
//                return list;
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    public List<CustomerAddressTemp> findSearchDataWithArray(String code, String name, String concat, int from, int row) {
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
            
                List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(""
                        + "SELECT "
                            + "mst_customer_jn_address.Code, "
                            + "mst_customer_jn_address.CustomerCode, "
                            + "mst_customer_jn_address.Name, "
                            + "mst_customer_jn_address.Address, "
                            + "mst_customer_jn_address.CityCode, "
                            + "mst_city.Name AS CityName, "
                            + "mst_country.code AS countryCode, "
                            + "mst_country.name AS countryName, "
                            + "mst_customer_jn_address.ZipCode, "
                            + "mst_customer_jn_address.shipToStatus, "
                            + "mst_customer_jn_address.billToStatus, "
                            + "mst_customer_jn_address.Phone1, "
                            + "mst_customer_jn_address.Phone2, "
                            + "mst_customer_jn_address.Fax, "
                            + "mst_customer_jn_address.EmailAddress, "
                            + "mst_customer_jn_address.contactperson AS contactPerson "
                        + "FROM mst_customer_jn_address "
                        + "INNER JOIN mst_city ON mst_customer_jn_address.CityCode=mst_city.Code "
                        + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
                        + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
                        + "INNER JOIN mst_country ON mst_country.Code = mst_island.CountryCode "
                        + "WHERE mst_customer_jn_address.code LIKE '%"+code+"%' "
                        + "AND mst_customer_jn_address.name LIKE '%"+name+"%' "
                        + "AND mst_customer_jn_address.code IN("+concatTemp+") "
                        + "LIMIT "+from+","+row+"")
                        .addScalar("code", Hibernate.STRING)
                        .addScalar("customerCode", Hibernate.STRING)
                        .addScalar("name", Hibernate.STRING)
                        .addScalar("customerRegistrationId", Hibernate.STRING)
                        .addScalar("address", Hibernate.STRING)
                        .addScalar("cityCode", Hibernate.STRING)
                        .addScalar("cityName", Hibernate.STRING)
                        .addScalar("islandCode", Hibernate.STRING)
                        .addScalar("islandName", Hibernate.STRING)
                        .addScalar("zipCode", Hibernate.STRING)
                        .addScalar("phone1", Hibernate.STRING)
                        .addScalar("phone2", Hibernate.STRING)
                        .addScalar("fax", Hibernate.STRING)
                        .addScalar("emailAddress", Hibernate.STRING)
                        .addScalar("longitude", Hibernate.BIG_DECIMAL)
                        .addScalar("latitude", Hibernate.BIG_DECIMAL)    
                        .addScalar("contactPerson", Hibernate.STRING)
                        .addScalar("priceTypeCode", Hibernate.STRING)
                        .addScalar("priceTypeName", Hibernate.STRING)
                        .addScalar("salesPersonCode", Hibernate.STRING)
                        .addScalar("salesPersonName", Hibernate.STRING)
                        .addScalar("shipToStatus", Hibernate.BOOLEAN)
                        .addScalar("billToStatus", Hibernate.BOOLEAN)
                        .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
                        .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
                        .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                        .list(); 
                
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerAddressTemp> findData(String code, String status) {
        try {   
            
            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_customer_jn_address.Code AS code, "
                    + "mst_customer_jn_address.name AS name, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.shipToStatus, "
                    + "mst_customer_jn_address.billToStatus, "
                    + "mst_customer_jn_address.longitude, "
                    + "mst_customer_jn_address.latitude, "
                    + "mst_customer_jn_address.defaultBillToCode, "
                    + "mst_customer_jn_address.defaultShipToCode, "
                    + "mst_customer_jn_address.Remark AS remark, "
                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
                + "FROM mst_customer_jn_address "
                + "WHERE 1=1 "
                    + " AND mst_customer_jn_address.code LIKE :prmCode "
                    + executeStatus(status)
                + "ORDER BY mst_customer_jn_address.code ASC "
                + "")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("customerRegistrationId", Hibernate.STRING)
                .addScalar("longitude", Hibernate.BIG_DECIMAL)
                .addScalar("latitude", Hibernate.BIG_DECIMAL)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
                .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
                .setParameter("prmCode", "%"+code+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     public List<CustomerAddressTemp> findDataCustomerAddressTemp(String headerCode) {
        try {
            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "mst_customer_jn_address.Code AS code, "
                    + "mst_customer_jn_address.name AS name, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.shipToStatus, "
                    + "mst_customer_jn_address.billToStatus, "
                    + "mst_customer_jn_address.contactPerson, "
                    + "mst_customer_jn_address.Remark AS remark, "
                    + "mst_customer_jn_address.CustomerCode AS customerCode, "
                    + "mst_customer.name AS customerName, "
                    + "mst_customer_jn_address.CityCode AS cityCode, "
                    + "mst_city.name AS cityName, "
                    + "mst_island.CountryCode AS countryCode, " 
                    + "mst_country.Name AS countryName, "
                    + "mst_customer_jn_address.Phone1 AS phone1, "
                    + "mst_customer_jn_address.Phone2 AS phone2, "
                    + "mst_customer_jn_address.Fax AS fax, "
                    + "mst_customer_jn_address.ZipCode AS zipCode, "
                    + "mst_customer_jn_address.EmailAddress AS emailAddress, "
                    + "mst_customer_jn_address.NpwpStatus AS npwpStatus, "
                    + "mst_customer_jn_address.Npwp AS npwp, "
                    + "mst_customer_jn_address.NpwpName AS npwpName, "
                    + "mst_customer_jn_address.NpwpAddress AS npwpAddress, "
                    + "mst_customer_jn_address.NpwpCityCode AS npwpCityCode, "
                    + "NpwpCityCode.Name AS npwpCityName, "
                    + "NpwpProvinceCode.Code AS npwpProvinceCode, "
                    + "NpwpProvinceCode.`Name` AS npwpProvinceName, "
                    + "NpwpIslandCode.Code AS npwpIslandCode, "
                    + "NpwpCountryCode.`Code` AS npwpCountryCode, "
                    + "NpwpCountryCode.`Name` AS npwpCountryName, "
                    + "mst_customer_jn_address.NpwpZipCode AS npwpZipCode, "            
                    + "mst_customer_jn_address.address "
                    + "FROM mst_customer_jn_address "
                    + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                    + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                    + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                    + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                    + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                    + "LEFT JOIN mst_city NpwpCityCode ON NpwpCityCode.`Code` = mst_customer_jn_address.`NpwpCityCode` "
                    + "LEFT JOIN mst_province NpwpProvinceCode ON NpwpProvinceCode.`Code` = NpwpCityCode.`ProvinceCode` "
                    + "LEFT JOIN mst_island NpwpIslandCode ON NpwpIslandCode.`Code` = NpwpProvinceCode.`IslandCode` "
                    + "LEFT JOIN mst_country NpwpCountryCode ON NpwpCountryCode.`Code` = NpwpIslandCode.`CountryCode` "             
                    + "WHERE mst_customer_jn_address.CustomerCode='" + headerCode + "' "
                    + "ORDER BY mst_customer_jn_address.code ASC  "
                    + "")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("customerCode", Hibernate.STRING)
                    .addScalar("customerName", Hibernate.STRING)
                    .addScalar("contactPerson", Hibernate.STRING)
                    .addScalar("cityCode", Hibernate.STRING)
                    .addScalar("cityName", Hibernate.STRING)
                    .addScalar("countryCode", Hibernate.STRING)
                    .addScalar("countryName", Hibernate.STRING)
                    .addScalar("phone1", Hibernate.STRING)
                    .addScalar("phone2", Hibernate.STRING)
                    .addScalar("zipCode", Hibernate.STRING)
                    .addScalar("fax", Hibernate.STRING)
                    .addScalar("emailAddress", Hibernate.STRING)
                    .addScalar("address", Hibernate.STRING)
                    .addScalar("activeStatus", Hibernate.BOOLEAN)
                    .addScalar("shipToStatus", Hibernate.BOOLEAN)
                    .addScalar("billToStatus", Hibernate.BOOLEAN)
                    .addScalar("npwpStatus", Hibernate.BOOLEAN)
                    .addScalar("npwp", Hibernate.STRING)
                    .addScalar("npwpName", Hibernate.STRING)
                    .addScalar("npwpAddress", Hibernate.STRING)
                    .addScalar("npwpCityCode", Hibernate.STRING)
                    .addScalar("npwpCityName", Hibernate.STRING)
                    .addScalar("npwpProvinceCode", Hibernate.STRING)
                    .addScalar("npwpProvinceName", Hibernate.STRING)
                    .addScalar("npwpIslandCode", Hibernate.STRING)
                    .addScalar("npwpCountryCode", Hibernate.STRING)
                    .addScalar("npwpCountryName", Hibernate.STRING)
                    .addScalar("npwpZipCode", Hibernate.STRING)    
                 
                    .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
     
      public int countDataCustomerAddressDetail(String code,String name,String status){
        try{ 
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(*) "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_customer_jn_address.code LIKE :prmCode "
                + "AND mst_customer_jn_address.name LIKE :prmName "
                + " "+status(status))
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
                 
                return temp.intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     
     public List<CustomerAddressTemp> findDataCustomerAddressDetail(String code, String name,String status, int from, int row) {
        try {   
            
            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>)hbmSession.hSession.createSQLQuery(
            "SELECT "
               + "mst_customer_jn_address.Code AS code, "
               + "mst_customer_jn_address.name AS name, "
               + "mst_customer_jn_address.ActiveStatus, "
               + "mst_customer_jn_address.shipToStatus, "
               + "mst_customer_jn_address.billToStatus, "
               + "mst_customer_jn_address.contactPerson, "
               + "mst_customer_jn_address.Remark AS remark, "
               + "mst_customer_jn_address.Phone1, "
               + "mst_customer_jn_address.CustomerCode AS customerCode, "
               + "mst_customer.name AS customerName, "
               + "mst_customer_jn_address.CityCode AS cityCode, "
               + "mst_city.name AS cityName, "
               + "mst_customer_jn_address.NpwpStatus AS npwpStatus, "
               + "mst_customer_jn_address.Npwp AS npwp, "
               + "mst_customer_jn_address.NpwpName AS npwpName, "
               + "mst_customer_jn_address.NpwpAddress AS npwpAddress, "
               + "mst_customer_jn_address.NpwpCityCode AS npwpCityCode, "
               + "NpwpCityCode.Name AS npwpCityName, "
               + "NpwpProvinceCode.Code AS npwpProvinceCode, "
               + "NpwpProvinceCode.`Name` AS npwpProvinceName, "
               + "NpwpIslandCode.Code AS npwpIslandCode, "
               + "NpwpCountryCode.`Code` AS npwpCountryCode, "
               + "NpwpCountryCode.`Name` AS npwpCountryName, "
               + "mst_customer_jn_address.NpwpZipCode AS npwpZipCode, "     
               + "mst_customer_jn_address.address "
               + "FROM mst_customer_jn_address "
               + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
               + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
               + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
               + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
               + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
               + "LEFT JOIN mst_city NpwpCityCode ON NpwpCityCode.`Code` = mst_customer_jn_address.`NpwpCityCode` "
               + "LEFT JOIN mst_province NpwpProvinceCode ON NpwpProvinceCode.`Code` = NpwpCityCode.`ProvinceCode` "
               + "LEFT JOIN mst_island NpwpIslandCode ON NpwpIslandCode.`Code` = NpwpProvinceCode.`IslandCode` "
               + "LEFT JOIN mst_country NpwpCountryCode ON NpwpCountryCode.`Code` = NpwpIslandCode.`CountryCode` "     
               + "WHERE mst_customer_jn_address.code LIKE :prmCode "
               + "AND mst_customer_jn_address.name LIKE :prmName "
               + " "+status(status)             
               + "ORDER BY mst_customer_jn_address.code ASC ")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .addScalar("npwpStatus", Hibernate.BOOLEAN)
                .addScalar("npwp", Hibernate.STRING)
                .addScalar("npwpName", Hibernate.STRING)
                .addScalar("npwpAddress", Hibernate.STRING)
                .addScalar("npwpCityCode", Hibernate.STRING)
                .addScalar("npwpCityName", Hibernate.STRING)
                .addScalar("npwpProvinceCode", Hibernate.STRING)
                .addScalar("npwpProvinceName", Hibernate.STRING)
                .addScalar("npwpIslandCode", Hibernate.STRING)
                .addScalar("npwpCountryCode", Hibernate.STRING)
                .addScalar("npwpCountryName", Hibernate.STRING)
                .addScalar("npwpZipCode", Hibernate.STRING)    
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     
    public List<CustomerAddressTemp> findDataCustomerAddressByDln(String headerCode, 
            String customerAddressCode, String customerAddressName) {
        try {
            List<CustomerAddressTemp> list = (List<CustomerAddressTemp>) hbmSession.hSession.createSQLQuery(""
                    + "SELECT DISTINCT "
                        + "mst_customer_jn_address.Code AS code, "
                        + "mst_customer_jn_address.name AS name, "
                        + "mst_customer_jn_address.ActiveStatus, "
                        + "mst_customer_jn_address.shipToStatus, "
                        + "mst_customer_jn_address.billToStatus, "
                        + "mst_customer_jn_address.defaultBillToCode, "
                        + "mst_customer_jn_address.defaultShipToCode, "
                        + "mst_customer_jn_address.contactPerson, "
                        + "mst_customer_jn_address.Remark AS remark, "
                        + "mst_customer_jn_address.CustomerCode AS customerCode, "
                        + "mst_customer.name AS customerName, "
                        + "mst_customer_jn_address.CityCode AS cityCode, "
                        + "mst_city.name AS cityName, "
                        + "mst_customer_jn_address.PriceTypeCode AS priceTypeCode, "
                        + "mst_customer_jn_address.address, "
                        + "mst_price_type.Name AS PriceTypeName, "
                        + "mst_customer_jn_address.SalesPersonCode, "
                        + "mst_sales_person.Name AS salesPersonName "
                    + "FROM  sal_sales_order_detail "
                    + "INNER JOIN mst_customer_jn_address ON mst_customer_jn_address.Code = sal_sales_order_detail.ShipToCode "
                    + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                    + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                    + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                    + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                    + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                    + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer_jn_address.PriceTypeCode "
                    + "LEFT JOIN mst_sales_person ON mst_sales_person.code=mst_customer_jn_address.SalesPersonCode "
                    + "WHERE "
                        + "sal_sales_order_detail.HeaderCode = :prmHeaderCode "
                        + "AND mst_customer_jn_address.code LIKE :prmCustomerAddressCode "
                        + "AND mst_customer_jn_address.name LIKE :prmCustomerAddressName "
                    + "ORDER BY mst_customer_jn_address.code ASC  "
                    + "")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("customerCode", Hibernate.STRING)
                    .addScalar("customerName", Hibernate.STRING)
                    .addScalar("contactPerson", Hibernate.STRING)
                    .addScalar("cityCode", Hibernate.STRING)
                    .addScalar("cityName", Hibernate.STRING)
                    .addScalar("priceTypeCode", Hibernate.STRING)
                    .addScalar("priceTypeName", Hibernate.STRING)
                    .addScalar("salesPersonCode", Hibernate.STRING)
                    .addScalar("salesPersonName", Hibernate.STRING)
                    .addScalar("address", Hibernate.STRING)
                    .addScalar("activeStatus", Hibernate.BOOLEAN)
                    .addScalar("shipToStatus", Hibernate.BOOLEAN)
                    .addScalar("billToStatus", Hibernate.BOOLEAN)
                    .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
                    .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
                    .setParameter("prmHeaderCode", headerCode)
                    .setParameter("prmCustomerAddressCode", "%" + customerAddressCode + "%")
                    .setParameter("prmCustomerAddressName", "%" + customerAddressName + "%")
                    .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    public CustomerAddressTemp populateGetData(String code, String name, String status) {
        try {
               CustomerAddressTemp customerAddressTemp = (CustomerAddressTemp) hbmSession.hSession.createSQLQuery(""
                + "SELECT mst_customer_jn_address.Code AS code, "
                    + "mst_customer_jn_address.name AS name, "
//                    + "mst_customer_jn_address.customerRegistrationId AS customerRegistrationId, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.shipToStatus, "
                    + "mst_customer_jn_address.billToStatus, "
                    + "mst_customer_jn_address.defaultBillToCode, "
                    + "mst_customer_jn_address.defaultShipToCode, "
                    + "mst_customer_jn_address.Remark AS remark, "
                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
                + "FROM mst_customer_jn_address "
                + "WHERE 1=1"
                       + " AND mst_customer_jn_address.code LIKE :prmCode "
                       + " AND mst_customer_jn_address.name LIKE :prmName "
                       + " "+executeStatus(status))
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
//                .addScalar("customerRegistrationId", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
                .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .uniqueResult(); 
                 
                return customerAddressTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerAddressTemp findDataBillAndShip(String code, String status, String statusBillShip) {
        try {
               CustomerAddressTemp customerAddressTemp = (CustomerAddressTemp) hbmSession.hSession.createSQLQuery(""
                 + "SELECT "
                    + "mst_customer_jn_address.Code AS code, "
                    + "mst_customer_jn_address.name AS name, "
                    + "mst_customer_jn_address.CustomerCode AS customerCode,"
                    + "mst_customer.name AS customerName, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.Address, "
                    + "mst_customer_jn_address.CityCode AS cityCode, "
                    + "mst_city.name AS cityName, "
                    + "mst_country.code AS countryCode, "
                    + "mst_country.name AS countryName, "
                    + "mst_customer_jn_address.shipToStatus, "
                    + "mst_customer_jn_address.billToStatus, "
                    + "mst_customer_jn_address.Phone1 AS phone1, "
                    + "mst_customer_jn_address.Phone2 AS phone2, "
                    + "mst_customer_jn_address.Fax AS fax, "
                    + "mst_customer_jn_address.EmailAddress AS emailAddress, "
                    + "mst_customer_jn_address.ContactPerson AS contactPerson, "
                    + "mst_customer_jn_address.Remark AS remark, "
                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "WHERE mst_customer_jn_address.code LIKE :prmCode "
                    + executeStatus(status)
                    + status(statusBillShip) )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", "%"+code+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .uniqueResult(); 
                 
                return customerAddressTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerAddressTemp getData2(String code, String customerCode, String shipToCode) {
        try {
               CustomerAddressTemp customerAddressTemp = (CustomerAddressTemp) hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_customer_jn_address.Code AS code, "
                    + "mst_customer_jn_address.name AS name, "
                    + "mst_customer_jn_address.CustomerCode AS customerCode,"
                    + "mst_customer.name AS customerName, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.Address, "
                    + "mst_customer_jn_address.CityCode AS cityCode, "
                    + "mst_city.name AS cityName, "
                    + "mst_country.code AS countryCode, "
                    + "mst_country.name AS countryName, "
                    + "mst_customer_jn_address.shipToStatus, "
                    + "mst_customer_jn_address.billToStatus, "
                    + "mst_customer_jn_address.Phone1 AS phone1, "
                    + "mst_customer_jn_address.Phone2 AS phone2, "
                    + "mst_customer_jn_address.Fax AS fax, "
                    + "mst_customer_jn_address.EmailAddress AS emailAddress, "
                    + "mst_customer_jn_address.ContactPerson AS contactPerson, "
                    + "mst_customer_jn_address.Remark AS remark, "
                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE 1=1 "
                    + " AND mst_customer_jn_address.code LIKE :prmCode "
                    + " AND mst_customer_jn_address.code LIKE :prmShipToCode "
                    + " AND mst_customer_jn_address.CustomerCode LIKE :prmCustomerCode "
                )
                    
               .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmCustomerCode", "%"+customerCode+"%")
                .setParameter("prmShipToCode", "%"+shipToCode+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .uniqueResult(); 
                 
                return customerAddressTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerAddressTemp populateGetData3(String code, String status) {
        try {
               CustomerAddressTemp customerAddressTemp = (CustomerAddressTemp) hbmSession.hSession.createSQLQuery(""
               + "SELECT "
                    + "mst_customer_jn_address.Code AS code, "
                    + "mst_customer_jn_address.name AS name, "
                    + "mst_customer_jn_address.CustomerCode AS customerCode, "
                    + "mst_customer_jn_address.longitude, "
                    + "mst_customer_jn_address.latitude, "
                    + "mst_customer.name AS customerName, "
                    + "mst_customer.address AS customerAddress, "
                    + "mst_customer.CityCode AS customerCityCode, "
                    + "custCity.name AS customerCityName, "
                    + "custCountry.code AS customerCountryCode, "
                    + "custCountry.name AS customerCountryName, "
                    + "mst_customer.phone1 AS customerPhone1, "
                    + "mst_customer.phone2 AS customerPhone2, "
                    + "mst_customer.fax AS customerFax, "
                    + "mst_customer.emailAddress AS customerEmailAddress, "
                    + "mst_customer.contactPerson AS customerContactPerson, "
                    + "mst_customer.customerCategoryCode AS customerCategoryCode, "
                    + "mst_customer_category.name AS customerCategoryName, "
                    + "mst_customer.customerSubTypeCode AS customerSubTypeCode, "
                    + "mst_customer_sub_type.name AS customerSubTypeName, "
                    + "mst_customer_sub_type.customerTypeCode, "
                    + "mst_customer_type.name AS customerTypeName, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.Address, "
                    + "mst_customer_jn_address.CityCode AS cityCode, "
                    + "custAddressCity.name AS cityName, "
                    + "custAddressCountry.code AS countryCode, "
                    + "custAddressCountry.name AS countryName, "
                    + "mst_customer_jn_address.phone1, "
                    + "mst_customer_jn_address.phone2, "
                    + "mst_customer_jn_address.fax, "
                    + "mst_customer_jn_address.emailAddress, "
                    + "mst_customer_jn_address.contactPerson, "
                    + "mst_customer_jn_address.shipToStatus, "
                    + "mst_customer_jn_address.billToStatus, "
                    + "mst_customer_jn_address.defaultBillToCode, "
                    + "mst_customer_jn_address.defaultShipToCode, "
                    + "mst_customer_jn_address.Remark AS remark, "
                    + "mst_customer_jn_address.PriceTypeCode AS priceTypeCode, "
                    + "mst_price_type.name AS priceTypeName, "
                    + "mst_customer_jn_address.SalesPersonCode AS salesPersonCode, "
                    + "mst_sales_person.name AS salesPersonName, "
                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.code "
                + "INNER JOIN mst_customer_sub_type ON mst_customer.CustomerSubTypeCode=mst_customer_sub_type.code "
                + "INNER JOIN mst_customer_type ON mst_customer_sub_type.CustomerTypeCode=mst_customer_type.code "
                + "INNER JOIN mst_city custCity ON custCity.Code = mst_customer.CityCode " 
                + " INNER JOIN mst_province custProvince ON custCity.ProvinceCode=custProvince.Code " 
                + " INNER JOIN mst_island custIsland ON custIsland.Code =custProvince.IslandCode  "
                + " INNER JOIN mst_country custCountry ON custIsland.CountryCode=custCountry.Code  "
                + " INNER JOIN mst_city custAddressCity ON custAddressCity.Code = mst_customer_jn_address.CityCode " 
                + " INNER JOIN mst_province custAddressProvince ON custAddressCity.ProvinceCode=custAddressProvince.Code  "
                + " INNER JOIN mst_island custAddressIsland ON custAddressIsland.Code =custAddressProvince.IslandCode " 
                + " INNER JOIN mst_country custAddressCountry ON custAddressIsland.CountryCode=custAddressCountry.Code  "
                + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer_jn_address.PriceTypeCode "
                + "LEFT JOIN mst_sales_person ON mst_sales_person.code=mst_customer_jn_address.SalesPersonCode "
                + "WHERE mst_customer_jn_address.code LIKE :prmCode "
                + "AND mst_customer_jn_address.BillToStatus = 1 "
                    +executeStatus(status))
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("customerCategoryCode", Hibernate.STRING)
                .addScalar("customerCategoryName", Hibernate.STRING)
                .addScalar("customerSubTypeCode", Hibernate.STRING)
                .addScalar("customerSubTypeName", Hibernate.STRING)
                .addScalar("customerTypeCode", Hibernate.STRING)
                .addScalar("customerTypeName", Hibernate.STRING)
                .addScalar("customerAddress", Hibernate.STRING)
                .addScalar("customerPhone1", Hibernate.STRING)
                .addScalar("customerPhone2", Hibernate.STRING)
                .addScalar("customerFax", Hibernate.STRING)
                .addScalar("customerEmailAddress", Hibernate.STRING)
                .addScalar("customerContactPerson", Hibernate.STRING)
                .addScalar("customerCityCode", Hibernate.STRING)
                .addScalar("customerCityName", Hibernate.STRING)
                .addScalar("customerCountryCode", Hibernate.STRING)
                .addScalar("customerCountryName", Hibernate.STRING)
                .addScalar("priceTypeCode", Hibernate.STRING)
                .addScalar("priceTypeName", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("contactPerson", Hibernate.STRING)       
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("priceTypeCode", Hibernate.STRING)
                .addScalar("priceTypeName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("shipToStatus", Hibernate.BOOLEAN)
                .addScalar("billToStatus", Hibernate.BOOLEAN)
                .addScalar("defaultBillToCode", Hibernate.BOOLEAN)
                .addScalar("defaultShipToCode", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", "%"+code+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                .uniqueResult(); 
                 
                return customerAddressTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    public CustomerAddress get(String code){
//        try{
//            return (CustomerAddress) hbmSession.hSession.get(CustomerAddress.class, code);
//        }catch(HibernateException e){
//            throw e;
//        }
//    }
    
    public CustomerAddressTemp findDataForUpdate(String code) {
        try{
            CustomerAddressTemp customerAddressTemp = (CustomerAddressTemp) hbmSession.hSession.createSQLQuery(""
                + "SELECT "
                    + "mst_customer_jn_address.Code AS code, "
                    + "mst_customer_jn_address.name AS name, "
                    + "mst_customer_jn_address.CustomerCode AS customerCode,"
                    + "mst_customer.name AS customerName, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.Address, "
                    + "mst_customer_jn_address.CityCode AS cityCode, "
                    + "mst_city.name AS cityName, "
                    + "mst_province.Code AS provinceCode, "
                    + "mst_province.Name AS provinceName, " 
                    + "mst_island.Code AS islandCode, "
                    + "mst_island.Name AS islandName, "
                    + "mst_country.code AS countryCode, "
                    + "mst_country.name AS countryName, "
                    + "mst_customer_jn_address.shipToStatus, "
                    + "mst_customer_jn_address.billToStatus, "
                    + "mst_customer_jn_address.Phone1 AS phone1, "
                    + "mst_customer_jn_address.Phone2 AS phone2,  "
                    + "mst_customer_jn_address.EmailAddress, "
                    + "mst_customer_jn_address.Fax AS fax, "
                    + "mst_customer_jn_address.ContactPerson AS contactPerson, "
                    + "mst_customer_jn_address.Remark AS remark, "
                    + "mst_customer_jn_address.NpwpStatus AS npwpStatus, "
                    + "mst_customer_jn_address.Npwp AS npwp, "
                    + "mst_customer_jn_address.NpwpName AS npwpName, "
                    + "mst_customer_jn_address.NpwpAddress AS npwpAddress, "
                    + "mst_customer_jn_address.NpwpCityCode AS npwpCityCode, "
                    + "NpwpCityCode.Name AS npwpCityName, "
                    + "NpwpProvinceCode.Code AS npwpProvinceCode, "
                    + "NpwpProvinceCode.`Name` AS npwpProvinceName, "
                    + "NpwpIslandCode.Code AS npwpIslandCode, "
                    + "NpwpIslandCode.Name AS npwpIslandName, "
                    + "NpwpCountryCode.`Code` AS npwpCountryCode, "
                    + "NpwpCountryCode.`Name` AS npwpCountryName, "
                    + "mst_customer_jn_address.NpwpZipCode AS npwpZipCode, "
                    + "mst_customer_jn_address.ActiveStatus, "
                    + "mst_customer_jn_address.InActiveBy AS inActiveBy, "
                    + "mst_customer_jn_address.InActiveDate AS inActiveDate, "
                    + "mst_customer_jn_address.CreatedBy AS createdBy, "
                    + "mst_customer_jn_address.CreatedDate AS createdDate, "
                    + "mst_customer_jn_address.UpdatedBy AS updatedBy, "
                    + "mst_customer_jn_address.UpdatedDate AS updatedDate "
                + "FROM mst_customer_jn_address "
                + "INNER JOIN mst_customer ON mst_customer.code = mst_customer_jn_address.CustomerCode "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer_jn_address.CityCode "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_island.Code =mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " 
                + "LEFT JOIN mst_city NpwpCityCode ON NpwpCityCode.`Code` = mst_customer_jn_address.`NpwpCityCode` "
                + "LEFT JOIN mst_province NpwpProvinceCode ON NpwpProvinceCode.`Code` = NpwpCityCode.`ProvinceCode` "
                + "LEFT JOIN mst_island NpwpIslandCode ON NpwpIslandCode.`Code` = NpwpProvinceCode.`IslandCode` "
                + "LEFT JOIN mst_country NpwpCountryCode ON NpwpCountryCode.`Code` = NpwpIslandCode.`CountryCode` "
             + "WHERE mst_customer_jn_address.code = '"+code+"' "
            )
                 .addScalar("code", Hibernate.STRING)
                 .addScalar("name", Hibernate.STRING)
                 .addScalar("address", Hibernate.STRING)
                 .addScalar("cityCode", Hibernate.STRING)
                 .addScalar("cityName", Hibernate.STRING)
                 .addScalar("countryCode", Hibernate.STRING)
                 .addScalar("countryName", Hibernate.STRING)
                 .addScalar("phone1", Hibernate.STRING)
                 .addScalar("phone2", Hibernate.STRING)
                 .addScalar("fax", Hibernate.STRING)
                 .addScalar("emailAddress", Hibernate.STRING)
                 .addScalar("contactPerson", Hibernate.STRING)
                 .addScalar("shipToStatus", Hibernate.BOOLEAN)
                 .addScalar("billToStatus", Hibernate.BOOLEAN)
                 .addScalar("npwpStatus", Hibernate.BOOLEAN)
                 .addScalar("activeStatus", Hibernate.BOOLEAN)
                 .addScalar("npwp", Hibernate.STRING)
                 .addScalar("npwpName", Hibernate.STRING)
                 .addScalar("npwpAddress", Hibernate.STRING)
                 .addScalar("npwpZipCode", Hibernate.STRING)
                 .addScalar("npwpCityCode", Hibernate.STRING)
                 .addScalar("npwpCityName", Hibernate.STRING)
                 .addScalar("npwpProvinceCode", Hibernate.STRING)
                 .addScalar("npwpProvinceName", Hibernate.STRING)
                 .addScalar("npwpIslandCode", Hibernate.STRING)
                 .addScalar("npwpIslandName", Hibernate.STRING)
                 .addScalar("npwpCountryCode", Hibernate.STRING)
                 .addScalar("npwpCountryName", Hibernate.STRING)
                 .addScalar("remark", Hibernate.STRING)
                 .addScalar("createdBy", Hibernate.STRING)
                 .addScalar("createdDate", Hibernate.TIMESTAMP)
                 .addScalar("inActiveBy", Hibernate.STRING)
                 .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                 .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                 .uniqueResult(); 
                 return customerAddressTemp;
        }catch(HibernateException e){
            throw e;
        }
    }
    
    public void save(CustomerAddress customerAddress, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            customerAddress.setCode(createCode(customerAddress));
            CustomerBLL customerBLL = new CustomerBLL(hbmSession);
//            Customer customer=new Customer();
//            customer=customerBLL.get(customerAddress.getCustomer().getCode());
//            customer.setApprovalStatus("PENDING");
//            hbmSession.hSession.update(customer);
            
            customerAddress.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerAddress.setCreatedDate(new Date()); 
//            customerAddress.setSalesPerson(null);
            hbmSession.hSession.save(customerAddress);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    customerAddress.getCode(), moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(CustomerAddress customerAddress, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(customerAddress.isActiveStatus()){
                customerAddress.setInActiveBy("");                
            }else{
                customerAddress.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                customerAddress.setInActiveDate(new Date());
            } 
            customerAddress.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerAddress.setUpdatedDate(new Date());
//            customerAddress.setSalesPerson(null);
            
            hbmSession.hSession.update(customerAddress);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerAddress.getCode(), moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
     public void updateSalesPersonCustomerAddress(CustomerAddress salesPersonCustomerAddress,String MODULECODE) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
//            salesPersonCustomerAddress.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
//            salesPersonCustomerAddress.setUpdatedDate(new Date()); 
        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat DATE_FORMAT_PERIOD = new SimpleDateFormat("dd/MM/yyyy");
        
        String updatedDated = DATE_FORMAT.format(new Date());


             String qry = "UPDATE  mst_customer_jn_address SET "
//                    +"mst_customer_jn_address.SalesPersonCode='"+salesPersonCustomerAddress.getSalesPerson().getCode()+"', "
                    +"mst_customer_jn_address.UpdatedBy='"+BaseSession.loadProgramSession().getUserName()+"', "
                    +"mst_customer_jn_address.UpdatedDate='"+updatedDated+"' "
                    +"WHERE mst_customer_jn_address.code = '" +salesPersonCustomerAddress.getCode()+ "' ";
            
            hbmSession.hSession.createSQLQuery(qry).executeUpdate();
            
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    salesPersonCustomerAddress.getCode(), MODULECODE));
             
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }    
     
     public void updatePriceListCustomerAddress(CustomerAddress priceListCustomerAddress,String MODULECODE) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
//            salesPersonCustomerAddress.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
//            salesPersonCustomerAddress.setUpdatedDate(new Date()); 
        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat DATE_FORMAT_PERIOD = new SimpleDateFormat("dd/MM/yyyy");
        
        String updatedDated = DATE_FORMAT.format(new Date());


             String qry = "UPDATE  mst_customer_jn_address SET "
//                    +"mst_customer_jn_address.PriceTypeCode='"+priceListCustomerAddress.getPriceType().getCode()+"', "
                    +"mst_customer_jn_address.UpdatedBy='"+BaseSession.loadProgramSession().getUserName()+"', "
                    +"mst_customer_jn_address.UpdatedDate='"+updatedDated+"' "
                    +"WHERE mst_customer_jn_address.code = '" +priceListCustomerAddress.getCode()+ "' ";
            
            hbmSession.hSession.createSQLQuery(qry).executeUpdate();
            
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    priceListCustomerAddress.getCode(), MODULECODE));
             
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }    
    
    
    public void delete(String id, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + CustomerAddressField.BEAN_NAME + " WHERE " + CustomerAddressField.CODE + " = :prmCode")
                    .setParameter("prmCode", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, moduleCode));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    } 
    
    public CustomerAddressTemp getMin() {
        try {
            
            String qry = "SELECT mst_customer_jn_address.code,mst_customer_jn_address.Name FROM mst_customer_jn_address ORDER BY mst_customer_jn_address.code LIMIT 0,1";
            CustomerAddressTemp companyTemp =(CustomerAddressTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerAddressTemp getMax() {
        try {
            
            String qry = "SELECT mst_customer_jn_address.code,mst_customer_jn_address.Name FROM mst_customer_jn_address ORDER BY mst_customer_jn_address.code DESC LIMIT 0,1";
            CustomerAddressTemp companyTemp =(CustomerAddressTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CustomerAddressTemp.class))
                    .uniqueResult();   
            
            return companyTemp;
            
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
