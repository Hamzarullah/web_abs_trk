
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ChartOfAccount;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.CustomerField;
import com.inkombizz.master.model.CustomerTemp;
import com.inkombizz.master.model.CustomerContactTemp;
import com.inkombizz.master.model.CustomerContactField;
import com.inkombizz.master.model.CustomerContact;
import com.inkombizz.master.model.Driver;
import com.inkombizz.utils.DateUtils;
import org.hibernate.criterion.Restrictions;


public class CustomerDAO {
    
    private HBMSession hbmSession;

    public CustomerDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    
    public String createCode(Customer customer){   
        try{
            String acronim = "CUS";
            DetachedCriteria dc = DetachedCriteria.forClass(Customer.class)
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
                concat_qry="AND mst_customer.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                + "SELECT COUNT(*) " 
                + "FROM mst_customer "
                + "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "INNER JOIN mst_business_entity ON mst_customer.BusinessEntityCode=mst_business_entity.Code "
                + "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code "
                + "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code "
                + "WHERE mst_customer.code LIKE '%"+code+"%' "
                + "AND mst_customer.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataEndUser(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_customer.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                + "SELECT COUNT(*) " 
                + "FROM mst_customer "
                + "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "INNER JOIN mst_business_entity ON mst_customer.BusinessEntityCode=mst_business_entity.Code "
                + "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code "
                + "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code "    
                + "WHERE mst_customer.code LIKE '%"+code+"%' "
                + "AND mst_customer.name LIKE '%"+name+"%' "
                + "AND mst_customer.endUserStatus = 1 "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countDataCust(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_customer.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                + "SELECT COUNT(*) " 
                + "FROM mst_customer "
                + "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "INNER JOIN mst_business_entity ON mst_customer.BusinessEntityCode=mst_business_entity.Code "
                + "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code "
                + "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code "    
                + "WHERE mst_customer.code LIKE '%"+code+"%' "
                + "AND mst_customer.name LIKE '%"+name+"%' "
                + "AND mst_customer.customerStatus = 1 "
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
   
    public CustomerTemp findData(String code) {
        try {
                CustomerTemp customerTemp = (CustomerTemp) hbmSession.hSession.createSQLQuery(
                  "SELECT " +
                "mst_customer.code, " +
                "mst_customer.name, " +
                "mst_customer.address, " +
                "mst_city.Code AS cityCode, " +
                "mst_city.Name AS cityName, " +
                "mst_province.Code AS provinceCode, " +
                "mst_province.Name AS provinceName, " +
                "mst_island.Code AS islandCode, " +
                "mst_island.name AS islandName, " +
                "mst_country.Code AS countryCode, " +
                "mst_country.Name AS countryName, " +
                "mst_customer.zipcode, " +
                "mst_customer.taxCode, " +
                "mst_payment_term.code AS PaymentTermCode, " +
                "mst_payment_term.Name AS PaymentTermName, " +
                "mst_customer_category.code AS CustomerCategoryCode, " +
                "mst_customer_category.Name AS CustomerCategoryName, " +                        
                "mst_customer.defaultContactPersonCode, " +
                "IFNULL(customerContact.name,'') AS defaultContactPersonName, " +
                "mst_customer.businessEntityCode, " +
                "mst_business_entity.name AS businessEntityName, " +
                "mst_customer.Phone1, " +
                "mst_customer.Phone2, " +
                "mst_customer.Fax, " +
                "mst_customer.EmailAddress AS emailAddress, " +
                "mst_customer.Remark, " +
                "mst_customer.activeStatus, " +
                "mst_customer.customerStatus, " +
                "mst_customer.endUserStatus, " +
                "mst_customer.InActiveBy, " +
                "mst_customer.InActiveDate, " +
                "mst_customer.createdBy, " +
                "mst_customer.createdDate " +
                "FROM mst_customer " +
                "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode = mst_payment_term.Code  "+
                "INNER JOIN mst_business_entity ON mst_customer.BusinessEntityCode = mst_business_entity.Code " +
                "LEFT JOIN mst_customer_jn_contact customerContact ON customerContact.code = mst_customer.defaultContactPersonCode AND mst_customer.code = customerContact.customerCode " +
                "INNER JOIN mst_city ON mst_customer.CityCode = mst_city.Code " +
                "INNER JOIN mst_province ON mst_city.ProvinceCode = mst_province.Code " +
                "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code " +
                "INNER JOIN mst_country ON mst_island.CountryCode = mst_country.Code " +
                "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code " +
                "WHERE mst_customer.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("taxCode", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("customerCategoryCode", Hibernate.STRING)
                .addScalar("customerCategoryName", Hibernate.STRING)     
                .addScalar("businessEntityCode", Hibernate.STRING)     
                .addScalar("businessEntityName", Hibernate.STRING)        
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .addScalar("defaultContactPersonName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("customerStatus", Hibernate.BOOLEAN)
                .addScalar("endUserStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                .uniqueResult(); 
                 
                return customerTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerTemp findData(String code,boolean active, boolean status) {
        try {
            
                CustomerTemp customerTemp = (CustomerTemp) hbmSession.hSession.createSQLQuery(
                  " SELECT " +
                "mst_customer.Code, " +
                "mst_customer.name, " +
                "mst_customer.Address, " +
                "mst_customer.CityCode, " +
                "mst_city.Name AS CityName, " +
                "mst_city.ProvinceCode, " +
                "mst_province.Name AS provinceName, " +
                "mst_province.IslandCode," +
                "mst_island.name AS islandName," +
                "mst_island.CountryCode, " +
                "mst_country.Name AS CountryName, " +
                "mst_customer.zipcode, " +
                "mst_customer.taxCode, " +
                "mst_customer.PaymentTermCode, " +
                "mst_payment_term.Name AS PaymentTermName, " +                                           
                "mst_customer.businessEntityCode, " +
                "mst_business_entity.name AS businessEntityName, " +
                "mst_customer.defaultContactPersonCode, " +
                "IFNULL(customerContact.name,'') AS defaultContactPersonName, " +
                "mst_customer.Phone1, " +
                "mst_customer.Phone2, " +
                "mst_customer.Fax, " +
                "mst_customer.EmailAddress AS emailAddress, " +
                "mst_customer_category.code AS CustomerCategoryCode, " +
                "mst_customer_category.Name AS CustomerCategoryName, " +          
                "mst_customer.Remark, " +
                "mst_customer.activeStatus, " +
                "mst_customer.customerStatus, " +
                "mst_customer.endUserStatus, " +                
                "mst_customer.InActiveBy, " +
                "mst_customer.InActiveDate, " +
                "mst_customer.createdBy, " +
                "mst_customer.createdDate " +
                "FROM mst_customer " +
                "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code " +
                "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code " +
                "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code " +
                "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " +
                "INNER JOIN mst_business_entity ON mst_customer.businessEntityCode=mst_business_entity.Code " +
                "LEFT JOIN mst_customer_jn_contact customerContact ON customerContact.code=mst_customer.defaultContactPersonCode AND mst_customer.code = customerContact.customerCode " +
                "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code "+
                "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code "           
                + "WHERE mst_customer.code ='"+code+"' "
                + "AND mst_customer.ActiveStatus= "+active+" "
                + "AND mst_customer.customerStatus= "+status+" "          
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("taxCode", Hibernate.STRING)
                .addScalar("customerStatus", Hibernate.BOOLEAN)
                .addScalar("endUserStatus", Hibernate.BOOLEAN)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("businessEntityCode", Hibernate.STRING)
                .addScalar("businessEntityName", Hibernate.STRING)
                .addScalar("customerCategoryCode", Hibernate.STRING)
                .addScalar("customerCategoryName", Hibernate.STRING)        
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                .uniqueResult(); 
                 
                return customerTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerTemp findDataEnd(String code,boolean active) {
        try {
            
                CustomerTemp customerTemp = (CustomerTemp) hbmSession.hSession.createSQLQuery(
                  " SELECT " +
                "mst_customer.Code, " +
                "mst_customer.name, " +
                "mst_customer.Address, " +
                "mst_customer.CityCode, " +
                "mst_city.Name AS CityName, " +
                "mst_city.ProvinceCode, " +
                "mst_province.Name AS provinceName, " +
                "mst_province.IslandCode," +
                "mst_island.name AS islandName," +
                "mst_island.CountryCode, " +
                "mst_country.Name AS CountryName, " +
                "mst_customer.zipcode, " +
                "mst_customer.taxCode, " +
                "mst_customer.PaymentTermCode, " +
                "mst_payment_term.Name AS PaymentTermName, " +
                "mst_customer.businessEntityCode, " +
                "mst_business_entity.name AS businessEntityName, " +          
                "mst_customer.defaultContactPersonCode, " +
                "IFNULL(customerContact.name,'') AS defaultContactPersonName, " +
                "mst_customer.Phone1, " +
                "mst_customer.Phone2, " +
                "mst_customer.Fax, " +
                "mst_customer.EmailAddress AS emailAddress, " +
                "mst_customer_category.code AS CustomerCategoryCode, " +
                "mst_customer_category.Name AS CustomerCategoryName, " +          
                "mst_customer.Remark, " +
                "mst_customer.activeStatus, " +
                "mst_customer.customerStatus, " +
                "mst_customer.endUserStatus, " +                
                "mst_customer.InActiveBy, " +
                "mst_customer.InActiveDate, " +
                "mst_customer.createdBy, " +
                "mst_customer.createdDate " +
                "FROM mst_customer " +
                "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code " +
                "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code " +
                "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code " +
                "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " +
                "INNER JOIN mst_business_entity ON mst_customer.businessEntityCode=mst_business_entity.Code " +
                "LEFT JOIN mst_customer_jn_contact customerContact ON customerContact.code=mst_customer.defaultContactPersonCode AND mst_customer.code = customerContact.customerCode " +
                "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code "+
                "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code "           
                + "WHERE mst_customer.code ='"+code+"' "
                + "AND mst_customer.ActiveStatus= "+active+" "
                + "AND mst_customer.endUserStatus= 1 "       
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("taxCode", Hibernate.STRING)
                .addScalar("customerStatus", Hibernate.BOOLEAN)
                .addScalar("endUserStatus", Hibernate.BOOLEAN)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("customerCategoryCode", Hibernate.STRING)
                .addScalar("customerCategoryName", Hibernate.STRING)        
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .addScalar("businessEntityCode", Hibernate.STRING)
                .addScalar("businessEntityName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                .uniqueResult(); 
                 
                return customerTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerTemp> findDataForCustomerOrder(String code, String name,String active,int from, int row) {
            try {   
                String concat_qry="";
                if(!active.equals("")){
                    concat_qry="AND mst_customer.ActiveStatus="+active+" ";
                }
                List<CustomerTemp> list = (List<CustomerTemp>)hbmSession.hSession.createSQLQuery(
                        "SELECT " +
                        "mst_customer.Code, " +
                        "mst_customer.name, " +
                        "mst_customer.Address, " +
                        "mst_customer.CityCode, " +
                        "mst_city.Name AS CityName, " +
                        "mst_city.ProvinceCode, " +
                        "mst_province.Name AS provinceName, " +
                        "mst_province.IslandCode, " +
                        "mst_island.Name AS islandName, " +
                        "mst_island.CountryCode, " +
                        "mst_country.Name AS CountryName, " +
                        "mst_customer.zipcode, " +
                        "mst_customer.taxCode, " +
                        "mst_customer.PaymentTermCode, " +
                        "mst_payment_term.Name AS PaymentTermName, " +                                                       
                        "mst_customer.defaultContactPersonCode, " +
                        "mst_customer.businessEntityCode, " +
                        "mst_business_entity.name AS businessEntityName, " +
                        "BillTo.Code AS billToCode, " +
                        "BillTo.Name AS billToName, " +
                        "BillTo.Address AS billToAddress, " +
                        "BillTo.ContactPerson AS billToContactPerson, " +
                        "ShipTo.Code AS shipToCode, " +
                        "ShipTo.Name AS shipToName, " +
                        "ShipTo.Address AS shipToAddress, " +
                        "ShipTo.ContactPerson AS shipToContactPerson, " +
                        "mst_customer.Phone1, " +
                        "mst_customer.Phone2, " +
                        "mst_customer.Fax, " +
                        "mst_customer.EmailAddress AS emailAddress, " +
                        "mst_customer_category.code AS CustomerCategoryCode, " +
                        "mst_customer_category.Name AS CustomerCategoryName, " +             
                        "mst_customer.Remark, " +
                        "mst_customer.activeStatus, " +
                        "mst_customer.customerStatus, " +
                        "mst_customer.endUserStatus, " +
                        "mst_customer.createdBy, " +
                        "mst_customer.createdDate " +
                        "FROM mst_customer " +
                        "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code " +
                        "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code " +
                        "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code " +
                        "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " +
                        "INNER JOIN mst_business_entity ON mst_customer.businessEntityCode=mst_business_entity.Code " +
                        "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code " +        
                        "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code " +
                                 "LEFT JOIN (SELECT " +
					"mst_customer_jn_address.Code, " +
					"mst_customer_jn_address.Name, " +
					"mst_customer_jn_address.CustomerCode, " +
					"mst_customer_jn_address.Address, " +
					"mst_customer_jn_address.contactperson " +
				    "FROM mst_customer_jn_address " +
				    "WHERE mst_customer_jn_address.billToStatus = 1 " +
				   ") AS BillTo ON BillTo.CustomerCode = mst_customer.Code " +
			"LEFT JOIN (SELECT " +
					"mst_customer_jn_address.Code, " +
					"mst_customer_jn_address.Name, " +
					"mst_customer_jn_address.CustomerCode, " +
					"mst_customer_jn_address.Address, " +
					"mst_customer_jn_address.contactperson " +
				    "FROM mst_customer_jn_address " +
				    "WHERE mst_customer_jn_address.shipToStatus = 1 " +
				  ") AS ShipTo ON ShipTo.CustomerCode = mst_customer.Code " 
                    + "WHERE mst_customer.code LIKE '%"+code+"%' "
                    + "AND mst_customer.name LIKE '%"+name+"%' "
                    + concat_qry
                    + "LIMIT "+from+","+row+"")

                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .addScalar("address", Hibernate.STRING)
                    .addScalar("cityCode", Hibernate.STRING)
                    .addScalar("cityName", Hibernate.STRING)
                    .addScalar("provinceCode", Hibernate.STRING)
                    .addScalar("provinceName", Hibernate.STRING)
                    .addScalar("countryCode", Hibernate.STRING)
                    .addScalar("countryName", Hibernate.STRING)
                    .addScalar("zipCode", Hibernate.STRING)
                    .addScalar("taxCode", Hibernate.STRING)
                    .addScalar("billToCode", Hibernate.STRING)
                    .addScalar("billToName", Hibernate.STRING)
                    .addScalar("billToAddress", Hibernate.STRING)
                    .addScalar("billToContactPerson", Hibernate.STRING)
                    .addScalar("shipToCode", Hibernate.STRING)
                    .addScalar("shipToName", Hibernate.STRING)
                    .addScalar("shipToAddress", Hibernate.STRING)
                    .addScalar("shipToContactPerson", Hibernate.STRING)
                    .addScalar("phone1", Hibernate.STRING)
                    .addScalar("phone2", Hibernate.STRING)
                    .addScalar("fax", Hibernate.STRING)
                    .addScalar("emailAddress", Hibernate.STRING)
                    .addScalar("paymentTermCode", Hibernate.STRING)
                    .addScalar("paymentTermName", Hibernate.STRING)
                    .addScalar("businessEntityCode", Hibernate.STRING)
                    .addScalar("businessEntityName", Hibernate.STRING)
                    .addScalar("defaultContactPersonCode", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("activeStatus", Hibernate.BOOLEAN)
                    .addScalar("customerStatus", Hibernate.BOOLEAN)
                    .addScalar("endUserStatus", Hibernate.BOOLEAN)
                    .addScalar("customerCategoryCode", Hibernate.STRING)
                    .addScalar("customerCategoryName", Hibernate.STRING)    
                    .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                    .list(); 

                    return list;
            }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    public int countDataForCustomerOrder(String code, String name, String branchCode){
//        try{
//            
//            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
//                    + "SELECT COUNT(*) " 
//                    + "FROM mst_customer "
//                    + "INNER JOIN mst_city ON mst_city.Code = mst_customer.CityCode "
//                    + "INNER JOIN mst_branch ON mst_branch.code = mst_customer.RegisteredBranchCode "
//                    + "INNER JOIN mst_payment_term ON mst_payment_term.Code = mst_customer.PaymentTermCode "
//                    + "INNER JOIN mst_customer_category ON mst_customer_category.Code = mst_customer.CustomerCategoryCode "
//                    + "INNER JOIN mst_customer_sub_type ON mst_customer_sub_type.Code = mst_customer.CustomerSubTypeCode "
//                    + "INNER JOIN mst_customer_type ON mst_customer_sub_type.CustomerTypeCode = mst_customer_type.Code "
//                    + "INNER JOIN mst_customer_class ON mst_customer_class.Code = mst_customer.CustomerClassCode "
//                    + "LEFT JOIN mst_chart_of_account ARAccount ON ARAccount.Code = mst_customer.ARAccountCode "
//                    + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer.PriceTypeCode "
//                    + "INNER JOIN mst_city npwpCity ON npwpCity.Code = mst_customer.NPWPCityCode "
//                    + "INNER JOIN mst_customer_jn_branch ON mst_customer_jn_branch.CustomerCode = mst_customer.Code "
//                        + "AND mst_customer_jn_branch.BranchCode = :prmBranchCode "
//                    + "WHERE "
//                        + "mst_customer.code LIKE :prmCode "
//                        + "AND mst_customer.name LIKE :prmName "
//                        + "AND mst_customer.ActiveStatus = 1 "
//                        + "AND mst_customer.ApprovalStatus = 'APPROVED' ")
//                    .setParameter("prmBranchCode", branchCode)
//                    .setParameter("prmCode", "%"+code+"%")
//                    .setParameter("prmName", "%"+name+"%")
//                    .uniqueResult();
//            return temp.intValue();
//            
//        }catch(Exception e){
//            e.printStackTrace();
//            return 0;
//        }
//    }
    
    public List<CustomerTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_customer.ActiveStatus="+active+" ";
            }
            List<CustomerTemp> list = (List<CustomerTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "mst_customer.Code, " +
                    "mst_customer.name, " +
                    "mst_customer.Address, " +
                    "mst_customer.CityCode, " +
                    "mst_city.Name AS CityName, " +
                    "mst_city.ProvinceCode, " +
                    "mst_province.Name AS provinceName, " +
                    "mst_province.IslandCode, " +
                    "mst_island.Name AS islandName, " +
                    "mst_island.CountryCode, " +
                    "mst_country.Name AS CountryName, " +
                    "mst_customer.zipcode, " +
                    "mst_customer.PaymentTermCode, " +
                    "mst_payment_term.Name AS PaymentTermName, " +                                     
                    "mst_customer.defaultContactPersonCode, " +
                    "mst_customer.businessEntityCode, " +
                    "mst_business_entity.name AS businessEntityName, " +        
                    "mst_customer.Phone1, " +
                    "mst_customer.Phone2, " +
                    "mst_customer.Fax, " +
                    "mst_customer.EmailAddress AS emailAddress, " +
                    "mst_customer_category.code AS CustomerCategoryCode, " +
                    "mst_customer_category.Name AS CustomerCategoryName, " +           
                    "mst_customer.Remark, " +
                    "mst_customer_category.code AS CustomerCategoryCode, " +
                    "mst_customer_category.Name AS CustomerCategoryName, " +             
                    "mst_customer.activeStatus, " +
                    "CASE " +
                        "WHEN mst_customer.customerStatus = 1 THEN 'YES' " +
                        "WHEN mst_customer.customerStatus = 0 THEN 'NO' " +
                    "END AS customerStatusCust, " +
                    "CASE " +
                        "WHEN mst_customer.endUserStatus = 1 THEN 'YES' " +
                        "WHEN mst_customer.endUserStatus = 0 THEN 'NO' " +
                    "END AS endUserStatusCust, " +
                    "mst_customer.taxCode, " +
                    "mst_customer.createdBy, " +
                    "mst_customer.createdDate " +
                    "FROM mst_customer " +
                    "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code " +
                    "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code " +
                    "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code " +
                    "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " +
                    "INNER JOIN mst_business_entity ON mst_customer.businessEntityCode=mst_business_entity.Code " +
                    "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code "+
                    "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code "         
                + "WHERE mst_customer.code LIKE '%"+code+"%' "
                + "AND mst_customer.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("taxCode", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("businessEntityCode", Hibernate.STRING)
                .addScalar("businessEntityName", Hibernate.STRING)
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("endUserStatusCust", Hibernate.STRING)
                .addScalar("customerStatusCust", Hibernate.STRING)
                .addScalar("customerCategoryCode", Hibernate.STRING)
                .addScalar("customerCategoryName", Hibernate.STRING)      
                .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerTemp> findDataCust(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_customer.ActiveStatus="+active+" ";
            }
            List<CustomerTemp> list = (List<CustomerTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "mst_customer.Code, " +
                    "mst_customer.name, " +
                    "mst_customer.Address, " +
                    "mst_customer.CityCode, " +
                    "mst_city.Name AS CityName, " +
                    "mst_city.ProvinceCode, " +
                    "mst_province.Name AS provinceName, " +
                    "mst_province.IslandCode, " +
                    "mst_island.Name AS islandName, " +
                    "mst_island.CountryCode, " +
                    "mst_country.Name AS CountryName, " +
                    "mst_customer.zipcode, " +
                    "mst_customer.PaymentTermCode, " +
                    "mst_payment_term.Name AS PaymentTermName, " +                                               
                    "mst_customer.defaultContactPersonCode, " +
                    "mst_customer.businessEntityCode, " +
                    "mst_business_entity.name AS businessEntityName, " +
                    "mst_customer.Phone1, " +
                    "mst_customer.Phone2, " +
                    "mst_customer.Fax, " +
                    "mst_customer.EmailAddress AS emailAddress, " +
                    "mst_customer.Remark, " +
                    "mst_customer_category.code AS CustomerCategoryCode, " +
                    "mst_customer_category.Name AS CustomerCategoryName, " +                   
                    "mst_customer.activeStatus, " +
                    "mst_customer.createdBy, " +
                    "mst_customer.createdDate " +
                    "FROM mst_customer " +
                    "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code " +
                    "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code " +
                    "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code " +
                    "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " +
                    "INNER JOIN mst_business_entity ON mst_customer.businessEntityCode=mst_business_entity.Code " +
                    "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code " +
                    "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code "        
                + "WHERE mst_customer.code LIKE '%"+code+"%' "
                + "AND mst_customer.name LIKE '%"+name+"%' "
                + concat_qry
                + "AND mst_customer.customerStatus = 1 "            
               + "LIMIT "+from+","+row+"")
    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("businessEntityCode", Hibernate.STRING)
                .addScalar("businessEntityName", Hibernate.STRING)
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("customerCategoryCode", Hibernate.STRING)
                .addScalar("customerCategoryName", Hibernate.STRING)    
                .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerTemp> findDataEndUser(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_customer.ActiveStatus="+active+" ";
            }
            List<CustomerTemp> list = (List<CustomerTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "mst_customer.Code, " +
                    "mst_customer.name, " +
                    "mst_customer.Address, " +
                    "mst_customer.CityCode, " +
                    "mst_city.Name AS CityName, " +
                    "mst_city.ProvinceCode, " +
                    "mst_province.Name AS provinceName, " +
                    "mst_province.IslandCode, " +
                    "mst_island.Name AS islandName, " +
                    "mst_island.CountryCode, " +
                    "mst_country.Name AS CountryName, " +
                    "mst_customer.zipcode, " +
                    "mst_customer.PaymentTermCode, " +
                    "mst_payment_term.Name AS PaymentTermName, " +                                                    
                    "mst_customer.defaultContactPersonCode, " +
                    "mst_customer.businessEntityCode, " +
                    "mst_business_entity.name AS businessEntityName, " +
                    "mst_customer.Phone1, " +
                    "mst_customer.Phone2, " +
                    "mst_customer.Fax, " +
                    "mst_customer.EmailAddress AS emailAddress, " +
                    "mst_customer.Remark, " +
                    "mst_customer_category.code AS CustomerCategoryCode, " +
                    "mst_customer_category.Name AS CustomerCategoryName, " +         
                    "mst_customer.activeStatus, " +
                    "mst_customer.createdBy, " +
                    "mst_customer.createdDate " +
                    "FROM mst_customer " +
                    "INNER JOIN mst_city ON mst_customer.CityCode=mst_city.Code " +
                    "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code " +
                    "INNER JOIN mst_island ON mst_province.IslandCode = mst_island.Code " +
                    "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code " +
                    "INNER JOIN mst_business_entity ON mst_customer.BusinessEntityCode=mst_business_entity.Code " +
                    "INNER JOIN mst_payment_term ON mst_customer.PaymentTermCode=mst_payment_term.Code " +
                    "INNER JOIN mst_customer_category ON mst_customer.CustomerCategoryCode=mst_customer_category.Code "           
                + "WHERE mst_customer.code LIKE '%"+code+"%' "
                + "AND mst_customer.name LIKE '%"+name+"%' "
                  + "AND mst_customer.endUserStatus = 1 "
                + concat_qry
               + "LIMIT "+from+","+row+"")
    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("businessEntityCode", Hibernate.STRING)
                .addScalar("businessEntityName", Hibernate.STRING)
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("customerCategoryCode", Hibernate.STRING)
                .addScalar("customerCategoryName", Hibernate.STRING)    
                .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    
    public List<CustomerContactTemp> findDataComponentDetail(String code, String status) {
        try {
            List<CustomerContactTemp> list = (List<CustomerContactTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "mst_customer_jn_contact.Code AS code, "
                    + "mst_customer_jn_contact.name AS name, "
                    + "mst_customer_jn_contact.CustomerCode AS customerCode, "
                    + "mst_customer.name AS customerName, "
                    + "mst_customer_jn_contact.ActiveStatus, "
                    + "mst_customer_jn_contact.Phone AS phone, "
                    + "mst_customer_jn_contact.MobileNo AS mobileNo, "
                    + "mst_customer_jn_contact.BirthDate AS birthDate, "
                    + "mst_customer_jn_contact.JobPositionCode AS jobPositionCode, "
                    + "mst_job_position.Name As jobPositionName "
                    + "FROM mst_customer_jn_contact "
                    + "INNER JOIN mst_customer ON mst_customer.`code` = mst_customer_jn_contact.CustomerCode "
                    + "INNER JOIN mst_job_position on mst_job_position.Code = mst_customer_jn_contact.JobPositionCode " 
                    + "WHERE mst_customer_jn_contact.CustomerCode='%" + code + "%' "
                    + "ORDER BY mst_customer_jn_contact.code ASC  "
                    + "")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("customerCode", Hibernate.STRING)
                    .addScalar("customerName", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .addScalar("phone", Hibernate.STRING)
                    .addScalar("mobileNo", Hibernate.STRING)    
                    .addScalar("birthDate", Hibernate.TIMESTAMP)
                    .addScalar("jobPositionCode", Hibernate.STRING)
                    .addScalar("jobPositionName", Hibernate.STRING)
                    .addScalar("activeStatus", Hibernate.BOOLEAN)
                    .setResultTransformer(Transformers.aliasToBean(CustomerContactTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    
    
    public Customer get(String code) {
        try {
               return (Customer) hbmSession.hSession.get(Customer.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     
    public void save(Customer customer, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            customer.setCode(createCode(customer));
            if(customer.isActiveStatus()){
                customer.setInActiveBy("");
                customer.setInActiveDate(DateUtils.newDate(1900, 1, 1));
            }else{
                customer.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                customer.setInActiveDate(new Date());
            }
            
            ChartOfAccount chartOfAccount=new ChartOfAccount();
//            if(customer.getArChartOfAccount() == null || customer.getArChartOfAccount().getCode().equals("")){
//                customer.setArChartOfAccount(null);
//            }else{
//                chartOfAccount.setCode(customer.getArChartOfAccount().getCode());
//                customer.setArChartOfAccount(chartOfAccount);
//            }
            
            customer.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customer.setCreatedDate(new Date());             
            hbmSession.hSession.save(customer);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    customer.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    public void update(Customer customer, String moduleCode){
        try {
            
            hbmSession.hSession.beginTransaction();
            
            CustomerTemp customerTemp=findData(customer.getCode());
            
            if(customer.isActiveStatus()){
                customer.setInActiveBy("");
                customer.setInActiveDate(DateUtils.newDate(1900, 1, 1));
            }else{
                if(customerTemp.isActiveStatus() != customer.isActiveStatus()){
                    customer.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                    customer.setInActiveDate(new Date());
                }else{
                    customer.setInActiveBy(customerTemp.getInActiveBy());
                    customer.setInActiveDate(customerTemp.getInActiveDate());
                }
            }
            
            ChartOfAccount chartOfAccount=new ChartOfAccount();
//            if(customer.getArChartOfAccount() == null || customer.getArChartOfAccount().getCode().equals("")){
//                customer.setArChartOfAccount(null);
//            }else{
//                chartOfAccount.setCode(customer.getArChartOfAccount().getCode());
//                customer.setArChartOfAccount(chartOfAccount);
//            }
            
            customer.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customer.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(customer);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    customer.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CustomerField.BEAN_NAME + " WHERE " + CustomerField.CODE + " = :prmCode")
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
     public CustomerTemp getMin() {
        try {
            
            String qry = "SELECT mst_customer.code,mst_customer.Name FROM mst_customer ORDER BY mst_customer.code LIMIT 0,1";
            CustomerTemp customerTemp =(CustomerTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                    .uniqueResult();   
            
            return customerTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerTemp getMax() {
        try {
            
            String qry = "SELECT mst_customer.code,mst_customer.Name FROM mst_customer ORDER BY mst_customer.code DESC LIMIT 0,1";
            CustomerTemp customerTemp =(CustomerTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                    .uniqueResult();   
            
            return customerTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public int countDataCustomerSortName(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_customer.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_customer.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_customer.ActiveStatus = 0 OR mst_customer.ActiveStatus = 1) ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_customer "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer.CityCode "
                + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
                + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_country.Code = mst_island.CountryCode "
                + "INNER JOIN mst_payment_term ON mst_payment_term.Code = mst_customer.PaymentTermCode "
                + "INNER JOIN mst_chart_of_account ARAccount ON ARAccount.Code = mst_customer.ARAccountCode "
//                + "LEFT JOIN mst_price_type ON mst_price_type.code = mst_customer.priceTypeCode "
//                + "LEFT JOIN mst_city npwpCity ON npwpCity.Code = mst_customer.NPWPCityCode "
                + "WHERE mst_customer.code LIKE :prmCode "
                + "AND mst_customer.name LIKE :prmName "
                +concat_qry)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerTemp> findDataCustomerSortName(String code, String name,String active,int from, int row) {
        try {   

            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_customer.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_customer.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_customer.ActiveStatus = 0 OR mst_customer.ActiveStatus = 1) ";
            }
            
            List<CustomerTemp> list = (List<CustomerTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_customer.Code AS code, "
                + "mst_customer.name AS name, "
                + "mst_customer.Address AS address, "
                + "mst_customer.CityCode AS cityCode, "
                + "mst_city.name AS cityName, "
                + "mst_country.Code AS countryCode, "
                + "mst_country.Name AS countryName, "
                + "mst_customer.EmailAddress AS emailAddress, "
                + "mst_customer.fax AS fax, "
                + "mst_customer.ZipCode AS zipCode, "
                + "mst_customer.phone1 AS phone1, "
                + "mst_customer.phone2 AS phone2, "
                + "mst_customer.ActiveStatus, "
                + "mst_customer.customerStatus, " 
                + "mst_customer.endUserStatus, " 
                + "mst_customer.Remark AS remark, "                                                   
                + "mst_customer.InActiveBy AS inActiveBy, "
                + "mst_customer.InActiveDate AS inActiveDate "
                + "FROM mst_customer "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer.CityCode "
                + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
                + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_country.Code = mst_island.CountryCode "
                + "INNER JOIN mst_payment_term ON mst_payment_term.Code = mst_customer.PaymentTermCode "
                + "LEFT JOIN mst_chart_of_account ARAccount ON ARAccount.Code = mst_customer.ARAccountCode "
//                + "LEFT JOIN mst_city npwpCity ON npwpCity.Code = mst_customer.NPWPCityCode "
                + "WHERE mst_customer.code LIKE :prmCode "
                + "AND mst_customer.name LIKE :prmName "
                + concat_qry
                + "ORDER BY mst_customer.name ASC ")
                    
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
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
//                .addScalar("wapuStatus", Hibernate.BOOLEAN)
//                .addScalar("promoStatus", Hibernate.BOOLEAN)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("endUserStatus", Hibernate.BOOLEAN)
                .addScalar("customerStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
//                .addScalar("NPWP", Hibernate.STRING)
//                .addScalar("NPWPAddress", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
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