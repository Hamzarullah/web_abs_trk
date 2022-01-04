
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.ListOfApplicableDocumentBLL;
import com.inkombizz.sales.model.ListOfApplicableDocument;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.system.model.Module;
import java.util.Date;

@Results({
    @Result(name="success", location="sales/list-of-applicable-document-upload-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ListOfApplicableDocumentUploadInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private ListOfApplicableDocument listOfApplicableDocumentUpload;
    private Date listOfApplicableDocumentUploadTransactionDate;
    private Boolean listOfApplicableDocumentUploadUpdateMode = Boolean.FALSE;
    private String code="";
    
    private Module module=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            ListOfApplicableDocumentBLL listOfApplicableDocumentUploadBLL = new ListOfApplicableDocumentBLL(hbmSession);
            
            if(listOfApplicableDocumentUploadUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentUploadBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }            

                listOfApplicableDocumentUpload = (ListOfApplicableDocument) hbmSession.hSession.get(ListOfApplicableDocument.class, listOfApplicableDocumentUpload.getCode());
                listOfApplicableDocumentUploadTransactionDate=listOfApplicableDocumentUpload.getTransactionDate();
            }
            return SUCCESS;
                
        } catch (Exception e) {
            e.printStackTrace();
        }
   
        return SUCCESS;
    }
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public ListOfApplicableDocument getListOfApplicableDocumentUpload() {
        return listOfApplicableDocumentUpload;
    }

    public void setListOfApplicableDocumentUpload(ListOfApplicableDocument listOfApplicableDocumentUpload) {
        this.listOfApplicableDocumentUpload = listOfApplicableDocumentUpload;
    }

    public Boolean getListOfApplicableDocumentUploadUpdateMode() {
        return listOfApplicableDocumentUploadUpdateMode;
    }

    public void setListOfApplicableDocumentUploadUpdateMode(Boolean listOfApplicableDocumentUploadUpdateMode) {
        this.listOfApplicableDocumentUploadUpdateMode = listOfApplicableDocumentUploadUpdateMode;
    }

    public Date getListOfApplicableDocumentUploadTransactionDate() {
        return listOfApplicableDocumentUploadTransactionDate;
    }

    public void setListOfApplicableDocumentUploadTransactionDate(Date listOfApplicableDocumentUploadTransactionDate) {
        this.listOfApplicableDocumentUploadTransactionDate = listOfApplicableDocumentUploadTransactionDate;
    }

    
}
