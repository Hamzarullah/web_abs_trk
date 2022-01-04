/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.ItemFinishGoods;
import com.inkombizz.engineering.bll.BillOfMaterialBLL;
import com.inkombizz.engineering.model.BillOfMaterial;
import com.inkombizz.engineering.model.BomTemp;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

/**
 *
 * @author CHRIST
 */

@Results({
    @Result(name="success", location="engineering/bill-of-material-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class BillOfMaterialInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private BillOfMaterial billOfMaterial=new BillOfMaterial();
    private BomTemp billOfMaterialInps=new BomTemp();
    private ItemFinishGoods itemFinishGoods=new ItemFinishGoods();
    private boolean billOfMaterialRevisionMode = false;
    private String documentOrderType="";
    private String documentOrderCode="";
    private String documentOrderDetail="";
    private String headerCode="";
    private String itemFinishGoodsCode="";
    private Date billOfMaterialTransactionDate ;
    private EnumActivity.ENUM_Activity enumBillOfMaterialActivity;
    
    @Override
    public String execute(){
  
        try {                
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);  
            
            switch(enumBillOfMaterialActivity){
                case NEW:
                    if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        return "redirect";
                    }
                    billOfMaterial = new BillOfMaterial();
                    
                    itemFinishGoods = (ItemFinishGoods) hbmSession.hSession.get(ItemFinishGoods.class, itemFinishGoodsCode);
                    billOfMaterialInps = billOfMaterialBLL.getData(documentOrderDetail);
                    
                    billOfMaterial.setCode("AUTO");
                    billOfMaterial.setBomNo("AUTO");
//                    billOfMaterial.setHeaderCode(headerCode);
                    billOfMaterial.setItemFinishGoods(itemFinishGoods);
                    billOfMaterial.setItemFinishGoodsRemark(itemFinishGoods.getRemark());
                    billOfMaterial.setDocumentOrderCode(billOfMaterialInps.getDocumentOrderCode());
                    billOfMaterial.setDocumentDetailCode(billOfMaterialInps.getDocumentOrderDetailCode());
                    billOfMaterial.setTransactionDateDoc(billOfMaterialInps.getTransactionDateDoc());
                    billOfMaterial.setDocumentType(documentOrderType);
                    billOfMaterial.setTransactionDate(new Date());
                    billOfMaterialTransactionDate= new Date();
                    break;
                case UPDATE:
                    if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }

                    billOfMaterial = (BillOfMaterial) hbmSession.hSession.get(BillOfMaterial.class, billOfMaterial.getCode());
                    billOfMaterialInps = billOfMaterialBLL.getData(billOfMaterial.getDocumentDetailCode());
//                    customerPurchaseOrderTransactionDate=customerPurchaseOrder.getTransactionDate();
                    billOfMaterial.setBomNo(billOfMaterial.getBomNo());
                    billOfMaterial.setDocumentOrderCode(documentOrderCode);
                    billOfMaterial.setTransactionDateDoc(billOfMaterialInps.getTransactionDateDoc());
                    billOfMaterialTransactionDate = billOfMaterial.getTransactionDate();
                    break;
                case REVISE:
                    if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        return "redirect";
                    }
                    String refBomCode=billOfMaterial.getCode();
                    
                    billOfMaterial = (BillOfMaterial) hbmSession.hSession.get(BillOfMaterial.class, billOfMaterial.getCode());
                    billOfMaterialInps = billOfMaterialBLL.getData(billOfMaterial.getDocumentDetailCode());
                    billOfMaterialTransactionDate=billOfMaterial.getTransactionDate();
                    String newCode=billOfMaterialBLL.createCode(enumBillOfMaterialActivity, billOfMaterial);
                    billOfMaterial.setCode(newCode);
                    billOfMaterial.setRefBomCode(refBomCode);
                    billOfMaterial.setCodeTemp(refBomCode);
                    billOfMaterial.setRevision(billOfMaterial.getCode().substring(billOfMaterial.getCode().length()-2));
                    billOfMaterial.setDocumentOrderCode(documentOrderCode);
                    billOfMaterial.setTransactionDateDoc(billOfMaterialInps.getTransactionDateDoc());
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

    public BillOfMaterial getBillOfMaterial() {
        return billOfMaterial;
    }

    public void setBillOfMaterial(BillOfMaterial billOfMaterial) {
        this.billOfMaterial = billOfMaterial;
    }

    public ItemFinishGoods getItemFinishGoods() {
        return itemFinishGoods;
    }

    public void setItemFinishGoods(ItemFinishGoods itemFinishGoods) {
        this.itemFinishGoods = itemFinishGoods;
    }

    public boolean isBillOfMaterialRevisionMode() {
        return billOfMaterialRevisionMode;
    }

    public void setBillOfMaterialRevisionMode(boolean billOfMaterialRevisionMode) {
        this.billOfMaterialRevisionMode = billOfMaterialRevisionMode;
    }

    public String getDocumentOrderType() {
        return documentOrderType;
    }

    public void setDocumentOrderType(String documentOrderType) {
        this.documentOrderType = documentOrderType;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getItemFinishGoodsCode() {
        return itemFinishGoodsCode;
    }

    public void setItemFinishGoodsCode(String itemFinishGoodsCode) {
        this.itemFinishGoodsCode = itemFinishGoodsCode;
    }

    public EnumActivity.ENUM_Activity getEnumBillOfMaterialActivity() {
        return enumBillOfMaterialActivity;
    }

    public void setEnumBillOfMaterialActivity(EnumActivity.ENUM_Activity enumBillOfMaterialActivity) {
        this.enumBillOfMaterialActivity = enumBillOfMaterialActivity;
    }

    public String getDocumentOrderCode() {
        return documentOrderCode;
    }

    public void setDocumentOrderCode(String documentOrderCode) {
        this.documentOrderCode = documentOrderCode;
    }

    public String getDocumentOrderDetail() {
        return documentOrderDetail;
    }

    public void setDocumentOrderDetail(String documentOrderDetail) {
        this.documentOrderDetail = documentOrderDetail;
    }

    public Date getBillOfMaterialTransactionDate() {
        return billOfMaterialTransactionDate;
    }

    public void setBillOfMaterialTransactionDate(Date billOfMaterialTransactionDate) {
        this.billOfMaterialTransactionDate = billOfMaterialTransactionDate;
    }
    
    
}
