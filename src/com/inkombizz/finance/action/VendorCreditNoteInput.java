
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.finance.bll.VendorCreditNoteBLL;
import com.inkombizz.finance.model.VendorCreditNote;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/vendor-credit-note-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorCreditNoteInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private VendorCreditNote vendorCreditNote;
    private boolean vendorCreditNoteUpdateMode = Boolean.FALSE;
    private Date vendorCreditNoteTransactionDate;
    public Date vendorCreditNoteDateFirstSession;
    public Date vendorCreditNoteDateLastSession;
    private Currency currency=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            VendorCreditNoteBLL vendorCreditNoteBLL = new VendorCreditNoteBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
                
            vendorCreditNoteDateFirstSession = firstDate;
            vendorCreditNoteDateLastSession = lastDate;
            
             if(vendorCreditNoteUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(vendorCreditNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                vendorCreditNote = (VendorCreditNote) hbmSession.hSession.get(VendorCreditNote.class, vendorCreditNote.getCode());
                vendorCreditNoteTransactionDate=vendorCreditNote.getTransactionDate();
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(vendorCreditNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                vendorCreditNote = new VendorCreditNote();
                vendorCreditNote.setTransactionDate(new Date());
                vendorCreditNote.setTaxInvoiceDate(new Date());
                vendorCreditNote.setDueDate(new Date());
                vendorCreditNote.setVendorInvoiceDate(new Date());
                vendorCreditNote.setCode("AUTO");
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                vendorCreditNote.setBranch(user.getBranch());
                
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                vendorCreditNote.setCurrency(currency);
                
                vendorCreditNote.setTransactionDate(new Date());
                vendorCreditNote.setTaxInvoiceDate(new Date());
                vendorCreditNoteTransactionDate=new Date();
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

    public VendorCreditNote getVendorCreditNote() {
        return vendorCreditNote;
    }

    public void setVendorCreditNote(VendorCreditNote vendorCreditNote) {
        this.vendorCreditNote = vendorCreditNote;
    }

    public boolean isVendorCreditNoteUpdateMode() {
        return vendorCreditNoteUpdateMode;
    }

    public void setVendorCreditNoteUpdateMode(boolean vendorCreditNoteUpdateMode) {
        this.vendorCreditNoteUpdateMode = vendorCreditNoteUpdateMode;
    }

    public Date getVendorCreditNoteTransactionDate() {
        return vendorCreditNoteTransactionDate;
    }

    public void setVendorCreditNoteTransactionDate(Date vendorCreditNoteTransactionDate) {
        this.vendorCreditNoteTransactionDate = vendorCreditNoteTransactionDate;
    }

    public Date getVendorCreditNoteDateFirstSession() {
        return vendorCreditNoteDateFirstSession;
    }

    public void setVendorCreditNoteDateFirstSession(Date vendorCreditNoteDateFirstSession) {
        this.vendorCreditNoteDateFirstSession = vendorCreditNoteDateFirstSession;
    }

    public Date getVendorCreditNoteDateLastSession() {
        return vendorCreditNoteDateLastSession;
    }

    public void setVendorCreditNoteDateLastSession(Date vendorCreditNoteDateLastSession) {
        this.vendorCreditNoteDateLastSession = vendorCreditNoteDateLastSession;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

}
