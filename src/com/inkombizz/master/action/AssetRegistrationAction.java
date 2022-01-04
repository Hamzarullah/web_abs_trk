
package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


import com.inkombizz.master.bll.AssetRegistrationBLL;
import com.inkombizz.master.model.AssetRegistration;
import com.inkombizz.master.model.Currency;

@Results({
    @Result(name="success", location="master/asset-registration.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class AssetRegistrationAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private AssetRegistration assetRegistration;
    private String currencyCode = "";
    private String currencyName = "";
    
    @Override
    public String execute() {
        try {
            AssetRegistrationBLL assetRegistrationBLL = new AssetRegistrationBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(assetRegistrationBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }
 
                Currency currency= new Currency();
                currency =(Currency)hbmSession.hSession.get(Currency.class,BaseSession.loadProgramSession().getSetup().getCurrencyCode());
                currencyCode = currency.getCode();
                currencyName = currency.getName();
                
            return SUCCESS;
        }
        
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }    

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public AssetRegistration getAssetRegistration() {
        return assetRegistration;
    }

    public void setAssetRegistration(AssetRegistration assetRegistration) {
        this.assetRegistration = assetRegistration;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getCurrencyName() {
        return currencyName;
    }

    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }

}
