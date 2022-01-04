
package com.inkombizz.master.action;


import com.inkombizz.action.BaseSession;
import com.inkombizz.action.ProgramSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.BranchBLL;
import com.inkombizz.master.bll.GlobalBLL;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.BranchTemp;
import com.inkombizz.master.model.Global;
import static com.opensymphony.xwork2.Action.SUCCESS;

@Result(type="json")
public class BranchJsonAction extends ActionSupport{
    
    private static final long serialVersionUID=1L;
    
    protected HBMSession hbmSession=new HBMSession();
    
    private ProgramSession prgSession = new ProgramSession();
    
    private Branch branch;
    private BranchTemp branchTemp;
    private List <BranchTemp> listBranchTemp;
    private String branchSearchCode = "";
    private String branchSearchName = "";
    private String branchSearchCodeConcat = "";
    private String branchSearchActiveStatus = "true";
    private String actionAuthority="";
    private List<Global> lstGlobal;
    private List <BranchTemp> listBranchCustomerDepositTypeTemp;
    
    @Override
    public String execute(){
        try{
            return findData();
        }
        catch(Exception Ex){
            return SUCCESS;
        }
    }
    
    @Action("branch-data")
    public String findData() {
        try {
            BranchBLL branchBLL = new BranchBLL(hbmSession);
            ListPaging <BranchTemp> listPaging = branchBLL.findData(paging,branchSearchCode,branchSearchName,branchSearchActiveStatus);
            
            listBranchTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("branch-get-data")
    public String findData1() {
        try {
            BranchBLL branchBLL = new BranchBLL(hbmSession);
            this.branchTemp = branchBLL.findData(this.branch.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("branch-get")
    public String findData2() {
        try {
            BranchBLL branchBLL = new BranchBLL(hbmSession);
            this.branchTemp = branchBLL.findData(this.branch.getCode(),this.branch.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("branch-authority")
    public String branchAuthority(){
        try{
            
            BranchBLL branchBLL = new BranchBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(branchBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(branchBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(branchBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                
            }
            
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("branch-search-data-with-array")
    public String polulateSearchDataWithArray(){
        try{
            
            BranchBLL branchBLL = new BranchBLL(hbmSession);
            ListPaging<BranchTemp> listPaging = branchBLL.polulateSearchDataWithArray(branchSearchCode, branchSearchName, branchSearchCodeConcat, paging); 
            
            listBranchTemp=listPaging.getList();
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("branch-save")
    public String save() {
        try {
            BranchBLL branchBLL = new BranchBLL(hbmSession);
           
            if(branchBLL.isExist(this.branch.getCode())){
                this.errorMessage = "Code "+this.branch.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                branchBLL.save(this.branch);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.branch.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("branch-update")
    public String update() {
        try {
            BranchBLL branchBLL = new BranchBLL(hbmSession);
            
            branchBLL.update(this.branch);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.branch.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("branch-delete")
    public String delete() {
        try {
            BranchBLL branchBLL = new BranchBLL(hbmSession);
//            GlobalBLL globalBLL=new GlobalBLL(hbmSession);
            
//            lstGlobal=globalBLL.usedBranch(this.branch.getCode());
//            
//            if(lstGlobal.isEmpty()){
//                branchBLL.delete(this.branch.getCode());
//                this.message = "DELETE DATA SUCCESS. \n Code : " + this.branch.getCode();
//            }else{
//                this.message = "Code: "+this.branch.getCode() + " Is Used By "+lstGlobal.get(0).getUsedName()+" [ Code: "+ lstGlobal.get(0).getUsedCode() +" ]!";
//            }
      
            branchBLL.delete(this.branch.getCode());
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.branch.getCode();
                
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("branch-get-min")
    public String populateDataSupplierMin() {
        try {
            BranchBLL branchBLL=new BranchBLL(hbmSession);
            this.branchTemp = branchBLL.getMin();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("branch-get-max")
    public String populateDataSupplierMax() {
        try {
            BranchBLL branchBLL=new BranchBLL(hbmSession);
            this.branchTemp = branchBLL.getMax();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("branch-get-all")
    public String findAllBranch(){
        try{
            
            BranchBLL branchBLL = new BranchBLL(hbmSession);
            List<BranchTemp> list = branchBLL.findAllBranchForDeposit(); 
            
            listBranchCustomerDepositTypeTemp=list;
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ProgramSession getPrgSession() {
        return prgSession;
    }

    public void setPrgSession(ProgramSession prgSession) {
        this.prgSession = prgSession;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public BranchTemp getBranchTemp() {
        return branchTemp;
    }

    public void setBranchTemp(BranchTemp branchTemp) {
        this.branchTemp = branchTemp;
    }

    public List<BranchTemp> getListBranchTemp() {
        return listBranchTemp;
    }

    public void setListBranchTemp(List<BranchTemp> listBranchTemp) {
        this.listBranchTemp = listBranchTemp;
    }

    public String getBranchSearchCode() {
        return branchSearchCode;
    }

    public void setBranchSearchCode(String branchSearchCode) {
        this.branchSearchCode = branchSearchCode;
    }

    public String getBranchSearchName() {
        return branchSearchName;
    }

    public void setBranchSearchName(String branchSearchName) {
        this.branchSearchName = branchSearchName;
    }

    public String getBranchSearchActiveStatus() {
        return branchSearchActiveStatus;
    }

    public void setBranchSearchActiveStatus(String branchSearchActiveStatus) {
        this.branchSearchActiveStatus = branchSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public List<Global> getLstGlobal() {
        return lstGlobal;
    }

    public void setLstGlobal(List<Global> lstGlobal) {
        this.lstGlobal = lstGlobal;
    }

    public String getBranchSearchCodeConcat() {
        return branchSearchCodeConcat;
    }

    public void setBranchSearchCodeConcat(String branchSearchCodeConcat) {
        this.branchSearchCodeConcat = branchSearchCodeConcat;
    }

    public List<BranchTemp> getListBranchCustomerDepositTypeTemp() {
        return listBranchCustomerDepositTypeTemp;
    }

    public void setListBranchCustomerDepositTypeTemp(List<BranchTemp> listBranchCustomerDepositTypeTemp) {
        this.listBranchCustomerDepositTypeTemp = listBranchCustomerDepositTypeTemp;
    }
    
    
    
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">
    
    Paging paging=new Paging();

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
    
}
