

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
import com.inkombizz.master.model.ModeOfTransportationTemp;
import com.inkombizz.master.model.ModeOfTransportationField;
import com.inkombizz.master.model.ModeOfTransportation;
import org.hibernate.criterion.Restrictions;



public class ModeOfTransportationDAO {
    
    private HBMSession hbmSession;
    
    public ModeOfTransportationDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public String createCode(ModeOfTransportation modeOfTransportation){   
        try{
            String acronim = "ARM";
            DetachedCriteria dc = DetachedCriteria.forClass(ModeOfTransportation.class)
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
    public List <ModeOfTransportation> findByCriteria(DetachedCriteria dc, int from, int size) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setFirstResult(from);
            criteria.setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_mode_of_transportation.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_mode_of_transportation "
                + "WHERE mst_mode_of_transportation.code LIKE '%"+code+"%' "
                + "AND mst_mode_of_transportation.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
       
//    public int countByCriteria(DetachedCriteria dc) {
//        try {
//            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
//            criteria.setProjection(Projections.rowCount());
//            if (criteria.list().size() == 0)
//            	return 0;
//            else
//            	return ((Integer) criteria.list().get(0)).intValue();
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
    public ModeOfTransportationTemp findData(String code) {
        try {
            ModeOfTransportationTemp modeOfTransportationTemp = (ModeOfTransportationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_mode_of_transportation.Code, "
                + "mst_mode_of_transportation.name, "
                + "mst_mode_of_transportation.activeStatus, "
                + "mst_mode_of_transportation.remark, "
                + "mst_mode_of_transportation.InActiveBy, "
                + "mst_mode_of_transportation.InActiveDate, "
                + "mst_mode_of_transportation.CreatedBy, "
                + "mst_mode_of_transportation.CreatedDate "
                + "FROM mst_mode_of_transportation "
                + "WHERE mst_mode_of_transportation.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(ModeOfTransportationTemp.class))
                .uniqueResult(); 
                 
                return modeOfTransportationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ModeOfTransportationTemp findData(String code,boolean active) {
        try {
            ModeOfTransportationTemp modeOfTransportationTemp = (ModeOfTransportationTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_mode_of_transportation.Code, "
                + "mst_mode_of_transportation.name, "
                + "mst_mode_of_transportation.remark "
                + "FROM mst_mode_of_transportation "
                + "WHERE mst_mode_of_transportation.code ='"+code+"' "
                + "AND mst_mode_of_transportation.ActiveStatus ="+active+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ModeOfTransportationTemp.class))
                .uniqueResult(); 
                 
                return modeOfTransportationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ModeOfTransportationTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_mode_of_transportation.ActiveStatus="+active+" ";
            }
            List<ModeOfTransportationTemp> list = (List<ModeOfTransportationTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_mode_of_transportation.Code, "
                + "mst_mode_of_transportation.name, "
                + "mst_mode_of_transportation.remark, "
                + "mst_mode_of_transportation.ActiveStatus "
                + "FROM mst_mode_of_transportation "
                + "WHERE mst_mode_of_transportation.code LIKE '%"+code+"%' "
                + "AND mst_mode_of_transportation.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(ModeOfTransportationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            
            List countData = criteria.list();
            
            if (countData.isEmpty())
                return 0;
            else {
                return  ( Integer.parseInt(countData.get(0).toString()) ) ;
            }
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ModeOfTransportation modeOfTransportation, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            modeOfTransportation.setCode(createCode(modeOfTransportation));
            if(modeOfTransportation.isActiveStatus()){
                modeOfTransportation.setInActiveBy("");                
            }else{
                modeOfTransportation.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                modeOfTransportation.setInActiveDate(new Date());
            }
            
            modeOfTransportation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            modeOfTransportation.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(modeOfTransportation);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    modeOfTransportation.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ModeOfTransportation modeOfTransportation, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(modeOfTransportation.isActiveStatus()){
                modeOfTransportation.setInActiveBy("");                
            }else{
                modeOfTransportation.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                modeOfTransportation.setInActiveDate(new Date());
            }
            modeOfTransportation.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            modeOfTransportation.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(modeOfTransportation);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    modeOfTransportation.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ModeOfTransportationField.BEAN_NAME + " WHERE " + ModeOfTransportationField.CODE + " = :prmCode")
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
