package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import static com.opensymphony.xwork2.Action.SUCCESS;

import com.inkombizz.master.bll.PurchaseDestinationBLL;
import com.inkombizz.master.model.PurchaseDestination;
import com.inkombizz.master.model.PurchaseDestinationTemp;


@Result(type = "json")
public class PurchaseDestinationJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    private PurchaseDestination purchaseDestination;
    private PurchaseDestinationTemp purchaseDestinationTemp;
    private List <PurchaseDestinationTemp> listPurchaseDestinationTemp;
    private String purchaseDestinationSearchCode = "";
    private String purchaseDestinationSearchName = "";
    private String purchaseDestinationSearchActiveStatus="true";
    private String purchaseDestinationSearchBillTo="";
    private String purchaseDestinationSearchShipTo="";
    private String actionAuthority="";
    private String code="";
    private String activeStatus="";
    private String statusBillShip="";
    
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("purchase-destination-data")
    public String findData() {
        try {
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);
            ListPaging <PurchaseDestinationTemp> listPaging = purchaseDestinationBLL.findData(purchaseDestinationSearchCode,purchaseDestinationSearchName,purchaseDestinationSearchActiveStatus,paging);
            
            listPurchaseDestinationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-destination-search-data")
    public String findDataPD() {
        try {
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);
            ListPaging <PurchaseDestinationTemp> listPaging = purchaseDestinationBLL.findDataPD(purchaseDestinationSearchCode,purchaseDestinationSearchName,purchaseDestinationSearchActiveStatus,purchaseDestinationSearchBillTo,purchaseDestinationSearchShipTo,paging);
            
            listPurchaseDestinationTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-destination-get-data")
    public String findData1() {
        try {
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);
            this.purchaseDestinationTemp = purchaseDestinationBLL.findData(this.purchaseDestination.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-destination-get-bill-and-ship")
    public String findDataBillAndShip() {
        try {
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);

            this.purchaseDestinationTemp = purchaseDestinationBLL.findDataBillAndShip(code, activeStatus, statusBillShip);
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-destination-get")
    public String findData2() {
        try {
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);
            this.purchaseDestinationTemp = purchaseDestinationBLL.findData(this.purchaseDestination.getCode(),this.purchaseDestination.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-destination-authority")
    public String purchaseDestinationAuthority(){
        try{
            
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseDestinationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseDestinationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(purchaseDestinationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("purchase-destination-save")
    public String save() {
        try {
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);
            
            purchaseDestination.setInActiveDate(commonFunction.setDateTime(purchaseDestinationTemp.getInActiveDateTemp()));
            purchaseDestination.setCreatedDate(commonFunction.setDateTime(purchaseDestinationTemp.getCreatedDateTemp()));
            
            if(purchaseDestinationBLL.isExist(this.purchaseDestination.getCode())){
                this.errorMessage = "CODE "+this.purchaseDestination.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                purchaseDestinationBLL.save(this.purchaseDestination,this.purchaseDestinationTemp);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.purchaseDestination.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-destination-update")
    public String update() {
        try {
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);
            
            purchaseDestination.setInActiveDate(commonFunction.setDateTime(purchaseDestinationTemp.getInActiveDateTemp()));
            purchaseDestination.setCreatedDate(commonFunction.setDateTime(purchaseDestinationTemp.getCreatedDateTemp()));
            purchaseDestinationBLL.update(this.purchaseDestination,this.purchaseDestinationTemp);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.purchaseDestination.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("purchase-destination-delete")
    public String delete() {
        try {
            PurchaseDestinationBLL purchaseDestinationBLL = new PurchaseDestinationBLL(hbmSession);
//            boolean check=false;// = purchaseDestinationBLL.isExistToDelete(this.purchaseDestination.getCode());
//            if(check == true){
//                this.message = "CODE "+this.purchaseDestination.getCode() + " : IS READY BE USE...!!!  ";
//            }else{
                purchaseDestinationBLL.delete(this.purchaseDestination.getCode());
                
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.purchaseDestination.getCode();
//            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public PurchaseDestination getPurchaseDestination() {
        return purchaseDestination;
    }

    public void setPurchaseDestination(PurchaseDestination purchaseDestination) {
        this.purchaseDestination = purchaseDestination;
    }

    public PurchaseDestinationTemp getPurchaseDestinationTemp() {
        return purchaseDestinationTemp;
    }

    public void setPurchaseDestinationTemp(PurchaseDestinationTemp purchaseDestinationTemp) {
        this.purchaseDestinationTemp = purchaseDestinationTemp;
    }

    public List<PurchaseDestinationTemp> getListPurchaseDestinationTemp() {
        return listPurchaseDestinationTemp;
    }

    public void setListPurchaseDestinationTemp(List<PurchaseDestinationTemp> listPurchaseDestinationTemp) {
        this.listPurchaseDestinationTemp = listPurchaseDestinationTemp;
    }

    public String getPurchaseDestinationSearchCode() {
        return purchaseDestinationSearchCode;
    }

    public void setPurchaseDestinationSearchCode(String purchaseDestinationSearchCode) {
        this.purchaseDestinationSearchCode = purchaseDestinationSearchCode;
    }

    public String getPurchaseDestinationSearchName() {
        return purchaseDestinationSearchName;
    }

    public void setPurchaseDestinationSearchName(String purchaseDestinationSearchName) {
        this.purchaseDestinationSearchName = purchaseDestinationSearchName;
    }

    public String getPurchaseDestinationSearchActiveStatus() {
        return purchaseDestinationSearchActiveStatus;
    }

    public void setPurchaseDestinationSearchActiveStatus(String purchaseDestinationSearchActiveStatus) {
        this.purchaseDestinationSearchActiveStatus = purchaseDestinationSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public String getPurchaseDestinationSearchBillTo() {
        return purchaseDestinationSearchBillTo;
    }

    public void setPurchaseDestinationSearchBillTo(String purchaseDestinationSearchBillTo) {
        this.purchaseDestinationSearchBillTo = purchaseDestinationSearchBillTo;
    }

    public String getPurchaseDestinationSearchShipTo() {
        return purchaseDestinationSearchShipTo;
    }

    public void setPurchaseDestinationSearchShipTo(String purchaseDestinationSearchShipTo) {
        this.purchaseDestinationSearchShipTo = purchaseDestinationSearchShipTo;
    }

    public String getActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(String activeStatus) {
        this.activeStatus = activeStatus;
    }

    public String getStatusBillShip() {
        return statusBillShip;
    }

    public void setStatusBillShip(String statusBillShip) {
        this.statusBillShip = statusBillShip;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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