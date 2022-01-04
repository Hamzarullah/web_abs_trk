
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.finance.bll.CustomerCreditNoteBLL;
import com.inkombizz.finance.model.CustomerCreditNote;
import com.inkombizz.security.model.User;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/customer-credit-note-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerCreditNoteInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerCreditNote customerCreditNote;
    private boolean customerCreditNoteUpdateMode = false;
    private Currency currency=null;
    private Date customerCreditNoteTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerCreditNoteBLL customerCreditNoteBLL = new CustomerCreditNoteBLL(hbmSession);
            
            if(customerCreditNoteUpdateMode){
                
                if (!BaseSession.loadProgramSession().hasAuthority(customerCreditNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                customerCreditNote = (CustomerCreditNote) hbmSession.hSession.get(CustomerCreditNote.class, customerCreditNote.getCode());
                customerCreditNoteTransactionDate=customerCreditNote.getTransactionDate();
            }else{
                
                if (!BaseSession.loadProgramSession().hasAuthority(customerCreditNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }

                customerCreditNote = new CustomerCreditNote();
                customerCreditNote.setTransactionDate(new Date());  
                customerCreditNote.setTaxInvoiceDate(new Date());
                customerCreditNote.setDueDate(new Date());
                customerCreditNote.setCode("AUTO");
                
                Branch branch=new Branch();

                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                customerCreditNote.setBranch(user.getBranch());   
                
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                customerCreditNote.setCurrency(currency);
                customerCreditNoteTransactionDate=new Date();
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

    public CustomerCreditNote getCustomerCreditNote() {
        return customerCreditNote;
    }

    public void setCustomerCreditNote(CustomerCreditNote customerCreditNote) {
        this.customerCreditNote = customerCreditNote;
    }

    public boolean isCustomerCreditNoteUpdateMode() {
        return customerCreditNoteUpdateMode;
    }

    public void setCustomerCreditNoteUpdateMode(boolean customerCreditNoteUpdateMode) {
        this.customerCreditNoteUpdateMode = customerCreditNoteUpdateMode;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public Date getCustomerCreditNoteTransactionDate() {
        return customerCreditNoteTransactionDate;
    }

    public void setCustomerCreditNoteTransactionDate(Date customerCreditNoteTransactionDate) {
        this.customerCreditNoteTransactionDate = customerCreditNoteTransactionDate;
    }

}
