
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.finance.bll.CustomerDebitNoteBLL;
import com.inkombizz.finance.model.CustomerDebitNote;
import com.inkombizz.security.model.User;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="finance/customer-debit-note-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerDebitNoteInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerDebitNote customerDebitNote;
    private boolean customerDebitNoteUpdateMode = false;
    private Currency currency=null;
    private Date customerDebitNoteTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerDebitNoteBLL customerDebitNoteBLL = new CustomerDebitNoteBLL(hbmSession);
            
            if(customerDebitNoteUpdateMode){
                
                if (!BaseSession.loadProgramSession().hasAuthority(customerDebitNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                customerDebitNote = (CustomerDebitNote) hbmSession.hSession.get(CustomerDebitNote.class, customerDebitNote.getCode());
                customerDebitNoteTransactionDate=customerDebitNote.getTransactionDate();
            }else{
                
                if (!BaseSession.loadProgramSession().hasAuthority(customerDebitNoteBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }

                customerDebitNote = new CustomerDebitNote();
                customerDebitNote.setTransactionDate(new Date());  
                customerDebitNote.setTaxInvoiceDate(new Date());
                customerDebitNote.setDueDate(new Date());
                customerDebitNote.setCode("AUTO");
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                customerDebitNote.setBranch(user.getBranch());
                
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                customerDebitNote.setCurrency(currency);
                customerDebitNoteTransactionDate=new Date();
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

    public CustomerDebitNote getCustomerDebitNote() {
        return customerDebitNote;
    }

    public void setCustomerDebitNote(CustomerDebitNote customerDebitNote) {
        this.customerDebitNote = customerDebitNote;
    }

    public boolean isCustomerDebitNoteUpdateMode() {
        return customerDebitNoteUpdateMode;
    }

    public void setCustomerDebitNoteUpdateMode(boolean customerDebitNoteUpdateMode) {
        this.customerDebitNoteUpdateMode = customerDebitNoteUpdateMode;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public Date getCustomerDebitNoteTransactionDate() {
        return customerDebitNoteTransactionDate;
    }

    public void setCustomerDebitNoteTransactionDate(Date customerDebitNoteTransactionDate) {
        this.customerDebitNoteTransactionDate = customerDebitNoteTransactionDate;
    }

}
