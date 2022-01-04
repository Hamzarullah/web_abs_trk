/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.inkombizz.inventory.bll.GoodsReceivedNoteBLL;
import com.inkombizz.inventory.model.GoodsReceivedNote;
import com.inkombizz.utils.DateUtils;

@Results({
    @Result(name="success", location="inventory/goods-received-note-confirmation.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
/**
 *
 * @author Rayis
 */
public class GoodsReceivedNoteConfirmationAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private GoodsReceivedNote goodsReceivedNoteConfirmation=new GoodsReceivedNote();;
        
    @Override
    public String execute() {
        try {
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(goodsReceivedNoteBLL.MODULECODE_CONFIRMATION, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
            goodsReceivedNoteConfirmation.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            goodsReceivedNoteConfirmation.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
                        
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

    public GoodsReceivedNote getGoodsReceivedNoteConfirmation() {
        return goodsReceivedNoteConfirmation;
    }

    public void setGoodsReceivedNoteConfirmation(GoodsReceivedNote goodsReceivedNoteConfirmation) {
        this.goodsReceivedNoteConfirmation = goodsReceivedNoteConfirmation;
    }

}