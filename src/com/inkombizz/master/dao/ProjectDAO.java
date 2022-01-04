

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
import com.inkombizz.master.model.DcasVisualExamination;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.Project;
import com.inkombizz.master.model.ProjectTemp;
import com.inkombizz.master.model.ProjectField;
import org.hibernate.criterion.Restrictions;



public class ProjectDAO {
    
    private HBMSession hbmSession;
    
    public ProjectDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(Project project){   
        try{
            String acronim = "PJT";
            DetachedCriteria dc = DetachedCriteria.forClass(Project.class)
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
                concat_qry="AND mst_project.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_project "
                + "WHERE mst_project.code LIKE '%"+code+"%' "
                + "AND mst_project.name LIKE '%"+name+"%' "
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
    
    public ProjectTemp findData(String code) {
        try {
            ProjectTemp projectTemp = (ProjectTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_project.Code, "
                + "mst_project.name, "
                + "mst_project.activeStatus, "
                + "mst_project.remark, "
                + "mst_project.InActiveBy, "
                + "mst_project.InActiveDate, "
                + "mst_project.CreatedBy, "
                + "mst_project.CreatedDate "
                + "FROM mst_project "
                + "WHERE mst_project.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ProjectTemp.class))
                .uniqueResult(); 
                 
                return projectTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ProjectTemp findData(String code,boolean active) {
        try {
            ProjectTemp projectTemp = (ProjectTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_project.Code, "
                + "mst_project.name, "
                + "mst_project.remark "
                + "FROM mst_project "
                + "WHERE mst_project.code ='"+code+"' "
                + "AND mst_project.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ProjectTemp.class))
                .uniqueResult(); 
                 
                return projectTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ProjectTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_project.ActiveStatus="+active+" ";
            }
            List<ProjectTemp> list = (List<ProjectTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_project.Code, "
                + "mst_project.name, "
                + "mst_project.remark, "
                + "mst_project.ActiveStatus "
                + "FROM mst_project "
                + "WHERE mst_project.code LIKE '%"+code+"%' "
                + "AND mst_project.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ProjectTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Project project, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            project.setCode(createCode(project));
            if(project.isActiveStatus()){
                project.setInActiveBy("");                
            }else{
                project.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                project.setInActiveDate(new Date());
            }
            
            project.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            project.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(project);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    project.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Project project, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(project.isActiveStatus()){
                project.setInActiveBy("");                
            }else{
                project.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                project.setInActiveDate(new Date());
            }
            project.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            project.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(project);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    project.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ProjectField.BEAN_NAME + " WHERE " + ProjectField.CODE + " = :prmCode")
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
