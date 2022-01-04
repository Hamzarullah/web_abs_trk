package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.DistributionChannel;
import com.inkombizz.master.model.DistributionChannelField;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.master.model.DistributionChannelTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

public class DistributionChannelDAO {
    
    private HBMSession hbmSession;
    
    public DistributionChannelDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public List <DistributionChannel> findByCriteria(DetachedCriteria dc, int from, int size) {
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
    
    public List<DistributionChannel> findByCriteria(DetachedCriteria dc) {
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
                concat_qry="AND mst_distribution_channel.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_distribution_channel.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_distribution_channel.ActiveStatus = 0 OR mst_distribution_channel.ActiveStatus = 1) ";
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_distribution_channel "
                + "WHERE mst_distribution_channel.code LIKE :prmCode "
                + "AND mst_distribution_channel.name LIKE :prmName "+concat_qry)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
     public List<DistributionChannelTemp> findSearchData(String code, String name, String active,int from, int row) {
        try {   

            String concat_qry="";
            if(!active.equals("") && active.equals("Active")){
                concat_qry="AND mst_distribution_channel.ActiveStatus = 1 ";
            }
            
            if(!active.equals("") && active.equals("InActive")){
                concat_qry="AND mst_distribution_channel.ActiveStatus = 0 ";
            }
            
            if(!active.equals("") && active.equals("All")){
                concat_qry="AND (mst_distribution_channel.ActiveStatus = 0 OR mst_distribution_channel.ActiveStatus = 1) ";
            }
            
            List<DistributionChannelTemp> list = (List<DistributionChannelTemp>)hbmSession.hSession.createSQLQuery(
                 "SELECT mst_distribution_channel.Code AS code, "
                + "mst_distribution_channel.Name AS name, "
                + "mst_distribution_channel.ActiveStatus "
                + "FROM mst_distribution_channel "
                + "WHERE mst_distribution_channel.code LIKE :prmCode "
                + "AND mst_distribution_channel.name LIKE :prmName "+concat_qry
                + "ORDER BY mst_distribution_channel.code "
                + "LIMIT "+from+","+row+"")
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .setParameter("prmCode", "%"+code+"%")
                .setParameter("prmName", "%"+name+"%")
                .setResultTransformer(Transformers.aliasToBean(DistributionChannelTemp.class))

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
    
    public DistributionChannel get(String id) {
        try {
            return (DistributionChannel) hbmSession.hSession.get(DistributionChannel.class, id);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(DistributionChannel distributionChannel, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            distributionChannel.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            distributionChannel.setCreatedDate(new Date()); 
//            distributionChannel.setCompanyCode(BaseSession.loadProgramSession().getCompanyCode());
//            String Id = distributionChannel.getCode();
//            distributionChannel.setId(Id);
            hbmSession.hSession.save(distributionChannel);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    distributionChannel.getCode(), "CAR BRAND"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
	
    public void update(DistributionChannel distributionChannel, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.update(distributionChannel);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    distributionChannel.getCode(), "CAR BRAND"));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + DistributionChannelField.BEAN_NAME + " WHERE " + DistributionChannelField.CODE + " = :prmId")
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