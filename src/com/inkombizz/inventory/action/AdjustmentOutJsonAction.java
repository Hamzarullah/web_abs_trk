
package com.inkombizz.inventory.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.AdjustmentOutBLL;
import com.inkombizz.inventory.model.AdjustmentOut;
import com.inkombizz.inventory.model.AdjustmentOutItemDetail;
import com.inkombizz.inventory.model.AdjustmentOutSerialNoDetail;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;


@Result(type = "json")
public class AdjustmentOutJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private AdjustmentOut adjustmentOut=new AdjustmentOut();
    private AdjustmentOut adjustmentOutApproval=new AdjustmentOut();
    private AdjustmentOutItemDetail adjustmentOutItemDetail;
    
    private List<AdjustmentOut> listAdjustmentOut;
    private List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail;
    private List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail;
    
//    private List<SerialNoDetail> listSerialNoDetail;
//    private String listSerialNoDetailJSON;
    
    private String listAdjustmentOutItemDetailJSON;
    private String listAdjustmentOutSerialNoDetailJSON;
    private String listAdjustmentOutApprovalItemDetailJSON;
    private String listAdjustmentOutApprovalSerialNoDetailJSON;
        
    //private ArrayList listItemCode;
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    

    @Action("adjustment-out-data")
    public String findData() {
        try {
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);
            
            ListPaging<AdjustmentOut> listPaging = adjustmentOutBLL.findData(paging,this.adjustmentOut);

            listAdjustmentOut = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-out-approval-data")
    public String findDataApproval(){
        try{
            
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);         
            
            ListPaging<AdjustmentOut> listPaging = adjustmentOutBLL.findDataApproval(paging,adjustmentOutApproval);
            
            listAdjustmentOut = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-out-item-detail-data")
    public String findDataItemDetail(){
        try {
            
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);
            List<AdjustmentOutItemDetail> list = adjustmentOutBLL.findDataItemDetail(this.adjustmentOut.getCode());

            listAdjustmentOutItemDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-out-serial-no-detail-data")
    public String findDataSerialNoDetail(){
        try {
            
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);
            List<AdjustmentOutSerialNoDetail> list = adjustmentOutBLL.findDataSerialNoDetail(this.adjustmentOut.getCode());

            listAdjustmentOutSerialNoDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-out-serial-no-detail-bulk-data")
    public String findBulkDataSerialNoDetail(){
        try {
            
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);
            Gson gson = new Gson();
            this.listAdjustmentOutItemDetail = gson.fromJson(this.listAdjustmentOutItemDetailJSON, new TypeToken<List<AdjustmentOutItemDetail>>(){}.getType());
            List<AdjustmentOutSerialNoDetail> list = adjustmentOutBLL.findBulkDataSerialNoDetail(this.listAdjustmentOutItemDetail);

            listAdjustmentOutSerialNoDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
        
   
    @Action("adjustment-out-save")
    public String save() {
        try {
                AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);

                Gson gson = new Gson();
                Gson bson = new Gson();
                bson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listAdjustmentOutItemDetail = gson.fromJson(this.listAdjustmentOutItemDetailJSON, new TypeToken<List<AdjustmentOutItemDetail>>(){}.getType());
                this.listAdjustmentOutSerialNoDetail = bson.fromJson(this.listAdjustmentOutSerialNoDetailJSON, new TypeToken<List<AdjustmentOutSerialNoDetail>>(){}.getType());

                
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

                adjustmentOut.setTransactionDate(DateUtils.newDateTime(adjustmentOut.getTransactionDate(),true));
                
                Date createdDate = sdf.parse(adjustmentOut.getCreatedDateTemp());
                Date createdDatetime = new java.sql.Timestamp(createdDate.getTime());
                adjustmentOut.setCreatedDate(createdDatetime);
                
                if(adjustmentOutBLL.isExist(this.adjustmentOut.getCode())) {
                    adjustmentOutBLL.update(adjustmentOut, listAdjustmentOutItemDetail,listAdjustmentOutSerialNoDetail);
                    this.message = "UPDATE DATA SUCCESS.<br/>Code : " + this.adjustmentOut.getCode(); 
                }else{
                    
                    adjustmentOutBLL.save(adjustmentOut, listAdjustmentOutItemDetail,listAdjustmentOutSerialNoDetail);
                    this.message = "SAVE DATA SUCCESS.<br/>Code : " + this.adjustmentOut.getCode();
                }


                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("adjustment-out-save-approval-data")
    public String approval() {
        try {
                AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);

                Gson gson = new Gson();
                Gson bson = new Gson();
                bson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listAdjustmentOutItemDetail = gson.fromJson(this.listAdjustmentOutItemDetailJSON, new TypeToken<List<AdjustmentOutItemDetail>>(){}.getType());
                this.listAdjustmentOutSerialNoDetail = bson.fromJson(this.listAdjustmentOutSerialNoDetailJSON, new TypeToken<List<AdjustmentOutSerialNoDetail>>(){}.getType());

                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);

                Date transactionDateTemp = sdf.parse(adjustmentOutApproval.getTransactionDateTemp());
                Date transactionDate = new java.sql.Timestamp(transactionDateTemp.getTime());
                adjustmentOutApproval.setTransactionDate(transactionDate);
                
                Date updatedDateTemp = sdf.parse(adjustmentOutApproval.getUpdatedDateTemp());
                Date updatedDate = new java.sql.Timestamp(updatedDateTemp.getTime());
                adjustmentOutApproval.setUpdatedDate(updatedDate);
                
                Date createdDateTemp = sdf.parse(adjustmentOutApproval.getCreatedDateTemp());
                Date createdDate = new java.sql.Timestamp(createdDateTemp.getTime());
                adjustmentOutApproval.setCreatedDate(createdDate);
                
                adjustmentOutBLL.approval(adjustmentOutApproval, listAdjustmentOutItemDetail,listAdjustmentOutSerialNoDetail);
                this.message = "APPROVAL DATA SUCCESS.<br/>Code : " + this.adjustmentOutApproval.getCode();

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/> MESSAGE : <br/>" + ex.getMessage();
            return SUCCESS;
        }
    }

    @Action("adjustment-out-delete")
    public String delete(){
        String _messg = "";
        try{
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);
    
            if (!BaseSession.loadProgramSession().hasAuthority(adjustmentOutBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            adjustmentOutBLL.delete(this.adjustmentOut.getCode());
            
            this.message = _messg + "DATA SUCCESS. \n IOT No : " + this.adjustmentOut.getCode();
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            this.error = true;
            this.errorMessage = _messg + "DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("adjustment-out-confirmation")
    public String confirmApproveStatus(){
        try{
            AdjustmentOutBLL adjustmentOutBLL = new AdjustmentOutBLL(hbmSession);
            
            if(adjustmentOutBLL.isApproved(this.adjustmentOut.getCode())){
                this.error = true;
                this.errorMessage = "Unable to Manipulate Data!<br/>this transaction ["+this.adjustmentOut.getCode()+"] has been Approve!";
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

    public AdjustmentOut getAdjustmentOut() {
        return adjustmentOut;
    }

    public void setAdjustmentOut(AdjustmentOut adjustmentOut) {
        this.adjustmentOut = adjustmentOut;
    }

    public AdjustmentOut getAdjustmentOutApproval() {
        return adjustmentOutApproval;
    }

    public void setAdjustmentOutApproval(AdjustmentOut adjustmentOutApproval) {
        this.adjustmentOutApproval = adjustmentOutApproval;
    }

    public AdjustmentOutItemDetail getAdjustmentOutItemDetail() {
        return adjustmentOutItemDetail;
    }

    public void setAdjustmentOutItemDetail(AdjustmentOutItemDetail adjustmentOutItemDetail) {
        this.adjustmentOutItemDetail = adjustmentOutItemDetail;
    }

    public List<AdjustmentOut> getListAdjustmentOut() {
        return listAdjustmentOut;
    }

    public void setListAdjustmentOut(List<AdjustmentOut> listAdjustmentOut) {
        this.listAdjustmentOut = listAdjustmentOut;
    }

    public List<AdjustmentOutItemDetail> getListAdjustmentOutItemDetail() {
        return listAdjustmentOutItemDetail;
    }

    public void setListAdjustmentOutItemDetail(List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail) {
        this.listAdjustmentOutItemDetail = listAdjustmentOutItemDetail;
    }

    public List<AdjustmentOutSerialNoDetail> getListAdjustmentOutSerialNoDetail() {
        return listAdjustmentOutSerialNoDetail;
    }

    public void setListAdjustmentOutSerialNoDetail(List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail) {
        this.listAdjustmentOutSerialNoDetail = listAdjustmentOutSerialNoDetail;
    }

    public String getListAdjustmentOutItemDetailJSON() {
        return listAdjustmentOutItemDetailJSON;
    }

    public void setListAdjustmentOutItemDetailJSON(String listAdjustmentOutItemDetailJSON) {
        this.listAdjustmentOutItemDetailJSON = listAdjustmentOutItemDetailJSON;
    }

    public String getListAdjustmentOutSerialNoDetailJSON() {
        return listAdjustmentOutSerialNoDetailJSON;
    }

    public void setListAdjustmentOutSerialNoDetailJSON(String listAdjustmentOutSerialNoDetailJSON) {
        this.listAdjustmentOutSerialNoDetailJSON = listAdjustmentOutSerialNoDetailJSON;
    }

    public String getListAdjustmentOutApprovalItemDetailJSON() {
        return listAdjustmentOutApprovalItemDetailJSON;
    }

    public void setListAdjustmentOutApprovalItemDetailJSON(String listAdjustmentOutApprovalItemDetailJSON) {
        this.listAdjustmentOutApprovalItemDetailJSON = listAdjustmentOutApprovalItemDetailJSON;
    }

    public String getListAdjustmentOutApprovalSerialNoDetailJSON() {
        return listAdjustmentOutApprovalSerialNoDetailJSON;
    }

    public void setListAdjustmentOutApprovalSerialNoDetailJSON(String listAdjustmentOutApprovalSerialNoDetailJSON) {
        this.listAdjustmentOutApprovalSerialNoDetailJSON = listAdjustmentOutApprovalSerialNoDetailJSON;
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