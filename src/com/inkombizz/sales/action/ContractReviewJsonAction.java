
package com.inkombizz.sales.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.ContractReviewBLL;
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
import com.inkombizz.sales.model.ContractReviewSalesQuotation;
import com.inkombizz.sales.model.ContractReviewTemp;
import com.inkombizz.sales.model.ContractReviewValveType;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result (type = "json")
public class ContractReviewJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private ContractReview contractReview;
    private List<ContractReviewTemp> listContractReviewTemp; 
    private List<ContractReviewSalesQuotation> listContractReviewSalesQuotation;
    private List<ContractReviewValveType> listContractReviewValveType;
    private List<ContractReviewDCASDesign> listContractReviewDCASDesign;
    private List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign;
    private List<ContractReviewDCASTesting> listContractReviewDCASTesting;
    private List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest;
    private List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination;
    private List<ContractReviewDCASNde> listContractReviewDCASNde;
    private List<ContractReviewDCASMarking> listContractReviewDCASMarking;
    private List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements;
    private List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval;
    
    private String contractReviewSearchCode ="";
    private String contractReviewCustomerSearchCode="";
    private String contractReviewCustomerSearchName="";
    private String contractReviewSearchValidStatus="TRUE";
    private Date contractReviewSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date contractReviewSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    private String listContractReviewSalesQuotationJSON;
    private String listContractReviewValveTypeJSON;
    private String listContractReviewDCASDesignJSON;
    private String listContractReviewDCASFireSafeByDesignJSON;
    private String listContractReviewDCASTestingJSON;
    private String listContractReviewDCASHydroTestJSON;
    private String listContractReviewDCASVisualExaminationJSON;
    private String listContractReviewDCASMarkingJSON;
    private String listContractReviewDCASNdeJSON;
    private String listContractReviewDCASLegalRequirementsJSON;
    private String listContractReviewCADDocumentApprovalJSON;
   
    private EnumActivity.ENUM_Activity enumContractReviewActivity;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("contract-review-data")
    public String findData() {
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            ListPaging <ContractReviewTemp> listPaging = contractReviewBLL.findData(paging, contractReviewSearchCode, contractReviewCustomerSearchCode, contractReviewCustomerSearchName,
                                                                                    contractReviewSearchValidStatus, contractReviewSearchFirstDate, contractReviewSearchLastDate);
            
            listContractReviewTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-sales-quotation-data")
    public String findDataSalesQuotation(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewSalesQuotation> list = contractReviewBLL.findDataSalesQuotation(contractReview.getCode());
            
            listContractReviewSalesQuotation = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-valve-type-data")
    public String findDataValveType(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewValveType> list = contractReviewBLL.findDataValveType(contractReview.getCode());
            
            listContractReviewValveType = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-dcas-design-data")
    public String findDataDcasDesign(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewDCASDesign> list = contractReviewBLL.findDataDcasDesign(contractReview.getCode());
            
            listContractReviewDCASDesign = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-dcas-fire-safe-by-design-data")
    public String findDataDcasFireSafeByDesign(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewDCASFireSafeByDesign> list = contractReviewBLL.findDataDcasFireSafeByDesign(contractReview.getCode());
            
            listContractReviewDCASFireSafeByDesign = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-dcas-testing-data")
    public String findDataDcasTesting(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
           List<ContractReviewDCASTesting> list = contractReviewBLL.findDataDcasTesting(contractReview.getCode());
            
            listContractReviewDCASTesting = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-dcas-hydro-test-data")
    public String findDataDcasHydroTest(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewDCASHydroTest> list = contractReviewBLL.findDataDcasHydroTest(contractReview.getCode());
            
            listContractReviewDCASHydroTest = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-dcas-visual-examination-data")
    public String findDataDcasVisualExamination(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewDCASVisualExamination> list = contractReviewBLL.findDataDcasVisualExamination(contractReview.getCode());
            
            listContractReviewDCASVisualExamination = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-dcas-nde-data")
    public String findDataDcasNde(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewDCASNde> list = contractReviewBLL.findDataDcasNde(contractReview.getCode());
            
            listContractReviewDCASNde = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-dcas-marking-data")
    public String findDataDcasMarking(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewDCASMarking> list = contractReviewBLL.findDataDcasMarking(contractReview.getCode());
            
            listContractReviewDCASMarking = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-dcas-legal-requirements-data")
    public String findDataDcasLegalRequirements(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewDCASLegalRequirements> list = contractReviewBLL.findDataDcasLegalRequirements(contractReview.getCode());
            
            listContractReviewDCASLegalRequirements = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("contract-review-cad-document-approval-data")
    public String findDataCadDocumentApproval(){
        try {
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            List<ContractReviewCADDocumentApproval> list = contractReviewBLL.findDataCadDocumentApproval(contractReview.getCode());
            
            listContractReviewCADDocumentApproval = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-save")
    public String save(){
        String _Messg = "";
        try {
                        
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);
            
            Gson gson = new Gson();
            Gson bson = new Gson();
            
            this.listContractReviewSalesQuotation = bson.fromJson(this.listContractReviewSalesQuotationJSON, new TypeToken<List<ContractReviewSalesQuotation>>(){}.getType());           
            this.listContractReviewValveType = gson.fromJson(this.listContractReviewValveTypeJSON, new TypeToken<List<ContractReviewValveType>>(){}.getType());            
            this.listContractReviewDCASDesign = gson.fromJson(this.listContractReviewDCASDesignJSON, new TypeToken<List<ContractReviewDCASDesign>>(){}.getType());            
            this.listContractReviewDCASFireSafeByDesign = gson.fromJson(this.listContractReviewDCASFireSafeByDesignJSON, new TypeToken<List<ContractReviewDCASFireSafeByDesign>>(){}.getType());            
            this.listContractReviewDCASTesting = gson.fromJson(this.listContractReviewDCASTestingJSON, new TypeToken<List<ContractReviewDCASTesting>>(){}.getType());            
            this.listContractReviewDCASHydroTest = gson.fromJson(this.listContractReviewDCASHydroTestJSON, new TypeToken<List<ContractReviewDCASHydroTest>>(){}.getType());
            this.listContractReviewDCASVisualExamination = gson.fromJson(this.listContractReviewDCASVisualExaminationJSON, new TypeToken<List<ContractReviewDCASVisualExamination>>(){}.getType());
            this.listContractReviewDCASNde = gson.fromJson(this.listContractReviewDCASNdeJSON, new TypeToken<List<ContractReviewDCASNde>>(){}.getType());            
            this.listContractReviewDCASMarking = gson.fromJson(this.listContractReviewDCASMarkingJSON, new TypeToken<List<ContractReviewDCASMarking>>(){}.getType());            
            this.listContractReviewDCASLegalRequirements = gson.fromJson(this.listContractReviewDCASLegalRequirementsJSON, new TypeToken<List<ContractReviewDCASLegalRequirements>>(){}.getType());            
            this.listContractReviewCADDocumentApproval = gson.fromJson(this.listContractReviewCADDocumentApprovalJSON, new TypeToken<List<ContractReviewCADDocumentApproval>>(){}.getType());            

            contractReview.setCreatedDate(new Date());
            contractReview.setTransactionDate(DateUtils.newDateTime(contractReview.getTransactionDate(),true));
            if(enumContractReviewActivity.equals(EnumActivity.ENUM_Activity.UPDATE)){
                _Messg="UPDATE ";
                contractReviewBLL.update(contractReview, listContractReviewSalesQuotation,listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                                     listContractReviewDCASTesting, listContractReviewDCASHydroTest,listContractReviewDCASVisualExamination, listContractReviewDCASNde, listContractReviewDCASMarking,
                                     listContractReviewDCASLegalRequirements,listContractReviewCADDocumentApproval);
            }

            if(enumContractReviewActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                _Messg = "REVISE";
                if(contractReviewBLL.isExist(this.contractReview.getCode())){
                    throw new Exception("Code "+this.contractReview.getCode()+" has been existing in Database!");
                }else{
                    contractReviewBLL.revise(contractReview, listContractReviewSalesQuotation,listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                                     listContractReviewDCASTesting, listContractReviewDCASHydroTest,listContractReviewDCASVisualExamination, listContractReviewDCASNde, listContractReviewDCASMarking,
                                     listContractReviewDCASLegalRequirements,listContractReviewCADDocumentApproval);
                }
                
            }

            if(enumContractReviewActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                _Messg = "SAVE";
                contractReviewBLL.save(enumContractReviewActivity,contractReview, listContractReviewSalesQuotation,listContractReviewValveType, listContractReviewDCASDesign, listContractReviewDCASFireSafeByDesign,
                                     listContractReviewDCASTesting, listContractReviewDCASHydroTest,listContractReviewDCASVisualExamination, listContractReviewDCASNde, listContractReviewDCASMarking,
                                     listContractReviewDCASLegalRequirements,listContractReviewCADDocumentApproval);
            }

            this.message = _Messg + " DATA SUCCESS.<br/>PO No : " + this.contractReview.getCode();

            return SUCCESS;
          }catch (Exception e) {
            e.printStackTrace();
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("contract-review-delete")
    public String delete(){
        String _messg = "";
        try{
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession);     

            _messg = "DELETE ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(contractReviewBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
              
                
            contractReviewBLL.delete(contractReview);
            
            this.message = _messg + "DATA SUCCESS.<br/> POD No : " + this.contractReview.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = _messg + "DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ContractReview getContractReview() {
        return contractReview;
    }

    public void setContractReview(ContractReview contractReview) {
        this.contractReview = contractReview;
    }

    public List<ContractReviewTemp> getListContractReviewTemp() {
        return listContractReviewTemp;
    }

    public void setListContractReviewTemp(List<ContractReviewTemp> listContractReviewTemp) {
        this.listContractReviewTemp = listContractReviewTemp;
    }

    public List<ContractReviewSalesQuotation> getListContractReviewSalesQuotation() {
        return listContractReviewSalesQuotation;
    }

    public void setListContractReviewSalesQuotation(List<ContractReviewSalesQuotation> listContractReviewSalesQuotation) {
        this.listContractReviewSalesQuotation = listContractReviewSalesQuotation;
    }

    public List<ContractReviewValveType> getListContractReviewValveType() {
        return listContractReviewValveType;
    }

    public void setListContractReviewValveType(List<ContractReviewValveType> listContractReviewValveType) {
        this.listContractReviewValveType = listContractReviewValveType;
    }

    public List<ContractReviewDCASDesign> getListContractReviewDCASDesign() {
        return listContractReviewDCASDesign;
    }

    public void setListContractReviewDCASDesign(List<ContractReviewDCASDesign> listContractReviewDCASDesign) {
        this.listContractReviewDCASDesign = listContractReviewDCASDesign;
    }

    public List<ContractReviewDCASFireSafeByDesign> getListContractReviewDCASFireSafeByDesign() {
        return listContractReviewDCASFireSafeByDesign;
    }

    public void setListContractReviewDCASFireSafeByDesign(List<ContractReviewDCASFireSafeByDesign> listContractReviewDCASFireSafeByDesign) {
        this.listContractReviewDCASFireSafeByDesign = listContractReviewDCASFireSafeByDesign;
    }

    public List<ContractReviewDCASTesting> getListContractReviewDCASTesting() {
        return listContractReviewDCASTesting;
    }

    public void setListContractReviewDCASTesting(List<ContractReviewDCASTesting> listContractReviewDCASTesting) {
        this.listContractReviewDCASTesting = listContractReviewDCASTesting;
    }

    public List<ContractReviewDCASHydroTest> getListContractReviewDCASHydroTest() {
        return listContractReviewDCASHydroTest;
    }

    public void setListContractReviewDCASHydroTest(List<ContractReviewDCASHydroTest> listContractReviewDCASHydroTest) {
        this.listContractReviewDCASHydroTest = listContractReviewDCASHydroTest;
    }

    public List<ContractReviewDCASVisualExamination> getListContractReviewDCASVisualExamination() {
        return listContractReviewDCASVisualExamination;
    }

    public void setListContractReviewDCASVisualExamination(List<ContractReviewDCASVisualExamination> listContractReviewDCASVisualExamination) {
        this.listContractReviewDCASVisualExamination = listContractReviewDCASVisualExamination;
    }

    public List<ContractReviewDCASNde> getListContractReviewDCASNde() {
        return listContractReviewDCASNde;
    }

    public void setListContractReviewDCASNde(List<ContractReviewDCASNde> listContractReviewDCASNde) {
        this.listContractReviewDCASNde = listContractReviewDCASNde;
    }

    public List<ContractReviewDCASMarking> getListContractReviewDCASMarking() {
        return listContractReviewDCASMarking;
    }

    public void setListContractReviewDCASMarking(List<ContractReviewDCASMarking> listContractReviewDCASMarking) {
        this.listContractReviewDCASMarking = listContractReviewDCASMarking;
    }

    public List<ContractReviewDCASLegalRequirements> getListContractReviewDCASLegalRequirements() {
        return listContractReviewDCASLegalRequirements;
    }

    public void setListContractReviewDCASLegalRequirements(List<ContractReviewDCASLegalRequirements> listContractReviewDCASLegalRequirements) {
        this.listContractReviewDCASLegalRequirements = listContractReviewDCASLegalRequirements;
    }

    public List<ContractReviewCADDocumentApproval> getListContractReviewCADDocumentApproval() {
        return listContractReviewCADDocumentApproval;
    }

    public void setListContractReviewCADDocumentApproval(List<ContractReviewCADDocumentApproval> listContractReviewCADDocumentApproval) {
        this.listContractReviewCADDocumentApproval = listContractReviewCADDocumentApproval;
    }

    public String getContractReviewSearchCode() {
        return contractReviewSearchCode;
    }

    public void setContractReviewSearchCode(String contractReviewSearchCode) {
        this.contractReviewSearchCode = contractReviewSearchCode;
    }

    public String getContractReviewCustomerSearchCode() {
        return contractReviewCustomerSearchCode;
    }

    public void setContractReviewCustomerSearchCode(String contractReviewCustomerSearchCode) {
        this.contractReviewCustomerSearchCode = contractReviewCustomerSearchCode;
    }

    public String getContractReviewCustomerSearchName() {
        return contractReviewCustomerSearchName;
    }

    public void setContractReviewCustomerSearchName(String contractReviewCustomerSearchName) {
        this.contractReviewCustomerSearchName = contractReviewCustomerSearchName;
    }

    public Date getContractReviewSearchFirstDate() {
        return contractReviewSearchFirstDate;
    }

    public void setContractReviewSearchFirstDate(Date contractReviewSearchFirstDate) {
        this.contractReviewSearchFirstDate = contractReviewSearchFirstDate;
    }

    public Date getContractReviewSearchLastDate() {
        return contractReviewSearchLastDate;
    }

    public void setContractReviewSearchLastDate(Date contractReviewSearchLastDate) {
        this.contractReviewSearchLastDate = contractReviewSearchLastDate;
    }

    public String getListContractReviewSalesQuotationJSON() {
        return listContractReviewSalesQuotationJSON;
    }

    public void setListContractReviewSalesQuotationJSON(String listContractReviewSalesQuotationJSON) {
        this.listContractReviewSalesQuotationJSON = listContractReviewSalesQuotationJSON;
    }

    public String getListContractReviewValveTypeJSON() {
        return listContractReviewValveTypeJSON;
    }

    public void setListContractReviewValveTypeJSON(String listContractReviewValveTypeJSON) {
        this.listContractReviewValveTypeJSON = listContractReviewValveTypeJSON;
    }

    public String getListContractReviewDCASDesignJSON() {
        return listContractReviewDCASDesignJSON;
    }

    public void setListContractReviewDCASDesignJSON(String listContractReviewDCASDesignJSON) {
        this.listContractReviewDCASDesignJSON = listContractReviewDCASDesignJSON;
    }

    public String getListContractReviewDCASFireSafeByDesignJSON() {
        return listContractReviewDCASFireSafeByDesignJSON;
    }

    public void setListContractReviewDCASFireSafeByDesignJSON(String listContractReviewDCASFireSafeByDesignJSON) {
        this.listContractReviewDCASFireSafeByDesignJSON = listContractReviewDCASFireSafeByDesignJSON;
    }

    public String getListContractReviewDCASTestingJSON() {
        return listContractReviewDCASTestingJSON;
    }

    public void setListContractReviewDCASTestingJSON(String listContractReviewDCASTestingJSON) {
        this.listContractReviewDCASTestingJSON = listContractReviewDCASTestingJSON;
    }

    public String getListContractReviewDCASHydroTestJSON() {
        return listContractReviewDCASHydroTestJSON;
    }

    public void setListContractReviewDCASHydroTestJSON(String listContractReviewDCASHydroTestJSON) {
        this.listContractReviewDCASHydroTestJSON = listContractReviewDCASHydroTestJSON;
    }

    public String getListContractReviewDCASVisualExaminationJSON() {
        return listContractReviewDCASVisualExaminationJSON;
    }

    public void setListContractReviewDCASVisualExaminationJSON(String listContractReviewDCASVisualExaminationJSON) {
        this.listContractReviewDCASVisualExaminationJSON = listContractReviewDCASVisualExaminationJSON;
    }

    public String getListContractReviewDCASMarkingJSON() {
        return listContractReviewDCASMarkingJSON;
    }

    public void setListContractReviewDCASMarkingJSON(String listContractReviewDCASMarkingJSON) {
        this.listContractReviewDCASMarkingJSON = listContractReviewDCASMarkingJSON;
    }

    public String getListContractReviewDCASNdeJSON() {
        return listContractReviewDCASNdeJSON;
    }

    public void setListContractReviewDCASNdeJSON(String listContractReviewDCASNdeJSON) {
        this.listContractReviewDCASNdeJSON = listContractReviewDCASNdeJSON;
    }

    public String getListContractReviewDCASLegalRequirementsJSON() {
        return listContractReviewDCASLegalRequirementsJSON;
    }

    public void setListContractReviewDCASLegalRequirementsJSON(String listContractReviewDCASLegalRequirementsJSON) {
        this.listContractReviewDCASLegalRequirementsJSON = listContractReviewDCASLegalRequirementsJSON;
    }

    public String getListContractReviewCADDocumentApprovalJSON() {
        return listContractReviewCADDocumentApprovalJSON;
    }

    public void setListContractReviewCADDocumentApprovalJSON(String listContractReviewCADDocumentApprovalJSON) {
        this.listContractReviewCADDocumentApprovalJSON = listContractReviewCADDocumentApprovalJSON;
    }

    public EnumActivity.ENUM_Activity getEnumContractReviewActivity() {
        return enumContractReviewActivity;
    }

    public void setEnumContractReviewActivity(EnumActivity.ENUM_Activity enumContractReviewActivity) {
        this.enumContractReviewActivity = enumContractReviewActivity;
    }    

    public String getContractReviewSearchValidStatus() {
        return contractReviewSearchValidStatus;
    }

    public void setContractReviewSearchValidStatus(String contractReviewSearchValidStatus) {
        this.contractReviewSearchValidStatus = contractReviewSearchValidStatus;
    }
    
    
    // <editor-fold defaultstate="collapsed" desc="Message Info">
    private boolean error = false;
    private String errorMessage = "";
    private String message = "";

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">
    
    Paging paging = new Paging();
    
    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }
    
    public Integer getRows() {
        return paging.getRows();
    }
    public void setRows(Integer rows) {
        paging.setRows(rows);
    }
    
    public Integer getPage() {
        return paging.getPage();
    }
    public void setPage(Integer page) {
        paging.setPage(page);
    }
    
    public Integer getTotal() {
        return paging.getTotal();
    }
    public void setTotal(Integer total) {
        paging.setTotal(total);
    }
    
    public Integer getRecords() {
        return paging.getRecords();
    }
    public void setRecords(Integer records) {
        paging.setRecords(records);
        
        if (paging.getRecords() > 0 && paging.getRows() > 0)
            paging.setTotal((int) Math.ceil((double) paging.getRecords() / (double) paging.getRows()));
        else
            paging.setTotal(0);
    }
    
    public String getSord() {
        return paging.getSord();
    }
    public void setSord(String sord) {
        paging.setSord(sord);
    }
    
    public String getSidx() {
        return paging.getSidx();
    }
    public void setSidx(String sidx) {
        paging.setSidx(sidx);
    }
    
    public void setSearchField(String searchField) {
        paging.setSearchField(searchField);
    }
    public void setSearchString(String searchString) {
        paging.setSearchString(searchString);
    }
    public void setSearchOper(String searchOper) {
        paging.setSearchOper(searchOper);
    }

    
    // </editor-fold>
}


