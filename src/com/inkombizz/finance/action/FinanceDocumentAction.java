
package com.inkombizz.finance.action;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.FinanceDocumentBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="search/search-finance-document.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class FinanceDocumentAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    @Override
    public String execute() {
        try {
            FinanceDocumentBLL financeDocumentBLL = new FinanceDocumentBLL(hbmSession);   

            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
}
