
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.Project;
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
import com.inkombizz.master.model.SalesPerson;
import com.inkombizz.master.model.SalesPersonDistributionChannel;
import com.inkombizz.master.model.SalesPersonDistributionChannelField;
import com.inkombizz.master.model.SalesPersonDistributionChannelTemp;
import com.inkombizz.master.model.SalesPersonField;
import com.inkombizz.master.model.SalesPersonItemProductHead;
import com.inkombizz.master.model.SalesPersonItemProductHeadField;
import com.inkombizz.master.model.SalesPersonItemProductHeadTemp;
import com.inkombizz.master.model.SalesPersonTemp;
import java.text.ParseException;
import org.hibernate.criterion.Restrictions;


public class SalesPersonDAO {
    
    private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction();
    public SalesPersonDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public String createCode(SalesPerson salesPerson){   
        try{
            String acronim = "SLS";
            DetachedCriteria dc = DetachedCriteria.forClass(SalesPerson.class)
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
                concat_qry="AND mst_sales_person.ActiveStatus="+active+"";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_sales_person "
                + "INNER JOIN mst_employee ON mst_sales_person.employeeCode=mst_employee.Code "
                + "WHERE mst_sales_person.code LIKE :prmCode "
                + "AND mst_sales_person.name LIKE :prmName "
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


    public SalesPersonTemp findData(String code){
        try {
            SalesPersonTemp salesPersonTemp = (SalesPersonTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_sales_person.code, "
                + "mst_sales_person.name, "
                + "mst_sales_person.employeeCode, "
                + "mst_employee.Name AS EmployeeName, "
                + "mst_employee.address AS EmployeeAddress, "
                + "mst_employee.ZipCode AS EmployeeZipCode, "
                + "mst_city.code As EmployeeCityCode, "
                + "mst_city.name As EmployeeCityName, "
                + "mst_province.Code AS EmployeeProvinceCode, "
                + "mst_province.Name AS EmployeeProvinceName, "
                + "mst_island.Code AS EmployeeIslandCode, " 
                + "mst_island.Name AS EmployeeIslandName, "
                + "mst_country.Code AS EmployeeCountryCode, "
                + "mst_country.Name AS EmployeeCountryName, "
                + "mst_employee.mobileNo1 AS EmployeePhone1, "
                + "mst_employee.mobileNo2 AS EmployeePhone2, "
                + "mst_employee.EmailAddress AS EmployeeEmail,  "
                + "mst_sales_person.remark, "
                + "mst_sales_person.InActiveBy, "
                + "mst_sales_person.InActiveDate, "
                + "mst_sales_person.activeStatus, "
                + "mst_sales_person.createdBy, "
                + "mst_sales_person.createdDate "
                + "FROM mst_sales_person "
                + "INNER JOIN mst_employee ON mst_sales_person.employeeCode=mst_employee.Code "
                + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                + "INNER JOIN mst_province ON mst_city.ProvinceCode=mst_province.Code "
                + "INNER JOIN mst_island ON mst_province.IslandCode=mst_island.Code "
                + "INNER JOIN mst_country ON mst_island.CountryCode=mst_country.Code "
                + "WHERE mst_sales_person.code ='"+code+"' ")

                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("employeeCode", Hibernate.STRING)
                .addScalar("employeeName", Hibernate.STRING)
                .addScalar("employeeAddress", Hibernate.STRING)
                .addScalar("employeeZipCode", Hibernate.STRING)
                .addScalar("employeeCityCode", Hibernate.STRING)
                .addScalar("employeeCityName", Hibernate.STRING)
                .addScalar("employeeProvinceCode", Hibernate.STRING)
                .addScalar("employeeProvinceName", Hibernate.STRING)
                .addScalar("employeeIslandCode", Hibernate.STRING)
                .addScalar("employeeIslandName", Hibernate.STRING)
                .addScalar("employeeCountryCode", Hibernate.STRING)
                .addScalar("employeeCountryName", Hibernate.STRING)
                .addScalar("employeePhone1", Hibernate.STRING)
                .addScalar("employeePhone2", Hibernate.STRING)
                .addScalar("employeeEmail", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(SalesPersonTemp.class))
                .uniqueResult(); 

                return salesPersonTemp;
        }catch (HibernateException e) {
            throw e;
        }
    }


    public SalesPersonTemp findData(String code,boolean active) {
        try {
                        
            SalesPersonTemp salesPersonTemp = (SalesPersonTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_sales_person.Code, "
                + "mst_sales_person.name, "
                + "mst_sales_person.employeeCode, "
                + "mst_employee.Name AS EmployeeName, "
                + "mst_employee.address AS EmployeeAddress, "
                + "mst_employee.cityCode AS EmployeeCityCode, "
                + "mst_city.Name As EmployeeCityName, "
                + "mst_employee.mobileNo1 AS EmployeePhone1, "
                + "mst_employee.mobileNo2 AS EmployeePhone2, "
                + "mst_employee.EmailAddress AS EmployeeEmail  "
                + "FROM mst_sales_person "
                + "INNER JOIN mst_employee ON mst_sales_person.employeeCode=mst_employee.Code "
                + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                + "WHERE mst_sales_person.code ='"+code+"' "
                + "AND mst_sales_person.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("employeeCode", Hibernate.STRING)
                .addScalar("employeeName", Hibernate.STRING)
                .addScalar("employeeAddress", Hibernate.STRING)
                .addScalar("employeeCityCode", Hibernate.STRING)
                .addScalar("employeeCityName", Hibernate.STRING)
                .addScalar("employeePhone1", Hibernate.STRING)
                .addScalar("employeePhone2", Hibernate.STRING)
                .addScalar("employeeEmail", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(SalesPersonTemp.class))
                .uniqueResult(); 
                 
                return salesPersonTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<SalesPersonTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_sales_person.ActiveStatus="+active+" ";
            }
            List<SalesPersonTemp> list = (List<SalesPersonTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_sales_person.code, "
                + "mst_sales_person.name, "
                + "mst_employee.Code AS EmployeeCode, "
                + "mst_employee.Name AS EmployeeName, "
                + "mst_employee.address AS EmployeeAddress, "
                + "mst_city.Code AS EmployeeCityCode, "
                + "mst_city.Name As EmployeeCityName, "
                + "mst_employee.mobileNo1 AS EmployeePhone1, "
                + "mst_employee.mobileNo2 AS EmployeePhone2, "
                + "mst_employee.EmailAddress AS EmployeeEmail, "
                + "mst_sales_person.activeStatus "
                + "FROM mst_sales_person "
                + "INNER JOIN mst_employee ON mst_sales_person.employeeCode=mst_employee.Code "
                + "INNER JOIN mst_city ON mst_employee.CityCode=mst_city.Code "
                + "WHERE mst_sales_person.code LIKE :prmCode "
                + "AND mst_sales_person.name LIKE :prmName "
                + concat_qry
                + "ORDER BY mst_sales_person.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("employeeCode", Hibernate.STRING)
                .addScalar("employeeName", Hibernate.STRING)
                .addScalar("employeeAddress", Hibernate.STRING)
                .addScalar("employeeCityCode", Hibernate.STRING)
                .addScalar("employeeCityName", Hibernate.STRING)
                .addScalar("employeePhone1", Hibernate.STRING)
                .addScalar("employeePhone2", Hibernate.STRING)
                .addScalar("employeeEmail", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(SalesPersonTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
        
   
    public void save(SalesPerson salesPerson, String moduleCode) throws ParseException {
        try {
            hbmSession.hSession.beginTransaction();
            
            salesPerson.setCode(createCode(salesPerson));
            if(salesPerson.isActiveStatus()){
                salesPerson.setInActiveBy("");
                salesPerson.setInActiveDate(commonFunction.setDateTime("01/01/1900 00:00:00"));
            }else{
                salesPerson.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                salesPerson.setInActiveDate(new Date());
            }
            salesPerson.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            salesPerson.setCreatedDate(new Date()); 

            hbmSession.hSession.save(salesPerson);
   
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    salesPerson.getCode() , moduleCode));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(SalesPerson salesPerson, String moduleCode) throws ParseException {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(salesPerson.isActiveStatus()){
                salesPerson.setInActiveBy("");
                salesPerson.setInActiveDate(commonFunction.setDateTime("01/01/1900 00:00:00"));
            }else{
                salesPerson.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                salesPerson.setInActiveDate(new Date());
            }
            salesPerson.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            salesPerson.setUpdatedDate(new Date()); 
            hbmSession.hSession.update(salesPerson);

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    salesPerson.getCode(), ""));

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
            hbmSession.hSession.createQuery("DELETE FROM " + SalesPersonField.BEAN_NAME + " WHERE " + SalesPersonField.CODE + " = :prmCode")
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


    public SalesPersonTemp min() {
        try {
            
            String qry = 
                    "SELECT "
                + "mst_sales_person.code, "
                + "mst_sales_person.Name "
                + "FROM mst_sales_person "
                + "INNER JOIN mst_employee ON mst_sales_person.employeeCode=mst_employee.Code "
                + "ORDER BY mst_sales_person.code "
                + "LIMIT 0,1";
            SalesPersonTemp salesPersonTemp =(SalesPersonTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(SalesPersonTemp.class))
            .uniqueResult();   
            
            return salesPersonTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public SalesPersonTemp max() {
        try {
            
            String qry = 
                    "SELECT "
                + "mst_sales_person.code, "
                + "mst_sales_person.Name "
                + "FROM mst_sales_person "
                + "INNER JOIN mst_employee ON mst_sales_person.employeeCode=mst_employee.Code "
                + "ORDER BY mst_sales_person.code DESC "
                + "LIMIT 0,1";
            SalesPersonTemp salesPersonTemp =(SalesPersonTemp)hbmSession.hSession.createSQLQuery(qry)
            .addScalar("code", Hibernate.STRING)
            .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(SalesPersonTemp.class))
            .uniqueResult();   
            
            return salesPersonTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<SalesPersonDistributionChannel> findDetailByCriteria(DetachedCriteria dc, int from, int size) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setFirstResult(from)
                    .setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
}