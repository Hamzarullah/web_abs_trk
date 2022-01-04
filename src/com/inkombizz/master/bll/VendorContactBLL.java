package com.inkombizz.master.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.VendorContactDAO;
import com.inkombizz.master.dao.VendorDAO;
import com.inkombizz.master.model.Vendor;
import com.inkombizz.master.model.VendorContact;
import com.inkombizz.master.model.VendorContactField;
import com.inkombizz.master.model.VendorContactTemp;
import com.inkombizz.master.model.VendorField;
import com.inkombizz.master.model.VendorTemp;
import org.hibernate.criterion.Restrictions;

public class VendorContactBLL {
    public static final String MODULECODE = "006_MST_VENDOR_CONTACT";
    
    private VendorContactDAO vendorContactDAO;

    public VendorContactBLL(HBMSession hbmSession) {
        this.vendorContactDAO = new VendorContactDAO(hbmSession);
    }
	
     public ListPaging<VendorContactTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Vendor.class);           
    
            paging.setRecords(vendorContactDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorContactTemp> listVendorContactTemp = vendorContactDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorContactTemp> listPaging = new ListPaging<VendorContactTemp>();
            
            listPaging.setList(listVendorContactTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ListPaging<VendorContactTemp> findDataForVendor(String vendorCode, String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Vendor.class);           
    
            paging.setRecords(vendorContactDAO.countDataForVendor(vendorCode,code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorContactTemp> listVendorContactTemp = vendorContactDAO.findDataForVendor(vendorCode,code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorContactTemp> listPaging = new ListPaging<VendorContactTemp>();
            
            listPaging.setList(listVendorContactTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
     public ListPaging<VendorContactTemp> polulateSearchDataWithArray(String code, String name, String concat, Paging paging) throws Exception {
        try {
                     
            paging.setRecords(vendorContactDAO.countSearchDataWithArray(code, name, concat));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorContactTemp> listVendorContactTemp = vendorContactDAO.findSearchDataWithArray(code,name, concat, paging.getFromRow(),paging.getToRow());
            
            ListPaging<VendorContactTemp> listPaging = new ListPaging<VendorContactTemp>();
            
            listPaging.setList(listVendorContactTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
    public VendorContactTemp findData(String code) throws Exception {
        try {
            return (VendorContactTemp) vendorContactDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
     public List<VendorContactTemp> findDataVendorContactTemp(String headerCode) throws Exception {
        try {

            List<VendorContactTemp> listVendorContactTemp = vendorContactDAO.findDataVendorContactTemp(headerCode);

            return listVendorContactTemp;
        } catch (Exception e) {
            throw e;
        }
    }
    
    public VendorContactTemp findData(String code,boolean active) throws Exception {
        try {
            return (VendorContactTemp) vendorContactDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public VendorContactTemp findDataVendorContactForVendor(String vendorCode,String code) throws Exception {
        try {
            return (VendorContactTemp) vendorContactDAO.findDataVendorContactForVendor(vendorCode,code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public VendorContact get(String code){
        try{
            return (VendorContact) vendorContactDAO.get(code);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void save(VendorContact vendorContact) throws Exception {
        try {
            vendorContactDAO.save(vendorContact, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(VendorContact vendorContact) throws Exception {
        try {
            vendorContactDAO.update(vendorContact, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            vendorContactDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(VendorContact.class)
                            .add(Restrictions.eq(VendorContactField.CODE, code));
             
            if(vendorContactDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public VendorContactDAO getVendorContactDAO() {
        return vendorContactDAO;
    }

    public void setVendorContactDAO(VendorContactDAO vendorContactDAO) {
        this.vendorContactDAO = vendorContactDAO;
    }

    public static String getMODULECODE() {
        return MODULECODE;
    }
    
    
}
