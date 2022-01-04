/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.bll.GoodsReceivedNoteBLL;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import java.util.Date;

import com.inkombizz.inventory.model.GoodsReceivedNote;
import com.inkombizz.master.model.Rack;
//import com.inkombizz.inventory.bll.GoodsReceivedNoteLocalBLL;


@Results({
    @Result(name="success", location="inventory/goods-received-note-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
/**
 *
 * @author Rayis
 */
public class GoodsReceivedNoteInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    
    private GoodsReceivedNote goodsReceivedNote;
    private EnumActivity.ENUM_Activity enumGoodsReceivedNoteActivity;
    private boolean goodsReceivedNoteUpdateMode = false;
    private Date goodsReceivedNoteTransactionDateFirstSession;
    private Date goodsReceivedNoteTransactionDateLastSession;
    private Date goodsReceivedNoteTransactionDate;
    private Date goodsReceivedNoteTransactionDateTemp;
    private String rackDockInName;
    @Override
    public String execute(){
  
        try {                
            GoodsReceivedNoteBLL goodsReceivedNoteBLL = new GoodsReceivedNoteBLL(hbmSession);  
                        
            goodsReceivedNoteTransactionDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            goodsReceivedNoteTransactionDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
                         
            switch(enumGoodsReceivedNoteActivity){
                case NEW:
                    goodsReceivedNote = new GoodsReceivedNote();
                    goodsReceivedNote.setCode("AUTO");
                    goodsReceivedNote.setTransactionDate(new Date());
                    goodsReceivedNoteTransactionDate=new Date();
                    goodsReceivedNoteTransactionDateTemp = new Date();
                    break;
                case UPDATE:
                    goodsReceivedNote = goodsReceivedNoteBLL.get(goodsReceivedNote.getCode());
                    goodsReceivedNoteTransactionDate=goodsReceivedNote.getTransactionDate();
                    goodsReceivedNoteTransactionDateTemp=goodsReceivedNote.getTransactionDate();
                    
                    Rack rack = (Rack) hbmSession.hSession.get(Rack.class, goodsReceivedNote.getWarehouse().getDockInCode());
                    rackDockInName = rack.getName();
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

    public GoodsReceivedNote getGoodsReceivedNote() {
        return goodsReceivedNote;
    }

    public void setGoodsReceivedNote(GoodsReceivedNote goodsReceivedNote) {
        this.goodsReceivedNote = goodsReceivedNote;
    }

    public EnumActivity.ENUM_Activity getEnumGoodsReceivedNoteActivity() {
        return enumGoodsReceivedNoteActivity;
    }

    public void setEnumGoodsReceivedNoteActivity(EnumActivity.ENUM_Activity enumGoodsReceivedNoteActivity) {
        this.enumGoodsReceivedNoteActivity = enumGoodsReceivedNoteActivity;
    }

    public boolean isGoodsReceivedNoteUpdateMode() {
        return goodsReceivedNoteUpdateMode;
    }

    public void setGoodsReceivedNoteUpdateMode(boolean goodsReceivedNoteUpdateMode) {
        this.goodsReceivedNoteUpdateMode = goodsReceivedNoteUpdateMode;
    }

    public Date getGoodsReceivedNoteTransactionDateFirstSession() {
        return goodsReceivedNoteTransactionDateFirstSession;
    }

    public void setGoodsReceivedNoteTransactionDateFirstSession(Date goodsReceivedNoteTransactionDateFirstSession) {
        this.goodsReceivedNoteTransactionDateFirstSession = goodsReceivedNoteTransactionDateFirstSession;
    }

    public Date getGoodsReceivedNoteTransactionDateLastSession() {
        return goodsReceivedNoteTransactionDateLastSession;
    }

    public void setGoodsReceivedNoteTransactionDateLastSession(Date goodsReceivedNoteTransactionDateLastSession) {
        this.goodsReceivedNoteTransactionDateLastSession = goodsReceivedNoteTransactionDateLastSession;
    }

    public Date getGoodsReceivedNoteTransactionDate() {
        return goodsReceivedNoteTransactionDate;
    }

    public void setGoodsReceivedNoteTransactionDate(Date goodsReceivedNoteTransactionDate) {
        this.goodsReceivedNoteTransactionDate = goodsReceivedNoteTransactionDate;
    }

    public Date getGoodsReceivedNoteTransactionDateTemp() {
        return goodsReceivedNoteTransactionDateTemp;
    }

    public void setGoodsReceivedNoteTransactionDateTemp(Date goodsReceivedNoteTransactionDateTemp) {
        this.goodsReceivedNoteTransactionDateTemp = goodsReceivedNoteTransactionDateTemp;
    }

    public String getRackDockInName() {
        return rackDockInName;
    }

    public void setRackDockInName(String rackDockInName) {
        this.rackDockInName = rackDockInName;
    }
    
}
