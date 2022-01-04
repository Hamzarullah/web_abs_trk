

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
import com.inkombizz.master.model.DcasLegalRequirements;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.DcasMarking;
import com.inkombizz.master.model.DcasMarkingTemp;
import com.inkombizz.master.model.DcasMarkingField;
import org.hibernate.criterion.Restrictions;



public class DcasMarkingDAO {
    
    private HBMSession hbmSession;
    
    public DcasMarkingDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(DcasMarking dcasMarking){   
        try{
            String acronim = "DCASMRK";
            DetachedCriteria dc = DetachedCriteria.forClass(DcasMarking.class)
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
                concat_qry="AND mst_dcas_marking.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_dcas_marking "
                + "WHERE mst_dcas_marking.code LIKE '%"+code+"%' "
                + "AND mst_dcas_marking.name LIKE '%"+name+"%' "
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
    
    public DcasMarkingTemp findData(String code) {
        try {
            DcasMarkingTemp dcasMarkingTemp = (DcasMarkingTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_marking.Code, "
                + "mst_dcas_marking.name, "
                + "mst_dcas_marking.activeStatus, "
                + "mst_dcas_marking.remark, "
                + "mst_dcas_marking.InActiveBy, "
                + "mst_dcas_marking.InActiveDate, "
                + "mst_dcas_marking.CreatedBy, "
                + "mst_dcas_marking.CreatedDate "
                + "FROM mst_dcas_marking "
                + "WHERE mst_dcas_marking.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DcasMarkingTemp.class))
                .uniqueResult(); 
                 
                return dcasMarkingTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DcasMarkingTemp findData(String code,boolean active) {
        try {
            DcasMarkingTemp dcasMarkingTemp = (DcasMarkingTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_marking.Code, "
                + "mst_dcas_marking.name, "
                + "mst_dcas_marking.remark "
                + "FROM mst_dcas_marking "
                + "WHERE mst_dcas_marking.code ='"+code+"' "
                + "AND mst_dcas_marking.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DcasMarkingTemp.class))
                .uniqueResult(); 
                 
                return dcasMarkingTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<DcasMarkingTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_dcas_marking.ActiveStatus="+active+" ";
            }
            List<DcasMarkingTemp> list = (List<DcasMarkingTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_marking.Code, "
                + "mst_dcas_marking.name, "
                + "mst_dcas_marking.remark, "
                + "mst_dcas_marking.ActiveStatus "
                + "FROM mst_dcas_marking "
                + "WHERE mst_dcas_marking.code LIKE '%"+code+"%' "
                + "AND mst_dcas_marking.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(DcasMarkingTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(DcasMarking dcasMarking, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            dcasMarking.setCode(createCode(dcasMarking));
            if(dcasMarking.isActiveStatus()){
                dcasMarking.setInActiveBy("");                
            }else{
                dcasMarking.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasMarking.setInActiveDate(new Date());
            }
            
            dcasMarking.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            dcasMarking.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(dcasMarking);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    dcasMarking.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(DcasMarking dcasMarking, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(dcasMarking.isActiveStatus()){
                dcasMarking.setInActiveBy("");                
            }else{
                dcasMarking.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasMarking.setInActiveDate(new Date());
            }
            dcasMarking.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            dcasMarking.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(dcasMarking);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    dcasMarking.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DcasMarkingField.BEAN_NAME + " WHERE " + DcasMarkingField.CODE + " = :prmCode")
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
