

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

import com.inkombizz.master.model.UploadFileLocation;
import com.inkombizz.master.model.UploadFileLocationTemp;
import com.inkombizz.master.model.UploadFileLocationField;



public class UploadFileLocationDAO {
    
    private HBMSession hbmSession;
    
    public UploadFileLocationDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_upload_file_location.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_upload_file_location "
                + "WHERE mst_upload_file_location.code LIKE '%"+code+"%' "
                + "AND mst_upload_file_location.name LIKE '%"+name+"%' "
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
    
    public UploadFileLocationTemp findData(String code) {
        try {
            UploadFileLocationTemp uploadFileLocationTemp = (UploadFileLocationTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_upload_file_location.code, "
                +" mst_upload_file_location.name, "
                +" mst_share_folder.code AS shareFolderCode, "
                +" mst_share_folder.name AS shareFolderName, "
                +" mst_upload_file_location.activeStatus, "
                +" mst_upload_file_location.createdBy, "
                +" mst_upload_file_location.createdDate, "
                +" mst_upload_file_location.updatedBy, "
                +" mst_upload_file_location.updatedDate, "
                +" mst_upload_file_location.inActiveBy, "
                +" mst_upload_file_location.inActiveDate, "
                +" mst_upload_file_location.remark "
                +" FROM mst_upload_file_location "
                +" INNER JOIN mst_share_folder ON mst_share_folder.code = mst_upload_file_location.shareFolderCode "
                +" WHERE mst_upload_file_location.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("shareFolderCode", Hibernate.STRING)
                .addScalar("shareFolderName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                    
                .setResultTransformer(Transformers.aliasToBean(UploadFileLocationTemp.class))
                .uniqueResult(); 
                 
                return uploadFileLocationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public UploadFileLocationTemp findData(String code,boolean active) {
        try {
            UploadFileLocationTemp uploadFileLocationTemp = (UploadFileLocationTemp)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_upload_file_location.code, "
                +" mst_upload_file_location.name, "
                +" mst_share_folder.code AS shareFolderCode, "
                +" mst_share_folder.name AS shareFolderName, "
                +" mst_upload_file_location.activeStatus, "
                +" mst_upload_file_location.createdBy, "
                +" mst_upload_file_location.createdDate, "
                +" mst_upload_file_location.updatedBy, "
                +" mst_upload_file_location.updatedDate, "
                +" mst_upload_file_location.inActiveBy, "
                +" mst_upload_file_location.inActiveDate, "
                +" mst_upload_file_location.remark "
                +" FROM mst_upload_file_location "
                +" INNER JOIN mst_share_folder ON mst_share_folder.code = mst_upload_file_location.shareFolderCode "
                + "WHERE mst_upload_file_location.code ='"+code+"' "
                + "AND mst_upload_file_location.ActiveStatus ="+active+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("shareFolderCode", Hibernate.STRING)
                .addScalar("shareFolderName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(UploadFileLocationTemp.class))
                .uniqueResult(); 
                 
                return uploadFileLocationTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<UploadFileLocationTemp> findData(String code, String name,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_upload_file_location.ActiveStatus="+active+" ";
            }
            List<UploadFileLocationTemp> list = (List<UploadFileLocationTemp>)hbmSession.hSession.createSQLQuery(""
                +" SELECT "
                +" mst_upload_file_location.code, "
                +" mst_upload_file_location.name, "
                +" mst_share_folder.code AS shareFolderCode, "
                +" mst_share_folder.name AS shareFolderName, "
                +" mst_upload_file_location.activeStatus, "
                +" mst_upload_file_location.createdBy, "
                +" mst_upload_file_location.createdDate, "
                +" mst_upload_file_location.updatedBy, "
                +" mst_upload_file_location.updatedDate, "
                +" mst_upload_file_location.inActiveBy, "
                +" mst_upload_file_location.inActiveDate, "
                +" mst_upload_file_location.remark "
                +" FROM mst_upload_file_location "
                +" INNER JOIN mst_share_folder ON mst_share_folder.code = mst_upload_file_location.shareFolderCode "
                + "WHERE mst_upload_file_location.code LIKE '%"+code+"%' "
                + "AND mst_upload_file_location.name LIKE '%"+name+"%' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("shareFolderCode", Hibernate.STRING)
                .addScalar("shareFolderName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(UploadFileLocationTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(UploadFileLocation uploadFileLocation, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(uploadFileLocation.isActiveStatus()){
                uploadFileLocation.setInActiveBy("");                
            }else{
                uploadFileLocation.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                uploadFileLocation.setInActiveDate(new Date());
            }
            
            uploadFileLocation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            uploadFileLocation.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(uploadFileLocation);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
                                                                    uploadFileLocation.getCode() , ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(UploadFileLocation uploadFileLocation, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            if(uploadFileLocation.isActiveStatus()){
                uploadFileLocation.setInActiveBy("");                
            }else{
                uploadFileLocation.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                uploadFileLocation.setInActiveDate(new Date());
            }
            uploadFileLocation.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            uploadFileLocation.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(uploadFileLocation);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                    uploadFileLocation.getCode(), ""));
             
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
            hbmSession.hSession.createQuery("DELETE FROM " + UploadFileLocationField.BEAN_NAME + " WHERE " + UploadFileLocationField.CODE + " = :prmCode")
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
