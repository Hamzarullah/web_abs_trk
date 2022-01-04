
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.AssetRegistrationDAO;
import com.inkombizz.master.model.AssetRegistration;
import com.inkombizz.master.model.AssetRegistrationField;
import com.inkombizz.master.model.AssetRegistrationTemp;


public class AssetRegistrationBLL {
    
    public static final String MODULECODE = "006_MST_ASSET_REGISTRATION";
    
    private AssetRegistrationDAO assetRegistrationDAO;
    
    public AssetRegistrationBLL (HBMSession hbmSession) {
        this.assetRegistrationDAO = new AssetRegistrationDAO(hbmSession);
    }
    
    
    public ListPaging<AssetRegistrationTemp> findData(Paging paging, String code, String name,String bbmVoucherNo, String ChartOfAccountCode, String ChartOfAccountName,String active) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(AssetRegistration.class);           
            paging.setRecords(assetRegistrationDAO.countData(code,name,active));
            criteria = paging.addOrderCriteria(criteria);          
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<AssetRegistrationTemp> listAssetRegistrationTemp = assetRegistrationDAO.findData(code,name,bbmVoucherNo,ChartOfAccountCode,ChartOfAccountName,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AssetRegistrationTemp> listPaging = new ListPaging<AssetRegistrationTemp>();
            
            listPaging.setList(listAssetRegistrationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public AssetRegistrationTemp findData(String code) throws Exception {
        try {
            return (AssetRegistrationTemp) assetRegistrationDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public AssetRegistrationTemp findData(String code,boolean active) throws Exception {
        try {
            return (AssetRegistrationTemp) assetRegistrationDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public AssetRegistrationTemp findData2(String code,String active) throws Exception {
        try {
            return (AssetRegistrationTemp) assetRegistrationDAO.findData2(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(AssetRegistration assetRegistration) throws Exception {
        try {
            assetRegistrationDAO.save(assetRegistration, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(AssetRegistration assetRegistration) throws Exception {
        try {
            assetRegistrationDAO.update(assetRegistration, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            assetRegistrationDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
    
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(AssetRegistration.class)
                            .add(Restrictions.eq(AssetRegistrationField.CODE, code));
             
            if(assetRegistrationDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public AssetRegistrationTemp min() throws Exception {
        try {
            return assetRegistrationDAO.min();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public AssetRegistrationTemp max() throws Exception {
        try {
            return assetRegistrationDAO.max();
        }
        catch (Exception e) {
            throw e;
        }
    }
 
}
