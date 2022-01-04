
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.UploadFileLocationDAO;
import com.inkombizz.master.model.UploadFileLocation;
import com.inkombizz.master.model.UploadFileLocationField;
import com.inkombizz.master.model.UploadFileLocationTemp;


public class UploadFileLocationBLL {
    
    public final String MODULECODE = "006_MST_UPLOAD_FILE_LOCATION";
    
    private UploadFileLocationDAO uploadFileLocationDAO;
    
    public UploadFileLocationBLL(HBMSession hbmSession){
        this.uploadFileLocationDAO=new UploadFileLocationDAO(hbmSession);
    }
    
    public ListPaging<UploadFileLocationTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(UploadFileLocation.class);           
    
            paging.setRecords(uploadFileLocationDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<UploadFileLocationTemp> listUploadFileLocationTemp = uploadFileLocationDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<UploadFileLocationTemp> listPaging = new ListPaging<UploadFileLocationTemp>();
            
            listPaging.setList(listUploadFileLocationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public UploadFileLocationTemp findData(String code) throws Exception {
        try {
            return (UploadFileLocationTemp) uploadFileLocationDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public UploadFileLocationTemp findData(String code,boolean active) throws Exception {
        try {
            return (UploadFileLocationTemp) uploadFileLocationDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(UploadFileLocation uploadFileLocation) throws Exception {
        try {
            uploadFileLocationDAO.save(uploadFileLocation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(UploadFileLocation uploadFileLocation) throws Exception {
        try {
            uploadFileLocationDAO.update(uploadFileLocation, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            uploadFileLocationDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(UploadFileLocation.class)
                            .add(Restrictions.eq(UploadFileLocationField.CODE, code));
             
            if(uploadFileLocationDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
