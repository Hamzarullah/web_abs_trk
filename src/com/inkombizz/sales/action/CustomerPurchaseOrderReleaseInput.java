
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Currency;
import com.inkombizz.sales.bll.CustomerPurchaseOrderReleaseBLL;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Module;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-purchase-order-release-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerPurchaseOrderReleaseInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
//    private CustomerPurchaseOrder customerPurchaseOrderRelease;
    private CustomerSalesOrder customerPurchaseOrderRelease;
    private CustomerPurchaseOrder customerPurchaseOrderReleaseNew;
    private EnumActivity.ENUM_Activity enumCustomerPurchaseOrderReleaseActivity;
    private String customerPurchaseOrderReleaseUpdateMode;
    private String customerPurchaseOrderReleaseCloneModeCode;
    private String customerPurchaseOrderReleaseCode;
    private String customerPurchaseOrderReleaseSalesOrderCode;
    private Currency currency=null;
    private Module module=null;
    private Date customerPurchaseOrderReleaseTransactionDate;
    private Date customerPurchaseOrderReleaseDateFirstSession;
    private Date customerPurchaseOrderReleaseDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerPurchaseOrderReleaseBLL customerPurchaseOrderReleaseBLL = new CustomerPurchaseOrderReleaseBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            customerPurchaseOrderReleaseDateFirstSession = firstDate;
            customerPurchaseOrderReleaseDateLastSession = lastDate;
            
            switch(enumCustomerPurchaseOrderReleaseActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderReleaseBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }
                    
//                    module = (Module) hbmSession.hSession.get(Module.class, customerPurchaseOrderReleaseBLL.MODULECODE);
                    
                    User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());
                    
                
                    customerPurchaseOrderRelease = new CustomerSalesOrder();
                    
                    customerPurchaseOrderRelease.setCode("AUTO");
                    customerPurchaseOrderRelease.setCustSONo("AUTO");
                    customerPurchaseOrderRelease.setTransactionDate(new Date());
                    customerPurchaseOrderRelease.setBranch(user.getBranch()); 
                    customerPurchaseOrderReleaseTransactionDate=new Date();
                    customerPurchaseOrderRelease.setPartialShipmentStatus("NO");
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderReleaseBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
//                    String refCUSTRLCode=customerPurchaseOrderReleaseCode;
                    customerPurchaseOrderRelease = (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, customerPurchaseOrderRelease.getCode());
