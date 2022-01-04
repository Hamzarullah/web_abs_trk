

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
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemBolt;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.Vendor;
import com.inkombizz.master.model.VendorTemp;
import com.inkombizz.master.model.VendorField;
import com.inkombizz.master.model.VendorJnContactTemp;
import org.hibernate.criterion.Restrictions;



public class VendorDAO {
    
    private HBMSession hbmSession;
    
    public VendorDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(Vendor vendor){   
        try{
            String acronim = "VDR";
            DetachedCriteria dc = DetachedCriteria.forClass(Vendor.class)
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
                concat_qry="AND mst_vendor.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_vendor "
                + "INNER JOIN mst_city ON mst_city.Code = mst_vendor.CityCode "
                + "LEFT JOIN mst_vendor_jn_contact ON mst_vendor_jn_contact.Code = mst_vendor.DefaultContactPersonCode "
                + "LEFT JOIN mst_payment_term ON mst_payment_term.Code = mst_vendor.PaymentTermCode "
                + "INNER JOIN mst_vendor_category ON mst_vendor_category.Code = mst_vendor.VendorCategoryCode "
                + "INNER JOIN mst_business_entity ON mst_business_entity.Code = mst_vendor.BusinessEntityCode "
                + "INNER JOIN mst_city npwpCity ON npwpCity.Code = mst_vendor.NPWPCityCode "
                + "WHERE mst_vendor.code LIKE :prmCode "
                + "AND mst_vendor.name LIKE :prmName "
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
    
    public VendorTemp findData(String code) {
        try {
            VendorTemp vendorTemp = (VendorTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_vendor.code, "
                + "mst_vendor.name, "
                + "mst_vendor.address, "
                + "mst_city.code AS cityCode, "
                + "mst_city.name AS cityName, "
                + "mst_province.code AS provinceCode, "
                + "mst_province.name AS provinceName, "
                + "mst_island.code AS islandCode, "
                + "mst_island.name AS islandName, "
                + "mst_country.code AS countryCode, "
                + "mst_country.name AS countryName, "
                + "mst_vendor.zipCode, "
                + "mst_vendor.phone1, "
                + "mst_vendor.phone2, "
                + "mst_vendor.emailAddress, "
                + "mst_vendor.fax, "
                + "mst_vendor_category.code AS vendorCategoryCode, "
                + "mst_vendor_category.name AS vendorCategoryName, "  
                + "mst_vendor.BusinessEntityCode, "
                + "mst_business_entity.name AS businessEntityName, "
                + "mst_vendor.defaultContactPersonCode, "
                + "mst_vendor_jn_contact.name AS defaultContactPersonName, "            
                + "mst_vendor.npwp, "            
                + "mst_vendor.npwpName, "            
                + "mst_vendor.npwpAddress, "            
                + "mst_city.code AS npwpCityCode, "
                + "mst_city.name AS npwpCityName, "
                + "mst_province.code AS npwpProvinceCode, "
                + "mst_province.name AS npwpProvinceName, "
                + "mst_island.code AS npwpIslandCode, "
                + "mst_island.name AS npwpIslandName, "
                + "mst_country.code AS npwpCountryCode, "
                + "mst_country.name AS npwpCountryName, "           
                + "mst_vendor.npwpZipCode, "               
                + "mst_payment_term.code AS paymentTermCode, "               
                + "mst_payment_term.name AS paymentTermName, "     
                + "mst_vendor.localImport, "
                + "mst_vendor.remark, "
                + "mst_vendor.scope, "
                + "mst_vendor.InActiveBy, "
                + "mst_vendor.InActiveDate, "
                + "mst_vendor.criticalStatus, "
                + "mst_vendor.penaltyStatus, "
                + "mst_vendor.activeStatus, "
                + "mst_vendor.CreatedBy, "
                + "mst_vendor.CreatedDate "
                + "FROM mst_vendor "
                + "INNER JOIN mst_city ON mst_city.code = mst_vendor.cityCode "
                + "INNER JOIN mst_province ON mst_province.code = mst_city.provinceCode "
                + "INNER JOIN mst_island ON mst_island.code = mst_province.islandCode "
                + "INNER JOIN mst_country ON mst_country.code = mst_island.countryCode "
                + "INNER JOIN mst_city npwpCity ON npwpCity.Code = mst_vendor.CityCode  "
                + "INNER JOIN mst_province npwpProvince ON npwpCity.ProvinceCode=npwpProvince.Code  " 
                + "INNER JOIN mst_island npwpIsland ON npwpIsland.Code =npwpProvince.IslandCode  "
                + "INNER JOIN mst_country npwpCountry ON npwpIsland.CountryCode=npwpCountry.Code "    
                + "INNER JOIN mst_payment_term ON mst_payment_term.code = mst_vendor.paymentTermCode "
                + "INNER JOIN mst_business_entity ON mst_business_entity.Code = mst_vendor.BusinessEntityCode "
                + "LEFT JOIN mst_vendor_category ON mst_vendor_category.code = mst_vendor.vendorCategoryCode "
                + "LEFT JOIN mst_vendor_jn_contact ON mst_vendor_jn_contact.code = mst_vendor.defaultContactPersonCode "
                + "WHERE mst_vendor.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("vendorCategoryCode", Hibernate.STRING)
                .addScalar("vendorCategoryName", Hibernate.STRING)
                .addScalar("businessEntityCode", Hibernate.STRING)
                .addScalar("businessEntityName", Hibernate.STRING)
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .addScalar("defaultContactPersonName", Hibernate.STRING)
                .addScalar("npwp", Hibernate.STRING)
                .addScalar("npwpName", Hibernate.STRING)
                .addScalar("npwpAddress", Hibernate.STRING)
                .addScalar("npwpCityCode", Hibernate.STRING)
                .addScalar("npwpCityName", Hibernate.STRING)
                .addScalar("npwpProvinceCode", Hibernate.STRING)
                .addScalar("npwpProvinceName", Hibernate.STRING)
                .addScalar("npwpIslandCode", Hibernate.STRING)
                .addScalar("npwpIslandName", Hibernate.STRING)
                .addScalar("npwpCountryCode", Hibernate.STRING)
                .addScalar("npwpCountryName", Hibernate.STRING)
                .addScalar("npwpZipCode", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("localImport", Hibernate.STRING)
                .addScalar("scope", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("criticalStatus", Hibernate.BOOLEAN)
                .addScalar("penaltyStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(VendorTemp.class))
                .uniqueResult(); 
                 
                return vendorTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    //update
    public VendorTemp findDataGet(String code) {
       try {
            VendorTemp vendorTemp = (VendorTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_vendor.code, "
                + "mst_vendor.name, "
                + "mst_vendor.address, "
                + "mst_city.code AS cityCode, "
                + "mst_city.name AS cityName, "
                + "mst_province.code AS provinceCode, "
                + "mst_province.name AS provinceName, "
                + "mst_island.code AS islandCode, "
                + "mst_island.name AS islandName, "
                + "mst_country.code AS countryCode, "
                + "mst_country.name AS countryName, "
                + "mst_vendor.zipCode, "
                + "mst_vendor.phone1, "
                + "mst_vendor.phone2, "
                + "mst_vendor.emailAddress, "
                + "mst_vendor.fax, "
                + "mst_vendor_category.code AS vendorCategoryCode, "
                + "mst_vendor_category.name AS vendorCategoryName, "   
                + "mst_vendor.defaultContactPersonCode, "
                + "mst_vendor_jn_contact.name AS defaultContactPersonName, "
                + "mst_vendor.BusinessEntityCode, "
                + "mst_business_entity.name AS businessEntityName, "            
                + "mst_vendor.npwp, "            
                + "mst_vendor.npwpName, "            
                + "mst_vendor.npwpAddress, "            
                + "mst_city.code AS npwpCityCode, "
                + "mst_city.name AS npwpCityName, "
                + "mst_province.code AS npwpProvinceCode, "
                + "mst_province.name AS npwpProvinceName, "
                + "mst_island.code AS npwpIslandCode, "
                + "mst_island.name AS npwpIslandName, "
                + "mst_country.code AS npwpCountryCode, "
                + "mst_country.name AS npwpCountryName, "           
                + "mst_vendor.npwpZipCode, "               
                + "mst_payment_term.code AS paymentTermCode, "               
                + "mst_payment_term.name AS paymentTermName, "   
                + "mst_vendor.localImport, "
                + "mst_vendor.remark, "
                + "mst_vendor.scope, "
                + "mst_vendor.InActiveBy, "
                + "mst_vendor.InActiveDate, "
                + "mst_vendor.activeStatus, "
                + "mst_vendor.criticalStatus, "
                + "mst_vendor.CreatedBy, "
                + "mst_vendor.CreatedDate "
                + "FROM mst_vendor "
                + "INNER JOIN mst_city ON mst_city.code = mst_vendor.cityCode "
                + "INNER JOIN mst_province ON mst_province.code = mst_city.provinceCode "
                + "INNER JOIN mst_island ON mst_island.code = mst_province.islandCode "
                + "INNER JOIN mst_country ON mst_country.code = mst_island.countryCode "
                + "INNER JOIN mst_city npwpCity ON npwpCity.Code = mst_vendor.CityCode  "
                + "INNER JOIN mst_province npwpProvince ON npwpCity.ProvinceCode=npwpProvince.Code  " 
                + "INNER JOIN mst_island npwpIsland ON npwpIsland.Code =npwpProvince.IslandCode  "
                + "INNER JOIN mst_country npwpCountry ON npwpIsland.CountryCode=npwpCountry.Code "    
                + "INNER JOIN mst_payment_term ON mst_payment_term.code = mst_vendor.paymentTermCode "
                + "INNER JOIN mst_business_entity ON mst_business_entity.Code = mst_vendor.BusinessEntityCode "
                + "INNER JOIN mst_vendor_category ON mst_vendor_category.code = mst_vendor.vendorCategoryCode "
                + "LEFT JOIN mst_vendor_jn_contact ON mst_vendor_jn_contact.Code = mst_vendor.DefaultContactPersonCode "              
                + "WHERE mst_vendor.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("vendorCategoryCode", Hibernate.STRING)
                .addScalar("vendorCategoryName", Hibernate.STRING)
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .addScalar("defaultContactPersonName", Hibernate.STRING)  
                .addScalar("npwp", Hibernate.STRING)
                .addScalar("npwpName", Hibernate.STRING)
                .addScalar("npwpAddress", Hibernate.STRING)
                .addScalar("npwpCityCode", Hibernate.STRING)
                .addScalar("npwpCityName", Hibernate.STRING)
                .addScalar("npwpProvinceCode", Hibernate.STRING)
                .addScalar("npwpProvinceName", Hibernate.STRING)
                .addScalar("npwpIslandCode", Hibernate.STRING)
                .addScalar("npwpIslandName", Hibernate.STRING)
                .addScalar("npwpCountryCode", Hibernate.STRING)
                .addScalar("npwpCountryName", Hibernate.STRING)
                .addScalar("npwpZipCode", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("localImport", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("scope", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("criticalStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(VendorTemp.class))
                .uniqueResult(); 
                 
                return vendorTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<VendorTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_vendor.ActiveStatus="+active+" ";
            }
            List<VendorTemp> list = (List<VendorTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_vendor.code, "
                + "mst_vendor.name, "
                + "mst_vendor.address, "
                + "mst_city.code AS cityCode, "
                + "mst_city.name AS cityName, "
                + "mst_province.code AS provinceCode, "
                + "mst_province.name AS provinceName, "
                + "mst_island.code AS islandCode, "
                + "mst_island.name AS islandName, "
                + "mst_country.code AS countryCode, "
                + "mst_country.name AS countryName, "
                + "mst_vendor.zipCode, "
                + "mst_vendor.phone1, "
                + "mst_vendor.phone2, "
                + "mst_vendor.emailAddress, "
                + "mst_vendor.fax, "
                + "mst_vendor.defaultContactPersonCode, "
                + "mst_vendor_jn_contact.name AS defaultContactPersonName, "
                + "mst_vendor_category.code AS vendorCategoryCode, "
                + "mst_vendor_category.name AS vendorCategoryName, "
                + "mst_vendor.BusinessEntityCode, "
                + "mst_business_entity.name AS businessEntityName, "
                + "mst_vendor.npwp, "            
                + "mst_vendor.npwpName, "            
                + "mst_vendor.npwpAddress, "            
                + "mst_city.code AS npwpCityCode, "
                + "mst_city.name AS npwpCityName, "
                + "mst_province.code AS npwpProvinceCode, "
                + "mst_province.name AS npwpProvinceName, "
                + "mst_island.code AS npwpIslandCode, "
                + "mst_island.name AS npwpIslandName, "
                + "mst_country.code AS npwpCountryCode, "
                + "mst_country.name AS npwpCountryName, "           
                + "mst_vendor.npwpZipCode, "               
                + "mst_payment_term.code AS paymentTermCode, "               
                + "mst_payment_term.name AS paymentTermName, "     
                + "mst_payment_term.Days AS paymentTermDays, "     
                + "mst_vendor.localImport, "
                + "mst_vendor.remark, "
                + "mst_vendor.scope, "
                + "mst_vendor.InActiveBy, "
                + "mst_vendor.InActiveDate, "
                + "mst_vendor.activeStatus, "
                + "mst_vendor.criticalStatus, "
                + "mst_vendor.penaltyStatus, "
                + "mst_vendor.CreatedBy, "
                + "mst_vendor.CreatedDate "
                + "FROM mst_vendor "
                + "INNER JOIN mst_city ON mst_city.code = mst_vendor.cityCode "
                + "INNER JOIN mst_province ON mst_province.code = mst_city.provinceCode "
                + "INNER JOIN mst_island ON mst_island.code = mst_province.islandCode "
                + "INNER JOIN mst_country ON mst_country.code = mst_island.countryCode "
                + "INNER JOIN mst_city npwpCity ON npwpCity.Code = mst_vendor.CityCode  "
                + "INNER JOIN mst_province npwpProvince ON npwpCity.ProvinceCode=npwpProvince.Code  " 
                + "INNER JOIN mst_island npwpIsland ON npwpIsland.Code =npwpProvince.IslandCode  "
                + "INNER JOIN mst_country npwpCountry ON npwpIsland.CountryCode=npwpCountry.Code "    
                + "INNER JOIN mst_payment_term ON mst_payment_term.code = mst_vendor.paymentTermCode "
                + "INNER JOIN mst_business_entity ON mst_business_entity.Code = mst_vendor.BusinessEntityCode "
                + "INNER JOIN mst_vendor_category ON mst_vendor_category.code = mst_vendor.vendorCategoryCode "
                + "LEFT JOIN mst_vendor_jn_contact ON mst_vendor_jn_contact.Code = mst_vendor.DefaultContactPersonCode "            
                + "WHERE mst_vendor.code LIKE '%"+code+"%' "
                + "AND mst_vendor.name LIKE '%"+name+"%' "
                + concat_qry)
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("phone1", Hibernate.STRING)
                .addScalar("phone2", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("fax", Hibernate.STRING)
                .addScalar("defaultContactPersonCode", Hibernate.STRING)
                .addScalar("defaultContactPersonName", Hibernate.STRING)
                .addScalar("vendorCategoryCode", Hibernate.STRING)
                .addScalar("vendorCategoryName", Hibernate.STRING)
                .addScalar("businessEntityCode", Hibernate.STRING)
                .addScalar("businessEntityName", Hibernate.STRING)
                .addScalar("npwp", Hibernate.STRING)
                .addScalar("npwpName", Hibernate.STRING)
                .addScalar("npwpAddress", Hibernate.STRING)
                .addScalar("npwpCityCode", Hibernate.STRING)
                .addScalar("npwpCityName", Hibernate.STRING)
                .addScalar("npwpProvinceCode", Hibernate.STRING)
                .addScalar("npwpProvinceName", Hibernate.STRING)
                .addScalar("npwpIslandCode", Hibernate.STRING)
                .addScalar("npwpIslandName", Hibernate.STRING)
                .addScalar("npwpCountryCode", Hibernate.STRING)
                .addScalar("npwpCountryName", Hibernate.STRING)
                .addScalar("npwpZipCode", Hibernate.STRING)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("paymentTermDays", Hibernate.STRING)
                .addScalar("localImport", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("scope", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("criticalStatus", Hibernate.BOOLEAN)
                .addScalar("penaltyStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(VendorTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorJnContactTemp> findVendorJnContactDetailData(String vendorCode) {
        try {   
            
            List<VendorJnContactTemp> list = (List<VendorJnContactTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT mst_vendor_jn_contact.code AS vendorContactCode, "
                            + "mst_vendor_jn_contact.name AS vendorContactName, "
                            + "mst_vendor_jn_contact.birthDate AS vendorContactBirthDate, "
                            + "mst_vendor_jn_contact.Phone AS vendorContactPhone, "
                            + "mst_vendor_jn_contact.JobPositionCode AS vendorContactJobPositionCode, "
                            + "mst_job_position.name AS vendorContactJobPositionName "
                    + "FROM mst_vendor_jn_contact "
                    + "INNER JOIN mst_job_position ON mst_job_position.code = mst_vendor_jn_contact.JobPositionCode "
                    + "WHERE mst_vendor_jn_contact.VendorCode =:prmVendorCode ")
                    
                    .addScalar("vendorContactCode", Hibernate.STRING)
                    .addScalar("vendorContactName", Hibernate.STRING)
                    .addScalar("vendorContactPhone", Hibernate.STRING)
                    .addScalar("vendorContactBirthDate", Hibernate.TIMESTAMP)
                    .addScalar("vendorContactJobPositionCode", Hibernate.STRING)
                    .addScalar("vendorContactJobPositionName", Hibernate.STRING)
                    .setParameter("prmVendorCode",vendorCode)
                    .setResultTransformer(Transformers.aliasToBean(VendorJnContactTemp.class))
                    .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Vendor vendor, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            vendor.setCode(createCode(vendor));
            if(vendor.isActiveStatus()){
                vendor.setInActiveBy("");                
            }else{
                vendor.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                vendor.setInActiveDate(new Date());
            }
            
            if(vendor.getDefaultContactPerson().getCode().equals("")){
                vendor.setDefaultContactPerson(null);
            }
            
            vendor.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendor.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(vendor);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    vendor.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Vendor vendor, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(vendor.isActiveStatus()){
                vendor.setInActiveBy("");                
            }else{
                vendor.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                vendor.setInActiveDate(new Date());
            }
            
            if(vendor.getDefaultContactPerson().getCode().equals("")){
                vendor.setDefaultContactPerson(null);
            }
            vendor.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendor.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(vendor);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    vendor.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + VendorField.BEAN_NAME + " WHERE " + VendorField.CODE + " = :prmCode")
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
