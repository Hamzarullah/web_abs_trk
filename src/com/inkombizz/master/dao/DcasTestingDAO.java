

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
import com.inkombizz.master.model.DcasNde;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.DcasTesting;
import com.inkombizz.master.model.DcasTestingTemp;
import com.inkombizz.master.model.DcasTestingField;
import org.hibernate.criterion.Restrictions;



public class DcasTestingDAO {
    
    private HBMSession hbmSession;
    
    public DcasTestingDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(DcasTesting dcasTesting){   
        try{
            String acronim = "DCASTST";
            DetachedCriteria dc = DetachedCriteria.forClass(DcasTesting.class)
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
                concat_qry="AND mst_dcas_testing.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_dcas_testing "
                + "WHERE mst_dcas_testing.code LIKE '%"+code+"%' "
                + "AND mst_dcas_testing.name LIKE '%"+name+"%' "
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
    
    public DcasTestingTemp findData(String code) {
        try {
            DcasTestingTemp dcasTestingTemp = (DcasTestingTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_testing.Code, "
                + "mst_dcas_testing.name, "
                + "mst_dcas_testing.activeStatus, "
                + "mst_dcas_testing.remark, "
                + "mst_dcas_testing.InActiveBy, "
                + "mst_dcas_testing.InActiveDate, "
                + "mst_dcas_testing.CreatedBy, "
                + "mst_dcas_testing.CreatedDate "
                + "FROM mst_dcas_testing "
                + "WHERE mst_dcas_testing.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DcasTestingTemp.class))
                .uniqueResult(); 
                 
                return dcasTestingTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DcasTestingTemp findData(String code,boolean active) {
        try {
            DcasTestingTemp dcasTestingTemp = (DcasTestingTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_testing.Code, "
                + "mst_dcas_testing.name, "
                + "mst_dcas_testing.remark "
                + "FROM mst_dcas_testing "
                + "WHERE mst_dcas_testing.code ='"+code+"' "
                + "AND mst_dcas_testing.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DcasTestingTemp.class))
                .uniqueResult(); 
                 
                return dcasTestingTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<DcasTestingTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_dcas_testing.ActiveStatus="+active+" ";
            }
            List<DcasTestingTemp> list = (List<DcasTestingTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_testing.Code, "
                + "mst_dcas_testing.name, "
                + "mst_dcas_testing.remark, "
                + "mst_dcas_testing.ActiveStatus "
                + "FROM mst_dcas_testing "
                + "WHERE mst_dcas_testing.code LIKE '%"+code+"%' "
                + "AND mst_dcas_testing.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(DcasTestingTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(DcasTesting dcasTesting, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            dcasTesting.setCode(createCode(dcasTesting));
            if(dcasTesting.isActiveStatus()){
                dcasTesting.setInActiveBy("");                
            }else{
                dcasTesting.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasTesting.setInActiveDate(new Date());
            }
            
            dcasTesting.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            dcasTesting.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(dcasTesting);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    dcasTesting.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(DcasTesting dcasTesting, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(dcasTesting.isActiveStatus()){
                dcasTesting.setInActiveBy("");                
            }else{
                dcasTesting.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasTesting.setInActiveDate(new Date());
            }
            dcasTesting.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            dcasTesting.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(dcasTesting);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    dcasTesting.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DcasTestingField.BEAN_NAME + " WHERE " + DcasTestingField.CODE + " = :prmCode")
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
