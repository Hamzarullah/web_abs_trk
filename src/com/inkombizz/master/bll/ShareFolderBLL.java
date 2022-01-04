
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ShareFolderDAO;
import com.inkombizz.master.model.ShareFolder;
import com.inkombizz.master.model.ShareFolderField;
import com.inkombizz.master.model.ShareFolderTemp;


public class ShareFolderBLL {
    
    public final String MODULECODE = "006_MST_SHARE_FOLDER";
    
    private ShareFolderDAO shareFolderDAO;
    
    public ShareFolderBLL(HBMSession hbmSession){
        this.shareFolderDAO=new ShareFolderDAO(hbmSession);
    }
    
    public ListPaging<ShareFolderTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ShareFolder.class);           
    
            paging.setRecords(shareFolderDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ShareFolderTemp> listShareFolderTemp = shareFolderDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ShareFolderTemp> listPaging = new ListPaging<ShareFolderTemp>();
            
            listPaging.setList(listShareFolderTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ShareFolderTemp findData(String code) throws Exception {
        try {
            return (ShareFolderTemp) shareFolderDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ShareFolderTemp findData(String code,boolean active) throws Exception {
        try {
            return (ShareFolderTemp) shareFolderDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ShareFolder shareFolder) throws Exception {
        try {
            shareFolderDAO.save(shareFolder, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ShareFolder shareFolder) throws Exception {
        try {
            shareFolderDAO.update(shareFolder, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            shareFolderDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ShareFolder.class)
                            .add(Restrictions.eq(ShareFolderField.CODE, code));
             
            if(shareFolderDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
