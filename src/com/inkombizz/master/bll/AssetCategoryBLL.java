
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.AssetCategoryDAO;
import com.inkombizz.master.model.AssetCategory;
import com.inkombizz.master.model.AssetCategoryField;
import com.inkombizz.master.model.AssetCategoryTemp;


public class AssetCategoryBLL {
    
    public static final String MODULECODE = "006_MST_ASSET_CATEGORY";
    
    private AssetCategoryDAO assetCategoryDAO;
    
    public AssetCategoryBLL (HBMSession hbmSession) {
        this.assetCategoryDAO = new AssetCategoryDAO(hbmSession);
    }
    
    public ListPaging<AssetCategoryTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(AssetCategory.class);           
    
            paging.setRecords(assetCategoryDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<AssetCategoryTemp> listAssetCategoryTemp = assetCategoryDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<AssetCategoryTemp> listPaging = new ListPaging<AssetCategoryTemp>();
            
            listPaging.setList(listAssetCategoryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public AssetCategoryTemp findData(String code) throws Exception {
        try {
            return (AssetCategoryTemp) assetCategoryDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public AssetCategoryTemp findData(String code,boolean active) throws Exception {
        try {
            return (AssetCategoryTemp) assetCategoryDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    
    public void save(AssetCategory assetCategory) throws Exception {
        try {
            assetCategoryDAO.save(assetCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(AssetCategory assetCategory) throws Exception {
        try {
            assetCategoryDAO.update(assetCategory, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            assetCategoryDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(AssetCategory.class)
                            .add(Restrictions.eq(AssetCategoryField.CODE, code));
             
            if(assetCategoryDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    } 

}
