/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.engineering.bll.BillOfMaterialBLL;
import com.inkombizz.engineering.model.BillOfMaterial;
import com.inkombizz.engineering.model.BillOfMaterialPartDetail;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 *
 * @author CHRIST
 */
@Result(type = "json")
public class BillOfMaterialJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    
    private BillOfMaterial billOfMaterial=new BillOfMaterial();
    private BillOfMaterial billOfMaterialApproval=new BillOfMaterial();
    private List<BillOfMaterial> listBillOfMaterial;
    private List<BillOfMaterial> listBillOfMaterialApproval;
    private List<BillOfMaterialPartDetail> listBillOfMaterialDetail;
    private List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail;
    private List<BillOfMaterialPartDetail> listBillOfMaterialApprovalPartDetail;
    private String listBillOfMaterialItemDetailPartJSON;
    private EnumActivity.ENUM_Activity enumBillOfMaterialActivity;
    
    private String billOfMaterialCode = "";
    private String documentOrderCode = "";
    private String docDetailCode = "";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-data")
    public String findData() {
        try {
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);
            
            ListPaging<BillOfMaterial> listPaging = billOfMaterialBLL.findData(paging,billOfMaterial);

            listBillOfMaterial = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-approval-data")
    public String findDataApproval() {
        try {
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);
            
            ListPaging<BillOfMaterial> listPaging = billOfMaterialBLL.findDataApproval(paging,billOfMaterialApproval);

            listBillOfMaterialApproval = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-data-existing")
    public String findDataExisting() {
        try {
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);
            
            ListPaging<BillOfMaterial> listPaging = billOfMaterialBLL.findDataExisting(paging,billOfMaterial);

            listBillOfMaterial = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-detail-data")
    public String findDataDetail() {
        try {
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);
            
            ListPaging <BillOfMaterialPartDetail> listPaging = billOfMaterialBLL.findDataComponentDetail(documentOrderCode);
            listBillOfMaterialDetail = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-part-detail-data")
    public String findDataPartDetail() {
        try {
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);
            
            ListPaging <BillOfMaterialPartDetail> listPaging = billOfMaterialBLL.findDataPartDetail(billOfMaterialCode);
            listBillOfMaterialPartDetail = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-part-detail-approval-data")
    public String findDataPartDetailApproval() {
        try {
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);
            
            ListPaging <BillOfMaterialPartDetail> listPaging = billOfMaterialBLL.findDataPartDetail(billOfMaterialCode);
            listBillOfMaterialApprovalPartDetail = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-for-imr")
    public String findBomArrayImr(){
        try {
            
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);
            List<BillOfMaterialPartDetail> list = billOfMaterialBLL.findBomArrayImr(docDetailCode);
            
            listBillOfMaterialPartDetail = list;
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }

    @Action("bill-of-material-save")
    public String save() {
        try {
                BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);

                Gson gson = new Gson();
                gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listBillOfMaterialPartDetail = gson.fromJson(this.listBillOfMaterialItemDetailPartJSON, new TypeToken<List<BillOfMaterialPartDetail>>(){}.getType());
                                
                if(billOfMaterialBLL.isExist(this.billOfMaterial.getCode())) {
                    billOfMaterialBLL.update(billOfMaterial, listBillOfMaterialPartDetail);
                    this.message = "UPDATE DATA SUCCESS.<br/>BOM No : " + this.billOfMaterial.getCode(); 
                }else{
                    billOfMaterialBLL.save(enumBillOfMaterialActivity,billOfMaterial, listBillOfMaterialPartDetail);
                    this.message = "SAVE DATA SUCCESS.<br/>BOM No : " + this.billOfMaterial.getCode();
                }

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("bill-of-material-approval-save")
    public String saveStatus(){
        String _Messg = "";
        try {
            
            BillOfMaterialBLL billOfMaterialBLL = new BillOfMaterialBLL(hbmSession);
        
            billOfMaterialBLL.approval(billOfMaterialApproval);

            this.message = _Messg + " DATA SUCCESS.<br/>BOM No : " + this.billOfMaterialApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
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

    public List<BillOfMaterial> getListBillOfMaterial() {
        return listBillOfMaterial;
    }

    public void setListBillOfMaterial(List<BillOfMaterial> listBillOfMaterial) {
        this.listBillOfMaterial = listBillOfMaterial;
    }

    public List<BillOfMaterialPartDetail> getListBillOfMaterialPartDetail() {
        return listBillOfMaterialPartDetail;
    }

    public void setListBillOfMaterialPartDetail(List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail) {
        this.listBillOfMaterialPartDetail = listBillOfMaterialPartDetail;
    }

    public String getListBillOfMaterialItemDetailPartJSON() {
        return listBillOfMaterialItemDetailPartJSON;
    }

    public void setListBillOfMaterialItemDetailPartJSON(String listBillOfMaterialItemDetailPartJSON) {
        this.listBillOfMaterialItemDetailPartJSON = listBillOfMaterialItemDetailPartJSON;
    }

    public EnumActivity.ENUM_Activity getEnumBillOfMaterialActivity() {
        return enumBillOfMaterialActivity;
    }

    public void setEnumBillOfMaterialActivity(EnumActivity.ENUM_Activity enumBillOfMaterialActivity) {
        this.enumBillOfMaterialActivity = enumBillOfMaterialActivity;
    }

    public String getBillOfMaterialCode() {
        return billOfMaterialCode;
    }

    public void setBillOfMaterialCode(String billOfMaterialCode) {
        this.billOfMaterialCode = billOfMaterialCode;
    }

    public String getDocumentOrderCode() {
        return documentOrderCode;
    }

    public void setDocumentOrderCode(String documentOrderCode) {
        this.documentOrderCode = documentOrderCode;
    }

    public List<BillOfMaterialPartDetail> getListBillOfMaterialDetail() {
        return listBillOfMaterialDetail;
    }

    public void setListBillOfMaterialDetail(List<BillOfMaterialPartDetail> listBillOfMaterialDetail) {
        this.listBillOfMaterialDetail = listBillOfMaterialDetail;
    }

    public BillOfMaterial getBillOfMaterialApproval() {
        return billOfMaterialApproval;
    }

    public void setBillOfMaterialApproval(BillOfMaterial billOfMaterialApproval) {
        this.billOfMaterialApproval = billOfMaterialApproval;
    }

    public List<BillOfMaterial> getListBillOfMaterialApproval() {
        return listBillOfMaterialApproval;
    }

    public void setListBillOfMaterialApproval(List<BillOfMaterial> listBillOfMaterialApproval) {
        this.listBillOfMaterialApproval = listBillOfMaterialApproval;
    }

    public List<BillOfMaterialPartDetail> getListBillOfMaterialApprovalPartDetail() {
        return listBillOfMaterialApprovalPartDetail;
    }

    public void setListBillOfMaterialApprovalPartDetail(List<BillOfMaterialPartDetail> listBillOfMaterialApprovalPartDetail) {
        this.listBillOfMaterialApprovalPartDetail = listBillOfMaterialApprovalPartDetail;
    }

    public String getDocDetailCode() {
        return docDetailCode;
    }

    public void setDocDetailCode(String docDetailCode) {
        this.docDetailCode = docDetailCode;
    }

    
    
    
    
    // <editor-fold defaultstate="collapsed" desc="Message Info">
    private boolean error = false;
    private String errorMessage = "";
    private String message = "";

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="PAGING">
    
    Paging paging=new Paging();
    
    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }
    
    public Integer getRows() {
        return paging.getRows();
    }
    public void setRows(Integer rows) {
        paging.setRows(rows);
    }
    
    public Integer getPage() {
        return paging.getPage();
    }
    public void setPage(Integer page) {
        paging.setPage(page);
    }
    
    public Integer getTotal() {
        return paging.getTotal();
    }
    public void setTotal(Integer total) {
        paging.setTotal(total);
    }
    
    public Integer getRecords() {
        return paging.getRecords();
    }
    public void setRecords(Integer records) {
        paging.setRecords(records);
        
        if (paging.getRecords() > 0 && paging.getRows() > 0)
            paging.setTotal((int) Math.ceil((double) paging.getRecords() / (double) paging.getRows()));
        else
            paging.setTotal(0);
    }
    
    public String getSord() {
        return paging.getSord();
    }
    public void setSord(String sord) {
        paging.setSord(sord);
    }
    
    public String getSidx() {
        return paging.getSidx();
    }
    public void setSidx(String sidx) {
        paging.setSidx(sidx);
    }
    
    public void setSearchField(String searchField) {
        paging.setSearchField(searchField);
    }
    public void setSearchString(String searchString) {
        paging.setSearchString(searchString);
    }
    public void setSearchOper(String searchOper) {
        paging.setSearchOper(searchOper);
    }
    
    // </editor-fold>
}
