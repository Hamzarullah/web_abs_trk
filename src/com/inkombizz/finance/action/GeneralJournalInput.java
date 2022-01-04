
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.finance.model.GeneralJournal;
import com.inkombizz.finance.bll.GeneralJournalBLL;
import com.inkombizz.finance.model.GeneralJournalTemp;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import java.util.Date;

@Results({
        @Result(name="success", location="finance/general-journal-input.jsp"),
        @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class GeneralJournalInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private GeneralJournal generalJournal;
    private GeneralJournalTemp generalJournalTemp;
    private Currency currency=null;
    private boolean generalJournalUpdateMode = Boolean.FALSE;
    private Date generalJournalTransactionDateFirstSession;
    private Date generalJournalTransactionDateLastSession;
    private String generalJournalCurrencyCodeSession;
    private Module module=null;
    private Date generalJournalTransactionDate;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            GeneralJournalBLL generalJournalBLL = new GeneralJournalBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            generalJournalTransactionDateFirstSession=firstDate;
            generalJournalTransactionDateLastSession=lastDate;
                
             if(generalJournalUpdateMode){
                if (!BaseSession.loadProgramSession().hasAuthority(generalJournalBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                generalJournal = (GeneralJournal) hbmSession.hSession.get(GeneralJournal.class, generalJournal.getCode());
                generalJournalTransactionDate=generalJournal.getTransactionDate();
                
            }else{
                if (!BaseSession.loadProgramSession().hasAuthority(generalJournalBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                
//                module = (Module) hbmSession.hSession.get(Module.class, generalJournalBLL.MODULECODE);
                
                generalJournal = new GeneralJournal();
                generalJournal.setCode("AUTO");

//                Branch branch=new Branch();
//                branch.setCode(module.getBranch().getCode());
//                branch.setName(module.getBranch().getName());
//                generalJournal.setBranch(branch);
                
//                Company company=new Company();
//                company.setCode(module.getCompany().getCode());
//                company.setName(module.getCompany().getName());
//                generalJournal.setCompany(company);
                
                generalJournal.setTransactionDate(new Date());
                
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                generalJournal.setCurrency(currency);
                
                generalJournalCurrencyCodeSession=BaseSession.loadProgramSession().getSetup().getCurrencyCode();
                generalJournalTransactionDate=new Date();
                
                User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                generalJournal.setBranch(user.getBranch());
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

    public GeneralJournal getGeneralJournal() {
        return generalJournal;
    }

    public void setGeneralJournal(GeneralJournal generalJournal) {
        this.generalJournal = generalJournal;
    }

    public GeneralJournalTemp getGeneralJournalTemp() {
        return generalJournalTemp;
    }

    public void setGeneralJournalTemp(GeneralJournalTemp generalJournalTemp) {
        this.generalJournalTemp = generalJournalTemp;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public boolean isGeneralJournalUpdateMode() {
        return generalJournalUpdateMode;
    }

    public void setGeneralJournalUpdateMode(boolean generalJournalUpdateMode) {
        this.generalJournalUpdateMode = generalJournalUpdateMode;
    }

    public Date getGeneralJournalTransactionDateFirstSession() {
        return generalJournalTransactionDateFirstSession;
    }

    public void setGeneralJournalTransactionDateFirstSession(Date generalJournalTransactionDateFirstSession) {
        this.generalJournalTransactionDateFirstSession = generalJournalTransactionDateFirstSession;
    }

    public Date getGeneralJournalTransactionDateLastSession() {
        return generalJournalTransactionDateLastSession;
    }

    public void setGeneralJournalTransactionDateLastSession(Date generalJournalTransactionDateLastSession) {
        this.generalJournalTransactionDateLastSession = generalJournalTransactionDateLastSession;
    }

    public String getGeneralJournalCurrencyCodeSession() {
        return generalJournalCurrencyCodeSession;
    }

    public void setGeneralJournalCurrencyCodeSession(String generalJournalCurrencyCodeSession) {
        this.generalJournalCurrencyCodeSession = generalJournalCurrencyCodeSession;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Date getGeneralJournalTransactionDate() {
        return generalJournalTransactionDate;
    }

    public void setGeneralJournalTransactionDate(Date generalJournalTransactionDate) {
        this.generalJournalTransactionDate = generalJournalTransactionDate;
    }

    
    
}
