package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.VendorContact;
import com.inkombizz.master.model.VendorContactField;
import com.inkombizz.master.model.VendorContactTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

public class VendorContactDAO {
    
    private HBMSession hbmSession;
	
    public VendorContactDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public String createCode(VendorContact vendorContact){   
        try{
            String acronim = "VDRCTC";
            DetachedCriteria dc = DetachedCriteria.forClass(VendorContact.class)
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
                concat_qry="AND mst_vendor_jn_contact.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_vendor_jn_contact "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = mst_vendor_jn_contact.VendorCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode "
                + "WHERE mst_vendor_jn_contact.code LIKE :prmCode "
                + "AND mst_vendor_jn_contact.name LIKE :prmName "
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
   
    public int countDataForVendor(String vendorCode,String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_vendor_jn_contact.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_vendor_jn_contact "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = mst_vendor_jn_contact.VendorCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode "
                + "WHERE mst_vendor_jn_contact.code LIKE :prmCode "
                + "AND mst_vendor_jn_contact.name LIKE :prmName "
                + "AND mst_vendor_jn_contact.VendorCode LIKE :prmVendorCode "
                + concat_qry)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmName", "%"+name+"%")
                    .setParameter("prmVendorCode", "%"+vendorCode+"%")
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
                    + "SELECT COUNT(mst_vendor_jn_contact.Code) "
                    + "FROM mst_vendor_jn_contact "
                    + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode "
                    + "WHERE mst_vendor_jn_contact.code LIKE '%"+code+"%' "
                    + "AND mst_vendor_jn_contact.name LIKE '%"+name+"%' "
                    + "AND mst_vendor_jn_contact.code IN("+concatTemp+") "
                    + "AND mst_vendor_jn_contact.ActiveStatus=TRUE")
                    .uniqueResult();
            
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<VendorContactTemp> findSearchDataWithArray(String code, String name, String concat, int from, int row) {
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
            
            List<VendorContactTemp> list = (List<VendorContactTemp>)hbmSession.hSession.createSQLQuery(""
                    + "SELECT "
                    + "mst_vendor_jn_contact.Code, "
                    + "mst_vendor_jn_contact.name, "
                    + "mst_vendor_jn_contact.birthDate, "
                    + "mst_vendor_jn_contact.JobPositionCode, "
                    + "mst_job_position.name AS JobPositionName "
                    + "FROM mst_vendor_jn_contact "
                    + "JOIN mst_job_position ON mst_job_position.code = mst_vendor_jn_contact.JobPositionCode "
                    + "WHERE mst_vendor_jn_contact.code LIKE '%"+code+"%' "
                    + "AND mst_vendor_jn_contact.name LIKE '%"+name+"%' "
                    + "AND mst_vendor_jn_contact.code IN("+concatTemp+") "
                    + "AND mst_vendor_jn_contact.ActiveStatus=TRUE "
                    + "LIMIT "+from+","+row+"")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .addScalar("birthDate", Hibernate.TIMESTAMP)
                    .addScalar("jobPositionCode", Hibernate.STRING)
                    .addScalar("jobPositionName", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(VendorContactTemp.class))
                    .list(); 
            
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public VendorContactTemp findData(String code) {
        try {
            VendorContactTemp vendorContactTemp = (VendorContactTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_vendor_jn_contact.Code, "
                + "mst_vendor_jn_contact.VendorCode,"
                + "mst_vendor.Name AS vendorName, "
                + "mst_vendor_jn_contact.Name, "
                + "mst_vendor_jn_contact.Phone, "
                + "mst_vendor_jn_contact.MobileNo, "
                + "mst_vendor_jn_contact.BirthDate, "
                + "mst_vendor_jn_contact.JobPositionCode, "
                + "mst_job_position.Name As jobPositionName, "
                + "mst_vendor_jn_contact.activeStatus, "
                + "mst_vendor_jn_contact.CreatedBy, "
                + "mst_vendor_jn_contact.CreatedDate "
                + "FROM mst_vendor_jn_contact "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = mst_vendor_jn_contact.VendorCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode " 
                + "WHERE mst_vendor_jn_contact.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("mobileNo", Hibernate.STRING)    
                .addScalar("birthDate", Hibernate.TIMESTAMP)
                .addScalar("jobPositionCode", Hibernate.STRING)
                .addScalar("jobPositionName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(VendorContactTemp.class))
                .uniqueResult(); 
                 
                return vendorContactTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public VendorContactTemp findData(String code,boolean active) {
        try {
            VendorContactTemp vendorContactTemp = (VendorContactTemp)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "mst_vendor_jn_contact.Code, "
                + "mst_vendor_jn_contact.VendorCode,"
                + "mst_vendor.Name AS vendorName, "
                + "mst_vendor_jn_contact.Name, "
                + "mst_vendor_jn_contact.Phone, "
                + "mst_vendor_jn_contact.MobileNo, "
                + "mst_vendor_jn_contact.BirthDate, "
                + "mst_vendor_jn_contact.JobPositionCode, "
                + "mst_job_position.Name As jobPositionName, "
                + "mst_vendor_jn_contact.activeStatus, "
                + "mst_vendor_jn_contact.CreatedBy, "
                + "mst_vendor_jn_contact.CreatedDate "
                + "FROM mst_vendor_jn_contact "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = mst_vendor_jn_contact.VendorCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode " 
                + "WHERE mst_vendor_jn_contact.code ='"+code+"' "
                + "AND mst_vendor_jn_contact.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("mobileNo", Hibernate.STRING)    
                .addScalar("birthDate", Hibernate.TIMESTAMP)
                .addScalar("jobPositionCode", Hibernate.STRING)
                .addScalar("jobPositionName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(VendorContactTemp.class))
                .uniqueResult(); 
                 
                return vendorContactTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public VendorContactTemp findDataVendorContactForVendor(String vendorCode,String code) {
        try {
            VendorContactTemp vendorContactTemp = (VendorContactTemp)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "mst_vendor_jn_contact.Code, "
                + "mst_vendor_jn_contact.VendorCode,"
                + "mst_vendor.Name AS vendorName, "
                + "mst_vendor_jn_contact.Name, "
                + "mst_vendor_jn_contact.Phone, "
                + "mst_vendor_jn_contact.MobileNo, "
                + "mst_vendor_jn_contact.BirthDate, "
                + "mst_vendor_jn_contact.JobPositionCode, "
                + "mst_job_position.Name As jobPositionName, "
                + "mst_vendor_jn_contact.activeStatus, "
                + "mst_vendor_jn_contact.CreatedBy, "
                + "mst_vendor_jn_contact.CreatedDate "
                + "FROM mst_vendor_jn_contact "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = mst_vendor_jn_contact.VendorCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode " 
                + "WHERE mst_vendor_jn_contact.code LIKE '%"+code+"%' "
                + "AND mst_vendor.code ='"+vendorCode+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("mobileNo", Hibernate.STRING)    
                .addScalar("birthDate", Hibernate.TIMESTAMP)
                .addScalar("jobPositionCode", Hibernate.STRING)
                .addScalar("jobPositionName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(VendorContactTemp.class))
                .uniqueResult(); 
                 
                return vendorContactTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<VendorContactTemp> findDataVendorContactTemp(String headerCode) {
        try {
            List<VendorContactTemp> list = (List<VendorContactTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "mst_vendor_jn_contact.Code AS code, "
                    + "mst_vendor_jn_contact.name AS name, "
                    + "mst_vendor_jn_contact.VendorCode AS vendorCode, "
                    + "mst_vendor.name AS vendorName, "
                    + "mst_vendor_jn_contact.ActiveStatus, "
                    + "mst_vendor_jn_contact.Phone AS phone, "
                    + "mst_vendor_jn_contact.MobileNo AS mobileNo, "
                    + "mst_vendor_jn_contact.BirthDate AS birthDate, "
                    + "mst_vendor_jn_contact.JobPositionCode AS jobPositionCode, "
                    + "mst_job_position.Name As jobPositionName, "
                    + "mst_vendor.DefaultContactPersonCode "
                    + "FROM mst_vendor_jn_contact "
                    + "INNER JOIN mst_vendor ON mst_vendor.`code` = mst_vendor_jn_contact.VendorCode "
                    + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode " 
                    + "WHERE mst_vendor_jn_contact.VendorCode='" + headerCode + "' "
                    + "ORDER BY mst_vendor_jn_contact.code ASC  "
                    + "")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("vendorCode", Hibernate.STRING)
                    .addScalar("vendorName", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
                    .addScalar("phone", Hibernate.STRING)
                    .addScalar("mobileNo", Hibernate.STRING)    
                    .addScalar("birthDate", Hibernate.TIMESTAMP)
                    .addScalar("jobPositionCode", Hibernate.STRING)
                    .addScalar("jobPositionName", Hibernate.STRING)
                    .addScalar("activeStatus", Hibernate.BOOLEAN)
                    .addScalar("defaultContactPersonCode", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(VendorContactTemp.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }

    public List<VendorContactTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_vendor_jn_contact.ActiveStatus="+active+" ";
            }
            List<VendorContactTemp> list = (List<VendorContactTemp>)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "mst_vendor_jn_contact.Code, "
                + "mst_vendor_jn_contact.VendorCode,"
                + "mst_vendor.Name AS vendorName, "
                + "mst_vendor_jn_contact.Name, "
                + "mst_vendor_jn_contact.Phone, "
                + "mst_vendor_jn_contact.MobileNo, "
                + "mst_vendor_jn_contact.BirthDate, "
                + "mst_vendor_jn_contact.JobPositionCode, "
                + "mst_job_position.Name As jobPositionName, "
                + "mst_vendor_jn_contact.activeStatus, "
                + "mst_vendor_jn_contact.CreatedBy, "
                + "mst_vendor_jn_contact.CreatedDate "
                + "FROM mst_vendor_jn_contact "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = mst_vendor_jn_contact.VendorCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode " 
                + "WHERE mst_vendor_jn_contact.code LIKE '%"+code+"%' "
                + "AND mst_vendor_jn_contact.name LIKE '%"+name+"%' "
                + concat_qry
                + "ORDER BY mst_vendor_jn_contact.code ASC ")
                    
                 .addScalar("code", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("mobileNo", Hibernate.STRING)    
                .addScalar("birthDate", Hibernate.TIMESTAMP)
                .addScalar("jobPositionCode", Hibernate.STRING)
                .addScalar("jobPositionName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(VendorContactTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorContactTemp> findDataForVendor(String vendorCode, String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_vendor_jn_contact.ActiveStatus="+active+" ";
            }
            List<VendorContactTemp> list = (List<VendorContactTemp>)hbmSession.hSession.createSQLQuery(
                  "SELECT "
                + "mst_vendor_jn_contact.Code, "
                + "mst_vendor_jn_contact.VendorCode, "
                + "mst_vendor.Name AS vendorName, "
                + "mst_vendor_jn_contact.Name, "
                + "mst_vendor_jn_contact.Phone, "
                + "mst_vendor_jn_contact.MobileNo, "
                + "mst_vendor_jn_contact.BirthDate, "
                + "mst_vendor_jn_contact.JobPositionCode, "
                + "mst_job_position.Name As jobPositionName, "
                + "mst_vendor_jn_contact.activeStatus, "
                + "mst_vendor_jn_contact.CreatedBy, "
                + "mst_vendor_jn_contact.CreatedDate "
                + "FROM mst_vendor_jn_contact "
                + "INNER JOIN mst_vendor ON mst_vendor.Code = mst_vendor_jn_contact.VendorCode "
                + "INNER JOIN mst_job_position on mst_job_position.Code = mst_vendor_jn_contact.JobPositionCode " 
                + "WHERE mst_vendor_jn_contact.code LIKE '%"+code+"%' "
                + "AND mst_vendor_jn_contact.name LIKE '%"+name+"%' "
                + "AND mst_vendor_jn_contact.VendorCode LIKE '%"+vendorCode+"%' "
                + concat_qry
                + "ORDER BY mst_vendor_jn_contact.code ASC ")
                    
                 .addScalar("code", Hibernate.STRING)
                .addScalar("vendorCode", Hibernate.STRING)
                .addScalar("vendorName", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("phone", Hibernate.STRING)
                .addScalar("mobileNo", Hibernate.STRING)    
                .addScalar("birthDate", Hibernate.TIMESTAMP)
                .addScalar("jobPositionCode", Hibernate.STRING)
                .addScalar("jobPositionName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(VendorContactTemp.class))
                .setFirstResult(from)
                .setMaxResults(row)
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public VendorContact get(String code){
        try{
            return (VendorContact) hbmSession.hSession.get(VendorContact.class, code);
        }catch(HibernateException e){
            throw e;
        }
    }
    
    public void save(VendorContact vendorContact, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            vendorContact.setCode(createCode(vendorContact));
            if(vendorContact.isActiveStatus()){
                vendorContact.setInActiveBy("");                
            }else{
                vendorContact.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                vendorContact.setInActiveDate(new Date());
            }
            
            vendorContact.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            vendorContact.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(vendorContact);
            
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    vendorContact.getCode(), ""));

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(VendorContact vendorContact, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(vendorContact.isActiveStatus()){
                vendorContact.setInActiveBy("");                
            }else{
                vendorContact.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                vendorContact.setInActiveDate(new Date());
            }
            vendorContact.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            vendorContact.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(vendorContact);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    vendorContact.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + VendorContactField.BEAN_NAME + " WHERE " + VendorContactField.CODE + " = :prmCode")
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