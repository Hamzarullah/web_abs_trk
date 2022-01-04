
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.Currency;
import com.inkombizz.sales.bll.SalesQuotationBLL;
import com.inkombizz.sales.model.SalesQuotation;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

@Results({
    @Result(name="success", location="sales/sales-quotation-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class SalesQuotationInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private SalesQuotation salesQuotation;
    private boolean salesQuotationUpdateMode = false;
    private boolean salesQuotationReviseMode = false;
    private boolean salesQuotationCloneMode = false;
    private Currency currency=null;
    private Date salesQuotationTransactionDate;
    private Date salesQuotationTransactionDateFirstSession;
    private Date salesQuotationTransactionDateLastSession;
    private BigDecimal salesQuotationSubTotal;
    
    @Override
    public String execute() throws Exception {
  
        try {
            SalesQuotationBLL salesQuotationBLL = new SalesQuotationBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            salesQuotationTransactionDateFirstSession = firstDate;
            salesQuotationTransactionDateLastSession = lastDate;
            
            if(salesQuotationUpdateMode){
                
                if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                salesQuotation = (SalesQuotation) hbmSession.hSession.get(SalesQuotation.class, salesQuotation.getCode());
                salesQuotationTransactionDate=salesQuotation.getTransactionDate();
                salesQuotationSubTotal=salesQuotation.getTotalTransactionAmount().subtract(salesQuotation.getDiscountAmount());
                salesQuotation.setRefSalQUOCode(salesQuotation.getRefSalQUOCode());
                
            }
            else if(salesQuotationCloneMode){
                
                if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                
                salesQuotation = (SalesQuotation) hbmSession.hSession.get(SalesQuotation.class, salesQuotation.getCode());
                salesQuotation.setTransactionDate(new Date());  
                salesQuotationTransactionDate = new Date();
                salesQuotationSubTotal=salesQuotation.getTotalTransactionAmount().subtract(salesQuotation.getDiscountAmount());
                salesQuotation.setRefSalQUOCode("");
                
            }
            else if(salesQuotationReviseMode){
                if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }
                String RefSalQuoCode=salesQuotation.getCode();
                salesQuotation = (SalesQuotation) hbmSession.hSession.get(SalesQuotation.class, salesQuotation.getCode());
                salesQuotation.setTransactionDate(new Date());  
                salesQuotationTransactionDate = new Date();
                salesQuotationSubTotal=salesQuotation.getTotalTransactionAmount().subtract(salesQuotation.getDiscountAmount());
                salesQuotation.setCode(createReviseCode(salesQuotation));
                salesQuotation.setRefSalQUOCode(RefSalQuoCode);
                
            }else{
                
                if (!BaseSession.loadProgramSession().hasAuthority(salesQuotationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                    return "redirect";
                }

                salesQuotation = new SalesQuotation();
                salesQuotation.setTransactionDate(new Date());  
                salesQuotationTransactionDate = new Date();
                salesQuotation.setCode("AUTO");
            }
            
            return SUCCESS;
                
        } catch (Exception e) {
            e.printStackTrace();
        }
   
        return SUCCESS;
    }
    
    public String createReviseCode(SalesQuotation salesQuotation){        
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.REV.toString();
            String acronim =  salesQuotation.getCode().split("[.]")[0]+".";

            DetachedCriteria dc = DetachedCriteria.forClass(SalesQuotation.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                    if (list.size() > 0)
                        if(list.get(0) != null){
                            oldID=list.get(0).toString();
                        }
                            
                }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_2);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public SalesQuotation getSalesQuotation() {
        return salesQuotation;
    }

    public void setSalesQuotation(SalesQuotation salesQuotation) {
        this.salesQuotation = salesQuotation;
    }

    public boolean isSalesQuotationUpdateMode() {
        return salesQuotationUpdateMode;
    }

    public void setSalesQuotationUpdateMode(boolean salesQuotationUpdateMode) {
        this.salesQuotationUpdateMode = salesQuotationUpdateMode;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public Date getSalesQuotationTransactionDate() {
        return salesQuotationTransactionDate;
    }

    public void setSalesQuotationTransactionDate(Date salesQuotationTransactionDate) {
        this.salesQuotationTransactionDate = salesQuotationTransactionDate;
    }

    public boolean isSalesQuotationReviseMode() {
        return salesQuotationReviseMode;
    }

    public void setSalesQuotationReviseMode(boolean salesQuotationReviseMode) {
        this.salesQuotationReviseMode = salesQuotationReviseMode;
    }

    public Date getSalesQuotationTransactionDateFirstSession() {
        return salesQuotationTransactionDateFirstSession;
    }

    public void setSalesQuotationTransactionDateFirstSession(Date salesQuotationTransactionDateFirstSession) {
        this.salesQuotationTransactionDateFirstSession = salesQuotationTransactionDateFirstSession;
    }

    public Date getSalesQuotationTransactionDateLastSession() {
        return salesQuotationTransactionDateLastSession;
    }

    public void setSalesQuotationTransactionDateLastSession(Date salesQuotationTransactionDateLastSession) {
        this.salesQuotationTransactionDateLastSession = salesQuotationTransactionDateLastSession;
    }

    public BigDecimal getSalesQuotationSubTotal() {
        return salesQuotationSubTotal;
    }

    public void setSalesQuotationSubTotal(BigDecimal salesQuotationSubTotal) {
        this.salesQuotationSubTotal = salesQuotationSubTotal;
    }

    public boolean isSalesQuotationCloneMode() {
        return salesQuotationCloneMode;
    }

    public void setSalesQuotationCloneMode(boolean salesQuotationCloneMode) {
        this.salesQuotationCloneMode = salesQuotationCloneMode;
    }
    
    
}
