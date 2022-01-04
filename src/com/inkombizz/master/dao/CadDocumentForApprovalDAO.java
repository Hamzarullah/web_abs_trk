

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.CadDocumentForApproval;
import com.inkombizz.master.model.CadDocumentForApprovalTemp;
import com.inkombizz.master.model.CadDocumentForApprovalField;
import com.inkombizz.master.model.ItemBolt;
import org.hibernate.criterion.Restrictions;



public class CadDocumentForApprovalDAO {
    
    private HBMSession hbmSession;
    
    public CadDocumentForApprovalDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(CadDocumentForApproval cadDocumentForApproval){   
        try{
            String acronim = "CADDFA";
            DetachedCriteria dc = DetachedCriteria.forClass(CadDocumentForApproval.class)
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
                concat_qry="AND mst_cad_document_for_approval.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_cad_document_for_approval "
                + "WHERE mst_cad_document_for_approval.code LIKE '%"+code+"%' "
                + "AND mst_cad_document_for_approval.name LIKE '%"+name+"%' "
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
    
    public CadDocumentForApprovalTemp findData(String code) {
        try {
            CadDocumentForApprovalTemp cadDocumentForApprovalTemp = (CadDocumentForApprovalTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_cad_document_for_approval.Code, "
                + "mst_cad_document_for_approval.name, "
                + "mst_cad_document_for_approval.activeStatus, "
                + "mst_cad_document_for_approval.remark, "
                + "mst_cad_document_for_approval.InActiveBy, "
                + "mst_cad_document_for_approval.InActiveDate, "
                + "mst_cad_document_for_approval.CreatedBy, "
                + "mst_cad_document_for_approval.CreatedDate "
                + "FROM mst_cad_document_for_approval "
                + "WHERE mst_cad_document_for_approval.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(CadDocumentForApprovalTemp.class))
                .uniqueResult(); 
                 
                return cadDocumentForApprovalTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CadDocumentForApprovalTemp findData(String code,boolean active) {
        try {
            CadDocumentForApprovalTemp cadDocumentForApprovalTemp = (CadDocumentForApprovalTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_cad_document_for_approval.Code, "
                + "mst_cad_document_for_approval.name, "
                + "mst_cad_document_for_approval.remark "
                + "FROM mst_cad_document_for_approval "
                + "WHERE mst_cad_document_for_approval.code ='"+code+"' "
                + "AND mst_cad_document_for_approval.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CadDocumentForApprovalTemp.class))
                .uniqueResult(); 
                 
                return cadDocumentForApprovalTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<CadDocumentForApprovalTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_cad_document_for_approval.ActiveStatus="+active+" ";
            }
            List<CadDocumentForApprovalTemp> list = (List<CadDocumentForApprovalTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_cad_document_for_approval.Code, "
                + "mst_cad_document_for_approval.name, "
                + "mst_cad_document_for_approval.remark, "
                + "mst_cad_document_for_approval.ActiveStatus "
                + "FROM mst_cad_document_for_approval "
                + "WHERE mst_cad_document_for_approval.code LIKE '%"+code+"%' "
                + "AND mst_cad_document_for_approval.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CadDocumentForApprovalTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(CadDocumentForApproval cadDocumentForApproval, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            cadDocumentForApproval.setCode(createCode(cadDocumentForApproval));
            if(cadDocumentForApproval.isActiveStatus()){
                cadDocumentForApproval.setInActiveBy("");                
            }else{
                cadDocumentForApproval.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                cadDocumentForApproval.setInActiveDate(new Date());
            }
            
            cadDocumentForApproval.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            cadDocumentForApproval.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(cadDocumentForApproval);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    cadDocumentForApproval.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(CadDocumentForApproval cadDocumentForApproval, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(cadDocumentForApproval.isActiveStatus()){
                cadDocumentForApproval.setInActiveBy("");                
            }else{
                cadDocumentForApproval.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                cadDocumentForApproval.setInActiveDate(new Date());
            }
            cadDocumentForApproval.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            cadDocumentForApproval.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(cadDocumentForApproval);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    cadDocumentForApproval.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + CadDocumentForApprovalField.BEAN_NAME + " WHERE " + CadDocumentForApprovalField.CODE + " = :prmCode")
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
