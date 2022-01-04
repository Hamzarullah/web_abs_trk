

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
import com.inkombizz.master.model.DcasDesign;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.DcasFireSafeByDesign;
import com.inkombizz.master.model.DcasFireSafeByDesignTemp;
import com.inkombizz.master.model.DcasFireSafeByDesignField;
import org.hibernate.criterion.Restrictions;



public class DcasFireSafeByDesignDAO {
    
    private HBMSession hbmSession;
    
    public DcasFireSafeByDesignDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(DcasFireSafeByDesign dcasFireSafeByDesign){   
        try{
            String acronim = "DCASFIRE";
            DetachedCriteria dc = DetachedCriteria.forClass(DcasFireSafeByDesign.class)
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
                concat_qry="AND mst_dcas_fire_safe_by_design.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_dcas_fire_safe_by_design "
                + "WHERE mst_dcas_fire_safe_by_design.code LIKE '%"+code+"%' "
                + "AND mst_dcas_fire_safe_by_design.name LIKE '%"+name+"%' "
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
    
    public DcasFireSafeByDesignTemp findData(String code) {
        try {
            DcasFireSafeByDesignTemp dcasFireSafeByDesignTemp = (DcasFireSafeByDesignTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_fire_safe_by_design.Code, "
                + "mst_dcas_fire_safe_by_design.name, "
                + "mst_dcas_fire_safe_by_design.activeStatus, "
                + "mst_dcas_fire_safe_by_design.remark, "
                + "mst_dcas_fire_safe_by_design.InActiveBy, "
                + "mst_dcas_fire_safe_by_design.InActiveDate, "
                + "mst_dcas_fire_safe_by_design.CreatedBy, "
                + "mst_dcas_fire_safe_by_design.CreatedDate "
                + "FROM mst_dcas_fire_safe_by_design "
                + "WHERE mst_dcas_fire_safe_by_design.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DcasFireSafeByDesignTemp.class))
                .uniqueResult(); 
                 
                return dcasFireSafeByDesignTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DcasFireSafeByDesignTemp findData(String code,boolean active) {
        try {
            DcasFireSafeByDesignTemp dcasFireSafeByDesignTemp = (DcasFireSafeByDesignTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_fire_safe_by_design.Code, "
                + "mst_dcas_fire_safe_by_design.name, "
                + "mst_dcas_fire_safe_by_design.remark "
                + "FROM mst_dcas_fire_safe_by_design "
                + "WHERE mst_dcas_fire_safe_by_design.code ='"+code+"' "
                + "AND mst_dcas_fire_safe_by_design.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DcasFireSafeByDesignTemp.class))
                .uniqueResult(); 
                 
                return dcasFireSafeByDesignTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<DcasFireSafeByDesignTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_dcas_fire_safe_by_design.ActiveStatus="+active+" ";
            }
            List<DcasFireSafeByDesignTemp> list = (List<DcasFireSafeByDesignTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_fire_safe_by_design.Code, "
                + "mst_dcas_fire_safe_by_design.name, "
                + "mst_dcas_fire_safe_by_design.remark, "
                + "mst_dcas_fire_safe_by_design.ActiveStatus "
                + "FROM mst_dcas_fire_safe_by_design "
                + "WHERE mst_dcas_fire_safe_by_design.code LIKE '%"+code+"%' "
                + "AND mst_dcas_fire_safe_by_design.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(DcasFireSafeByDesignTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(DcasFireSafeByDesign dcasFireSafeByDesign, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            dcasFireSafeByDesign.setCode(createCode(dcasFireSafeByDesign));
            if(dcasFireSafeByDesign.isActiveStatus()){
                dcasFireSafeByDesign.setInActiveBy("");                
            }else{
                dcasFireSafeByDesign.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasFireSafeByDesign.setInActiveDate(new Date());
            }
            
            dcasFireSafeByDesign.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            dcasFireSafeByDesign.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(dcasFireSafeByDesign);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    dcasFireSafeByDesign.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(DcasFireSafeByDesign dcasFireSafeByDesign, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(dcasFireSafeByDesign.isActiveStatus()){
                dcasFireSafeByDesign.setInActiveBy("");                
            }else{
                dcasFireSafeByDesign.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasFireSafeByDesign.setInActiveDate(new Date());
            }
            dcasFireSafeByDesign.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            dcasFireSafeByDesign.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(dcasFireSafeByDesign);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    dcasFireSafeByDesign.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DcasFireSafeByDesignField.BEAN_NAME + " WHERE " + DcasFireSafeByDesignField.CODE + " = :prmCode")
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
