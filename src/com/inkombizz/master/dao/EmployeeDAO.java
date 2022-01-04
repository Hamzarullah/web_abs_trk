
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.CustomerAddress;
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
import com.inkombizz.master.model.Employee;
import com.inkombizz.master.model.EmployeeField;
import com.inkombizz.master.model.EmployeeTemp;
import java.text.ParseException;
import org.hibernate.criterion.Restrictions;


public class EmployeeDAO {
    
    private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction();
    public EmployeeDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    
    public String createCode(Employee employee){   
        try{
            String acronim = "EMP";
            DetachedCriteria dc = DetachedCriteria.forClass(Employee.class)
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
                concat_qry="AND mst_employee.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_employee "
                + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_religion ON mst_employee.ReligionCode=mst_religion.Code "
                + "INNER JOIN mst_education ON mst_employee.EducationCode=mst_education.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "INNER JOIN mst_city AS mst_npwpCity ON mst_employee.npwpCityCode=mst_npwpCity.Code "
                + "INNER JOIN mst_province AS mst_npwpProvince ON mst_npwpCity.ProvinceCode=mst_npwpProvince.Code "
                + "INNER JOIN mst_island AS mst_npwpIsland ON mst_npwpProvince.IslandCode=mst_npwpIsland.Code "
                + "INNER JOIN mst_country AS mst_npwpCountry ON mst_npwpIsland.CountryCode=mst_npwpCountry.Code "
                + "WHERE mst_employee.code LIKE :prmCode "
                + "AND mst_employee.name LIKE :prmName "
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


    public EmployeeTemp findData(String code){
        try {
            EmployeeTemp marketingTemp = (EmployeeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_employee.code, "
                + "mst_employee.NIK, "
                + "mst_employee.Name, "
                + "mst_employee.Address, "
                + "mst_employee.ZipCode, "
                + "mst_city.code AS cityCode, "
                + "mst_city.name AS cityName, "
                + "mst_province.code AS provinceCode, "
                + "mst_province.name AS provinceName, "
                + "mst_island.code AS islandCode, "
                + "mst_island.name AS islandName, "
                + "mst_island.CountryCode AS countryCode, "
                + "mst_country.Name AS countryName, "
                + "mst_employee.domicileAddress1, "
                + "mst_employee.domicileAddress2, "
                + "mst_employee.Phone, "
                + "mst_employee.mobileNo1, "
                + "mst_employee.mobileNo2, "
                + "mst_employee.EmailAddress, "
                + "mst_employee.joinDate, "
                + "mst_employee.resignDate, "
                + "mst_employee.birthDate, "
                + "mst_employee.birthPlace, "
                + "mst_employee.gender, "
                + "mst_employee.maritalStatus, "
                + "mst_employee.religionCode, "
                + "mst_religion.Name AS ReligionName, "
                + "mst_employee.EducationCode, "
                + "mst_education.Name AS educationName, "
                + "mst_employee.ACNo AS acNo, "
                + "mst_employee.ACName AS acName, "
                + "mst_employee.bankCode, "
                + "mst_bank.Name AS bankName , "
                + "mst_employee.bankBranch, "
                + "mst_employee.KTPNo, "
                + "mst_employee.NPWP, "
                + "mst_employee.npwpName, "
                + "mst_employee.npwpAddress, "
                + "mst_employee.npwpCityCode, "
                + "mst_npwpCity.Name AS npwpCityName, "
                + "mst_npwpCity.Name AS npwpProvinceCode, "
                + "mst_npwpCity.Name AS npwpProvinceName, "
                + "mst_npwpIsland.Code AS npwpIslandCode, "
                + "mst_npwpIsland.Name AS npwpIslandName, "
                + "mst_npwpIsland.CountryCode AS npwpCountryCode, "
                + "mst_npwpCountry.Name AS npwpCountryName, "
                + "mst_employee.npwpZipCode, "
                + "mst_employee.remark, "
                + "mst_employee.InActiveBy, "
                + "mst_employee.InActiveDate, "
                + "mst_employee.activeStatus, "
                + "mst_employee.createdBy, "
                + "mst_employee.createdDate "
                + "FROM mst_employee "
                + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "INNER JOIN mst_city AS mst_npwpCity ON mst_employee.npwpCityCode=mst_npwpCity.Code "
                + "INNER JOIN mst_province AS mst_npwpProvince ON mst_npwpCity.ProvinceCode=mst_npwpProvince.Code "
                + "INNER JOIN mst_island AS mst_npwpIsland ON mst_npwpProvince.IslandCode=mst_npwpIsland.Code "
                + "INNER JOIN mst_education ON mst_employee.EducationCode=mst_education.Code "
                + "INNER JOIN mst_religion ON mst_employee.ReligionCode=mst_religion.Code "
                + "INNER JOIN mst_bank ON mst_employee.BankCode=mst_bank.Code "
                + "INNER JOIN mst_country AS mst_npwpCountry ON mst_npwpIsland.CountryCode=mst_npwpCountry.Code "
                + "WHERE mst_employee.code ='"+code+"'")

                .addScalar("code", Hibernate.STRING)
                .addScalar("nik", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("provinceCode", Hibernate.STRING)
                .addScalar("provinceName", Hibernate.STRING)
                .addScalar("islandCode", Hibernate.STRING)
                .addScalar("islandName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("domicileAddress1", Hibernate.STRING)
                .addScalar("domicileAddress2", Hibernate.STRING)
                .addScalar("mobileNo1", Hibernate.STRING)
                .addScalar("mobileNo2", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("joinDate", Hibernate.DATE)
                .addScalar("resignDate", Hibernate.DATE)
                .addScalar("birthDate", Hibernate.DATE)
                .addScalar("birthPlace", Hibernate.STRING)
                .addScalar("gender", Hibernate.STRING)
                .addScalar("maritalStatus", Hibernate.STRING)
                .addScalar("religionCode", Hibernate.STRING)
                .addScalar("religionName", Hibernate.STRING)
                .addScalar("educationCode", Hibernate.STRING)
                .addScalar("educationName", Hibernate.STRING)
                .addScalar("acNo", Hibernate.STRING)
                .addScalar("acName", Hibernate.STRING)
                .addScalar("bankCode", Hibernate.STRING)
                .addScalar("bankName", Hibernate.STRING)
                .addScalar("bankBranch", Hibernate.STRING)
                .addScalar("ktpNo", Hibernate.STRING)
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
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(EmployeeTemp.class))
                .uniqueResult(); 

                return marketingTemp;
        }catch (HibernateException e) {
            throw e;
        }
    }

    public EmployeeTemp findData(String code,boolean active) {
        try {
                        
            EmployeeTemp marketingTemp = (EmployeeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_employee.code, "
                + "mst_employee.NIK, "
                + "mst_employee.name, "
                + "mst_employee.address, "
                + "mst_employee.ZipCode, "
                + "mst_city.code As cityCode, "
                + "mst_city.name As cityName, "
                + "mst_province.Code AS ProvinceCode, "
                + "mst_province.Name AS ProvinceName, "
                + "mst_country.Code AS CountryCode, "
                + "mst_country.Name AS CountryName, "
                + "mst_employee.Phone, "
                + "mst_employee.MobileNo1, "
                + "mst_employee.MobileNo2, "
                + "mst_employee.EmailAddress "
                + "FROM mst_employee "
                + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "INNER JOIN mst_city AS mst_npwpCity ON mst_employee.npwpCityCode=mst_npwpCity.Code "
                + "INNER JOIN mst_province AS mst_npwpProvince ON mst_npwpCity.ProvinceCode=mst_npwpProvince.Code "
                + "INNER JOIN mst_island AS mst_npwpIsland ON mst_npwpProvince.IslandCode=mst_npwpIsland.Code "
                + "INNER JOIN mst_country AS mst_npwpCountry ON mst_npwpIsland.CountryCode=mst_npwpCountry.Code "
                + "WHERE mst_employee.code ='"+code+"' "
                + "AND mst_employee.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("nik", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("mobileNo1", Hibernate.STRING)
                .addScalar("mobileNo2", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(EmployeeTemp.class))
                .uniqueResult(); 
                 
                return marketingTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }


    public List<EmployeeTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_employee.ActiveStatus="+active+" ";
            }
            List<EmployeeTemp> list = (List<EmployeeTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_employee.code, "
                + "mst_employee.nik, "                            
                + "mst_employee.name, "
                + "mst_employee.address, "
                + "mst_employee.ZipCode, "
                + "mst_city.code As cityCode, "
                + "mst_city.name As cityName, "
                + "mst_province.Code AS ProvinceCode, "
                + "mst_province.Name AS ProvinceName, "
                + "mst_country.Code AS CountryCode, "
                + "mst_country.Name AS CountryName, "
                + "mst_religion.Code AS ReligionCode, "
                + "mst_religion.Name AS ReligionName, "
                + "mst_education.Code AS EducationCode, "
                + "mst_education.Name AS EducationName, "
                + "mst_employee.DomicileAddress1, "
                + "mst_employee.DomicileAddress2, "
                + "mst_employee.BirthPlace, "
                + "mst_employee.BankBranch, "
                + "mst_employee.ACNo, "
                + "mst_employee.ACName, "
                + "mst_employee.NPWP, "
                + "mst_employee.NPWPAddress, "
                + "mst_employee.NPWPName, "
                + "mst_employee.Gender, "
                + "mst_employee.JoinDate, "
                + "mst_employee.KTPNo, "
                + "mst_employee.ResignDate, "
                + "mst_employee.KTPNo, "
                + "mst_employee.Gender, "
                + "mst_employee.MaritalStatus, "
                + "mst_employee.Phone, "
                + "mst_employee.MobileNo1, "
                + "mst_employee.MobileNo2, "
                + "mst_employee.EmailAddress, "
                + "mst_employee.activeStatus "
                + "FROM mst_employee "
                + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "INNER JOIN mst_religion ON mst_employee.ReligionCode=mst_religion.Code "
                + "INNER JOIN mst_education ON mst_employee.EducationCode=mst_education.Code "
                + "INNER JOIN mst_city AS mst_npwpCity ON mst_employee.npwpCityCode=mst_npwpCity.Code "
                + "INNER JOIN mst_province AS mst_npwpProvince ON mst_npwpCity.ProvinceCode=mst_npwpProvince.Code "
                + "INNER JOIN mst_island AS mst_npwpIsland ON mst_npwpProvince.IslandCode=mst_npwpIsland.Code "
                + "INNER JOIN mst_country AS mst_npwpCountry ON mst_npwpIsland.CountryCode=mst_npwpCountry.Code "
                + "WHERE mst_employee.code LIKE :prmCode "
                + "AND mst_employee.name LIKE :prmName "
                + concat_qry
                + "ORDER BY mst_employee.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("nik", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("address", Hibernate.STRING)
                .addScalar("zipCode", Hibernate.STRING)
                .addScalar("cityCode", Hibernate.STRING)
                .addScalar("cityName", Hibernate.STRING)
                .addScalar("countryCode", Hibernate.STRING)
                .addScalar("countryName", Hibernate.STRING)
                .addScalar("mobileNo1", Hibernate.STRING)
                .addScalar("mobileNo2", Hibernate.STRING)
                .addScalar("domicileAddress1", Hibernate.STRING)
                .addScalar("domicileAddress2", Hibernate.STRING)
                .addScalar("birthPlace", Hibernate.STRING)
                .addScalar("ktpNo", Hibernate.STRING)
                .addScalar("bankBranch", Hibernate.STRING)
                .addScalar("acNo", Hibernate.STRING)
                .addScalar("acName", Hibernate.STRING)
                .addScalar("npwp", Hibernate.STRING)
                .addScalar("npwpAddress", Hibernate.STRING)
                .addScalar("npwpName", Hibernate.STRING)
                .addScalar("gender", Hibernate.STRING)
                .addScalar("maritalStatus", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("emailAddress", Hibernate.STRING)
                .addScalar("religionCode", Hibernate.STRING)
                .addScalar("religionName", Hibernate.STRING)
                .addScalar("educationCode", Hibernate.STRING)
                .addScalar("educationName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(EmployeeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Employee employee, String moduleCode) throws ParseException, Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            employee.setCode(createCode(employee));
            if(employee.isActiveStatus()){
                employee.setInActiveBy("");
                employee.setInActiveDate(commonFunction.setDateTime("01/01/1900 00:00:00"));
            }else{
                employee.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                employee.setInActiveDate(new Date());
            }
            String headerCode = createCode(employee);
            employee.setCode(headerCode);
            employee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            employee.setCreatedDate(new Date()); 

            hbmSession.hSession.save(employee);
           
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    employee.getCode() , ""));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Employee employee, String moduleCode) throws ParseException, Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(employee.isActiveStatus()){
                employee.setInActiveBy("");
                employee.setInActiveDate(commonFunction.setDateTime("01/01/1900 00:00:00"));
            }else{
                employee.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                employee.setInActiveDate(new Date());
            }
            employee.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            employee.setUpdatedDate(new Date()); 

            hbmSession.hSession.update(employee);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    employee.getCode(), ""));

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
            
            hbmSession.hSession.createQuery("DELETE FROM " + EmployeeField.BEAN_NAME + " WHERE " + EmployeeField.CODE + " = :prmCode")
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


    public EmployeeTemp min() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_employee.code, "
                    + "mst_employee.Name "
                    + "FROM mst_employee "
                    + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                    + "ORDER BY mst_employee.code "
                    + "LIMIT 0,1";
            EmployeeTemp employeeTemp =(EmployeeTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(EmployeeTemp.class))
            .uniqueResult();   
            
            return employeeTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public EmployeeTemp max() {
        try {
            
            String qry = 
                        "SELECT "
                    + "mst_employee.code, "
                    + "mst_employee.Name "
                    + "FROM mst_employee "
                    + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                    + "ORDER BY mst_employee.code DESC "
                    + "LIMIT 0,1";
            EmployeeTemp marketingTemp =(EmployeeTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(EmployeeTemp.class))
            .uniqueResult();   
            
            return marketingTemp;
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

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }
    
}
