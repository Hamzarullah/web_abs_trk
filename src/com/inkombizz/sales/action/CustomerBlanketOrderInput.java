
package com.inkombizz.sales.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.bll.CustomerBlanketOrderBLL;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="sales/customer-blanket-order-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class CustomerBlanketOrderInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private CustomerBlanketOrder blanketOrder;    
    private EnumActivity.ENUM_Activity enumBlanketOrderActivity;
    private Date blanketOrderTransactionDate;
    private Date blanketOrderDateFirstSession;
    private Date blanketOrderDateLastSession;
    
    @Override
    public String execute() throws Exception {
  
        try {
            CustomerBlanketOrderBLL blanketOrderBLL = new CustomerBlanketOrderBLL(hbmSession);
            
            Date firstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            Date lastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());

            blanketOrderDateFirstSession = firstDate;
            blanketOrderDateLastSession = lastDate;
            
            switch(enumBlanketOrderActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(blanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }
                    
                    blanketOrder = new CustomerBlanketOrder();

                    blanketOrder.setCode("AUTO");
                    blanketOrder.setCustBONo("AUTO");
                    blanketOrder.setTransactionDate(new Date());
                    blanketOrder.setRequestDeliveryDate(new Date());
                    blanketOrder.setExpiredDate(new Date());
                    blanketOrderTransactionDate=new Date();
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(blanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    blanketOrder = (CustomerBlanketOrder) hbmSession.hSession.get(CustomerBlanketOrder.class, blanketOrder.getCode());
                    blanketOrderTransactionDate=blanketOrder.getTransactionDate();
                
                    break;
                case REVISE:
                    if (!BaseSession.loadProgramSession().hasAuthority(blanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
                    String refCUSTBOCode=blanketOrder.getCode();
                    
                    blanketOrder = (CustomerBlanketOrder) hbmSession.hSession.get(CustomerBlanketOrder.class, blanketOrder.getCode());
                    blanketOrderTransactionDate=blanketOrder.getTransactionDate();
//                    blanketOrder.setCustomerPurchaseOrderCode(blanketOrder.getCustomerPurchaseOrder().getCode());
                    blanketOrder.setCustomerBlanketOrderCode(blanketOrder.getCode());
//                    customerPurchaseOrderToBlanketOrder.setRefCUSTPOCode(customerPurchaseOrderToBlanketOrder.getCustomerPurchaseOrderCode());
                    String newCode=blanketOrderBLL.createCodeRevise(enumBlanketOrderActivity, blanketOrder);
                    blanketOrder.setCode(newCode);
                    blanketOrder.setRefCUSTBOCode(refCUSTBOCode);
                    blanketOrder.setRevision(blanketOrder.getCode().substring(blanketOrder.getCode().length()-2));
                    blanketOrder.setCustomerPurchaseOrderNo(blanketOrder.getCustomerPurchaseOrder().getCustomerPurchaseOrderNo());
                    blanketOrder.setRetentionPercent(blanketOrder.getCustomerPurchaseOrder().getRetentionPercent());
                    blanketOrder.setPartialShipmentStatus(blanketOrder.getCustomerPurchaseOrder().getPartialShipmentStatus());

                    break;
                case CLONE:
                    if (!BaseSession.loadProgramSession().hasAuthority(blanketOrderBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }

                    blanketOrder = (CustomerBlanketOrder) hbmSession.hSession.get(CustomerBlanketOrder.class, blanketOrder.getCode());
                    blanketOrder.setCode("AUTO");
                    blanketOrder.setRevision("00");
                    blanketOrderTransactionDate=blanketOrder.getTransactionDate();
                    
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

    public CustomerBlanketOrder getBlanketOrder() {
        return blanketOrder;
    }

    public void setBlanketOrder(CustomerBlanketOrder blanketOrder) {
        this.blanketOrder = blanketOrder;
    }

    public EnumActivity.ENUM_Activity getEnumBlanketOrderActivity() {
        return enumBlanketOrderActivity;
    }

    public void setEnumBlanketOrderActivity(EnumActivity.ENUM_Activity enumBlanketOrderActivity) {
        this.enumBlanketOrderActivity = enumBlanketOrderActivity;
    }

    public Date getBlanketOrderTransactionDate() {
        return blanketOrderTransactionDate;
    }

    public void setBlanketOrderTransactionDate(Date blanketOrderTransactionDate) {
        this.blanketOrderTransactionDate = blanketOrderTransactionDate;
    }

    public Date getBlanketOrderDateFirstSession() {
        return blanketOrderDateFirstSession;
    }

    public void setBlanketOrderDateFirstSession(Date blanketOrderDateFirstSession) {
        this.blanketOrderDateFirstSession = blanketOrderDateFirstSession;
    }

    public Date getBlanketOrderDateLastSession() {
        return blanketOrderDateLastSession;
    }

    public void setBlanketOrderDateLastSession(Date blanketOrderDateLastSession) {
        this.blanketOrderDateLastSession = blanketOrderDateLastSession;
    }

    
}
