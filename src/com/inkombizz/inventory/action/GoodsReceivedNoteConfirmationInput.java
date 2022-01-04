/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import java.util.Date;

import com.inkombizz.inventory.model.GoodsReceivedNote;
import com.inkombizz.inventory.bll.GoodsReceivedNoteBLL;


@Results({
    @Result(name="success", location="inventory/goods-received-note-confirmation-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
/**
 *
 * @author Rayis
 */
public class GoodsReceivedNoteConfirmationInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private GoodsReceivedNote goodsReceivedNoteConfirmation;
    private Date goodsReceivedNoteConfirmationTransactionDateTemp;
    private Date goodsReceivedNoteConfirmationTransactionDateFirstSession;
    private Date goodsReceivedNoteConfirmationTransactionDateLastSession;
        
    @Override
    public String execute(){
        
        try {                
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);  
            
            goodsReceivedNoteConfirmationTransactionDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            goodsReceivedNoteConfirmationTransactionDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            
            goodsReceivedNoteConfirmation = goodsReceivedNoteBLL.get(goodsReceivedNoteConfirmation.getCode());
//            goodsReceivedNoteConfirmationTransactionDateTemp=goodsReceivedNoteConfirmation.getTransactionDate();
            
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

    public GoodsReceivedNote getGoodsReceivedNoteConfirmation() {
        return goodsReceivedNoteConfirmation;
    }

    public void setGoodsReceivedNoteConfirmation(GoodsReceivedNote goodsReceivedNoteConfirmation) {
        this.goodsReceivedNoteConfirmation = goodsReceivedNoteConfirmation;
    }

    public Date getGoodsReceivedNoteConfirmationTransactionDateFirstSession() {
        return goodsReceivedNoteConfirmationTransactionDateFirstSession;
    }

    public void setGoodsReceivedNoteConfirmationTransactionDateFirstSession(Date goodsReceivedNoteConfirmationTransactionDateFirstSession) {
        this.goodsReceivedNoteConfirmationTransactionDateFirstSession = goodsReceivedNoteConfirmationTransactionDateFirstSession;
    }

    public Date getGoodsReceivedNoteConfirmationTransactionDateLastSession() {
        return goodsReceivedNoteConfirmationTransactionDateLastSession;
    }

    public void setGoodsReceivedNoteConfirmationTransactionDateLastSession(Date goodsReceivedNoteConfirmationTransactionDateLastSession) {
        this.goodsReceivedNoteConfirmationTransactionDateLastSession = goodsReceivedNoteConfirmationTransactionDateLastSession;
    }

    public Date getGoodsReceivedNoteConfirmationTransactionDateTemp() {
        return goodsReceivedNoteConfirmationTransactionDateTemp;
    }

    public void setGoodsReceivedNoteConfirmationTransactionDateTemp(Date goodsReceivedNoteConfirmationTransactionDateTemp) {
        this.goodsReceivedNoteConfirmationTransactionDateTemp = goodsReceivedNoteConfirmationTransactionDateTemp;
    }

    
}
