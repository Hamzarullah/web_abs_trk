

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.Education;
import com.inkombizz.master.model.EducationTemp;
import com.inkombizz.master.model.EducationField;



public class EducationDAO {
    
    private HBMSession hbmSession;
    
    public EducationDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_education.ActiveStatus="+active+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_education "
                + "WHERE mst_education.code LIKE '%"+code+"%' "
                + "AND mst_education.name LIKE '%"+name+"%' "
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
    
    public EducationTemp findData(String code) {
        try {
            EducationTemp educationTemp = (EducationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_education.Code, "
                + "mst_education.name, "
                + "mst_education.activeStatus, "
                + "mst_education.remark, "
                + "mst_education.InActiveBy, "
                + "mst_education.InActiveDate, "
                + "mst_education.CreatedBy, "
                + "mst_education.CreatedDate "
                + "FROM mst_education "
                + "WHERE mst_education.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(EducationTemp.class))
                .uniqueResult(); 
                 
                return educationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public EducationTemp findData(String code,boolean active) {
        try {
            EducationTemp educationTemp = (EducationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_education.Code, "
                + "mst_education.name, "
                + "mst_education.remark "
                + "FROM mst_education "
                + "WHERE mst_education.code ='"+code+"' "
                + "AND mst_education.ActiveStatus ="+active+" ")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(EducationTemp.class))
                .uniqueResult(); 
                 
                return educationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<EducationTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_education.ActiveStatus="+active+" ";
            }
            List<EducationTemp> list = (List<EducationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_education.Code, "
                + "mst_education.name, "
                + "mst_education.remark, "
                + "mst_education.ActiveStatus "
                + "FROM mst_education "
                + "WHERE mst_education.code LIKE '%"+code+"%' "
                + "AND mst_education.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(EducationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Education education, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(education.isActiveStatus()){
                education.setInActiveBy("");                
            }else{
                education.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                education.setInActiveDate(new Date());
            }
            
            education.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            education.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(education);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    education.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Education education, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(education.isActiveStatus()){
                education.setInActiveBy("");                
            }else{
                education.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                education.setInActiveDate(new Date());
            }
            education.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            education.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(education);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    education.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + EducationField.BEAN_NAME + " WHERE " + EducationField.CODE + " = :prmCode")
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
    
    
    
}
