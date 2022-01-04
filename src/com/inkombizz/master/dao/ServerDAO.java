

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
import com.inkombizz.system.dao.TransactionLogDAO;
import java.util.Date;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

import com.inkombizz.master.model.Server;
import com.inkombizz.master.model.ServerTemp;
import com.inkombizz.master.model.ServerField;



public class ServerDAO {
    
    private HBMSession hbmSession;
    
    public ServerDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_server.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_server "
                + "WHERE mst_server.code LIKE '%"+code+"%' "
                + "AND mst_server.name LIKE '%"+name+"%' "
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
    
    public ServerTemp findData(String code) {
        try {
            ServerTemp serverTemp = (ServerTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_server.code, "
                +" mst_server.name, "
                +" mst_server.computerName, "
                +" mst_server.ipAddress, "
                +" mst_server.brand, "
                +" mst_server.type, "
                +" mst_server.ramCapacity, "
                +" mst_server.ramUOM, "
                +" mst_server.hardDriveCapacity, "
                +" mst_server.hardDriveUOM, "
                +" mst_server.processor, "
                +" mst_server.acquisitionMonth, "
                +" mst_server.acquisitionYear, "
                +" mst_server.activeStatus, "
                +" mst_server.createdBy, "
                +" mst_server.createdDate, "
                +" mst_server.updatedBy, "
                +" mst_server.updatedDate, "
                +" mst_server.inActiveBy, "
                +" mst_server.inActiveDate, "
                +" mst_server.remark "
                + "FROM mst_server "
                + "WHERE mst_server.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("computerName", Hibernate.STRING)
                .addScalar("ipAddress", Hibernate.STRING)
                .addScalar("brand", Hibernate.STRING)
                .addScalar("type", Hibernate.STRING)
                .addScalar("ramCapacity", Hibernate.BIG_DECIMAL)
                .addScalar("ramUOM", Hibernate.STRING)
                .addScalar("hardDriveCapacity", Hibernate.BIG_DECIMAL)
                .addScalar("hardDriveUOM", Hibernate.STRING)
                .addScalar("processor", Hibernate.STRING)
                .addScalar("acquisitionMonth", Hibernate.BIG_DECIMAL)
                .addScalar("acquisitionYear", Hibernate.BIG_DECIMAL)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("remark", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(ServerTemp.class))
                .uniqueResult(); 
                 
                return serverTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ServerTemp findData(String code,boolean active) {
        try {
            ServerTemp serverTemp = (ServerTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_server.code, "
                +" mst_server.name, "
                +" mst_server.computerName, "
                +" mst_server.ipAddress, "
                +" mst_server.brand, "
                +" mst_server.type, "
                +" mst_server.ramCapacity, "
                +" mst_server.ramUOM, "
                +" mst_server.hardDriveCapacity, "
                +" mst_server.hardDriveUOM, "
                +" mst_server.processor, "
                +" mst_server.acquisitionMonth, "
                +" mst_server.acquisitionYear, "
                +" mst_server.activeStatus, "
                +" mst_server.createdBy, "
                +" mst_server.createdDate, "
                +" mst_server.updatedBy, "
                +" mst_server.updatedDate, "
                +" mst_server.inActiveBy, "
                +" mst_server.inActiveDate, "
                +" mst_server.remark "
                + "FROM mst_server "
                + "WHERE mst_server.code ='"+code+"' "
                + "AND mst_server.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("computerName", Hibernate.STRING)
                .addScalar("ipAddress", Hibernate.STRING)
                .addScalar("brand", Hibernate.STRING)
                .addScalar("type", Hibernate.STRING)
                .addScalar("ramCapacity", Hibernate.BIG_DECIMAL)
                .addScalar("ramUOM", Hibernate.STRING)
                .addScalar("hardDriveCapacity", Hibernate.BIG_DECIMAL)
                .addScalar("hardDriveUOM", Hibernate.STRING)
                .addScalar("processor", Hibernate.STRING)
                .addScalar("acquisitionMonth", Hibernate.BIG_DECIMAL)
                .addScalar("acquisitionYear", Hibernate.BIG_DECIMAL)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ServerTemp.class))
                .uniqueResult(); 
                 
                return serverTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ServerTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_server.ActiveStatus="+active+" ";
            }
            List<ServerTemp> list = (List<ServerTemp>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_server.code, "
                +" mst_server.name, "
                +" mst_server.computerName, "
                +" mst_server.ipAddress, "
                +" mst_server.brand, "
                +" mst_server.type, "
                +" mst_server.ramCapacity, "
                +" mst_server.ramUOM, "
                +" mst_server.hardDriveCapacity, "
                +" mst_server.hardDriveUOM, "
                +" mst_server.processor, "
                +" mst_server.acquisitionMonth, "
                +" mst_server.acquisitionYear, "
                +" mst_server.activeStatus, "
                +" mst_server.createdBy, "
                +" mst_server.createdDate, "
                +" mst_server.updatedBy, "
                +" mst_server.updatedDate, "
                +" mst_server.inActiveBy, "
                +" mst_server.inActiveDate, "
                +" mst_server.remark "
                + "FROM mst_server "
                + "WHERE mst_server.code LIKE '%"+code+"%' "
                + "AND mst_server.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("computerName", Hibernate.STRING)
                .addScalar("ipAddress", Hibernate.STRING)
                .addScalar("brand", Hibernate.STRING)
                .addScalar("type", Hibernate.STRING)
                .addScalar("ramCapacity", Hibernate.BIG_DECIMAL)
                .addScalar("ramUOM", Hibernate.STRING)
                .addScalar("hardDriveCapacity", Hibernate.BIG_DECIMAL)
                .addScalar("hardDriveUOM", Hibernate.STRING)
                .addScalar("processor", Hibernate.STRING)
                .addScalar("acquisitionMonth", Hibernate.BIG_DECIMAL)
                .addScalar("acquisitionYear", Hibernate.BIG_DECIMAL)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ServerTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(Server server, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(server.isActiveStatus()){
                server.setInActiveBy("");                
            }else{
                server.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                server.setInActiveDate(new Date());
            }
            
            server.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            server.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(server);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    server.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(Server server, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(server.isActiveStatus()){
                server.setInActiveBy("");                
            }else{
                server.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                server.setInActiveDate(new Date());
            }
            server.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            server.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(server);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    server.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ServerField.BEAN_NAME + " WHERE " + ServerField.CODE + " = :prmCode")
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
