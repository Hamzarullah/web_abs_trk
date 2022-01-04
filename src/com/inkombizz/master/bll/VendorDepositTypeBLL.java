package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.VendorDepositTypeDAO;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.BranchTemp;
import com.inkombizz.master.model.VendorDepositType;
import com.inkombizz.master.model.VendorDepositTypeChartOfAccount;
import com.inkombizz.master.model.VendorDepositTypeChartOfAccountTemp;
import com.inkombizz.master.model.VendorDepositTypeTemp;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author CHRIST
 */
public class VendorDepositTypeBLL {
    
    public static final String MODULECODE = "006_MST_VENDOR_DEPOSIT_TYPE";
    
    private VendorDepositTypeDAO vendorDepositTypeDAO;
    
    public VendorDepositTypeBLL(HBMSession hbmSession){
        this.vendorDepositTypeDAO = new VendorDepositTypeDAO(hbmSession);
    }
    
    public ListPaging<VendorDepositTypeTemp> findData(Paging paging) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(VendorDepositType.class);
            
            paging.setRecords(vendorDepositTypeDAO.countData());
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<VendorDepositTypeTemp> listVendorDepositTypeTemp=vendorDepositTypeDAO.findData(paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorDepositTypeTemp> listPaging=new ListPaging<VendorDepositTypeTemp>();
            
            listPaging.setList(listVendorDepositTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public ListPaging<VendorDepositTypeTemp> searchData(Paging paging, VendorDepositType vendorDepositType) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(VendorDepositType.class);
            
            paging.setRecords(vendorDepositTypeDAO.countSearchData(vendorDepositType));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<VendorDepositTypeTemp> listVendorDepositTypeTemp = vendorDepositTypeDAO.searchData(vendorDepositType, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorDepositTypeTemp> listPaging=new ListPaging<VendorDepositTypeTemp>();
            
            listPaging.setList(listVendorDepositTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public ListPaging<VendorDepositTypeTemp> findDataReportPaging(Paging paging,String code, String name) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(VendorDepositType.class);           
    
            paging.setRecords(vendorDepositTypeDAO.countDataReportPaging(code,name));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorDepositTypeTemp> listVendorDepositTypeTemp = vendorDepositTypeDAO.findDataReportPaging(code,name,paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorDepositTypeTemp> listPaging = new ListPaging<VendorDepositTypeTemp>();
            
            listPaging.setList(listVendorDepositTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<VendorDepositTypeTemp> searchDataForReport(Paging paging, VendorDepositType vendorDepositType) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(VendorDepositType.class);
            
            paging.setRecords(vendorDepositTypeDAO.countSearchDataForReport(vendorDepositType));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<VendorDepositTypeTemp> listVendorDepositTypeTemp = vendorDepositTypeDAO.searchDataForReport(vendorDepositType, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorDepositTypeTemp> listPaging=new ListPaging<VendorDepositTypeTemp>();
            
            listPaging.setList(listVendorDepositTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public VendorDepositTypeTemp findDataForReport(VendorDepositType vendorDepositType) throws Exception {
        try {
            return (VendorDepositTypeTemp) vendorDepositTypeDAO.findDataForReport(vendorDepositType);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public VendorDepositTypeTemp getMin() throws Exception {
        try {
            return vendorDepositTypeDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public VendorDepositTypeTemp getMax() throws Exception {
        try {
            return vendorDepositTypeDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ListPaging<VendorDepositTypeChartOfAccount> findDataCoaDetail(Paging paging, VendorDepositType vendorDepositType) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(VendorDepositType.class);
            
            paging.setRecords(vendorDepositTypeDAO.countDataCoaDetail(vendorDepositType));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<VendorDepositTypeChartOfAccount> listVendorDepositTypeChartOfAccount = vendorDepositTypeDAO.findDataCoaDetail(vendorDepositType, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorDepositTypeChartOfAccount> listPaging=new ListPaging<VendorDepositTypeChartOfAccount>();
            
            listPaging.setList(listVendorDepositTypeChartOfAccount);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public VendorDepositTypeTemp findData(VendorDepositType vendorDepositType) throws Exception {
        try {
            return (VendorDepositTypeTemp) vendorDepositTypeDAO.findData(vendorDepositType);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<VendorDepositTypeChartOfAccount> findDataChartOfAccount(String code) throws Exception{
        try{
            
            List<VendorDepositTypeChartOfAccount> listVendorDepositTypeChartOfAccount = vendorDepositTypeDAO.findDataChartOfAccount(code);
            
            return listVendorDepositTypeChartOfAccount;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public void save(VendorDepositType vendorDepositType
            ,List<VendorDepositTypeChartOfAccount> listVendorDepositTypeChartOfAccount
    ) throws Exception {
        try {
            vendorDepositTypeDAO.save(vendorDepositType, 
                    listVendorDepositTypeChartOfAccount,
                    MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public VendorDepositType get(String code) throws Exception {
        try{
            return (VendorDepositType) vendorDepositTypeDAO.get(code);
        }catch(Exception ex){
            throw ex;
        }
    }
    
    public int getDetailStatus(String code) throws Exception {
        try{
            int temp;
            return temp = vendorDepositTypeDAO.getDetailStatus(code);
        }catch(Exception ex){
            throw ex;
        }
    }
    

    public VendorDepositTypeDAO getVendorDepositTypeDAO() {
        return vendorDepositTypeDAO;
    }

    public void setVendorDepositTypeDAO(VendorDepositTypeDAO vendorDepositTypeDAO) {
        this.vendorDepositTypeDAO = vendorDepositTypeDAO;
    }
}
