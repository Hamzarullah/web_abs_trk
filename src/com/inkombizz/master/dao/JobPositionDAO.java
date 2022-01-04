

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
import com.inkombizz.master.model.ItemBoltField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.JobPosition;
import com.inkombizz.master.model.JobPositionTemp;
import com.inkombizz.master.model.JobPositionField;
import org.hibernate.criterion.Restrictions;



public class JobPositionDAO {
    
    private HBMSession hbmSession;
    
    public JobPositionDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(JobPosition jobPosition){   
        try{
            String acronim = "JOBPOS";
            DetachedCriteria dc = DetachedCriteria.forClass(JobPosition.class)
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
                concat_qry="AND mst_job_position.ActiveStatus="+active+" ";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_job_position "
                + "WHERE mst_job_position.code LIKE '%"+code+"%' "
                + "AND mst_job_position.name LIKE '%"+name+"%' "
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
    
    public JobPositionTemp findData(String code) {
        try {
            JobPositionTemp jobPositionTemp = (JobPositionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_job_position.Code, "
                + "mst_job_position.name, "
                + "mst_job_position.activeStatus, "
                + "mst_job_position.remark, "
                + "mst_job_position.InActiveBy, "
                + "mst_job_position.InActiveDate, "
                + "mst_job_position.CreatedBy, "
                + "mst_job_position.CreatedDate "
                + "FROM mst_job_position "
                + "WHERE mst_job_position.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(JobPositionTemp.class))
                .uniqueResult(); 
                 
                return jobPositionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public JobPositionTemp findData(String code,boolean active) {
        try {
            JobPositionTemp jobPositionTemp = (JobPositionTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_job_position.Code, "
                + "mst_job_position.name, "
                + "mst_job_position.remark "
                + "FROM mst_job_position "
                + "WHERE mst_job_position.code ='"+code+"' "
                + "AND mst_job_position.ActiveStatus ="+active+" ")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(JobPositionTemp.class))
                .uniqueResult(); 
                 
                return jobPositionTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<JobPositionTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_job_position.ActiveStatus="+active+" ";
            }
            List<JobPositionTemp> list = (List<JobPositionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_job_position.Code, "
                + "mst_job_position.name, "
                + "mst_job_position.remark, "
                + "mst_job_position.ActiveStatus "
                + "FROM mst_job_position "
                + "WHERE mst_job_position.code LIKE '%"+code+"%' "
                + "AND mst_job_position.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(JobPositionTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public List<JobPosition> findByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(JobPosition jobPosition, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            jobPosition.setCode(createCode(jobPosition));
            if(jobPosition.isActiveStatus()){
                jobPosition.setInActiveBy("");                
            }else{
                jobPosition.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                jobPosition.setInActiveDate(new Date());
            }
            
            jobPosition.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            jobPosition.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(jobPosition);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    jobPosition.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(JobPosition jobPosition, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(jobPosition.isActiveStatus()){
                jobPosition.setInActiveBy("");                
            }else{
                jobPosition.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                jobPosition.setInActiveDate(new Date());
            }
            jobPosition.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            jobPosition.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(jobPosition);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    jobPosition.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + JobPositionField.BEAN_NAME + " WHERE " + JobPositionField.CODE + " = :prmCode")
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
