
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Currency;
import com.inkombizz.sales.bll.CustomerPurchaseOrderToSalesOrderBLL;
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
    @Result(name="success", location="sales/customer-purchase-order-to-sales-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerPurchaseOrderToSalesOrderInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerPurchaseOrder customerPurchaseOrder;
    private EnumActivity.ENUM_Activity enumCustomerPurchaseOrderActivity;
    private String customerPurchaseOrderUpdateMode;
    private String customerPurchaseOrderCloneModeCode;
    private Currency currency=null;
    private Module module=null;
    private Date customerPurchaseOrderTransactionDate;
    private Date customerPurchaseOrderDateFirstSession;
    private Date customerPurchaseOrderDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerPurchaseOrderToSalesOrderBLL customerPurchaseOrderBLL = new CustomerPurchaseOrderToSalesOrderBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            customerPurchaseOrderDateFirstSession = firstDate;
            customerPurchaseOrderDateLastSession = lastDate;
            
            switch(enumCustomerPurchaseOrderActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }
                    
//                    module = (Module) hbmSession.hSession.get(Module.class, customerPurchaseOrderBLL.MODULECODE);
                    
                    User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                    
                
                    customerPurchaseOrder = new CustomerPurchaseOrder();
                    
                    customerPurchaseOrder.setCode("AUTO");
                    customerPurchaseOrder.setCustPONo("AUTO");
                    customerPurchaseOrder.setTransactionDate(new Date());
                    customerPurchaseOrder.setBranch(user.getBranch()); 
                    currency = (Currency) hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                    customerPurchaseOrder.setCurrency(currency);
                    customerPurchaseOrderTransactionDate=new Date();
                    customerPurchaseOrder.setPartialShipmentStatus("NO");
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    customerPurchaseOrder = (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, customerPurchaseOrder.getCode());
                    customerPurchaseOrderTransactionDate=customerPurchaseOrder.getTransactionDate();
                    customerPurchaseOrder.setCustomerPurchaseOrderCode(customerPurchaseOrder.getCode());
                    
                    break;
                case REVISE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
                    String refCUSTPOCode=customerPurchaseOrder.getCode();
                    
                    customerPurchaseOrder = (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, customerPurchaseOrder.getCode());
                    customerPurchaseOrder.setTransactionDate(new Date());
                    customerPurchaseOrderTransactionDate=new Date();
                    customerPurchaseOrder.setCustomerPurchaseOrderCode(customerPurchaseOrder.getCode());
//                    customerPurchaseOrder.setRefCUSTPOCode(customerPurchaseOrder.getCustomerPurchaseOrderCode());
                    String newCode=customerPurchaseOrderBLL.createCode(enumCustomerPurchaseOrderActivity, customerPurchaseOrder);
                    customerPurchaseOrder.setCode(newCode);
                    customerPurchaseOrder.setRefCUSTPOCode(refCUSTPOCode);
                    customerPurchaseOrder.setRevision(customerPurchaseOrder.getCode().substring(customerPurchaseOrder.getCode().length()-2));
                    break;
                case CLONE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }

                    customerPurchaseOrder = (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, customerPurchaseOrder.getCode());
                    customerPurchaseOrder.setCustomerPurchaseOrderCode(customerPurchaseOrder.getCode());
                    customerPurchaseOrder.setCode("AUTO");
                    customerPurchaseOrder.setRevision("00");
                    customerPurchaseOrder.setRefCUSTPOCode("");
                    customerPurchaseOrder.setTransactionDate(new Date());
                    customerPurchaseOrderTransactionDate=new Date();
                    
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

    public CustomerPurchaseOrder getCustomerPurchaseOrder() {
        return customerPurchaseOrder;
    }

    public void setCustomerPurchaseOrder(CustomerPurchaseOrder customerPurchaseOrder) {
        this.customerPurchaseOrder = customerPurchaseOrder;
    }

    public EnumActivity.ENUM_Activity getEnumCustomerPurchaseOrderActivity() {
        return enumCustomerPurchaseOrderActivity;
    }

    public void setEnumCustomerPurchaseOrderActivity(EnumActivity.ENUM_Activity enumCustomerPurchaseOrderActivity) {
        this.enumCustomerPurchaseOrderActivity = enumCustomerPurchaseOrderActivity;
    }

    public String getCustomerPurchaseOrderUpdateMode() {
        return customerPurchaseOrderUpdateMode;
    }

    public void setCustomerPurchaseOrderUpdateMode(String customerPurchaseOrderUpdateMode) {
        this.customerPurchaseOrderUpdateMode = customerPurchaseOrderUpdateMode;
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

    public Date getCustomerPurchaseOrderTransactionDate() {
        return customerPurchaseOrderTransactionDate;
    }

    public void setCustomerPurchaseOrderTransactionDate(Date customerPurchaseOrderTransactionDate) {
        this.customerPurchaseOrderTransactionDate = customerPurchaseOrderTransactionDate;
    }

    public Date getCustomerPurchaseOrderDateFirstSession() {
        return customerPurchaseOrderDateFirstSession;
    }

    public void setCustomerPurchaseOrderDateFirstSession(Date customerPurchaseOrderDateFirstSession) {
        this.customerPurchaseOrderDateFirstSession = customerPurchaseOrderDateFirstSession;
    }

    public Date getCustomerPurchaseOrderDateLastSession() {
        return customerPurchaseOrderDateLastSession;
    }

    public void setCustomerPurchaseOrderDateLastSession(Date customerPurchaseOrderDateLastSession) {
        this.customerPurchaseOrderDateLastSession = customerPurchaseOrderDateLastSession;
    }

    public String getCustomerPurchaseOrderCloneModeCode() {
        return customerPurchaseOrderCloneModeCode;
    }

    public void setCustomerPurchaseOrderCloneModeCode(String customerPurchaseOrderCloneModeCode) {
        this.customerPurchaseOrderCloneModeCode = customerPurchaseOrderCloneModeCode;
    }

    
    
}
