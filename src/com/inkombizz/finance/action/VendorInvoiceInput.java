/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.bll.VendorInvoiceBLL;
import com.inkombizz.finance.model.VendorInvoice;
import com.inkombizz.master.model.Currency;
import com.inkombizz.master.model.PaymentTerm;
import com.inkombizz.purchasing.model.PurchaseOrder;
import com.inkombizz.security.bll.UserBLL;
import com.inkombizz.security.model.User;
import com.inkombizz.security.model.UserTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author sukha
 */
@Results({
    @Result(name="success", location="finance/vendor-invoice-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class VendorInvoiceInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private VendorInvoice vendorInvoice; 
    private Currency currency=null;
    private boolean vendorInvoiceUpdateMode = false;
    private String code = "";
    private Date vendorInvoiceFirstDate;
    private Date vendorInvoiceLastDate;
    
    @Override
    public String execute() {
        try {
            VendorInvoiceBLL vendorInvoiceBLL = new VendorInvoiceBLL(hbmSession);
            UserBLL userBLL = new UserBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            vendorInvoiceFirstDate = firstDate;
            vendorInvoiceLastDate = lastDate;
                    
            
            if(vendorInvoiceUpdateMode){
               
                if (!BaseSession.loadProgramSession().hasAuthority(vendorInvoiceBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                    return "redirect";
                }
                vendorInvoice = (VendorInvoice) hbmSession.hSession.get(VendorInvoice.class, vendorInvoice.getCode());
            //    vendorInvoice = vendorInvoiceBLL.get(code);

            }else{
            
                vendorInvoice = new VendorInvoice();
                vendorInvoice.setCode("AUTO");
                vendorInvoice.setTransactionDate(new Date());
                
                vendorInvoice.setVendorInvoiceDate(new Date());
                
                PurchaseOrder purchaseOrder=new PurchaseOrder();
                PaymentTerm paymentTerm=new PaymentTerm();
                paymentTerm.setDays(BigDecimal.ZERO);
                purchaseOrder.setPaymentTerm(paymentTerm);
                vendorInvoice.setPurchaseOrder(purchaseOrder);
                
                vendorInvoice.setDueDate(new Date());
                
                
                vendorInvoice.setVendorTaxInvoiceDate(new Date());
                 User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                vendorInvoice.setBranch(user.getBranch()); 
                currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                vendorInvoice.setCurrency(currency);
               // vendorInvoice.setPaymentType("BANK");
                UserTemp userTemp = new UserTemp();
//                userTemp = userBLL.findData(BaseSession.loadProgramSession().getUserCode());
//                    Branch branch = new Branch();
//                    branch.setCode(userTemp.getDefaultBranchCode());
//                    branch.setName(userTemp.getDefaultBranchName());
               // vendorInvoice.setBranch(branch);
                
            }
            return SUCCESS;
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public VendorInvoice getVendorInvoice() {
        return vendorInvoice;
    }

    public void setVendorInvoice(VendorInvoice vendorInvoice) {
        this.vendorInvoice = vendorInvoice;
    }

    public boolean isVendorInvoiceUpdateMode() {
        return vendorInvoiceUpdateMode;
    }

    public void setVendorInvoiceUpdateMode(boolean vendorInvoiceUpdateMode) {
        this.vendorInvoiceUpdateMode = vendorInvoiceUpdateMode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getVendorInvoiceFirstDate() {
        return vendorInvoiceFirstDate;
    }

    public void setVendorInvoiceFirstDate(Date vendorInvoiceFirstDate) {
        this.vendorInvoiceFirstDate = vendorInvoiceFirstDate;
    }

    public Date getVendorInvoiceLastDate() {
        return vendorInvoiceLastDate;
    }

    public void setVendorInvoiceLastDate(Date vendorInvoiceLastDate) {
        this.vendorInvoiceLastDate = vendorInvoiceLastDate;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }
    
}
