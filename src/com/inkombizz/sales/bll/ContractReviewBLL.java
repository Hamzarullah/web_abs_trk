/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.ContractReviewDAO;
import com.inkombizz.sales.model.ContractReview;
import com.inkombizz.sales.model.ContractReviewCADDocumentApproval;
import com.inkombizz.sales.model.ContractReviewDCASDesign;
import com.inkombizz.sales.model.ContractReviewDCASFireSafeByDesign;
import com.inkombizz.sales.model.ContractReviewDCASHydroTest;
import com.inkombizz.sales.model.ContractReviewDCASLegalRequirements;
import com.inkombizz.sales.model.ContractReviewDCASMarking;
import com.inkombizz.sales.model.ContractReviewDCASNde;
import com.inkombizz.sales.model.ContractReviewDCASTesting;
import com.inkombizz.sales.model.ContractReviewDCASVisualExamination;
import com.inkombizz.sales.model.ContractReviewField;
import com.inkombizz.sales.model.ContractReviewSalesQuotation;
import com.inkombizz.sales.model.ContractReviewTemp;
import com.inkombizz.sales.model.ContractReviewValveType;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class ContractReviewBLL {
     public static final String MODULECODE = "002_SAL_CONTRACT_REVIEW";
    
    private ContractReviewDAO contractReviewDAO;
    
    public ContractReviewBLL(HBMSession hbmSession){
      this.contractReviewDAO = new ContractReviewDAO(hbmSession);
    }
    
     public ListPaging<ContractReviewTemp> findData(Paging paging,String code, String customerCode, String customerName, String validStatus, Date firstDate,Date lastDate) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ContractReview.class);           
    
            paging.setRecords(contractReviewDAO.countData(code,customerCode,customerName,validStatus, firstDate,lastDate));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
 
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ContractReviewTemp> listContractReviewTemp = contractReviewDAO.findData(code,customerCode,customerName,validStatus,firstDate,lastDate,paging.getFromRow(),paging.getToRow());
            
            ListPaging<ContractReviewTemp> listPaging = new ListPaging<ContractReviewTemp>();
            
            listPaging.setList(listContractReviewTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
     public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ContractReview.class)
                            .add(Restrictions.eq(ContractReviewField.CODE, headerCode));
             
            if(contractReviewDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
     
    public void save(EnumActivity.ENUM_Activity enumActivity, ContractReview contractReview, List<ContractReviewSalesQuotation> listContractReviewSalesQuotation, List<ContractReviewValveType> listContractReviewValveType,
                      List<ContractReviewDCASDesign> listContractReviewDCASDesign, List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign,
                      List<ContractReviewDCASTesting> listContractReviewDCASTesting, List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest,
                      List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination, List<ContractReviewDCASNde> listContractReviewDCASNde,
                      List<ContractReviewDCASMarking> listContractReviewDCASMarking, List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements,
                      List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval) throws Exception{
        try{
            contractReviewDAO.save(enumActivity, contractReview, listContractReviewSalesQuotation, listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                                   listContractReviewDCASTesting, listContractReviewDCASHydroTest,listContractReviewDCASVisualExamination, listContractReviewDCASNde, listContractReviewDCASMarking, listContractReviewDCASLegalRequirements,
                                   listContractReviewCADDocumentApproval, MODULECODE);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
    
    public void update(ContractReview contractReview, List<ContractReviewSalesQuotation> listContractReviewSalesQuotation, List<ContractReviewValveType> listContractReviewValveType,
                      List<ContractReviewDCASDesign> listContractReviewDCASDesign, List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign,
                      List<ContractReviewDCASTesting> listContractReviewDCASTesting, List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest,
                      List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination, List<ContractReviewDCASNde> listContractReviewDCASNde,
                      List<ContractReviewDCASMarking> listContractReviewDCASMarking, List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements,
                      List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval) throws Exception{
        try{
            contractReviewDAO.update(contractReview, listContractReviewSalesQuotation, listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                                   listContractReviewDCASTesting, listContractReviewDCASHydroTest,listContractReviewDCASVisualExamination, listContractReviewDCASNde, listContractReviewDCASMarking, listContractReviewDCASLegalRequirements,
                                   listContractReviewCADDocumentApproval, MODULECODE);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
    
    public void revise(ContractReview contractReview, List<ContractReviewSalesQuotation> listContractReviewSalesQuotation, List<ContractReviewValveType> listContractReviewValveType,
                      List<ContractReviewDCASDesign> listContractReviewDCASDesign, List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign,
                      List<ContractReviewDCASTesting> listContractReviewDCASTesting, List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest,
                      List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination, List<ContractReviewDCASNde> listContractReviewDCASNde,
                      List<ContractReviewDCASMarking> listContractReviewDCASMarking, List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements,
                      List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval) throws Exception{
        try{
            contractReviewDAO.revise(contractReview, listContractReviewSalesQuotation, listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                                   listContractReviewDCASTesting, listContractReviewDCASHydroTest,listContractReviewDCASVisualExamination, listContractReviewDCASNde, listContractReviewDCASMarking, listContractReviewDCASLegalRequirements,
                                   listContractReviewCADDocumentApproval, MODULECODE);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
    
    public void delete(ContractReview contractReview) throws Exception{
        contractReviewDAO.delete(contractReview,MODULECODE);
    }
     
    public List<ContractReviewSalesQuotation> findDataSalesQuotation(String headerCode) throws Exception {
        try {
            
            List<ContractReviewSalesQuotation> listContractReviewSalesQuotation = contractReviewDAO.findDataSalesQuotation(headerCode);
            
            return listContractReviewSalesQuotation;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewValveType> findDataValveType(String headerCode) throws Exception {
        try {
            
            List<ContractReviewValveType> listContractReviewValveType = contractReviewDAO.findDataValveType(headerCode);
            
            return listContractReviewValveType;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewDCASDesign> findDataDcasDesign(String headerCode) throws Exception {
        try {
            
            List<ContractReviewDCASDesign> listContractReviewDCASDesign = contractReviewDAO.findDataDcasDesign(headerCode);
            
            return listContractReviewDCASDesign;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ContractReview findSoForUpdateContractReview(String customerPurchaseOrderCode){
        try {
            
            ContractReview contractReview = contractReviewDAO.findSoForUpdateContractReview(customerPurchaseOrderCode);
            
            return contractReview;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewDCASFireSafeByDesign> findDataDcasFireSafeByDesign(String headerCode) throws Exception {
        try {
            
            List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign = contractReviewDAO.findDataDcasFireSafeByDesign(headerCode);
            
            return listContractReviewDCASFireSafeByDesign;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewDCASTesting> findDataDcasTesting(String headerCode) throws Exception {
        try {
            
            List<ContractReviewDCASTesting> listfindDataDcasTesting = contractReviewDAO.findDataDcasTesting(headerCode);
            
            return listfindDataDcasTesting;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewDCASHydroTest> findDataDcasHydroTest(String headerCode) throws Exception {
        try {
            
            List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest = contractReviewDAO.findDataDcasHydroTest(headerCode);
            
            return listContractReviewDCASHydroTest;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewDCASVisualExamination> findDataDcasVisualExamination(String headerCode) throws Exception {
        try {
            
            List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination = contractReviewDAO.findDataDcasVisualExamination(headerCode);
            
            return listContractReviewDCASVisualExamination;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewDCASNde> findDataDcasNde(String headerCode) throws Exception {
        try {
            
            List<ContractReviewDCASNde> listContractReviewDCASNde = contractReviewDAO.findDataDcasNde(headerCode);
            
            return listContractReviewDCASNde;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewDCASMarking> findDataDcasMarking(String headerCode) throws Exception {
        try {
            
            List<ContractReviewDCASMarking> listContractReviewDCASMarking = contractReviewDAO.findDataDcasMarking(headerCode);
            
            return listContractReviewDCASMarking;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewDCASLegalRequirements> findDataDcasLegalRequirements(String headerCode) throws Exception {
        try {
            
            List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements = contractReviewDAO.findDataDcasLegalRequirements(headerCode);
            
            return listContractReviewDCASLegalRequirements;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      
    public List<ContractReviewCADDocumentApproval> findDataCadDocumentApproval(String headerCode) throws Exception {
        try {
            
            List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval = contractReviewDAO.findDataCadDocumentApproval(headerCode);
            
            return listContractReviewCADDocumentApproval;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public String createReviseCode(EnumActivity.ENUM_Activity enumActivity,ContractReview contractReview) throws Exception {
        try {
            return contractReviewDAO.createReviseCode(enumActivity,contractReview);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public ContractReviewDAO getContractReviewDAO() {
        return contractReviewDAO;
    }

    public void setContractReviewDAO(ContractReviewDAO contractReviewDAO) {
        this.contractReviewDAO = contractReviewDAO;
    }
      
}
