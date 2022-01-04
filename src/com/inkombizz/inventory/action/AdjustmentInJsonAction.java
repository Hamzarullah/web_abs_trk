package com.inkombizz.inventory.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AdjustmentInBLL;
import com.inkombizz.utils.DateUtils;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.inventory.model.AdjustmentIn;
import com.inkombizz.inventory.model.AdjustmentInItemDetail;
import com.inkombizz.inventory.model.AdjustmentInItemDetailTemp;
import com.inkombizz.inventory.model.AdjustmentInSerialNoDetail;
import com.inkombizz.inventory.model.AdjustmentInTemp;

import static com.opensymphony.xwork2.Action.SUCCESS;
import java.text.SimpleDateFormat;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;

@Result(type = "json")
public class AdjustmentInJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    private AdjustmentIn adjustmentIn;
    private AdjustmentIn adjustmentInApproval;
    private AdjustmentInTemp adjustmentInTemp;
    private List<AdjustmentIn> listAdjustmentIn;
    private List<AdjustmentInTemp> listAdjustmentInTemp;
    
    private AdjustmentInItemDetail adjustmentInItemDetail;
    private List<AdjustmentInItemDetail> listAdjustmentInItemDetail;
    private List<AdjustmentInItemDetailTemp> listAdjustmentInItemDetailTemp;
    private List<AdjustmentInItemDetail> listAdjustmentInApprovalItemDetail;
    private List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail;
    
    private String listAdjustmentInItemDetailJSON;
    private String listAdjustmentInSerialNoDetailJSON;
    private String listAdjustmentInApprovalItemDetailJSON;
        
    private String adjustmentInSearchCode="";
    private String adjustmentInSearchWarehouseCode="";
    private String adjustmentInSearchWarehouseName="";
    private String adjustmentInSearchRefNo="";
    Date adjustmentInSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    Date adjustmentInSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
        
    private String adjustmentInApprovalSearchCode="";
    private String adjustmentInApprovalSearchWarehouseCode="";
    private String adjustmentInApprovalSearchWarehouseName="";
    private String adjustmentInApprovalSearchRefNo="";
    private String adjustmentInApprovalSearchRemark="";
    private String adjustmentInApprovalSearchApprovalStatus="PENDING";
    Date adjustmentInApprovalSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    Date adjustmentInApprovalSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    
    
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("adjustment-in-data")
    public String findData() {
        try {
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);
            
            ListPaging<AdjustmentInTemp> listPaging = adjustmentInBLL.findData(paging,adjustmentInSearchCode,adjustmentInSearchWarehouseCode,adjustmentInSearchWarehouseName,adjustmentInSearchRefNo,adjustmentInSearchFirstDate,adjustmentInSearchLastDate);

            listAdjustmentInTemp = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-in-approval-data")
    public String findDataApproval(){
        try{
            
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);         
            
            ListPaging<AdjustmentInTemp> listPaging = adjustmentInBLL.findDataApproval(paging,adjustmentInApprovalSearchCode,adjustmentInApprovalSearchWarehouseCode,adjustmentInApprovalSearchWarehouseName,adjustmentInApprovalSearchRefNo,adjustmentInApprovalSearchRemark,adjustmentInApprovalSearchApprovalStatus,adjustmentInApprovalSearchFirstDate,adjustmentInApprovalSearchLastDate);
            
            listAdjustmentInTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-in-item-detail-data")
    public String findDataItemDetail(){
        try {
            
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);
            List<AdjustmentInItemDetail> list = adjustmentInBLL.findDataItemDetail(this.adjustmentIn.getCode());

            listAdjustmentInItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-in-serial-no-detail-data")
    public String findDataSerialNoDetail(){
        try {
            
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);
            List<AdjustmentInSerialNoDetail> list = adjustmentInBLL.findDataSerialNoDetail(this.adjustmentInItemDetail.getCode());

            listAdjustmentInSerialNoDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-in-serial-no-detail-bulk-data")
    public String findBulkDataSerialNoDetail(){
        try {
            
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);
            Gson gson = new Gson();
            this.listAdjustmentInItemDetail = gson.fromJson(this.listAdjustmentInItemDetailJSON, new TypeToken<List<AdjustmentInItemDetail>>(){}.getType());
            List<AdjustmentInSerialNoDetail> list = adjustmentInBLL.findBulkDataSerialNoDetail(this.listAdjustmentInItemDetail);

            listAdjustmentInSerialNoDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
   
    @Action("adjustment-in-save")
    public String save() {
        try {
                AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);

                Gson gson = new Gson();
                Gson bson = new Gson();
                bson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listAdjustmentInItemDetail = gson.fromJson(this.listAdjustmentInItemDetailJSON, new TypeToken<List<AdjustmentInItemDetail>>(){}.getType());
                this.listAdjustmentInSerialNoDetail = bson.fromJson(this.listAdjustmentInSerialNoDetailJSON, new TypeToken<List<AdjustmentInSerialNoDetail>>(){}.getType());
                
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
                
                adjustmentIn.setTransactionDate(DateUtils.newDateTime(adjustmentIn.getTransactionDate(),true));
                    
                Date createdDate = sdf.parse(adjustmentIn.getCreatedDateTemp());
                Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
                adjustmentIn.setCreatedDate(createdDatetime);
                
                if(adjustmentInBLL.isExist(this.adjustmentIn.getCode())) {
                    adjustmentInBLL.update(adjustmentIn, listAdjustmentInItemDetail, listAdjustmentInSerialNoDetail);
                    this.message = "UPDATE DATA SUCCESS.<br/>ADJ-IN Code : " + this.adjustmentIn.getCode(); 
                }else{  
                    adjustmentInBLL.save(adjustmentIn, listAdjustmentInItemDetail, listAdjustmentInSerialNoDetail);
                    this.message = "SAVE DATA SUCCESS.<br/>ADJ-IN Code : " + this.adjustmentIn.getCode();
                }

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-in-save-approval-data")
    public String approval() {
        try {
                AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);

                Gson gson = new Gson();
                Gson bson = new Gson();
                bson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listAdjustmentInItemDetail = gson.fromJson(this.listAdjustmentInItemDetailJSON, new TypeToken<List<AdjustmentInItemDetail>>(){}.getType());
                this.listAdjustmentInSerialNoDetail = bson.fromJson(this.listAdjustmentInSerialNoDetailJSON, new TypeToken<List<AdjustmentInSerialNoDetail>>(){}.getType());

                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

                Date transactionDateTemp = sdf.parse(adjustmentInApproval.getTransactionDateTemp());
                Date transactionDate = new java.sql.Timestamp(transactionDateTemp.getTime());
                adjustmentInApproval.setTransactionDate(transactionDate);
                
                Date updatedDateTemp = sdf.parse(adjustmentInApproval.getUpdatedDateTemp());
                Date updatedDate = new java.sql.Timestamp(updatedDateTemp.getTime());
                adjustmentInApproval.setUpdatedDate(updatedDate);
                
                Date createdDateTemp = sdf.parse(adjustmentInApproval.getCreatedDateTemp());
                Date createdDate = new java.sql.Timestamp(createdDateTemp.getTime());
                adjustmentInApproval.setCreatedDate(createdDate);
                
                adjustmentInBLL.approval(adjustmentInApproval, listAdjustmentInItemDetail,listAdjustmentInSerialNoDetail);
                this.message = "APPROVAL DATA SUCCESS.<br/>Code : " + this.adjustmentInApproval.getCode();

                return SUCCESS;

        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.MESSAGE : <br/><br/><br/>" + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("adjustment-in-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(adjustmentInBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            adjustmentInBLL.delete(this.adjustmentIn.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>ADJ-IN Code : " + this.adjustmentIn.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-in-confirmation")
    public String confirmApproveStatus(){
        try{
            AdjustmentInBLL adjustmentInBLL = new AdjustmentInBLL(hbmSession);
            
            if(adjustmentInBLL.isApproved(this.adjustmentIn.getCode())){
                this.error = true;
                this.errorMessage = "Unable to Manipulate Data!<br/>this transaction ["+this.adjustmentIn.getCode()+"] has been Approve!";
                return SUCCESS;
            }
            
            return SUCCESS;
        }
        catch(Exception ex){
            this.error = true;
            this.errorMessage = "ERROR DATA FAILED.<br/> MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public AdjustmentIn getAdjustmentIn() {
        return adjustmentIn;
    }

    public void setAdjustmentIn(AdjustmentIn adjustmentIn) {
        this.adjustmentIn = adjustmentIn;
    }

    public AdjustmentIn getAdjustmentInApproval() {
        return adjustmentInApproval;
    }

    public void setAdjustmentInApproval(AdjustmentIn adjustmentInApproval) {
        this.adjustmentInApproval = adjustmentInApproval;
    }

    public AdjustmentInTemp getAdjustmentInTemp() {
        return adjustmentInTemp;
    }

    public void setAdjustmentInTemp(AdjustmentInTemp adjustmentInTemp) {
        this.adjustmentInTemp = adjustmentInTemp;
    }

    public List<AdjustmentIn> getListAdjustmentIn() {
        return listAdjustmentIn;
    }

    public void setListAdjustmentIn(List<AdjustmentIn> listAdjustmentIn) {
        this.listAdjustmentIn = listAdjustmentIn;
    }

    public List<AdjustmentInTemp> getListAdjustmentInTemp() {
        return listAdjustmentInTemp;
    }

    public void setListAdjustmentInTemp(List<AdjustmentInTemp> listAdjustmentInTemp) {
        this.listAdjustmentInTemp = listAdjustmentInTemp;
    }

    public AdjustmentInItemDetail getAdjustmentInItemDetail() {
        return adjustmentInItemDetail;
    }

    public void setAdjustmentInItemDetail(AdjustmentInItemDetail adjustmentInItemDetail) {
        this.adjustmentInItemDetail = adjustmentInItemDetail;
    }

    public List<AdjustmentInItemDetail> getListAdjustmentInItemDetail() {
        return listAdjustmentInItemDetail;
    }

    public void setListAdjustmentInItemDetail(List<AdjustmentInItemDetail> listAdjustmentInItemDetail) {
        this.listAdjustmentInItemDetail = listAdjustmentInItemDetail;
    }

    public List<AdjustmentInItemDetailTemp> getListAdjustmentInItemDetailTemp() {
        return listAdjustmentInItemDetailTemp;
    }

    public void setListAdjustmentInItemDetailTemp(List<AdjustmentInItemDetailTemp> listAdjustmentInItemDetailTemp) {
        this.listAdjustmentInItemDetailTemp = listAdjustmentInItemDetailTemp;
    }

    public List<AdjustmentInItemDetail> getListAdjustmentInApprovalItemDetail() {
        return listAdjustmentInApprovalItemDetail;
    }

    public void setListAdjustmentInApprovalItemDetail(List<AdjustmentInItemDetail> listAdjustmentInApprovalItemDetail) {
        this.listAdjustmentInApprovalItemDetail = listAdjustmentInApprovalItemDetail;
    }

    public String getListAdjustmentInItemDetailJSON() {
        return listAdjustmentInItemDetailJSON;
    }

    public void setListAdjustmentInItemDetailJSON(String listAdjustmentInItemDetailJSON) {
        this.listAdjustmentInItemDetailJSON = listAdjustmentInItemDetailJSON;
    }

    public String getListAdjustmentInSerialNoDetailJSON() {
        return listAdjustmentInSerialNoDetailJSON;
    }

    public void setListAdjustmentInSerialNoDetailJSON(String listAdjustmentInSerialNoDetailJSON) {
        this.listAdjustmentInSerialNoDetailJSON = listAdjustmentInSerialNoDetailJSON;
    }

    public String getListAdjustmentInApprovalItemDetailJSON() {
        return listAdjustmentInApprovalItemDetailJSON;
    }

    public void setListAdjustmentInApprovalItemDetailJSON(String listAdjustmentInApprovalItemDetailJSON) {
        this.listAdjustmentInApprovalItemDetailJSON = listAdjustmentInApprovalItemDetailJSON;
    }

    public String getAdjustmentInSearchCode() {
        return adjustmentInSearchCode;
    }

    public void setAdjustmentInSearchCode(String adjustmentInSearchCode) {
        this.adjustmentInSearchCode = adjustmentInSearchCode;
    }

    public String getAdjustmentInSearchWarehouseCode() {
        return adjustmentInSearchWarehouseCode;
    }

    public void setAdjustmentInSearchWarehouseCode(String adjustmentInSearchWarehouseCode) {
        this.adjustmentInSearchWarehouseCode = adjustmentInSearchWarehouseCode;
    }

    public String getAdjustmentInSearchWarehouseName() {
        return adjustmentInSearchWarehouseName;
    }

    public void setAdjustmentInSearchWarehouseName(String adjustmentInSearchWarehouseName) {
        this.adjustmentInSearchWarehouseName = adjustmentInSearchWarehouseName;
    }

    public String getAdjustmentInSearchRefNo() {
        return adjustmentInSearchRefNo;
    }

    public void setAdjustmentInSearchRefNo(String adjustmentInSearchRefNo) {
        this.adjustmentInSearchRefNo = adjustmentInSearchRefNo;
    }

    public Date getAdjustmentInSearchFirstDate() {
        return adjustmentInSearchFirstDate;
    }

    public void setAdjustmentInSearchFirstDate(Date adjustmentInSearchFirstDate) {
        this.adjustmentInSearchFirstDate = adjustmentInSearchFirstDate;
    }

    public Date getAdjustmentInSearchLastDate() {
        return adjustmentInSearchLastDate;
    }

    public void setAdjustmentInSearchLastDate(Date adjustmentInSearchLastDate) {
        this.adjustmentInSearchLastDate = adjustmentInSearchLastDate;
    }

    public String getAdjustmentInApprovalSearchCode() {
        return adjustmentInApprovalSearchCode;
    }

    public void setAdjustmentInApprovalSearchCode(String adjustmentInApprovalSearchCode) {
        this.adjustmentInApprovalSearchCode = adjustmentInApprovalSearchCode;
    }

    public String getAdjustmentInApprovalSearchWarehouseCode() {
        return adjustmentInApprovalSearchWarehouseCode;
    }

    public void setAdjustmentInApprovalSearchWarehouseCode(String adjustmentInApprovalSearchWarehouseCode) {
        this.adjustmentInApprovalSearchWarehouseCode = adjustmentInApprovalSearchWarehouseCode;
    }

    public String getAdjustmentInApprovalSearchWarehouseName() {
        return adjustmentInApprovalSearchWarehouseName;
    }

    public void setAdjustmentInApprovalSearchWarehouseName(String adjustmentInApprovalSearchWarehouseName) {
        this.adjustmentInApprovalSearchWarehouseName = adjustmentInApprovalSearchWarehouseName;
    }

    public String getAdjustmentInApprovalSearchRefNo() {
        return adjustmentInApprovalSearchRefNo;
    }

    public void setAdjustmentInApprovalSearchRefNo(String adjustmentInApprovalSearchRefNo) {
        this.adjustmentInApprovalSearchRefNo = adjustmentInApprovalSearchRefNo;
    }

    public String getAdjustmentInApprovalSearchRemark() {
        return adjustmentInApprovalSearchRemark;
    }

    public void setAdjustmentInApprovalSearchRemark(String adjustmentInApprovalSearchRemark) {
        this.adjustmentInApprovalSearchRemark = adjustmentInApprovalSearchRemark;
    }

    public String getAdjustmentInApprovalSearchApprovalStatus() {
        return adjustmentInApprovalSearchApprovalStatus;
    }

    public void setAdjustmentInApprovalSearchApprovalStatus(String adjustmentInApprovalSearchApprovalStatus) {
        this.adjustmentInApprovalSearchApprovalStatus = adjustmentInApprovalSearchApprovalStatus;
    }

    public Date getAdjustmentInApprovalSearchFirstDate() {
        return adjustmentInApprovalSearchFirstDate;
    }

    public void setAdjustmentInApprovalSearchFirstDate(Date adjustmentInApprovalSearchFirstDate) {
        this.adjustmentInApprovalSearchFirstDate = adjustmentInApprovalSearchFirstDate;
    }

    public Date getAdjustmentInApprovalSearchLastDate() {
        return adjustmentInApprovalSearchLastDate;
    }

    public void setAdjustmentInApprovalSearchLastDate(Date adjustmentInApprovalSearchLastDate) {
        this.adjustmentInApprovalSearchLastDate = adjustmentInApprovalSearchLastDate;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }

    public List<AdjustmentInSerialNoDetail> getListAdjustmentInSerialNoDetail() {
        return listAdjustmentInSerialNoDetail;
    }

    public void setListAdjustmentInSerialNoDetail(List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail) {
        this.listAdjustmentInSerialNoDetail = listAdjustmentInSerialNoDetail;
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