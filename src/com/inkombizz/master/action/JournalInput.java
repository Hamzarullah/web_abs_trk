
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.JournalBLL;
import com.inkombizz.master.model.Journal;
import com.inkombizz.master.model.JournalTemp;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="master/journal-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class JournalInput extends ActionSupport{
    protected HBMSession hbmSession = new HBMSession();
    private Journal journal;
    private JournalTemp journalTemp;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            JournalBLL journalBLL = new JournalBLL(hbmSession);
                
            if (!BaseSession.loadProgramSession().hasAuthority(journalBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }
            
            journalTemp=journalBLL.get(journal.getCode());
            journal.setCode(journalTemp.getCode());
            journal.setName(journalTemp.getName());
            journal.setActiveStatus(journalTemp.getActiveStatus());
            
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

    public Journal getJournal() {
        return journal;
    }

    public void setJournal(Journal journal) {
        this.journal = journal;
    }

    public JournalTemp getJournalTemp() {
        return journalTemp;
    }

    public void setJournalTemp(JournalTemp journalTemp) {
        this.journalTemp = journalTemp;
    }
    
    
}
