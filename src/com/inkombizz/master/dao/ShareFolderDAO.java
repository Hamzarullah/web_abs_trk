

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

import com.inkombizz.master.model.ShareFolder;
import com.inkombizz.master.model.ShareFolderTemp;
import com.inkombizz.master.model.ShareFolderField;



public class ShareFolderDAO {
    
    private HBMSession hbmSession;
    
    public ShareFolderDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_share_folder.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_share_folder "
                + "WHERE mst_share_folder.code LIKE '%"+code+"%' "
                + "AND mst_share_folder.name LIKE '%"+name+"%' "
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
    
    public ShareFolderTemp findData(String code) {
        try {
            ShareFolderTemp shareFolderTemp = (ShareFolderTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_share_folder.code, "
                +" mst_share_folder.name, "
                +" mst_share_folder.folderName, "
                +" mst_server.code AS serverCode, "
                +" mst_server.name AS serverName, "
                +" mst_share_folder.activeStatus, "
                +" mst_share_folder.createdBy, "
                +" mst_share_folder.createdDate, "
                +" mst_share_folder.updatedBy, "
                +" mst_share_folder.updatedDate, "
                +" mst_share_folder.inActiveBy, "
                +" mst_share_folder.inActiveDate, "
                +" mst_share_folder.remark "
                + "FROM mst_share_folder "
                + "INNER JOIN mst_server ON mst_server.code = mst_share_folder.serverCode "
                + "WHERE mst_share_folder.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("folderName", Hibernate.STRING)
                .addScalar("serverCode", Hibernate.STRING)
                .addScalar("serverName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("remark", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(ShareFolderTemp.class))
                .uniqueResult(); 
                 
                return shareFolderTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public ShareFolderTemp findData(String code,boolean active) {
        try {
            ShareFolderTemp shareFolderTemp = (ShareFolderTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_share_folder.code, "
                +" mst_share_folder.name, "
                +" mst_share_folder.folderName, "
                +" mst_server.code AS serverCode, "
                +" mst_server.name AS serverName, "
                +" mst_share_folder.activeStatus, "
                +" mst_share_folder.createdBy, "
                +" mst_share_folder.createdDate, "
                +" mst_share_folder.updatedBy, "
                +" mst_share_folder.updatedDate, "
                +" mst_share_folder.inActiveBy, "
                +" mst_share_folder.inActiveDate, "
                +" mst_share_folder.remark "
                + "FROM mst_share_folder "
                + "INNER JOIN mst_server ON mst_server.code = mst_share_folder.serverCode "
                + "WHERE mst_share_folder.code ='"+code+"' "
                + "AND mst_share_folder.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("folderName", Hibernate.STRING)
                .addScalar("serverCode", Hibernate.STRING)
                .addScalar("serverName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ShareFolderTemp.class))
                .uniqueResult(); 
                 
                return shareFolderTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ShareFolderTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_share_folder.ActiveStatus="+active+" ";
            }
            List<ShareFolderTemp> list = (List<ShareFolderTemp>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_share_folder.code, "
                +" mst_share_folder.name, "
                +" mst_share_folder.folderName, "
                +" mst_server.code AS serverCode, "
                +" mst_server.name AS serverName, "
                +" mst_share_folder.activeStatus, "
                +" mst_share_folder.createdBy, "
                +" mst_share_folder.createdDate, "
                +" mst_share_folder.updatedBy, "
                +" mst_share_folder.updatedDate, "
                +" mst_share_folder.inActiveBy, "
                +" mst_share_folder.inActiveDate, "
                +" mst_share_folder.remark "
                + "FROM mst_share_folder "
                + "INNER JOIN mst_server ON mst_server.code = mst_share_folder.serverCode "
                + "WHERE mst_share_folder.code LIKE '%"+code+"%' "
                + "AND mst_share_folder.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("folderName", Hibernate.STRING)
                .addScalar("serverCode", Hibernate.STRING)
                .addScalar("serverName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .addScalar("updatedBy", Hibernate.STRING)
                .addScalar("updatedDate", Hibernate.TIMESTAMP)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ShareFolderTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(ShareFolder shareFolder, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(shareFolder.isActiveStatus()){
                shareFolder.setInActiveBy("");                
            }else{
                shareFolder.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                shareFolder.setInActiveDate(new Date());
            }
            
            shareFolder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            shareFolder.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(shareFolder);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    shareFolder.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ShareFolder shareFolder, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(shareFolder.isActiveStatus()){
                shareFolder.setInActiveBy("");                
            }else{
                shareFolder.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                shareFolder.setInActiveDate(new Date());
            }
            shareFolder.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            shareFolder.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(shareFolder);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    shareFolder.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + ShareFolderField.BEAN_NAME + " WHERE " + ShareFolderField.CODE + " = :prmCode")
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
