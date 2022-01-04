/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Currency;
import com.inkombizz.sales.bll.CustomerPurchaseOrderToBlanketOrderBLL;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-purchase-order-to-blanket-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerPurchaseOrderToBlanketOrderInput extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerPurchaseOrder customerPurchaseOrderToBlanketOrder;
    private EnumActivity.ENUM_Activity enumCustomerPurchaseOrderToBlanketOrderActivity;
    private String customerPurchaseOrderToBlanketOrderUpdateMode;
    private Currency currency=null;
    private Module module=null;
    private Date customerPurchaseOrderToBlanketOrderTransactionDate;
    private Date customerPurchaseOrderToBlanketOrderDateFirstSession;
    private Date customerPurchaseOrderToBlanketOrderDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerPurchaseOrderToBlanketOrderBLL customerPurchaseOrderToBlanketOrderBLL = new CustomerPurchaseOrderToBlanketOrderBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            customerPurchaseOrderToBlanketOrderDateFirstSession = firstDate;
            customerPurchaseOrderToBlanketOrderDateLastSession = lastDate;
            
            switch(enumCustomerPurchaseOrderToBlanketOrderActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderToBlanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }
                    
//                    module = (Module) hbmSession.hSession.get(Module.class, customerPurchaseOrderToBlanketOrderBLL.MODULECODE);
                    
                    User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                    
                
                    customerPurchaseOrderToBlanketOrder = new CustomerPurchaseOrder();
                    
                    customerPurchaseOrderToBlanketOrder.setCode("AUTO");
                    customerPurchaseOrderToBlanketOrder.setCustPONo("AUTO");
                    customerPurchaseOrderToBlanketOrder.setTransactionDate(new Date());
                    customerPurchaseOrderToBlanketOrder.setBranch(user.getBranch()); 
                    currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                    customerPurchaseOrderToBlanketOrder.setCurrency(currency);
                    customerPurchaseOrderToBlanketOrderTransactionDate=new Date();
                    customerPurchaseOrderToBlanketOrder.setPartialShipmentStatus("NO");
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderToBlanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    customerPurchaseOrderToBlanketOrder = (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, customerPurchaseOrderToBlanketOrder.getCode());
                    customerPurchaseOrderToBlanketOrderTransactionDate=customerPurchaseOrderToBlanketOrder.getTransactionDate();
                    customerPurchaseOrderToBlanketOrder.setCustomerPurchaseOrderCode(customerPurchaseOrderToBlanketOrder.getCode());
                    
                    break;
                case REVISE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderToBlanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
                    String refCUSTPOCode=customerPurchaseOrderToBlanketOrder.getCode();
                    
                    customerPurchaseOrderToBlanketOrder = (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, customerPurchaseOrderToBlanketOrder.getCode());
                    customerPurchaseOrderToBlanketOrder.setTransactionDate(new Date());
                    customerPurchaseOrderToBlanketOrderTransactionDate=new Date();
                    customerPurchaseOrderToBlanketOrder.setCustomerPurchaseOrderCode(customerPurchaseOrderToBlanketOrder.getCode());
//                    customerPurchaseOrderToBlanketOrder.setRefCUSTPOCode(customerPurchaseOrderToBlanketOrder.getCustomerPurchaseOrderCode());
                    String newCode=customerPurchaseOrderToBlanketOrderBLL.createCode(enumCustomerPurchaseOrderToBlanketOrderActivity, customerPurchaseOrderToBlanketOrder);
                    customerPurchaseOrderToBlanketOrder.setCode(newCode);
                    customerPurchaseOrderToBlanketOrder.setRefCUSTPOCode(refCUSTPOCode);
                    customerPurchaseOrderToBlanketOrder.setRevision(customerPurchaseOrderToBlanketOrder.getCode().substring(customerPurchaseOrderToBlanketOrder.getCode().length()-2));
                    break;
                case CLONE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderToBlanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }

                    customerPurchaseOrderToBlanketOrder = (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, customerPurchaseOrderToBlanketOrder.getCode());
                    customerPurchaseOrderToBlanketOrder.setCustomerPurchaseOrderCode(customerPurchaseOrderToBlanketOrder.getCode());
                    customerPurchaseOrderToBlanketOrder.setCode("AUTO");
                    customerPurchaseOrderToBlanketOrder.setRevision("00");
                    customerPurchaseOrderToBlanketOrder.setRefCUSTPOCode("");
                    customerPurchaseOrderToBlanketOrder.setTransactionDate(new Date());
                    customerPurchaseOrderToBlanketOrderTransactionDate=new Date();
                    
                    break;
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

    public CustomerPurchaseOrder getCustomerPurchaseOrderToBlanketOrder() {
        return customerPurchaseOrderToBlanketOrder;
    }

    public void setCustomerPurchaseOrderToBlanketOrder(CustomerPurchaseOrder customerPurchaseOrderToBlanketOrder) {
        this.customerPurchaseOrderToBlanketOrder = customerPurchaseOrderToBlanketOrder;
    }

    public String getCustomerPurchaseOrderToBlanketOrderUpdateMode() {
        return customerPurchaseOrderToBlanketOrderUpdateMode;
    }

    public void setCustomerPurchaseOrderToBlanketOrderUpdateMode(String customerPurchaseOrderToBlanketOrderUpdateMode) {
        this.customerPurchaseOrderToBlanketOrderUpdateMode = customerPurchaseOrderToBlanketOrderUpdateMode;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Date getCustomerPurchaseOrderToBlanketOrderTransactionDate() {
        return customerPurchaseOrderToBlanketOrderTransactionDate;
    }

    public void setCustomerPurchaseOrderToBlanketOrderTransactionDate(Date customerPurchaseOrderToBlanketOrderTransactionDate) {
        this.customerPurchaseOrderToBlanketOrderTransactionDate = customerPurchaseOrderToBlanketOrderTransactionDate;
    }

    public Date getCustomerPurchaseOrderToBlanketOrderDateFirstSession() {
        return customerPurchaseOrderToBlanketOrderDateFirstSession;
    }

    public void setCustomerPurchaseOrderToBlanketOrderDateFirstSession(Date customerPurchaseOrderToBlanketOrderDateFirstSession) {
        this.customerPurchaseOrderToBlanketOrderDateFirstSession = customerPurchaseOrderToBlanketOrderDateFirstSession;
    }

    public Date getCustomerPurchaseOrderToBlanketOrderDateLastSession() {
        return customerPurchaseOrderToBlanketOrderDateLastSession;
    }

    public void setCustomerPurchaseOrderToBlanketOrderDateLastSession(Date customerPurchaseOrderToBlanketOrderDateLastSession) {
        this.customerPurchaseOrderToBlanketOrderDateLastSession = customerPurchaseOrderToBlanketOrderDateLastSession;
    }

    public EnumActivity.ENUM_Activity getEnumCustomerPurchaseOrderToBlanketOrderActivity() {
        return enumCustomerPurchaseOrderToBlanketOrderActivity;
    }

    public void setEnumCustomerPurchaseOrderToBlanketOrderActivity(EnumActivity.ENUM_Activity enumCustomerPurchaseOrderToBlanketOrderActivity) {
        this.enumCustomerPurchaseOrderToBlanketOrderActivity = enumCustomerPurchaseOrderToBlanketOrderActivity;
    }
    
}
