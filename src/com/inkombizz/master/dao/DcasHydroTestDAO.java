

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
import com.inkombizz.master.model.DcasFireSafeByDesign;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.DcasHydroTest;
import com.inkombizz.master.model.DcasHydroTestTemp;
import com.inkombizz.master.model.DcasHydroTestField;
import com.inkombizz.master.model.ItemBolt;
import org.hibernate.criterion.Restrictions;



public class DcasHydroTestDAO {
    
    private HBMSession hbmSession;
    
    public DcasHydroTestDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(DcasHydroTest dcasHydroTest){   
        try{
            String acronim = "DCASHYDTST";
            DetachedCriteria dc = DetachedCriteria.forClass(DcasHydroTest.class)
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
                concat_qry="AND mst_dcas_hydro_test.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_dcas_hydro_test "
                + "WHERE mst_dcas_hydro_test.code LIKE '%"+code+"%' "
                + "AND mst_dcas_hydro_test.name LIKE '%"+name+"%' "
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
    
    public DcasHydroTestTemp findData(String code) {
        try {
            DcasHydroTestTemp dcasHydroTestTemp = (DcasHydroTestTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_hydro_test.Code, "
                + "mst_dcas_hydro_test.name, "
                + "mst_dcas_hydro_test.activeStatus, "
                + "mst_dcas_hydro_test.remark, "
                + "mst_dcas_hydro_test.InActiveBy, "
                + "mst_dcas_hydro_test.InActiveDate, "
                + "mst_dcas_hydro_test.CreatedBy, "
                + "mst_dcas_hydro_test.CreatedDate "
                + "FROM mst_dcas_hydro_test "
                + "WHERE mst_dcas_hydro_test.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(DcasHydroTestTemp.class))
                .uniqueResult(); 
                 
                return dcasHydroTestTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public DcasHydroTestTemp findData(String code,boolean active) {
        try {
            DcasHydroTestTemp dcasHydroTestTemp = (DcasHydroTestTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_hydro_test.Code, "
                + "mst_dcas_hydro_test.name, "
                + "mst_dcas_hydro_test.remark "
                + "FROM mst_dcas_hydro_test "
                + "WHERE mst_dcas_hydro_test.code ='"+code+"' "
                + "AND mst_dcas_hydro_test.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(DcasHydroTestTemp.class))
                .uniqueResult(); 
                 
                return dcasHydroTestTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<DcasHydroTestTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_dcas_hydro_test.ActiveStatus="+active+" ";
            }
            List<DcasHydroTestTemp> list = (List<DcasHydroTestTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_dcas_hydro_test.Code, "
                + "mst_dcas_hydro_test.name, "
                + "mst_dcas_hydro_test.remark, "
                + "mst_dcas_hydro_test.ActiveStatus "
                + "FROM mst_dcas_hydro_test "
                + "WHERE mst_dcas_hydro_test.code LIKE '%"+code+"%' "
                + "AND mst_dcas_hydro_test.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(DcasHydroTestTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(DcasHydroTest dcasHydroTest, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            dcasHydroTest.setCode(createCode(dcasHydroTest));
            if(dcasHydroTest.isActiveStatus()){
                dcasHydroTest.setInActiveBy("");                
            }else{
                dcasHydroTest.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasHydroTest.setInActiveDate(new Date());
            }
            
            dcasHydroTest.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            dcasHydroTest.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(dcasHydroTest);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    dcasHydroTest.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(DcasHydroTest dcasHydroTest, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(dcasHydroTest.isActiveStatus()){
                dcasHydroTest.setInActiveBy("");                
            }else{
                dcasHydroTest.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                dcasHydroTest.setInActiveDate(new Date());
            }
            dcasHydroTest.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            dcasHydroTest.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(dcasHydroTest);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    dcasHydroTest.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DcasHydroTestField.BEAN_NAME + " WHERE " + DcasHydroTestField.CODE + " = :prmCode")
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
