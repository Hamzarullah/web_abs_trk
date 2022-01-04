/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.ItemFinishGoods;
import com.inkombizz.engineering.bll.BillOfMaterialBLL;
import com.inkombizz.engineering.model.BillOfMaterial;
import com.inkombizz.engineering.model.BomTemp;
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
    @Result(name="success", location="engineering/bill-of-material-approval-input.jsp"),
    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
})
public class BillOfMaterialApprovalInput extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    private BillOfMaterial billOfMaterialApproval=new BillOfMaterial();
    private BomTemp billOfMaterialInps=new BomTemp();
    private ItemFinishGoods itemFinishGoods=new ItemFinishGoods();
    private String documentOrderType="";
    private String documentOrderCode="";
    private String documentDetailCode="";
    private Date transactionDateDoc ;
    
    @Override
    public String execute(){
  
        try {                
            BillOfMaterialBLL billOfMaterialApprovalBLL = new BillOfMaterialBLL(hbmSession);  

            if (!BaseSession.loadProgramSession().hasAuthority(billOfMaterialApprovalBLL.MODULECODE_APPROVAL, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                return "redirect";
            }

            billOfMaterialApproval = (BillOfMaterial) hbmSession.hSession.get(BillOfMaterial.class, billOfMaterialApproval.getCode());
            billOfMaterialInps = billOfMaterialApprovalBLL.getData(documentDetailCode);
            billOfMaterialApproval.setBomNo(billOfMaterialApproval.getBomNo());
            billOfMaterialApproval.setDocumentOrderCode(documentOrderCode);
            billOfMaterialApproval.setTransactionDateDoc(billOfMaterialInps.getTransactionDateDoc());
                    
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
        return billOfMaterialApproval;
    }

    public void setBillOfMaterial(BillOfMaterial billOfMaterialApproval) {
        this.billOfMaterialApproval = billOfMaterialApproval;
    }

    public ItemFinishGoods getItemFinishGoods() {
        return itemFinishGoods;
    }

    public void setItemFinishGoods(ItemFinishGoods itemFinishGoods) {
        this.itemFinishGoods = itemFinishGoods;
    }

    public String getDocumentOrderType() {
        return documentOrderType;
    }

    public void setDocumentOrderType(String documentOrderType) {
        this.documentOrderType = documentOrderType;
    }

    public String getDocumentOrderCode() {
        return documentOrderCode;
    }

    public void setDocumentOrderCode(String documentOrderCode) {
        this.documentOrderCode = documentOrderCode;
    }

    public Date getTransactionDateDoc() {
        return transactionDateDoc;
    }

    public void setTransactionDateDoc(Date transactionDateDoc) {
        this.transactionDateDoc = transactionDateDoc;
    }

    public BillOfMaterial getBillOfMaterialApproval() {
        return billOfMaterialApproval;
    }

    public void setBillOfMaterialApproval(BillOfMaterial billOfMaterialApproval) {
        this.billOfMaterialApproval = billOfMaterialApproval;
    }

    public BomTemp getBillOfMaterialInps() {
        return billOfMaterialInps;
    }

    public void setBillOfMaterialInps(BomTemp billOfMaterialInps) {
        this.billOfMaterialInps = billOfMaterialInps;
    }

    public String getDocumentDetailCode() {
        return documentDetailCode;
    }

    public void setDocumentDetailCode(String documentDetailCode) {
        this.documentDetailCode = documentDetailCode;
    }
    
    

}
