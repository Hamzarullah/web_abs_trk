
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.ListOfApplicableDocumentBLL;
import com.inkombizz.sales.model.ListOfApplicableDocument;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/list-of-applicable-document-upload.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ListOfApplicableDocumentUploadAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private ListOfApplicableDocument listOfApplicableDocumentUpload=new ListOfApplicableDocument();
    
    @Override
    public String execute() {
        try {
            ListOfApplicableDocumentBLL listOfApplicableDocumentUploadBLL = new ListOfApplicableDocumentBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentUploadBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }    
            
            listOfApplicableDocumentUpload.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            listOfApplicableDocumentUpload.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
    
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ListOfApplicableDocument getListOfApplicableDocument() {
        return listOfApplicableDocumentUpload;
    }

    public void setListOfApplicableDocument(ListOfApplicableDocument listOfApplicableDocumentUpload) {
        this.listOfApplicableDocumentUpload = listOfApplicableDocumentUpload;
    }

    public ListOfApplicableDocument getListOfApplicableDocumentUpload() {
        return listOfApplicableDocumentUpload;
    }

    public void setListOfApplicableDocumentUpload(ListOfApplicableDocument listOfApplicableDocumentUpload) {
        this.listOfApplicableDocumentUpload = listOfApplicableDocumentUpload;
    }

    
    
}
