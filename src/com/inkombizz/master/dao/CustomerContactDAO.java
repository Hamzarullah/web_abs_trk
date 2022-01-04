package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Customer;
import com.inkombizz.master.model.CustomerField;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.CustomerCategory;
import com.inkombizz.master.model.CustomerContact;
import com.inkombizz.master.model.CustomerContactField;
import com.inkombizz.master.model.CustomerContactTemp;
import com.inkombizz.master.model.CustomerTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.utils.DateUtils;
import java.math.BigInteger;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

public class CustomerContactDAO {
    
    private HBMSession hbmSession;
	
    public CustomerContactDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    
    public String createCode(CustomerContact customerContact){   
        try{
            String acronim = "CUSCTC";
            DetachedCriteria dc = DetachedCriteria.forClass(CustomerContact.class)
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
                concat_qry="AND mst_customer_jn_contact.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_customer_jn_contact "
                + "INNER JOIN mst_customer ON mst_customer.Code = mst_customer_jn_contact.CustomerCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_customer_jn_contact.JobPositionCode "
                + "WHERE mst_customer_jn_contact.code LIKE :prmCode "
                + "AND mst_customer_jn_contact.name LIKE :prmName "
                + concat_qry)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmName", "%"+name+"%")
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public int countDataContact(String customerCode,String code,String name,String active){
        try{
            String concat_qry="";
            if(active.equals("true")){
                concat_qry="AND mst_customer_jn_contact.ActiveStatus = 1 ";
            }
            
            if(active.equals("false")){
                concat_qry="AND mst_customer_jn_contact.ActiveStatus = 0 ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                  "SELECT COUNT(*) "
                + "FROM mst_customer_jn_contact "
                + "INNER JOIN mst_job_position ON mst_customer_jn_contact.JobPositionCode=mst_job_position.Code "
                + "WHERE mst_customer_jn_contact.CustomerCode=:prmCustomerCode "
                + "     AND mst_customer_jn_contact.Code LIKE :prmCode "
                + "     AND mst_customer_jn_contact.Name LIKE :prmName "
                + concat_qry)
                .setParameter("prmCustomerCode",customerCode)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     
   public int countDataCustomer(String code,String name,String active){
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
                + "INNER JOIN mst_payment_term ON mst_payment_term.Code = mst_customer.PaymentTermCode "
//                + "INNER JOIN mst_customer_category ON mst_customer_category.Code = mst_customer.CustomerCategoryCode "
                + "LEFT JOIN mst_chart_of_account ARAccount ON ARAccount.Code = mst_customer.ARAccountCode "
                + "INNER JOIN mst_city npwpCity ON npwpCity.Code = mst_customer.NPWPCityCode "
                + "WHERE mst_customer.code LIKE :prmCode "
                + "AND mst_customer.name LIKE :prmName "+concat_qry)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
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
    public List<CustomerTemp> findDataCustomer(String code, String name, String active,int from, int row) {
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
                + "mst_customer.emailAddress AS emailAddress, "
                + "mst_customer.fax AS fax, "
                + "mst_customer.ZipCode AS zipCode, "
                + "mst_customer.phone1 AS phone1, "
                + "mst_customer.phone2 AS phone2, "
                + "mst_customer.ActiveStatus, "
                + "mst_customer.Remark AS remark, "
                + "mst_customer.InActiveBy AS inActiveBy, "
                + "mst_customer.InActiveDate AS inActiveDate "
                + "FROM mst_customer "
                + "INNER JOIN mst_city ON mst_city.Code = mst_customer.CityCode "
                + "INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode "
                + "INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode "
                + "INNER JOIN mst_country ON mst_country.Code = mst_island.CountryCode "
                + "INNER JOIN mst_payment_term ON mst_payment_term.Code = mst_customer.PaymentTermCode "
//                + "INNER JOIN mst_customer_category ON mst_customer_category.Code = mst_customer.CustomerCategoryCode "
                + "LEFT JOIN mst_chart_of_account ARAccount ON ARAccount.Code = mst_customer.ARAccountCode "
                + "INNER JOIN mst_city npwpCity ON npwpCity.Code = mst_customer.NPWPCityCode "
                + "WHERE mst_customer.code LIKE :prmCode "
                + "AND mst_customer.name LIKE :prmName "+concat_qry
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
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
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
    public CustomerContactTemp findData(String code) {
        try {
            CustomerContactTemp customerContactTemp = (CustomerContactTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_customer_jn_contact.Code, "
                + "mst_customer_jn_contact.CustomerCode,"
                + "mst_customer.Name AS customerName, "
                + "mst_customer_jn_contact.Name, "
                + "mst_customer_jn_contact.Phone, "
                + "mst_customer_jn_contact.MobileNo, "
                + "mst_customer_jn_contact.BirthDate, "
                + "mst_customer_jn_contact.JobPositionCode, "
                + "mst_job_position.Name As jobPositionName, "
                + "mst_customer_jn_contact.activeStatus, "
                + "mst_customer_jn_contact.CreatedBy, "
                + "mst_customer_jn_contact.CreatedDate "
                + "FROM mst_customer_jn_contact "
                + "INNER JOIN mst_customer ON mst_customer.Code = mst_customer_jn_contact.CustomerCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_customer_jn_contact.JobPositionCode " 
                + "WHERE mst_customer_jn_contact.code ='"+code+"'")
                    
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
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(CustomerContactTemp.class))
                .uniqueResult(); 
                 
                return customerContactTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerContactTemp findData(String code,boolean active) {
        try {
            CustomerContactTemp customerContactTemp = (CustomerContactTemp)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "mst_customer_jn_contact.Code, "
                + "mst_customer_jn_contact.CustomerCode,"
                + "mst_customer.Name AS customerName, "
                + "mst_customer_jn_contact.Name, "
                + "mst_customer_jn_contact.Phone, "
                + "mst_customer_jn_contact.MobileNo, "
                + "mst_customer_jn_contact.BirthDate, "
                + "mst_customer_jn_contact.JobPositionCode, "
                + "mst_job_position.Name As jobPositionName, "
                + "mst_customer_jn_contact.activeStatus, "
                + "mst_customer_jn_contact.CreatedBy, "
                + "mst_customer_jn_contact.CreatedDate "
                + "FROM mst_customer_jn_contact "
                + "INNER JOIN mst_customer ON mst_customer.Code = mst_customer_jn_contact.CustomerCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_customer_jn_contact.JobPositionCode " 
                + "WHERE mst_customer_jn_contact.code ='"+code+"' "
                + "AND mst_customer_jn_contact.ActiveStatus ="+active+"")
                    
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
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(CustomerContactTemp.class))
                .uniqueResult(); 
                 
                return customerContactTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<CustomerContactTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_customer_jn_contact.ActiveStatus="+active+" ";
            }
            List<CustomerContactTemp> list = (List<CustomerContactTemp>)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "mst_customer_jn_contact.Code, "
                + "mst_customer_jn_contact.CustomerCode,"
                + "mst_customer.Name AS customerName, "
                + "mst_customer_jn_contact.Name, "
                + "mst_customer_jn_contact.Phone, "
                + "mst_customer_jn_contact.MobileNo, "
                + "mst_customer_jn_contact.BirthDate, "
                + "mst_customer_jn_contact.JobPositionCode, "
                + "mst_job_position.Name As jobPositionName, "
                + "mst_customer_jn_contact.activeStatus, "
                + "mst_customer_jn_contact.CreatedBy, "
                + "mst_customer_jn_contact.CreatedDate "
                + "FROM mst_customer_jn_contact "
                + "INNER JOIN mst_customer ON mst_customer.Code = mst_customer_jn_contact.CustomerCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_customer_jn_contact.JobPositionCode " 
                + "WHERE mst_customer_jn_contact.code LIKE '%"+code+"%' "
                + "AND mst_customer_jn_contact.name LIKE '%"+name+"%' "
                + concat_qry
                + "ORDER BY mst_customer_jn_contact.code ASC ")
                    
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
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(CustomerContactTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerContact get(String code){
        try{
            return (CustomerContact) hbmSession.hSession.get(CustomerContact.class, code);
        }catch(HibernateException e){
            throw e;
        }
    }
    
    public void save(CustomerContact customerContact, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            customerContact.setCode(createCode(customerContact));
            customerContact.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerContact.setCreatedDate(new Date()); 
            String headerCode = createCode(customerContact);
            customerContact.setCode(headerCode);
            
            hbmSession.hSession.save(customerContact);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    customerContact.getCode(), ""));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public List<CustomerContactTemp> findDataCustomerContactTemp(String headerCode) {
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
                    + "WHERE mst_customer_jn_contact.CustomerCode='" + headerCode + "' "
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
    
    public List<CustomerContactTemp> findData(String customerCode,String code, String name, String active,int from, int row) {
        try {   

            String concat_qry="";
            if(active.equals("true")){
                concat_qry="AND mst_customer_jn_contact.ActiveStatus = 1 ";
            }
            
            if(active.equals("false")){
                concat_qry="AND mst_customer_jn_contact.ActiveStatus = 0 ";
            }
            
            List<CustomerContactTemp> list = (List<CustomerContactTemp>)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "	mst_customer_jn_contact.Code, "
                + "     mst_customer.code AS CustomerCode, "
                + "	mst_customer_jn_contact.Name, "
                + "	mst_customer_jn_contact.Phone, "
                + "	mst_customer_jn_contact.MobileNo, "
                + "	DATE(mst_customer_jn_contact.`BirthDate`)AS BirthDate, "
                + "	mst_customer_jn_contact.JobPositionCode, "
                + "	mst_job_position.Name AS JobPositionName, "
                + "     mst_customer_jn_contact.ActiveStatus, "
                + "     mst_customer_jn_contact.InActiveBy, "
                + "     mst_customer_jn_contact.InActiveDate "
                + "FROM mst_customer_jn_contact "
                + "INNER JOIN mst_customer ON mst_customer.`code` = mst_customer_jn_contact.CustomerCode "           
                + "INNER JOIN mst_job_position ON mst_customer_jn_contact.JobPositionCode=mst_job_position.Code "
                + "WHERE mst_customer_jn_contact.CustomerCode=:prmCustomerCode "
                + "     AND mst_customer_jn_contact.Code LIKE :prmCode "
                + "     AND mst_customer_jn_contact.Name LIKE :prmName "
                + concat_qry
                + "ORDER BY mst_customer_jn_contact.name")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("mobileNo", Hibernate.STRING)
                .addScalar("birthDate", Hibernate.DATE)
                .addScalar("jobPositionCode", Hibernate.STRING)
                .addScalar("jobPositionName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .setParameter("prmCustomerCode",customerCode)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(CustomerContactTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void update(CustomerContact customerContact, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            customerContact.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerContact.setUpdatedDate(new Date()); 
            
          
            
            hbmSession.hSession.update(customerContact);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    customerContact.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CustomerContactField.BEAN_NAME + " WHERE " + CustomerContactField.CODE + " = :prmCode")
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
}