package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.PriceType;
import com.inkombizz.master.model.PriceTypeField;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.master.model.PriceTypeTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

public class PriceTypeDAO {
    
    private HBMSession hbmSession;
    
    public PriceTypeDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <PriceType> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<PriceType> findByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    public int countSearchData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_price_type.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_price_type.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_price_type.ActiveStatus = 0 OR mst_price_type.ActiveStatus = 1) ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_price_type "
                + "WHERE mst_price_type.code LIKE :prmCode "
                + "AND mst_price_type.name LIKE :prmName "+concat_qry)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public List<PriceTypeTemp> findSearchData(String code, String name, String active,int from, int row) {
        try {   

            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_price_type.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_price_type.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_price_type.ActiveStatus = 0 OR mst_price_type.ActiveStatus = 1) ";
            }
            
            List<PriceTypeTemp> list = (List<PriceTypeTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_price_type.Code AS code, "
                + "mst_price_type.Name AS name, "
                + "mst_price_type.ActiveStatus "
                + "FROM mst_price_type "
                + "WHERE mst_price_type.code LIKE :prmCode "
                + "AND mst_price_type.name LIKE :prmName "+concat_qry
                + "ORDER BY mst_price_type.code "
                + "LIMIT "+from+","+row+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(PriceTypeTemp.class))

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
    
    public PriceType get(String id) {
        try {
            return (PriceType) hbmSession.hSession.get(PriceType.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(PriceType priceType, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            priceType.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            priceType.setCreatedDate(new Date()); 
//            priceType.setCompanyCode(BaseSession.loadProgramSession().getCompanyCode());
//            String Id = priceType.getCode();
//            priceType.setId(Id);
            hbmSession.hSession.save(priceType);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    priceType.getCode(), "CAR BRAND"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(PriceType priceType, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.update(priceType);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    priceType.getCode(), "CAR BRAND"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void delete(String id, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + PriceTypeField.BEAN_NAME + " WHERE " + PriceTypeField.CODE + " = :prmId")
                    .setParameter("prmId", id)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    id, "CAR BRAND"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    } 
}