
package com.inkombizz.ppic.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.bll.ItemMaterialRequestBLL;
import com.inkombizz.ppic.model.ItemMaterialRequest;
import com.inkombizz.security.model.User;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


@Results({
    @Result(name="success", location="ppic/item-material-request-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class ItemMaterialRequestInput extends ActionSupport{
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private ItemMaterialRequest itemMaterialRequest=new ItemMaterialRequest();
    private Date itemMaterialRequestDateFirstSession;
    private Date itemMaterialRequestDateLastSession;
    private EnumActivity.ENUM_Activity enumItemMaterialRequestActivity;
    private Date itemMaterialRequestTransactionDate;
    
    @Override
    public String execute(){
  
        try {                
            ItemMaterialRequestBLL itemMaterialRequestBLL = new ItemMaterialRequestBLL(hbmSession);  
            
            itemMaterialRequestDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            itemMaterialRequestDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            switch(enumItemMaterialRequestActivity){
                    case NEW:
                        if (!BaseSession.loadProgramSession().hasAuthority(itemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                        }

                        itemMaterialRequest = new ItemMaterialRequest();

                        User user = (User) hbmSession.hSession.get(User.class, BaseSession.loadProgramSession().getUserName());

                        itemMaterialRequest.setCode("AUTO");
                        itemMaterialRequest.setTransactionDate(new Date());
                        itemMaterialRequestTransactionDate=new Date();
                        break;
                    
                    case UPDATE:
                        if (!BaseSession.loadProgramSession().hasAuthority(itemMaterialRequestBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                        }
                        
                        itemMaterialRequest = (ItemMaterialRequest) hbmSession.hSession.get(ItemMaterialRequest.class, itemMaterialRequest.getCode());
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

    public ItemMaterialRequest getItemMaterialRequest() {
        return itemMaterialRequest;
    }

    public void setItemMaterialRequest(ItemMaterialRequest itemMaterialRequest) {
        this.itemMaterialRequest = itemMaterialRequest;
    }

    public Date getItemMaterialRequestDateFirstSession() {
        return itemMaterialRequestDateFirstSession;
    }

    public void setItemMaterialRequestDateFirstSession(Date itemMaterialRequestDateFirstSession) {
        this.itemMaterialRequestDateFirstSession = itemMaterialRequestDateFirstSession;
    }

    public Date getItemMaterialRequestDateLastSession() {
        return itemMaterialRequestDateLastSession;
    }

    public void setItemMaterialRequestDateLastSession(Date itemMaterialRequestDateLastSession) {
        this.itemMaterialRequestDateLastSession = itemMaterialRequestDateLastSession;
    }

    public EnumActivity.ENUM_Activity getEnumItemMaterialRequestActivity() {
        return enumItemMaterialRequestActivity;
    }

    public void setEnumItemMaterialRequestActivity(EnumActivity.ENUM_Activity enumItemMaterialRequestActivity) {
        this.enumItemMaterialRequestActivity = enumItemMaterialRequestActivity;
    }

    public Date getItemMaterialRequestTransactionDate() {
        return itemMaterialRequestTransactionDate;
    }

    public void setItemMaterialRequestTransactionDate(Date itemMaterialRequestTransactionDate) {
        this.itemMaterialRequestTransactionDate = itemMaterialRequestTransactionDate;
    }
    
}