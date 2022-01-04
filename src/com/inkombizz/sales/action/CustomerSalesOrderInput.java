
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerSalesOrderBLL;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-sales-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerSalesOrderInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerSalesOrder salesOrder;    
    private EnumActivity.ENUM_Activity enumSalesOrderActivity;
    private Date salesOrderTransactionDate;
    private Date salesOrderDateFirstSession;
    private Date salesOrderDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerSalesOrderBLL salesOrderBLL = new CustomerSalesOrderBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            salesOrderDateFirstSession = firstDate;
            salesOrderDateLastSession = lastDate;
            
            switch(enumSalesOrderActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(salesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }
                    
                    salesOrder = new CustomerSalesOrder();
                    
                    User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());

                    salesOrder.setCode("AUTO");
                    salesOrder.setCustSONo("AUTO");
                    salesOrder.setTransactionDate(new Date());
                    salesOrder.setBranch(user.getBranch());
                    salesOrder.setRequestDeliveryDate(new Date());
                    salesOrder.setExpiredDate(new Date());
                    salesOrderTransactionDate=new Date();
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(salesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    salesOrder = (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, salesOrder.getCode());
                    salesOrderTransactionDate=salesOrder.getTransactionDate();
                
                    break;
                case REVISE:
                    if (!BaseSession.loadProgramSession().hasAuthority(salesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
                    
                    String refCUSTSOCode=salesOrder.getCode();
                    
                    salesOrder = (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, salesOrder.getCode());
                    salesOrderTransactionDate=salesOrder.getTransactionDate();
//                    salesOrder.setCustomerPurchaseOrderCode(salesOrder.getCustomerPurchaseOrder().getCode());
                    salesOrder.setCustomerSalesOrderCode(salesOrder.getCode());
//                    customerPurchaseOrderToBlanketOrder.setRefCUSTPOCode(customerPurchaseOrderToBlanketOrder.getCustomerPurchaseOrderCode());
                    String newCode=salesOrderBLL.createCodeRevise(enumSalesOrderActivity, salesOrder);
                    salesOrder.setCode(newCode);
                    salesOrder.setRefCUSTSOCode(refCUSTSOCode);
                    salesOrder.setRevision(salesOrder.getCode().substring(salesOrder.getCode().length()-2));
                    salesOrder.setCustomerPurchaseOrderNo(salesOrder.getCustomerPurchaseOrder().getCustomerPurchaseOrderNo());
                    salesOrder.setRetentionPercent(salesOrder.getCustomerPurchaseOrder().getRetentionPercent());
                    salesOrder.setPartialShipmentStatus(salesOrder.getCustomerPurchaseOrder().getPartialShipmentStatus());
                    
                    break;
                case CLONE:
                    if (!BaseSession.loadProgramSession().hasAuthority(salesOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }

                    salesOrder = (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, salesOrder.getCode());
                    salesOrder.setCode("AUTO");
                    salesOrder.setRevision("00");
                    salesOrder.setOrderStatus(salesOrder.getCustomerPurchaseOrder().getOrderStatus());
                    salesOrderTransactionDate=salesOrder.getTransactionDate();
                    
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

    public CustomerSalesOrder getSalesOrder() {
        return salesOrder;
    }

    public void setSalesOrder(CustomerSalesOrder salesOrder) {
        this.salesOrder = salesOrder;
    }

    public Date getSalesOrderTransactionDate() {
        return salesOrderTransactionDate;
    }

    public void setSalesOrderTransactionDate(Date salesOrderTransactionDate) {
        this.salesOrderTransactionDate = salesOrderTransactionDate;
    }

    public Date getSalesOrderDateFirstSession() {
        return salesOrderDateFirstSession;
    }

    public void setSalesOrderDateFirstSession(Date salesOrderDateFirstSession) {
        this.salesOrderDateFirstSession = salesOrderDateFirstSession;
    }

    public Date getSalesOrderDateLastSession() {
        return salesOrderDateLastSession;
    }

    public void setSalesOrderDateLastSession(Date salesOrderDateLastSession) {
        this.salesOrderDateLastSession = salesOrderDateLastSession;
    }

    public EnumActivity.ENUM_Activity getEnumSalesOrderActivity() {
        return enumSalesOrderActivity;
    }

    public void setEnumSalesOrderActivity(EnumActivity.ENUM_Activity enumSalesOrderActivity) {
        this.enumSalesOrderActivity = enumSalesOrderActivity;
    }

    public Date getSalesOrderByCustomerPurchaseOrderTransactionDate() {
        return salesOrderTransactionDate;
    }

    public void setSalesOrderByCustomerPurchaseOrderTransactionDate(Date salesOrderTransactionDate) {
        this.salesOrderTransactionDate = salesOrderTransactionDate;
    }

    public Date getSalesOrderByCustomerPurchaseOrderDateFirstSession() {
        return salesOrderDateFirstSession;
    }

    public void setSalesOrderByCustomerPurchaseOrderDateFirstSession(Date salesOrderDateFirstSession) {
        this.salesOrderDateFirstSession = salesOrderDateFirstSession;
    }

    public Date getSalesOrderByCustomerPurchaseOrderDateLastSession() {
        return salesOrderDateLastSession;
    }

    public void setSalesOrderByCustomerPurchaseOrderDateLastSession(Date salesOrderDateLastSession) {
        this.salesOrderDateLastSession = salesOrderDateLastSession;
    }
    
    
}
