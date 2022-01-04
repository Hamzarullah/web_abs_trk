

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
import com.inkombizz.master.model.DcasTesting;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.DcasVisualExamination;
import com.inkombizz.master.model.DcasVisualExaminationTemp;
import com.inkombizz.master.model.DcasVisualExaminationField;
import org.hibernate.criterion.Restrictions;



public class DcasVisualExaminationDAO {
    
    private HBMSession hbmSession;
    
    public DcasVisualExaminationDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(DcasVisualExamination dcasVisualExamination){   
        try{
            String acronim = "DCASVISEXM";
            DetachedCriteria dc = DetachedCriteria.forClass(DcasVisualExamination.class)
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
                concat_qry="AND mst_dcas_visual_examination.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_dcas_visual_examination "
                + "WHERE mst_dcas_visual_examination.code LIKE '%"+code+"%' "
                + "AND mst_dcas_visual_examination.name LIKE '%"+name+"%' "
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
    
    public DcasVisualExaminationTemp findData(String code) {
        try {
            DcasVisualExaminationTemp dcasVisualExaminationTemp = (DcasVisualExaminationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_visual_examination.Code, "
                + "mst_dcas_visual_examination.name, "
                + "mst_dcas_visual_examination.activeStatus, "
                + "mst_dcas_visual_examination.remark, "
                + "mst_dcas_visual_examination.InActiveBy, "
                + "mst_dcas_visual_examination.InActiveDate, "
                + "mst_dcas_visual_examination.CreatedBy, "
                + "mst_dcas_visual_examination.CreatedDate "
                + "FROM mst_dcas_visual_examination "
                + "WHERE mst_dcas_visual_examination.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DcasVisualExaminationTemp.class))
                .uniqueResult(); 
                 
                return dcasVisualExaminationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DcasVisualExaminationTemp findData(String code,boolean active) {
        try {
            DcasVisualExaminationTemp dcasVisualExaminationTemp = (DcasVisualExaminationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_visual_examination.Code, "
                + "mst_dcas_visual_examination.name, "
                + "mst_dcas_visual_examination.remark "
                + "FROM mst_dcas_visual_examination "
                + "WHERE mst_dcas_visual_examination.code ='"+code+"' "
                + "AND mst_dcas_visual_examination.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DcasVisualExaminationTemp.class))
                .uniqueResult(); 
                 
                return dcasVisualExaminationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<DcasVisualExaminationTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_dcas_visual_examination.ActiveStatus="+active+" ";
            }
            List<DcasVisualExaminationTemp> list = (List<DcasVisualExaminationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_visual_examination.Code, "
                + "mst_dcas_visual_examination.name, "
                + "mst_dcas_visual_examination.remark, "
                + "mst_dcas_visual_examination.ActiveStatus "
                + "FROM mst_dcas_visual_examination "
                + "WHERE mst_dcas_visual_examination.code LIKE '%"+code+"%' "
                + "AND mst_dcas_visual_examination.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(DcasVisualExaminationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(DcasVisualExamination dcasVisualExamination, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            dcasVisualExamination.setCode(createCode(dcasVisualExamination));
            if(dcasVisualExamination.isActiveStatus()){
                dcasVisualExamination.setInActiveBy("");                
            }else{
                dcasVisualExamination.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasVisualExamination.setInActiveDate(new Date());
            }
            
            dcasVisualExamination.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            dcasVisualExamination.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(dcasVisualExamination);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    dcasVisualExamination.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(DcasVisualExamination dcasVisualExamination, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(dcasVisualExamination.isActiveStatus()){
                dcasVisualExamination.setInActiveBy("");                
            }else{
                dcasVisualExamination.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasVisualExamination.setInActiveDate(new Date());
            }
            dcasVisualExamination.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            dcasVisualExamination.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(dcasVisualExamination);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    dcasVisualExamination.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DcasVisualExaminationField.BEAN_NAME + " WHERE " + DcasVisualExaminationField.CODE + " = :prmCode")
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
