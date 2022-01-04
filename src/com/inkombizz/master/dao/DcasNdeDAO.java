

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
import com.inkombizz.master.model.DcasMarking;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.DcasNde;
import com.inkombizz.master.model.DcasNdeTemp;
import com.inkombizz.master.model.DcasNdeField;
import org.hibernate.criterion.Restrictions;



public class DcasNdeDAO {
    
    private HBMSession hbmSession;
    
    public DcasNdeDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(DcasNde dcasNde){   
        try{
            String acronim = "DCASNDE";
            DetachedCriteria dc = DetachedCriteria.forClass(DcasNde.class)
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
                concat_qry="AND mst_dcas_nde.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_dcas_nde "
                + "WHERE mst_dcas_nde.code LIKE '%"+code+"%' "
                + "AND mst_dcas_nde.name LIKE '%"+name+"%' "
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
    
    public DcasNdeTemp findData(String code) {
        try {
            DcasNdeTemp dcasNdeTemp = (DcasNdeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_nde.Code, "
                + "mst_dcas_nde.name, "
                + "mst_dcas_nde.activeStatus, "
                + "mst_dcas_nde.remark, "
                + "mst_dcas_nde.InActiveBy, "
                + "mst_dcas_nde.InActiveDate, "
                + "mst_dcas_nde.CreatedBy, "
                + "mst_dcas_nde.CreatedDate "
                + "FROM mst_dcas_nde "
                + "WHERE mst_dcas_nde.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DcasNdeTemp.class))
                .uniqueResult(); 
                 
                return dcasNdeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DcasNdeTemp findData(String code,boolean active) {
        try {
            DcasNdeTemp dcasNdeTemp = (DcasNdeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_nde.Code, "
                + "mst_dcas_nde.name, "
                + "mst_dcas_nde.remark "
                + "FROM mst_dcas_nde "
                + "WHERE mst_dcas_nde.code ='"+code+"' "
                + "AND mst_dcas_nde.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DcasNdeTemp.class))
                .uniqueResult(); 
                 
                return dcasNdeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<DcasNdeTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_dcas_nde.ActiveStatus="+active+" ";
            }
            List<DcasNdeTemp> list = (List<DcasNdeTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_nde.Code, "
                + "mst_dcas_nde.name, "
                + "mst_dcas_nde.remark, "
                + "mst_dcas_nde.ActiveStatus "
                + "FROM mst_dcas_nde "
                + "WHERE mst_dcas_nde.code LIKE '%"+code+"%' "
                + "AND mst_dcas_nde.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(DcasNdeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(DcasNde dcasNde, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            dcasNde.setCode(createCode(dcasNde));
            if(dcasNde.isActiveStatus()){
                dcasNde.setInActiveBy("");                
            }else{
                dcasNde.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasNde.setInActiveDate(new Date());
            }
            
            dcasNde.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            dcasNde.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(dcasNde);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    dcasNde.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(DcasNde dcasNde, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(dcasNde.isActiveStatus()){
                dcasNde.setInActiveBy("");                
            }else{
                dcasNde.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasNde.setInActiveDate(new Date());
            }
            dcasNde.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            dcasNde.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(dcasNde);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    dcasNde.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DcasNdeField.BEAN_NAME + " WHERE " + DcasNdeField.CODE + " = :prmCode")
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
