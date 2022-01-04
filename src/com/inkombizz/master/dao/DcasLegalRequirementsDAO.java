

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
import com.inkombizz.master.model.CadDocumentForApproval;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.DcasLegalRequirements;
import com.inkombizz.master.model.DcasLegalRequirementsTemp;
import com.inkombizz.master.model.DcasLegalRequirementsField;
import org.hibernate.criterion.Restrictions;



public class DcasLegalRequirementsDAO {
    
    private HBMSession hbmSession;
    
    public DcasLegalRequirementsDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(DcasLegalRequirements dcasLegalRequirements){   
        try{
            String acronim = "DCASLGLREQ";
            DetachedCriteria dc = DetachedCriteria.forClass(DcasLegalRequirements.class)
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
                concat_qry="AND mst_dcas_legal_requirements.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_dcas_legal_requirements "
                + "WHERE mst_dcas_legal_requirements.code LIKE '%"+code+"%' "
                + "AND mst_dcas_legal_requirements.name LIKE '%"+name+"%' "
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
    
    public DcasLegalRequirementsTemp findData(String code) {
        try {
            DcasLegalRequirementsTemp dcasLegalRequirementsTemp = (DcasLegalRequirementsTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_legal_requirements.Code, "
                + "mst_dcas_legal_requirements.name, "
                + "mst_dcas_legal_requirements.activeStatus, "
                + "mst_dcas_legal_requirements.remark, "
                + "mst_dcas_legal_requirements.InActiveBy, "
                + "mst_dcas_legal_requirements.InActiveDate, "
                + "mst_dcas_legal_requirements.CreatedBy, "
                + "mst_dcas_legal_requirements.CreatedDate "
                + "FROM mst_dcas_legal_requirements "
                + "WHERE mst_dcas_legal_requirements.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DcasLegalRequirementsTemp.class))
                .uniqueResult(); 
                 
                return dcasLegalRequirementsTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DcasLegalRequirementsTemp findData(String code,boolean active) {
        try {
            DcasLegalRequirementsTemp dcasLegalRequirementsTemp = (DcasLegalRequirementsTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_legal_requirements.Code, "
                + "mst_dcas_legal_requirements.name, "
                + "mst_dcas_legal_requirements.remark "
                + "FROM mst_dcas_legal_requirements "
                + "WHERE mst_dcas_legal_requirements.code ='"+code+"' "
                + "AND mst_dcas_legal_requirements.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DcasLegalRequirementsTemp.class))
                .uniqueResult(); 
                 
                return dcasLegalRequirementsTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<DcasLegalRequirementsTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_dcas_legal_requirements.ActiveStatus="+active+" ";
            }
            List<DcasLegalRequirementsTemp> list = (List<DcasLegalRequirementsTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_legal_requirements.Code, "
                + "mst_dcas_legal_requirements.name, "
                + "mst_dcas_legal_requirements.remark, "
                + "mst_dcas_legal_requirements.ActiveStatus "
                + "FROM mst_dcas_legal_requirements "
                + "WHERE mst_dcas_legal_requirements.code LIKE '%"+code+"%' "
                + "AND mst_dcas_legal_requirements.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(DcasLegalRequirementsTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(DcasLegalRequirements dcasLegalRequirements, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            dcasLegalRequirements.setCode(createCode(dcasLegalRequirements));
            if(dcasLegalRequirements.isActiveStatus()){
                dcasLegalRequirements.setInActiveBy("");                
            }else{
                dcasLegalRequirements.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasLegalRequirements.setInActiveDate(new Date());
            }
            
            dcasLegalRequirements.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            dcasLegalRequirements.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(dcasLegalRequirements);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    dcasLegalRequirements.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(DcasLegalRequirements dcasLegalRequirements, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(dcasLegalRequirements.isActiveStatus()){
                dcasLegalRequirements.setInActiveBy("");                
            }else{
                dcasLegalRequirements.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasLegalRequirements.setInActiveDate(new Date());
            }
            dcasLegalRequirements.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            dcasLegalRequirements.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(dcasLegalRequirements);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    dcasLegalRequirements.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DcasLegalRequirementsField.BEAN_NAME + " WHERE " + DcasLegalRequirementsField.CODE + " = :prmCode")
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
