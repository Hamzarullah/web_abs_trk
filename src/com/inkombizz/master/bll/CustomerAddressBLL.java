/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.master.dao.CustomerAddressDAO;
//import com.inkombizz.master.model.AreaSalesManager;
//import com.inkombizz.master.model.AreaSalesManagerField;
import com.inkombizz.master.model.CustomerAddress;
import com.inkombizz.master.model.CustomerAddressField;
import com.inkombizz.master.model.CustomerAddressTemp;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author KalongMan
 */

public class CustomerAddressBLL {
    
    public static final String MODULECODE = "006_MST_CUSTOMER_ADDRESS";
    
    private CustomerAddressDAO customerAddressDAO;
    
    public CustomerAddressBLL (HBMSession hbmSession) {
        this.customerAddressDAO = new CustomerAddressDAO(hbmSession);
    }
    
    public ListPaging<CustomerAddressTemp> findData(String code, String name, String customerCode,String active) throws Exception {
        try {
            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findData(code,name,customerCode,active);
            ListPaging<CustomerAddressTemp> listPaging = new ListPaging<CustomerAddressTemp>();
            
            listPaging.setList(listCustomerAddressTemp);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
//    public ListPaging<CustomerAddressTemp> findDataSalesPersonCustomerAddress(Paging paging,String customerCode, String customerName, String salesPersonCode, String salesPersonName,String active) throws Exception {
//        try {
//            paging.setRecords(customerAddressDAO.countDataSalesPersonCustomerAddress(customerCode,customerName,salesPersonCode,salesPersonName,active));
//            
//            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
//            
//            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findDataSalesPersonCustomerAddress(customerCode,customerName,salesPersonCode,salesPersonName,active,paging.getFromRow(),paging.getToRow());
//            ListPaging<CustomerAddressTemp> listPaging = new ListPaging<CustomerAddressTemp>();
//            
//            listPaging.setList(listCustomerAddressTemp);
//            
//            return listPaging;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
//    
//     public ListPaging<CustomerAddressTemp> findDataPriceListCustomerAddress(String customerCode, String customerName, String priceTypeCode, String priceTypeName,String active,String parentPriceType,Paging paging) throws Exception {
//        try {
//            paging.setRecords(customerAddressDAO.countDataPriceListCustomerAddress(customerCode,customerName,priceTypeCode,priceTypeName,active,parentPriceType));
//            
//            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
//            
//            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findDataPriceListCustomerAddress(customerCode,customerName,priceTypeCode,priceTypeName,active,parentPriceType,paging.getFromRow(), paging.getToRow());
//            ListPaging<CustomerAddressTemp> listPaging = new ListPaging<CustomerAddressTemp>();
//            
//            listPaging.setList(listCustomerAddressTemp);
//            
//            return listPaging;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    public ListPaging<CustomerAddressTemp> findData(String customerCode,String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerAddress.class);           
    
            paging.setRecords(customerAddressDAO.countDataSearch(customerCode,code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findData(customerCode,code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerAddressTemp> listPaging = new ListPaging<CustomerAddressTemp>();
            
            listPaging.setList(listCustomerAddressTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public ListPaging<CustomerAddressTemp> findData2(String customerCode,String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerAddress.class);           
    
            paging.setRecords(customerAddressDAO.countDataSearch2(customerCode,code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findData2(customerCode,code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerAddressTemp> listPaging = new ListPaging<CustomerAddressTemp>();
            
            listPaging.setList(listCustomerAddressTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
//    public ListPaging<CustomerAddressTemp> findDataByWarehouse(String code, String name,String active,Paging paging) throws Exception {
//        try {
//            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerAddress.class);           
//    
//            paging.setRecords(customerAddressDAO.countDataSearchByWarehouse(code,name,active));
//            
//            criteria.setProjection(null);
//            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
//            
//            criteria = paging.addOrderCriteria(criteria);          
//            
//            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
//            
//            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findDataByWarehouse(code,name,active, paging.getFromRow(), paging.getToRow());
//            
//            ListPaging<CustomerAddressTemp> listPaging = new ListPaging<CustomerAddressTemp>();
//            
//            listPaging.setList(listCustomerAddressTemp);
//            listPaging.setPaging(paging);
//            
//            return listPaging;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
     
    public ListPaging<CustomerAddressTemp> polulateSearchDataWithArray(String code, String name, String concat, Paging paging) throws Exception {
        try {
                     
            paging.setRecords(customerAddressDAO.countSearchDataWithArray(code, name, concat));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findSearchDataWithArray(code,name, concat, paging.getFromRow(),paging.getToRow());
            
            ListPaging<CustomerAddressTemp> listPaging = new ListPaging<CustomerAddressTemp>();
            
            listPaging.setList(listCustomerAddressTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
    public CustomerAddressTemp findDataBillAndShip(String code, String status, String statusBillShip) throws Exception {
        try {
            return (CustomerAddressTemp) customerAddressDAO.findDataBillAndShip(code, status, statusBillShip);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerAddressTemp populateGetData(String code, String customerCode, String status) throws Exception {
        try {
            return (CustomerAddressTemp) customerAddressDAO.populateGetData(code, customerCode, status);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
      public CustomerAddressTemp populateGetData3(String code,String active) throws Exception {
        try {
            return (CustomerAddressTemp) customerAddressDAO.populateGetData3(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public void save(CustomerAddress customerAddress) throws Exception {
        try {
            customerAddressDAO.save(customerAddress, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
//  Get data For update
    public CustomerAddressTemp findDataForUpdate(String code) throws Exception {
        try{
            return (CustomerAddressTemp) customerAddressDAO.findDataForUpdate(code);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void update(CustomerAddress customerAddress) throws Exception {
        try {
            customerAddressDAO.update(customerAddress, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public void updateSalesPerson(CustomerAddress salesPersonCustomerAddress) throws Exception{
        try{
            customerAddressDAO.updateSalesPersonCustomerAddress(salesPersonCustomerAddress, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
     
    public void delete(String code) throws Exception {
        try {
            customerAddressDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerAddress.class)
                            .add(Restrictions.eq(CustomerAddressField.CODE, code));
             
            if(customerAddressDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    } 
    
    public boolean isExist(String code, String status) throws Exception{
        try{            
            boolean exist = false;
            if(customerAddressDAO.isExisByQuery(code,status) > 0)
                 exist = true;
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
  
    public List<CustomerAddressTemp> findDataCustomerAddressTemp(String headerCode) throws Exception {
        try {

            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findDataCustomerAddressTemp(headerCode);

            return listCustomerAddressTemp;
        } catch (Exception e) {
            throw e;
        }
    }
  
  public ListPaging<CustomerAddressTemp> findDataCustomerAddressDetail(Paging paging,String code, String name,String status) throws Exception {
        try {

            paging.setRecords(customerAddressDAO.countDataCustomerAddressDetail(code,name,status));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerAddressTemp> listCustomerAddressDetailTemp = customerAddressDAO.findDataCustomerAddressDetail(code,name,status,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerAddressTemp> listPaging = new ListPaging<CustomerAddressTemp>();
            
            listPaging.setList(listCustomerAddressDetailTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
  
    public List<CustomerAddressTemp> findDataCustomerAddressByDln(String headerCode,
            String customerAddressCode, String customerAddressName) throws Exception {
        try {

            List<CustomerAddressTemp> listCustomerAddressTemp = customerAddressDAO.findDataCustomerAddressByDln(headerCode,customerAddressCode,customerAddressName);

            return listCustomerAddressTemp;
        } catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerAddressTemp getMin() throws Exception {
        try {
            return customerAddressDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerAddressTemp getMax() throws Exception {
        try {
            return customerAddressDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }

    public CustomerAddressDAO getCustomerAddressDAO() {
        return customerAddressDAO;
    }

    public void setCustomerAddressDAO(CustomerAddressDAO customerAddressDAO) {
        this.customerAddressDAO = customerAddressDAO;
    }

    public static String getMODULECODE() {
        return MODULECODE;
    }

    
}
