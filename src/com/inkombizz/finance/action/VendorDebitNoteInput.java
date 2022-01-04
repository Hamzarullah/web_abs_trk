
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.finance.bll.VendorDebitNoteBLL;
import com.inkombizz.finance.model.VendorDebitNote;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="finance/vendor-debit-note-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorDebitNoteInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private VendorDebitNote vendorDebitNote;
    private boolean vendorDebitNoteUpdateMode = Boolean.FALSE;
    private Date vendorDebitNoteTransactionDate;
    public Date vendorDebitNoteDateFirstSession;
    public Date vendorDebitNoteDateLastSession;
    private Currency currency=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            VendorDebitNoteBLL vendorDebitNoteBLL = new VendorDebitNoteBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
                
            vendorDebitNoteDateFirstSession = firstDate;
            vendorDebitNoteDateLastSession = lastDate;
            
             if(vendorDebitNoteUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(vendorDebitNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                vendorDebitNote = (VendorDebitNote) hbmSession.hSession.get(VendorDebitNote.class, vendorDebitNote.getCode());
                vendorDebitNoteTransactionDate=vendorDebitNote.getTransactionDate();
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(vendorDebitNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
                vendorDebitNote = new VendorDebitNote();
                vendorDebitNote.setTransactionDate(new Date());
                vendorDebitNote.setTaxInvoiceDate(new Date());
                vendorDebitNote.setDueDate(new Date());
                vendorDebitNote.setVendorInvoiceDate(new Date());
                vendorDebitNote.setCode("AUTO");
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                vendorDebitNote.setBranch(user.getBranch());
                
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                vendorDebitNote.setCurrency(currency);
                
                vendorDebitNote.setTransactionDate(new Date());
                vendorDebitNote.setTaxInvoiceDate(new Date());
                vendorDebitNoteTransactionDate=new Date();
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

    public VendorDebitNote getVendorDebitNote() {
        return vendorDebitNote;
    }

    public void setVendorDebitNote(VendorDebitNote vendorDebitNote) {
        this.vendorDebitNote = vendorDebitNote;
    }

    public boolean isVendorDebitNoteUpdateMode() {
        return vendorDebitNoteUpdateMode;
    }

    public void setVendorDebitNoteUpdateMode(boolean vendorDebitNoteUpdateMode) {
        this.vendorDebitNoteUpdateMode = vendorDebitNoteUpdateMode;
    }

    public Date getVendorDebitNoteTransactionDate() {
        return vendorDebitNoteTransactionDate;
    }

    public void setVendorDebitNoteTransactionDate(Date vendorDebitNoteTransactionDate) {
        this.vendorDebitNoteTransactionDate = vendorDebitNoteTransactionDate;
    }

    public Date getVendorDebitNoteDateFirstSession() {
        return vendorDebitNoteDateFirstSession;
    }

    public void setVendorDebitNoteDateFirstSession(Date vendorDebitNoteDateFirstSession) {
        this.vendorDebitNoteDateFirstSession = vendorDebitNoteDateFirstSession;
    }

    public Date getVendorDebitNoteDateLastSession() {
        return vendorDebitNoteDateLastSession;
    }

    public void setVendorDebitNoteDateLastSession(Date vendorDebitNoteDateLastSession) {
        this.vendorDebitNoteDateLastSession = vendorDebitNoteDateLastSession;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

}
