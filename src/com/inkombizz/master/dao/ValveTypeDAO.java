

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

import com.inkombizz.master.model.ValveType;
import com.inkombizz.master.model.ValveTypeTemp;
import com.inkombizz.master.model.ValveTypeField;
import org.hibernate.criterion.Restrictions;



public class ValveTypeDAO {
    
    private HBMSession hbmSession;
    
    public ValveTypeDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ValveType valveType){   
        try{
            String acronim = "VVLTYP";
            DetachedCriteria dc = DetachedCriteria.forClass(ValveType.class)
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
                concat_qry="AND mst_valve_type.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_valve_type "
                + "WHERE mst_valve_type.code LIKE '%"+code+"%' "
                + "AND mst_valve_type.name LIKE '%"+name+"%' "
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
    
    public ValveTypeTemp findData(String code) {
        try {
            ValveTypeTemp valveTypeTemp = (ValveTypeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_valve_type.Code, "
                + "mst_valve_type.name, "
                + "mst_valve_type.activeStatus, "
                + "mst_valve_type.remark, "
                + "mst_valve_type.InActiveBy, "
                + "mst_valve_type.InActiveDate, "
                + "mst_valve_type.CreatedBy, "
                + "mst_valve_type.CreatedDate "
                + "FROM mst_valve_type "
                + "WHERE mst_valve_type.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ValveTypeTemp.class))
                .uniqueResult(); 
                 
                return valveTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ValveTypeTemp findData(String code,boolean active) {
        try {
            ValveTypeTemp valveTypeTemp = (ValveTypeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_valve_type.Code, "
                + "mst_valve_type.name, "
                + "mst_valve_type.remark "
                + "FROM mst_valve_type "
                + "WHERE mst_valve_type.code ='"+code+"' "
                + "AND mst_valve_type.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ValveTypeTemp.class))
                .uniqueResult(); 
                 
                return valveTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ValveTypeTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_valve_type.ActiveStatus="+active+" ";
            }
            List<ValveTypeTemp> list = (List<ValveTypeTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_valve_type.Code, "
                + "mst_valve_type.name, "
                + "mst_valve_type.remark, "
                + "mst_valve_type.ActiveStatus "
                + "FROM mst_valve_type "
                + "WHERE mst_valve_type.code LIKE '%"+code+"%' "
                + "AND mst_valve_type.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ValveTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ValveType valveType, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
//            valveType.setCode(createCode(valveType));
            if(valveType.isActiveStatus()){
                valveType.setInActiveBy("");                
            }else{
                valveType.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                valveType.setInActiveDate(new Date());
            }
            
            valveType.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            valveType.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(valveType);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    valveType.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ValveType valveType, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(valveType.isActiveStatus()){
                valveType.setInActiveBy("");                
            }else{
                valveType.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                valveType.setInActiveDate(new Date());
            }
            valveType.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            valveType.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(valveType);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    valveType.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ValveTypeField.BEAN_NAME + " WHERE " + ValveTypeField.CODE + " = :prmCode")
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
