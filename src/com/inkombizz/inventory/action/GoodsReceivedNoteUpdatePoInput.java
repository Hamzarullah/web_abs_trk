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
    @Result(name="success", location="inventory/goods-received-note-update-po-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
/**
 *
 * @author Rayis
 */
public class GoodsReceivedNoteUpdatePoInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    
    private GoodsReceivedNote goodsReceivedNoteUpdatePo;
    private Date goodsReceivedNoteUpdatePoTransactionDateFirstSession;
    private Date goodsReceivedNoteUpdatePoTransactionDateLastSession;
    private Date goodsReceivedNoteUpdatePoTransactionDate;
    private Date goodsReceivedNoteUpdatePoTransactionDateTemp;
    private String rackDockInName;
    @Override
    public String execute(){
  
        try {                
            GoodsReceivedNoteBLL goodsReceivedNoteUpdateBLL = new GoodsReceivedNoteBLL(hbmSession);  
                        
            goodsReceivedNoteUpdatePoTransactionDateFirstSession=DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
            goodsReceivedNoteUpdatePoTransactionDateLastSession=DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
     
            goodsReceivedNoteUpdatePo = goodsReceivedNoteUpdateBLL.get(goodsReceivedNoteUpdatePo.getCode());
            goodsReceivedNoteUpdatePoTransactionDate=goodsReceivedNoteUpdatePo.getTransactionDate();
            goodsReceivedNoteUpdatePoTransactionDateTemp=goodsReceivedNoteUpdatePo.getTransactionDate();

            Rack rack = (Rack) hbmSession.hSession.get(Rack.class, goodsReceivedNoteUpdatePo.getWarehouse().getDockInCode());
            rackDockInName = rack.getName();
            
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

    public GoodsReceivedNote getGoodsReceivedNoteUpdatePo() {
        return goodsReceivedNoteUpdatePo;
    }

    public void setGoodsReceivedNoteUpdatePo(GoodsReceivedNote goodsReceivedNoteUpdatePo) {
        this.goodsReceivedNoteUpdatePo = goodsReceivedNoteUpdatePo;
    }

    public Date getGoodsReceivedNoteUpdatePoTransactionDateFirstSession() {
        return goodsReceivedNoteUpdatePoTransactionDateFirstSession;
    }

    public void setGoodsReceivedNoteUpdatePoTransactionDateFirstSession(Date goodsReceivedNoteUpdatePoTransactionDateFirstSession) {
        this.goodsReceivedNoteUpdatePoTransactionDateFirstSession = goodsReceivedNoteUpdatePoTransactionDateFirstSession;
    }

    public Date getGoodsReceivedNoteUpdatePoTransactionDateLastSession() {
        return goodsReceivedNoteUpdatePoTransactionDateLastSession;
    }

    public void setGoodsReceivedNoteUpdatePoTransactionDateLastSession(Date goodsReceivedNoteUpdatePoTransactionDateLastSession) {
        this.goodsReceivedNoteUpdatePoTransactionDateLastSession = goodsReceivedNoteUpdatePoTransactionDateLastSession;
    }

    public Date getGoodsReceivedNoteUpdatePoTransactionDate() {
        return goodsReceivedNoteUpdatePoTransactionDate;
    }

    public void setGoodsReceivedNoteUpdatePoTransactionDate(Date goodsReceivedNoteUpdatePoTransactionDate) {
        this.goodsReceivedNoteUpdatePoTransactionDate = goodsReceivedNoteUpdatePoTransactionDate;
    }

    public Date getGoodsReceivedNoteUpdatePoTransactionDateTemp() {
        return goodsReceivedNoteUpdatePoTransactionDateTemp;
    }

    public void setGoodsReceivedNoteUpdatePoTransactionDateTemp(Date goodsReceivedNoteUpdatePoTransactionDateTemp) {
        this.goodsReceivedNoteUpdatePoTransactionDateTemp = goodsReceivedNoteUpdatePoTransactionDateTemp;
    }

    public String getRackDockInName() {
        return rackDockInName;
    }

    public void setRackDockInName(String rackDockInName) {
        this.rackDockInName = rackDockInName;
    }

    
}
