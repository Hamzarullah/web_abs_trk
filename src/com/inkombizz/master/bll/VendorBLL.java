
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.VendorDAO;
import com.inkombizz.master.model.Vendor;
import com.inkombizz.master.model.VendorField;
import com.inkombizz.master.model.VendorJnContactTemp;
import com.inkombizz.master.model.VendorTemp;


public class VendorBLL {
    
    public final String MODULECODE = "006_MST_VENDOR";
    
    private VendorDAO vendorDAO;
    
    public VendorBLL(HBMSession hbmSession){
        this.vendorDAO=new VendorDAO(hbmSession);
    }
    
    //refresh
    public ListPaging<VendorTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Vendor.class);           
    
            paging.setRecords(vendorDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorTemp> listVendorTemp = vendorDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorTemp> listPaging = new ListPaging<VendorTemp>();
            
            listPaging.setList(listVendorTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public VendorTemp findData(String code) throws Exception {
        try {
            return (VendorTemp) vendorDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public VendorTemp findDataGet(String code) throws Exception {
        try {
            return (VendorTemp) vendorDAO.findDataGet(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Vendor vendor) throws Exception {
        try {
            vendorDAO.save(vendor, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Vendor vendor) throws Exception {
        try {
            vendorDAO.update(vendor, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            vendorDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Vendor.class)
                            .add(Restrictions.eq(VendorField.CODE, code));
             
            if(vendorDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    public List<VendorJnContactTemp> findVendorJnContactDetailData(String vendorCode) throws Exception {
        try {
            
            List<VendorJnContactTemp> listVendorJnContactTemp = vendorDAO.findVendorJnContactDetailData(vendorCode);
                                    
            return listVendorJnContactTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public VendorDAO getVendorDAO() {
        return vendorDAO;
    }

    public void setVendorDAO(VendorDAO vendorDAO) {
        this.vendorDAO = vendorDAO;
    }
    
}
