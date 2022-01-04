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
import com.inkombizz.master.model.Department;
import com.inkombizz.master.model.DepartmentField;
import com.inkombizz.master.model.DepartmentTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

/**
 *
 * @author Rayis
 */
public class DepartmentDAO {
    
    private HBMSession hbmSession;
    
    public DepartmentDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <Department> findByCriteria(DetachedCriteria dc, int from, int size) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setFirstResult(from);
            criteria.setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<Department> findByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countSearchData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_department.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_department.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_department.ActiveStatus = 0 OR mst_department.ActiveStatus = 1) ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_department "
                + "WHERE mst_department.code LIKE :prmCode "
                + "AND mst_department.name LIKE :prmName "+concat_qry)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public DepartmentTemp findData(String code) {
        try {
            DepartmentTemp departmentTemp = (DepartmentTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_department.Code, "
                + "mst_department.name, "
                + "mst_department.activeStatus, "
                + "mst_department.remark, "
                + "mst_department.InActiveBy, "
                + "mst_department.InActiveDate, "
                + "mst_department.CreatedBy, "
                + "mst_department.CreatedDate "
                + "FROM mst_department "
                + "WHERE mst_department.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DepartmentTemp.class))
                .uniqueResult(); 
                 
                return departmentTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DepartmentTemp findData(String code,boolean active) {
        try {
            DepartmentTemp departmentTemp = (DepartmentTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_department.Code, "
                + "mst_department.name, "
                + "mst_department.remark "
                + "FROM mst_department "
                + "WHERE mst_department.code like '%"+code+"%' "
                + "AND mst_department.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DepartmentTemp.class))
                .uniqueResult(); 
                 
                return departmentTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
     public List<DepartmentTemp> findSearchData(String code, String name, String active,int from, int row) {
        try {   

            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_department.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_department.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_department.ActiveStatus = 0 OR mst_department.ActiveStatus = 1) ";
            }
            
            List<DepartmentTemp> list = (List<DepartmentTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_department.Code AS code, "
                + "mst_department.Name AS name, "
                + "mst_department.ActiveStatus "
                + "FROM mst_department "
                + "WHERE mst_department.code LIKE :prmCode "
                + "AND mst_department.name LIKE :prmName "+concat_qry
                + "ORDER BY mst_department.code "
                + "LIMIT "+from+","+row+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(DepartmentTemp.class))

                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

     public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            
            List countData = criteria.list();
            
            if (countData.isEmpty())
                return 0;
            else {
                return  ( Integer.parseInt(countData.get(0).toString()) ) ;
            }
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public Department get(String id) {
        try {
            return (Department) hbmSession.hSession.get(Department.class, id);
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
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(mst_department.Code) "
                + "FROM mst_department "
                + "WHERE mst_department.code LIKE '%"+code+"%' "
                + "AND mst_department.name LIKE '%"+name+"%' "
                + "AND mst_department.code IN("+concatTemp+") "
                + "AND mst_department.ActiveStatus=TRUE"
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<DepartmentTemp> findSearchDataWithArray(String code, String name, String concat, int from, int row) {
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
            
                List<DepartmentTemp> list = (List<DepartmentTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_department.Code, "
                + "mst_department.name "
                + "FROM mst_department "
                + "WHERE mst_department.code LIKE '%"+code+"%' "
                + "AND mst_department.name LIKE '%"+name+"%' "
                + "AND mst_department.code IN("+concatTemp+") "
                + "AND mst_department.ActiveStatus=TRUE "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DepartmentTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Department department, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            department.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            department.setCreatedDate(new Date()); 
//            department.setCompanyCode(BaseSession.loadProgramSession().getCompanyCode());
//            String Id = department.getCode();
//            department.setId(Id);
            hbmSession.hSession.save(department);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    department.getCode(), "CAR BRAND"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(Department department, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(department.isActiveStatus()){
                department.setInActiveBy("");                
            }else{
                department.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                department.setInActiveDate(new Date());
            }
            
            department.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            department.setUpdatedDate(new Date());
            
            hbmSession.hSession.update(department);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    department.getCode(), "CAR BRAND"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void delete(String id, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + DepartmentField.BEAN_NAME + " WHERE " + DepartmentField.CODE + " = :prmId")
                    .setParameter("prmId", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, "CAR BRAND"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    } 
}