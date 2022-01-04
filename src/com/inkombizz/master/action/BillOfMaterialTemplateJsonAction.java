
package com.inkombizz.master.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.action.ProgramSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.BankBLL;
import com.inkombizz.master.bll.BillOfMaterialTemplateBLL;
import com.inkombizz.master.model.BillOfMaterialTemplate;
import com.inkombizz.master.model.BillOfMaterialTemplateDetail;
import com.inkombizz.master.model.BillOfMaterialTemplateTemp;
import com.inkombizz.ppic.bll.ProductionPlanningOrderBLL;
import com.inkombizz.ppic.model.ProductionPlanningOrderItemDetail;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result(type="json")
public class BillOfMaterialTemplateJsonAction extends ActionSupport {
    private static final long serialVersionUID=1L;
    
    protected HBMSession hbmSession=new HBMSession();
    
    private ProgramSession prgSession = new ProgramSession();
    private BillOfMaterialTemplate billOfMaterialTemplate = new BillOfMaterialTemplate();
    private BillOfMaterialTemplateTemp billOfMaterialTemplateTemp;
    private List <BillOfMaterialTemplate> listBillOfMaterialTemplate;
    private List <BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail;
    private String code="";
    private String headerCode="";
    private String actionAuthority="";
    private String listBillOfMaterialTemplateDetailJSON;
    
    @Override
    public String execute(){
        try{
            return findData();
        }
        catch(Exception Ex){
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-template-data")
    public String findData() {
        try {
            BillOfMaterialTemplateBLL billOfMaterialTemplateBLL = new BillOfMaterialTemplateBLL(hbmSession);
            ListPaging <BillOfMaterialTemplate> listPaging = billOfMaterialTemplateBLL.findData(paging,billOfMaterialTemplate);
            
            listBillOfMaterialTemplate = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-template-get-data")
    public String findData1() {
        try {
            BillOfMaterialTemplateBLL billOfMaterialTemplateBLL = new BillOfMaterialTemplateBLL(hbmSession);
            this.billOfMaterialTemplateTemp = billOfMaterialTemplateBLL.findData(this.billOfMaterialTemplate.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-template-get-detail")
    public String findDataDetail(){
        try {
            
            BillOfMaterialTemplateBLL billOfMaterialTemplateBLL = new BillOfMaterialTemplateBLL(hbmSession);
            List<BillOfMaterialTemplateDetail> list = billOfMaterialTemplateBLL.findDataDetail(headerCode);
            
            listBillOfMaterialTemplateDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-template-get-detail-template")
    public String findDataDetailTemplate(){
        try {
            
            BillOfMaterialTemplateBLL billOfMaterialTemplateBLL = new BillOfMaterialTemplateBLL(hbmSession);
            List<BillOfMaterialTemplateDetail> list = billOfMaterialTemplateBLL.findDataDetailTemplate(headerCode);
            
            listBillOfMaterialTemplateDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-template-authority")
    public String bankAuthority(){
        try{
            
            BillOfMaterialTemplateBLL billOfMaterialTemplateBLL = new BillOfMaterialTemplateBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialTemplateBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialTemplateBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialTemplateBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("bill-of-material-template-save")
    public String save() {
        try {
                BillOfMaterialTemplateBLL billOfMaterialTemplateBLL = new BillOfMaterialTemplateBLL(hbmSession);

                Gson gson = new Gson();
                gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listBillOfMaterialTemplateDetail = gson.fromJson(this.listBillOfMaterialTemplateDetailJSON, new TypeToken<List<BillOfMaterialTemplateDetail>>(){}.getType());
                                
                if(billOfMaterialTemplateBLL.isExist(this.billOfMaterialTemplate.getCode())) {
                    billOfMaterialTemplateBLL.update(billOfMaterialTemplate, listBillOfMaterialTemplateDetail);
                    this.message = "UPDATE DATA SUCCESS.<br/>BOM Template No : " + this.billOfMaterialTemplate.getCode(); 
                }else{
                    billOfMaterialTemplateBLL.save(billOfMaterialTemplate, listBillOfMaterialTemplateDetail);
                    this.message = "SAVE DATA SUCCESS.<br/>BOM Template : " + this.billOfMaterialTemplate.getCode();
                }

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-template-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            BillOfMaterialTemplateBLL billOfMaterialTemplateBLL = new BillOfMaterialTemplateBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialTemplateBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            billOfMaterialTemplateBLL.delete(this.billOfMaterialTemplate.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>PPO No : " + this.billOfMaterialTemplate.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
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

    public BillOfMaterialTemplate getBillOfMaterialTemplate() {
        return billOfMaterialTemplate;
    }

    public void setBillOfMaterialTemplate(BillOfMaterialTemplate billOfMaterialTemplate) {
        this.billOfMaterialTemplate = billOfMaterialTemplate;
    }

    public List<BillOfMaterialTemplate> getListBillOfMaterialTemplate() {
        return listBillOfMaterialTemplate;
    }

    public void setListBillOfMaterialTemplate(List<BillOfMaterialTemplate> listBillOfMaterialTemplate) {
        this.listBillOfMaterialTemplate = listBillOfMaterialTemplate;
    }

    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }

    public List<BillOfMaterialTemplateDetail> getListBillOfMaterialTemplateDetail() {
        return listBillOfMaterialTemplateDetail;
    }

    public void setListBillOfMaterialTemplateDetail(List<BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail) {
        this.listBillOfMaterialTemplateDetail = listBillOfMaterialTemplateDetail;
    }

    public String getListBillOfMaterialTemplateDetailJSON() {
        return listBillOfMaterialTemplateDetailJSON;
    }

    public void setListBillOfMaterialTemplateDetailJSON(String listBillOfMaterialTemplateDetailJSON) {
        this.listBillOfMaterialTemplateDetailJSON = listBillOfMaterialTemplateDetailJSON;
    }

    public BillOfMaterialTemplateTemp getBillOfMaterialTemplateTemp() {
        return billOfMaterialTemplateTemp;
    }

    public void setBillOfMaterialTemplateTemp(BillOfMaterialTemplateTemp billOfMaterialTemplateTemp) {
        this.billOfMaterialTemplateTemp = billOfMaterialTemplateTemp;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
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
