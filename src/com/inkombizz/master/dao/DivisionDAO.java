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
import com.inkombizz.master.model.Division;
import com.inkombizz.master.model.DivisionField;
import com.inkombizz.master.model.DivisionTemp;
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


public class DivisionDAO {
    
    private HBMSession hbmSession;
    
    public DivisionDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <Division> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<Division> findByCriteria(DetachedCriteria dc) {
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
                concat_qry="AND mst_division.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_division.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_division.ActiveStatus = 0 OR mst_division.ActiveStatus = 1) ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_division "
                + "INNER JOIN mst_department ON mst_division.DepartmentCode=mst_department.Code "
                + "WHERE mst_division.code LIKE :prmCode "
                + "AND mst_division.name LIKE :prmName "+concat_qry)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countSearchDataWithUserAuth(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_division.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_division.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_division.ActiveStatus = 0 OR mst_division.ActiveStatus = 1) ";
            }
            
            String user = BaseSession.loadProgramSession().getUserName();
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_division "
                + "INNER JOIN mst_department ON mst_division.DepartmentCode=mst_department.Code "
                + "WHERE mst_division.code LIKE :prmCode "
                + "AND mst_division.Code IN ("
                    + " SELECT scr_user_division.DivisionCode From scr_user_division WHERE scr_user_division.UserCode = '"+user+"') "
                + "AND mst_division.name LIKE :prmName "+concat_qry)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public DivisionTemp findData(String code) {
        try {
            DivisionTemp divisionTemp = (DivisionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_division.Code, "
                + "mst_division.name, "
                + "mst_division.DepartmentCode, "
                + "mst_department.Name AS DepartmentName, "
                + "mst_division.activeStatus, "
                + "mst_division.remark, "
                + "mst_division.InActiveBy, "
                + "mst_division.InActiveDate, "
                + "mst_division.CreatedBy, "
                + "mst_division.CreatedDate "
                + "FROM mst_division "
                + "INNER JOIN mst_department ON mst_division.DepartmentCode=mst_department.Code "
                + "WHERE mst_division.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("departmentCode", Hibernate.STRING)
                .addScalar("departmentName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DivisionTemp.class))
                .uniqueResult(); 
                 
                return divisionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DivisionTemp findData(String code,boolean active) {
        try {
            DivisionTemp divisionTemp = (DivisionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_division.Code, "
                + "mst_division.name, "
                + "mst_division.DepartmentCode, "
                + "mst_department.Name AS DepartmentName, "
                + "mst_division.remark "
                + "FROM mst_division "
                + "INNER JOIN mst_department ON mst_division.DepartmentCode=mst_department.Code "
                + "WHERE mst_division.code like '%"+code+"%' "
                + "AND mst_division.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("departmentCode", Hibernate.STRING)
                .addScalar("departmentName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DivisionTemp.class))
                .uniqueResult(); 
                 
                return divisionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DivisionTemp findDataWithUserAuth(String code,boolean active) {
        try {
            
            String user = BaseSession.loadProgramSession().getUserName();
            
            DivisionTemp divisionTemp = (DivisionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_division.Code, "
                + "mst_division.name, "
                + "mst_division.DepartmentCode, "
                + "mst_department.Name AS DepartmentName, "
                + "mst_division.remark "
                + "FROM mst_division "
                + "INNER JOIN mst_department ON mst_division.DepartmentCode=mst_department.Code "
                + "WHERE mst_division.code like '%"+code+"%' "
                + "AND mst_division.Code IN ("
                    + " SELECT scr_user_division.DivisionCode From scr_user_division WHERE scr_user_division.UserCode = '"+user+"') "
                + "AND mst_division.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("departmentCode", Hibernate.STRING)
                .addScalar("departmentName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DivisionTemp.class))
                .uniqueResult(); 
                 
                return divisionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
     public List<DivisionTemp> findSearchData(String code, String name, String active,int from, int row) {
        try {   

            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_division.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_division.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_division.ActiveStatus = 0 OR mst_division.ActiveStatus = 1) ";
            }
            
            List<DivisionTemp> list = (List<DivisionTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_division.Code AS code, "
                + "mst_division.Name AS name, "
                + "mst_division.DepartmentCode, "
                + "mst_department.Name AS DepartmentName, "
                + "mst_division.ActiveStatus "
                + "FROM mst_division "
                + "INNER JOIN mst_department ON mst_division.DepartmentCode=mst_department.Code "
                + "WHERE mst_division.code LIKE :prmCode "
                + "AND mst_division.name LIKE :prmName "+concat_qry
                + "ORDER BY mst_division.code "
                + "LIMIT "+from+","+row+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("departmentCode", Hibernate.STRING)
                .addScalar("departmentName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(DivisionTemp.class))

                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     
    public List<DivisionTemp> findSearchDataWithUserAuth(String code, String name, String active,int from, int row) {
        try {   

            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_division.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_division.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_division.ActiveStatus = 0 OR mst_division.ActiveStatus = 1) ";
            }
            
            String user = BaseSession.loadProgramSession().getUserName();
            
            List<DivisionTemp> list = (List<DivisionTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_division.Code AS code, "
                + "mst_division.Name AS name, "
                + "mst_division.DepartmentCode, "
                + "mst_department.Name AS DepartmentName, "
                + "mst_division.ActiveStatus "
                + "FROM mst_division "
                + "INNER JOIN mst_department ON mst_division.DepartmentCode=mst_department.Code "
                + "WHERE mst_division.code LIKE :prmCode "
                + "AND mst_division.Code IN ("
                    + " SELECT scr_user_division.DivisionCode From scr_user_division WHERE scr_user_division.UserCode = '"+user+"' ) "
                + "AND mst_division.name LIKE :prmName "+concat_qry
                + "ORDER BY mst_division.code "
                + "LIMIT "+from+","+row+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("departmentCode", Hibernate.STRING)
                .addScalar("departmentName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(DivisionTemp.class))

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
    
    public Division get(String id) {
        try {
            return (Division) hbmSession.hSession.get(Division.class, id);
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
                    "SELECT COUNT(mst_division.Code) "
                + "FROM mst_division "
                + "WHERE mst_division.code LIKE '%"+code+"%' "
                + "AND mst_division.name LIKE '%"+name+"%' "
                + "AND mst_division.code IN("+concatTemp+") "
                + "AND mst_division.ActiveStatus=TRUE"
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<DivisionTemp> findSearchDataWithArray(String code, String name, String concat, int from, int row) {
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
            
                List<DivisionTemp> list = (List<DivisionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_division.Code, "
                + "mst_division.name "
                + "FROM mst_division "
                + "WHERE mst_division.code LIKE '%"+code+"%' "
                + "AND mst_division.name LIKE '%"+name+"%' "
                + "AND mst_division.code IN("+concatTemp+") "
                + "AND mst_division.ActiveStatus=TRUE "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DivisionTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Division division, String moduleCode) throws Exception{
        try {
            hbmSession.hSession.beginTransaction();
            division.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            division.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(division);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    division.getCode(), "DIVISION"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(Division division, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(division.isActiveStatus()){
                division.setInActiveBy("");                
            }else{
                division.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                division.setInActiveDate(new Date());
            }
            
            division.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            division.setUpdatedDate(new Date());
            
            hbmSession.hSession.update(division);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    division.getCode(), "DIVISION"));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DivisionField.BEAN_NAME + " WHERE " + DivisionField.CODE + " = :prmId")
                    .setParameter("prmId", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, "DIVISION"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    } 
}