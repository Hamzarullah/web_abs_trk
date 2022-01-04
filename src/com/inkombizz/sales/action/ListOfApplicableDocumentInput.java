
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.ListOfApplicableDocumentBLL;
import com.inkombizz.sales.model.ListOfApplicableDocument;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/list-of-applicable-document-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ListOfApplicableDocumentInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private ListOfApplicableDocument listOfApplicableDocument;
    private EnumActivity.ENUM_Activity enumListApplicableDocumentActivity;
    private Date listOfApplicableDocumentTransactionDate;
    private Date listOfApplicableDocumentDateFirstSession;
    private Date listOfApplicableDocumentDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            ListOfApplicableDocumentBLL listOfApplicableDocumentBLL = new ListOfApplicableDocumentBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 1);
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), 12);

            listOfApplicableDocumentDateFirstSession = firstDate;
            listOfApplicableDocumentDateLastSession = lastDate;
            
            switch(enumListApplicableDocumentActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }
                    
                    listOfApplicableDocument = new ListOfApplicableDocument();

                    listOfApplicableDocument.setCode("AUTO");
                    listOfApplicableDocument.setTransactionDate(new Date());
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    listOfApplicableDocument = (ListOfApplicableDocument) hbmSession.hSession.get(ListOfApplicableDocument.class, listOfApplicableDocument.getCode());
                    listOfApplicableDocumentTransactionDate=listOfApplicableDocument.getTransactionDate();
                
                    break;
                case CLONE:
                    if (!BaseSession.loadProgramSession().hasAuthority(listOfApplicableDocumentBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }

                    listOfApplicableDocument = (ListOfApplicableDocument) hbmSession.hSession.get(ListOfApplicableDocument.class, listOfApplicableDocument.getCode());
                    listOfApplicableDocument.setCodeLAD(listOfApplicableDocument.getCode());
                    listOfApplicableDocument.setCode("AUTO");
                    listOfApplicableDocumentTransactionDate=listOfApplicableDocument.getTransactionDate();
                    listOfApplicableDocument.setTransactionDate(listOfApplicableDocument.getTransactionDate());
                    listOfApplicableDocument.setSalesOrder(null);
                    break;
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

    public ListOfApplicableDocument getListOfApplicableDocument() {
        return listOfApplicableDocument;
    }

    public void setListOfApplicableDocument(ListOfApplicableDocument listOfApplicableDocument) {
        this.listOfApplicableDocument = listOfApplicableDocument;
    }

    public EnumActivity.ENUM_Activity getEnumListApplicableDocumentActivity() {
        return enumListApplicableDocumentActivity;
    }

    public void setEnumListApplicableDocumentActivity(EnumActivity.ENUM_Activity enumListApplicableDocumentActivity) {
        this.enumListApplicableDocumentActivity = enumListApplicableDocumentActivity;
    }

    public Date getListOfApplicableDocumentTransactionDate() {
        return listOfApplicableDocumentTransactionDate;
    }

    public void setListOfApplicableDocumentTransactionDate(Date listOfApplicableDocumentTransactionDate) {
        this.listOfApplicableDocumentTransactionDate = listOfApplicableDocumentTransactionDate;
    }

    public Date getListOfApplicableDocumentDateFirstSession() {
        return listOfApplicableDocumentDateFirstSession;
    }

    public void setListOfApplicableDocumentDateFirstSession(Date listOfApplicableDocumentDateFirstSession) {
        this.listOfApplicableDocumentDateFirstSession = listOfApplicableDocumentDateFirstSession;
    }

    public Date getListOfApplicableDocumentDateLastSession() {
        return listOfApplicableDocumentDateLastSession;
    }

    public void setListOfApplicableDocumentDateLastSession(Date listOfApplicableDocumentDateLastSession) {
        this.listOfApplicableDocumentDateLastSession = listOfApplicableDocumentDateLastSession;
    }

    
}
