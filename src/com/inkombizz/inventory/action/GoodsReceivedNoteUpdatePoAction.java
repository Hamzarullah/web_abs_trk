/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.GoodsReceivedNoteBLL;
import com.inkombizz.inventory.model.GoodsReceivedNote;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author Sukha Vaddhana
 */

@Results({
    @Result(name="success", location="inventory/goods-received-note-update-po.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})

public class GoodsReceivedNoteUpdatePoAction extends ActionSupport{
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private GoodsReceivedNote goodsReceivedNoteUpdatePo = new GoodsReceivedNote();
    
    @Override
    public String execute() {
        try {
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);            
            if (!BaseSession.loadProgramSession().hasAuthority(goodsReceivedNoteBLL.MODULECODE_UPDATE_PO, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
                return "redirect";
            }           
            
            goodsReceivedNoteUpdatePo.setTransactionFirstDate(DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
            goodsReceivedNoteUpdatePo.setTransactionLastDate(DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth()));
                        
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

    public GoodsReceivedNote getGoodsReceivedNoteUpdatePo() {
        return goodsReceivedNoteUpdatePo;
    }

    public void setGoodsReceivedNoteUpdatePo(GoodsReceivedNote goodsReceivedNoteUpdatePo) {
        this.goodsReceivedNoteUpdatePo = goodsReceivedNoteUpdatePo;
    }
    
    
}
