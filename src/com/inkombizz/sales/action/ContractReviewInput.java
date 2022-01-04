
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.ContractReviewBLL;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.sales.model.ContractReview;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import com.inkombizz.utils.DateUtils;

@Results({
    @Result(name="success", location="sales/contract-review-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ContractReviewInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private ContractReview contractReview =new ContractReview();
    private ContractReview contractReviewForSo =new ContractReview();
    private EnumActivity.ENUM_Activity enumContractReviewActivity;
    private Date contractReviewTransactionDate;
    private Date contractReviewTransactionDateFirstSession;
    private Date contractReviewTransactionDateLastSession;
    private Module module=null;
    
    @Override
    public String execute() throws Exception {
  
        try {                
            ContractReviewBLL contractReviewBLL = new ContractReviewBLL(hbmSession); 
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            contractReviewTransactionDateFirstSession = firstDate;
            contractReviewTransactionDateLastSession = lastDate;
          
            switch(enumContractReviewActivity){
                case UPDATE :
                    if (!BaseSession.loadProgramSession().hasAuthority(contractReviewBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }            
                    
                    contractReview = (ContractReview) hbmSession.hSession.get(ContractReview.class, contractReview.getCode());
                    
                    contractReviewForSo = contractReviewBLL.findSoForUpdateContractReview(contractReview.getCustomerPurchaseOrder().getCode());
                    contractReviewTransactionDate = contractReview.getTransactionDate();
                    
                    contractReview.setTransactionDate(contractReview.getTransactionDate());
                    contractReview.setSfs2YearSparepartStatus(contractReview.getSfs2YearSparepartStatus());
                break;
                
                case REVISE :
                    if (!BaseSession.loadProgramSession().hasAuthority(contractReviewBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
                    
                    String refCUSTCRCode=contractReview.getCode();
                    
                    contractReview = (ContractReview) hbmSession.hSession.get(ContractReview.class, contractReview.getCode());
                    contractReviewTransactionDate=contractReview.getTransactionDate();
                    String newCode=contractReviewBLL.createReviseCode(enumContractReviewActivity, contractReview);
                    contractReview.setCode(newCode);
                    contractReview.setRefCUSTCRCode(refCUSTCRCode);
                    contractReview.setRevision(contractReview.getCode().substring(contractReview.getCode().length()-2));
                    contractReview.setCustomerPurchaseOrder(contractReview.getCustomerPurchaseOrder());
                break;
            
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(contractReviewBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }       

                    contractReview = new ContractReview();
                    User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());

                    contractReview.setCode("AUTO");
                    contractReview.setTransactionDate(new Date());
                    contractReview.setBranch(user.getBranch()); 
                    contractReviewTransactionDate = new Date();
                
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

    public ContractReview getContractReview() {
        return contractReview;
    }

    public void setContractReview(ContractReview contractReview) {
        this.contractReview = contractReview;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Date getContractReviewTransactionDateFirstSession() {
        return contractReviewTransactionDateFirstSession;
    }

    public void setContractReviewTransactionDateFirstSession(Date contractReviewTransactionDateFirstSession) {
        this.contractReviewTransactionDateFirstSession = contractReviewTransactionDateFirstSession;
    }

    public Date getContractReviewTransactionDateLastSession() {
        return contractReviewTransactionDateLastSession;
    }

    public void setContractReviewTransactionDateLastSession(Date contractReviewTransactionDateLastSession) {
        this.contractReviewTransactionDateLastSession = contractReviewTransactionDateLastSession;
    }

    public Date getContractReviewTransactionDate() {
        return contractReviewTransactionDate;
    }

    public void setContractReviewTransactionDate(Date contractReviewTransactionDate) {
        this.contractReviewTransactionDate = contractReviewTransactionDate;
    }

    public EnumActivity.ENUM_Activity getEnumContractReviewActivity() {
        return enumContractReviewActivity;
    }

    public void setEnumContractReviewActivity(EnumActivity.ENUM_Activity enumContractReviewActivity) {
        this.enumContractReviewActivity = enumContractReviewActivity;
    }

    public ContractReview getContractReviewForSo() {
        return contractReviewForSo;
    }

    public void setContractReviewForSo(ContractReview contractReviewForSo) {
        this.contractReviewForSo = contractReviewForSo;
    }
    
}
