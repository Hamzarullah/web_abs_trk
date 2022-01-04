

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

import com.inkombizz.master.model.RackType;
import com.inkombizz.master.model.RackTypeTemp;
import com.inkombizz.master.model.RackTypeField;
import org.hibernate.criterion.Restrictions;



public class RackTypeDAO {
    
    private HBMSession hbmSession;
    
    public RackTypeDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public String createCode(){   
        try{
            String acronim = "RCKTYP";
            DetachedCriteria dc = DetachedCriteria.forClass(RackType.class)
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
                concat_qry="AND mst_rack_type.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_rack_type "
                + "WHERE mst_rack_type.code LIKE '%"+code+"%' "
                + "AND mst_rack_type.name LIKE '%"+name+"%' "
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
    
    public RackTypeTemp findData(String code) {
        try {
            RackTypeTemp rackTypeTemp = (RackTypeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_rack_type.Code, "
                + "mst_rack_type.name, "
                + "mst_rack_type.activeStatus, "
                + "mst_rack_type.remark, "
                + "mst_rack_type.InActiveBy, "
                + "mst_rack_type.InActiveDate, "
                + "mst_rack_type.CreatedBy, "
                + "mst_rack_type.CreatedDate "
                + "FROM mst_rack_type "
                + "WHERE mst_rack_type.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(RackTypeTemp.class))
                .uniqueResult(); 
                 
                return rackTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public RackTypeTemp findData(String code,boolean active) {
        try {
            RackTypeTemp rackTypeTemp = (RackTypeTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_rack_type.Code, "
                + "mst_rack_type.name, "
                + "mst_rack_type.remark "
                + "FROM mst_rack_type "
                + "WHERE mst_rack_type.code ='"+code+"' "
                + "AND mst_rack_type.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(RackTypeTemp.class))
                .uniqueResult(); 
                 
                return rackTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<RackTypeTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_rack_type.ActiveStatus="+active+" ";
            }
            List<RackTypeTemp> list = (List<RackTypeTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_rack_type.Code, "
                + "mst_rack_type.name, "
                + "mst_rack_type.remark, "
                + "mst_rack_type.ActiveStatus "
                + "FROM mst_rack_type "
                + "WHERE mst_rack_type.code LIKE '%"+code+"%' "
                + "AND mst_rack_type.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(RackTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(RackType rackType, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            rackType.setCode(createCode());
            if(rackType.isActiveStatus()){
                rackType.setInActiveBy("");                
            }else{
                rackType.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                rackType.setInActiveDate(new Date());
            }
            
            rackType.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            rackType.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(rackType);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    rackType.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(RackType rackType, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(rackType.isActiveStatus()){
                rackType.setInActiveBy("");                
            }else{
                rackType.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                rackType.setInActiveDate(new Date());
            }
            rackType.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            rackType.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(rackType);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    rackType.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + RackTypeField.BEAN_NAME + " WHERE " + RackTypeField.CODE + " = :prmCode")
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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    
    
}
