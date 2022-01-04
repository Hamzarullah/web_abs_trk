package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.CustomerDepositTypeDAO;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.BranchTemp;
import com.inkombizz.master.model.CustomerDepositType;
import com.inkombizz.master.model.CustomerDepositTypeChartOfAccount;
import com.inkombizz.master.model.CustomerDepositTypeChartOfAccountTemp;
import com.inkombizz.master.model.CustomerDepositTypeTemp;
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
public class CustomerDepositTypeBLL {
    
    public static final String MODULECODE = "006_MST_CUSTOMER_DEPOSIT_TYPE";
    
    private CustomerDepositTypeDAO customerDepositTypeDAO;
    
    public CustomerDepositTypeBLL(HBMSession hbmSession){
        this.customerDepositTypeDAO = new CustomerDepositTypeDAO(hbmSession);
    }
    
    public ListPaging<CustomerDepositTypeTemp> findData(Paging paging) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(CustomerDepositType.class);
            
            paging.setRecords(customerDepositTypeDAO.countData());
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<CustomerDepositTypeTemp> listCustomerDepositTypeTemp=customerDepositTypeDAO.findData(paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerDepositTypeTemp> listPaging=new ListPaging<CustomerDepositTypeTemp>();
            
            listPaging.setList(listCustomerDepositTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public ListPaging<CustomerDepositTypeTemp> searchData(Paging paging, CustomerDepositType customerDepositType) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(CustomerDepositType.class);
            
            paging.setRecords(customerDepositTypeDAO.countSearchData(customerDepositType));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<CustomerDepositTypeTemp> listCustomerDepositTypeTemp = customerDepositTypeDAO.searchData(customerDepositType, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerDepositTypeTemp> listPaging=new ListPaging<CustomerDepositTypeTemp>();
            
            listPaging.setList(listCustomerDepositTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public ListPaging<CustomerDepositTypeTemp> findDataReportPaging(Paging paging,String code, String name) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerDepositType.class);           
    
            paging.setRecords(customerDepositTypeDAO.countDataReportPaging(code,name));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerDepositTypeTemp> listCustomerDepositTypeTemp = customerDepositTypeDAO.findDataReportPaging(code,name,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerDepositTypeTemp> listPaging = new ListPaging<CustomerDepositTypeTemp>();
            
            listPaging.setList(listCustomerDepositTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<CustomerDepositTypeTemp> searchDataForReport(Paging paging, CustomerDepositType customerDepositType) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(CustomerDepositType.class);
            
            paging.setRecords(customerDepositTypeDAO.countSearchDataForReport(customerDepositType));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<CustomerDepositTypeTemp> listCustomerDepositTypeTemp = customerDepositTypeDAO.searchDataForReport(customerDepositType, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerDepositTypeTemp> listPaging=new ListPaging<CustomerDepositTypeTemp>();
            
            listPaging.setList(listCustomerDepositTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public ListPaging<CustomerDepositTypeChartOfAccount> findDataCoaDetail(Paging paging, CustomerDepositType customerDepositType) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(CustomerDepositType.class);
            
            paging.setRecords(customerDepositTypeDAO.countDataCoaDetail(customerDepositType));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<CustomerDepositTypeChartOfAccount> listCustomerDepositTypeChartOfAccount = customerDepositTypeDAO.findDataCoaDetail(customerDepositType, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerDepositTypeChartOfAccount> listPaging=new ListPaging<CustomerDepositTypeChartOfAccount>();
            
            listPaging.setList(listCustomerDepositTypeChartOfAccount);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public CustomerDepositTypeTemp findData(CustomerDepositType customerDepositType) throws Exception {
        try {
            return (CustomerDepositTypeTemp) customerDepositTypeDAO.findData(customerDepositType);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerDepositTypeTemp findDataForReport(CustomerDepositType customerDepositType) throws Exception {
        try {
            return (CustomerDepositTypeTemp) customerDepositTypeDAO.findDataForReport(customerDepositType);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<CustomerDepositTypeChartOfAccount> findDataChartOfAccount(String code) throws Exception{
        try{
            
            List<CustomerDepositTypeChartOfAccount> listCustomerDepositTypeChartOfAccount = customerDepositTypeDAO.findDataChartOfAccount(code);
            
            return listCustomerDepositTypeChartOfAccount;
        }
        catch(Exception ex){
            throw ex;
        }   
    }
    
    public CustomerDepositTypeTemp getMin() throws Exception {
        try {
            return customerDepositTypeDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerDepositTypeTemp getMax() throws Exception {
        try {
            return customerDepositTypeDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(CustomerDepositType customerDepositType
            ,List<CustomerDepositTypeChartOfAccount> listCustomerDepositTypeChartOfAccount
    ) throws Exception {
        try {
            customerDepositTypeDAO.save(customerDepositType, 
                    listCustomerDepositTypeChartOfAccount,
                    MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CustomerDepositType get(String code) throws Exception {
        try{
            return (CustomerDepositType) customerDepositTypeDAO.get(code);
        }catch(Exception ex){
            throw ex;
        }
    }
    
    public int getDetailStatus(String code) throws Exception {
        try{
            int temp;
            return temp = customerDepositTypeDAO.getDetailStatus(code);
        }catch(Exception ex){
            throw ex;
        }
    }
    

    public CustomerDepositTypeDAO getCustomerDepositTypeDAO() {
        return customerDepositTypeDAO;
    }

    public void setCustomerDepositTypeDAO(CustomerDepositTypeDAO customerDepositTypeDAO) {
        this.customerDepositTypeDAO = customerDepositTypeDAO;
    }
}