//                    salesOrder = (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, salesOrder.getCode());
                    customerPurchaseOrderReleaseTransactionDate = customerPurchaseOrderRelease.getCustomerPurchaseOrder().getTransactionDate();
                    customerPurchaseOrderRelease.setCode(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCode());
                    customerPurchaseOrderRelease.setRefCUSTPOCode(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getRefCUSTPOCode());
                    customerPurchaseOrderRelease.setRevision(customerPurchaseOrderRelease.getCode().substring(customerPurchaseOrderRelease.getCode().length()-2));
                    customerPurchaseOrderRelease.setCustomerPurchaseOrderReleaseCode(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCode());
                    customerPurchaseOrderRelease.setCustPONo(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCustPONo());
                    customerPurchaseOrderRelease.setBranch(customerPurchaseOrderRelease.getBranch());
                    customerPurchaseOrderRelease.setCustomerBlanketOrder(customerPurchaseOrderRelease.getCustomerBlanketOrder());
                    customerPurchaseOrderRelease.setRetentionPercent(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getRetentionPercent());
                    customerPurchaseOrderRelease.setPartialShipmentStatus(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getPartialShipmentStatus());
                    customerPurchaseOrderRelease.setCustomerPurchaseOrderNo(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCustomerPurchaseOrderNo());
                    customerPurchaseOrderRelease.setCustomer(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCustomer());
                    customerPurchaseOrderRelease.setEndUser(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getEndUser());
                    customerPurchaseOrderRelease.setCurrency(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCurrency());
                    customerPurchaseOrderRelease.setSalesPerson(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getSalesPerson());
                    customerPurchaseOrderRelease.setProject(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getProject());
                    customerPurchaseOrderRelease.setRemark(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getRemark());
                    customerPurchaseOrderRelease.setRefNo(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getRefNo());
                    
                    break;
                case REVISE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderReleaseBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
                    String refCUSTRLCode=customerPurchaseOrderReleaseCode;
                    
                    customerPurchaseOrderRelease = (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, customerPurchaseOrderReleaseSalesOrderCode);
                    customerPurchaseOrderRelease.setCustPONo(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCustPONo());
                    customerPurchaseOrderRelease.setCustomerPurchaseOrderReleaseCode(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCode());
                    customerPurchaseOrderRelease.setCustomerPurchaseOrderNo(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCustomerPurchaseOrderNo());
                    customerPurchaseOrderRelease.setPartialShipmentStatus(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getPartialShipmentStatus());
                    customerPurchaseOrderReleaseNew = (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, customerPurchaseOrderReleaseCode);
                    String newCode=customerPurchaseOrderReleaseBLL.createCode(enumCustomerPurchaseOrderReleaseActivity, customerPurchaseOrderReleaseNew);
                    customerPurchaseOrderRelease.setTransactionDate(new Date());
                    customerPurchaseOrderReleaseTransactionDate=new Date();
                    
                    customerPurchaseOrderRelease.setCode(newCode);
                    customerPurchaseOrderRelease.setRefCUSTPOCode(refCUSTRLCode);
                    customerPurchaseOrderRelease.setRevision(customerPurchaseOrderRelease.getCode().substring(refCUSTRLCode.length()-2));
                    
                    break;
                case CLONE:
                    if (!BaseSession.loadProgramSession().hasAuthority(customerPurchaseOrderReleaseBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }

                    customerPurchaseOrderRelease = (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, customerPurchaseOrderRelease.getCode());
                    customerPurchaseOrderRelease.setCustomerPurchaseOrderReleaseCode(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCode());
                    customerPurchaseOrderRelease.setCustomerPurchaseOrderCode(customerPurchaseOrderRelease.getCode());
                    customerPurchaseOrderRelease.setCode("AUTO");
                    customerPurchaseOrderRelease.setRevision("00");
                    customerPurchaseOrderRelease.setRefCUSTSOCode("");
                    customerPurchaseOrderRelease.setCustomerPurchaseOrderNo(customerPurchaseOrderRelease.getCustomerPurchaseOrder().getCustomerPurchaseOrderNo());
                    customerPurchaseOrderRelease.setTransactionDate(new Date());
                    customerPurchaseOrderReleaseTransactionDate=new Date();
                    
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

    public EnumActivity.ENUM_Activity getEnumCustomerPurchaseOrderReleaseActivity() {
        return enumCustomerPurchaseOrderReleaseActivity;
    }

    public void setEnumCustomerPurchaseOrderReleaseActivity(EnumActivity.ENUM_Activity enumCustomerPurchaseOrderReleaseActivity) {
        this.enumCustomerPurchaseOrderReleaseActivity = enumCustomerPurchaseOrderReleaseActivity;
    }

    public String getCustomerPurchaseOrderReleaseUpdateMode() {
        return customerPurchaseOrderReleaseUpdateMode;
    }

    public void setCustomerPurchaseOrderReleaseUpdateMode(String customerPurchaseOrderReleaseUpdateMode) {
        this.customerPurchaseOrderReleaseUpdateMode = customerPurchaseOrderReleaseUpdateMode;
    }

    public String getCustomerPurchaseOrderReleaseCloneModeCode() {
        return customerPurchaseOrderReleaseCloneModeCode;
    }

    public void setCustomerPurchaseOrderReleaseCloneModeCode(String customerPurchaseOrderReleaseCloneModeCode) {
        this.customerPurchaseOrderReleaseCloneModeCode = customerPurchaseOrderReleaseCloneModeCode;
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

    public Date getCustomerPurchaseOrderReleaseTransactionDate() {
        return customerPurchaseOrderReleaseTransactionDate;
    }

    public void setCustomerPurchaseOrderReleaseTransactionDate(Date customerPurchaseOrderReleaseTransactionDate) {
        this.customerPurchaseOrderReleaseTransactionDate = customerPurchaseOrderReleaseTransactionDate;
    }

    public Date getCustomerPurchaseOrderReleaseDateFirstSession() {
        return customerPurchaseOrderReleaseDateFirstSession;
    }

    public void setCustomerPurchaseOrderReleaseDateFirstSession(Date customerPurchaseOrderReleaseDateFirstSession) {
        this.customerPurchaseOrderReleaseDateFirstSession = customerPurchaseOrderReleaseDateFirstSession;
    }

    public Date getCustomerPurchaseOrderReleaseDateLastSession() {
        return customerPurchaseOrderReleaseDateLastSession;
    }

    public void setCustomerPurchaseOrderReleaseDateLastSession(Date customerPurchaseOrderReleaseDateLastSession) {
        this.customerPurchaseOrderReleaseDateLastSession = customerPurchaseOrderReleaseDateLastSession;
    }

    public CustomerSalesOrder getCustomerPurchaseOrderRelease() {
        return customerPurchaseOrderRelease;
    }

    public void setCustomerPurchaseOrderRelease(CustomerSalesOrder customerPurchaseOrderRelease) {
        this.customerPurchaseOrderRelease = customerPurchaseOrderRelease;
    }

    public CustomerPurchaseOrder getCustomerPurchaseOrderReleaseNew() {
        return customerPurchaseOrderReleaseNew;
    }

    public void setCustomerPurchaseOrderReleaseNew(CustomerPurchaseOrder customerPurchaseOrderReleaseNew) {
        this.customerPurchaseOrderReleaseNew = customerPurchaseOrderReleaseNew;
    }

    public String getCustomerPurchaseOrderReleaseCode() {
        return customerPurchaseOrderReleaseCode;
    }

    public void setCustomerPurchaseOrderReleaseCode(String customerPurchaseOrderReleaseCode) {
        this.customerPurchaseOrderReleaseCode = customerPurchaseOrderReleaseCode;
    }

    public String getCustomerPurchaseOrderReleaseSalesOrderCode() {
        return customerPurchaseOrderReleaseSalesOrderCode;
    }

    public void setCustomerPurchaseOrderReleaseSalesOrderCode(String customerPurchaseOrderReleaseSalesOrderCode) {
        this.customerPurchaseOrderReleaseSalesOrderCode = customerPurchaseOrderReleaseSalesOrderCode;
    }

}
