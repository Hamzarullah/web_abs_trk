
package com.inkombizz.ppic.action;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.ppic.bll.ProductionPlanningOrderBLL;
import com.inkombizz.ppic.model.ProductionPlanningOrder;
import com.inkombizz.ppic.model.ProductionPlanningOrderItemDetail;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result(type = "json")
public class ProductionPlanningOrderJsonAction extends ActionSupport{
     
    private static final long serialVersionUID = 1L;
    protected HBMSession hbmSession = new HBMSession();
    
    private ProductionPlanningOrder productionPlanningOrder=new ProductionPlanningOrder();
    private ProductionPlanningOrder productionPlanningOrderItemBillOfMaterial=new ProductionPlanningOrder();
    private ProductionPlanningOrder productionPlanningOrderApproval;
    private ProductionPlanningOrder productionPlanningOrderClosing;
    private List<ProductionPlanningOrder> listProductionPlanningOrder;
    private List<ProductionPlanningOrder> listProductionPlanningOrderItemBillOfMaterial;
    private List<ProductionPlanningOrder> listProductionPlanningOrderApproval;
    private List<ProductionPlanningOrder> listProductionPlanningOrderClosing;
    
    private ProductionPlanningOrderItemDetail productionPlanningOrderItemDetail;
    private List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderItemDetail;
    private List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderItemBillOfMaterialDetail;
    private List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderApprovalItemDetail;
    private List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderClosingItemDetail;
    
    private String listProductionPlanningOrderItemDetailJSON;
    
    private String productionPlanningOrderApprovalSearchCode="";
    private String productionPlanningOrderApprovalSearchRemark="";
    private String productionPlanningOrderApprovalSearchRefNo="";
    private Date productionPlanningOrderApprovalSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date productionPlanningOrderApprovalSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String productionPlanningOrderApprovalSearchCustomerCode="";
    private String productionPlanningOrderApprovalSearchCustomerName="";
    private String productionPlanningOrderApprovalSearchApprovalStatus="PENDING";
    private String productionPlanningOrderApprovalSearchDocumentType="";
    
    private String productionPlanningOrderClosingSearchCode="";
    private String productionPlanningOrderClosingSearchRemark="";
    private String productionPlanningOrderClosingSearchRefNo="";
    private Date productionPlanningOrderClosingSearchFirstDate = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private Date productionPlanningOrderClosingSearchLastDate = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private String productionPlanningOrderClosingSearchCustomerCode="";
    private String productionPlanningOrderClosingSearchCustomerName="";
    private String productionPlanningOrderClosingSearchClosingStatus="";
    private String productionPlanningOrderClosingSearchDocumentType="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-data")
    public String findData() {
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            
            ListPaging<ProductionPlanningOrder> listPaging = productionPlanningBLL.findData(paging,productionPlanningOrder);

            listProductionPlanningOrder = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("product-planning-order-search-data")
    public String findDataSearch() {
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            
            ListPaging<ProductionPlanningOrder> listPaging = productionPlanningBLL.findDataSearch(paging,productionPlanningOrder);

            listProductionPlanningOrder = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-item-bill-of-material-find-data")
    public String findDataBom() {
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            
            ListPaging<ProductionPlanningOrder> listPaging = productionPlanningBLL.findDataBom(paging,productionPlanningOrderItemBillOfMaterial);

            listProductionPlanningOrderItemBillOfMaterial = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-detail-data")
    public String findDataItemDetail(){
        try {
            
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            List<ProductionPlanningOrderItemDetail> list = productionPlanningBLL.findDataItemDetail(this.productionPlanningOrder.getCode(),this.productionPlanningOrder.getDocumentType());

            listProductionPlanningOrderItemDetail = list;
            
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-detail-data-imr")
    public String findDataItemDetailImr(){
        try {
            
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            List<ProductionPlanningOrderItemDetail> list = productionPlanningBLL.findDataItemDetail(this.productionPlanningOrder.getCode(),this.productionPlanningOrder.getDocumentType());

            listProductionPlanningOrderItemDetail = list;
            
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-bom-detail-data")
    public String findDataBomItemDetail(){
        try {
            
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            List<ProductionPlanningOrderItemDetail> list = productionPlanningBLL.findDataBomItemDetail(this.productionPlanningOrder.getCode());

            listProductionPlanningOrderItemBillOfMaterialDetail = list;
            
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-approval-detail-data")
    public String findApprovalDataItemDetail(){
        try {
            
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            List<ProductionPlanningOrderItemDetail> list = productionPlanningBLL.findApprovalDataItemDetail(this.productionPlanningOrderApproval.getCode(),this.productionPlanningOrderApproval.getDocumentType());

            listProductionPlanningOrderApprovalItemDetail = list;
            
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-closing-detail-data")
    public String findClosingDataItemDetail(){
        try {
            
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            List<ProductionPlanningOrderItemDetail> list = productionPlanningBLL.findClosingDataItemDetail(this.productionPlanningOrderClosing.getCode(),this.productionPlanningOrderClosing.getDocumentType());

            listProductionPlanningOrderClosingItemDetail = list;
            
            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-approval-data")
    public String findApprovalData() {
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            
            ListPaging<ProductionPlanningOrder> listPaging = productionPlanningBLL.findApprovalData(paging,productionPlanningOrderApprovalSearchCode,productionPlanningOrderApprovalSearchRemark,productionPlanningOrderApprovalSearchRefNo,
                    productionPlanningOrderApprovalSearchFirstDate,productionPlanningOrderApprovalSearchLastDate,productionPlanningOrderApprovalSearchCustomerCode,productionPlanningOrderApprovalSearchCustomerName,productionPlanningOrderApprovalSearchApprovalStatus,
                    productionPlanningOrderApprovalSearchDocumentType);

            listProductionPlanningOrderApproval = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-closing-data")
    public String findClosingData() {
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            
            ListPaging<ProductionPlanningOrder> listPaging = productionPlanningBLL.findClosingData(paging,productionPlanningOrderClosingSearchCode,productionPlanningOrderClosingSearchRemark,productionPlanningOrderClosingSearchRefNo,
                    productionPlanningOrderClosingSearchFirstDate,productionPlanningOrderClosingSearchLastDate,productionPlanningOrderClosingSearchCustomerCode,productionPlanningOrderClosingSearchCustomerName,productionPlanningOrderClosingSearchClosingStatus,
                    productionPlanningOrderApprovalSearchDocumentType);

            listProductionPlanningOrderClosing = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
        
    @Action("production-planning-order-save")
    public String save() {
        try {
                ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);

                Gson gson = new Gson();
                gson =  new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
                
                this.listProductionPlanningOrderItemDetail = gson.fromJson(this.listProductionPlanningOrderItemDetailJSON, new TypeToken<List<ProductionPlanningOrderItemDetail>>(){}.getType());
                                
                if(productionPlanningBLL.isExist(this.productionPlanningOrder.getCode())) {
                    productionPlanningBLL.update(productionPlanningOrder, listProductionPlanningOrderItemDetail);
                    this.message = "UPDATE DATA SUCCESS.<br/>PPO No : " + this.productionPlanningOrder.getCode(); 
                }else{
                    
                    productionPlanningBLL.save(productionPlanningOrder, listProductionPlanningOrderItemDetail);
                    this.message = "SAVE DATA SUCCESS.<br/>PPO No : " + this.productionPlanningOrder.getCode();
                }

                return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED.<br/>MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-approval-save")
    public String saveApproval(){
        String _Messg = "";
        try {
            
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
        
            productionPlanningBLL.approval(productionPlanningOrderApproval);

            this.message = _Messg + " DATA SUCCESS.<br/>PPO No : " + this.productionPlanningOrderApproval.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-closing-save")
    public String saveClosing(){
        String _Messg = "";
        try {
            
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
        
            productionPlanningBLL.closing(productionPlanningOrderClosing);

            this.message = _Messg + " DATA SUCCESS.<br/>PPO No : " + this.productionPlanningOrderClosing.getCode();

            return SUCCESS;
        } catch (Exception e) {
            this.error = true;
            this.errorMessage = _Messg + " DATA FAILED.<br/>MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("production-planning-order-delete")
    public String delete(){
        String _Messg = "DELETE";
        try {
            ProductionPlanningOrderBLL productionPlanningBLL = new ProductionPlanningOrderBLL(hbmSession);
            if (!BaseSession.loadProgramSession().hasAuthority(productionPlanningBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            } 
            productionPlanningBLL.delete(this.productionPlanningOrder.getCode());
             this.message = _Messg + " DATA SUCCESS.<br/>PPO No : " + this.productionPlanningOrder.getCode();

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

    public ProductionPlanningOrder getProductionPlanningOrder() {
        return productionPlanningOrder;
    }

    public void setProductionPlanningOrder(ProductionPlanningOrder productionPlanningOrder) {
        this.productionPlanningOrder = productionPlanningOrder;
    }

    public ProductionPlanningOrder getProductionPlanningOrderApproval() {
        return productionPlanningOrderApproval;
    }

    public void setProductionPlanningOrderApproval(ProductionPlanningOrder productionPlanningOrderApproval) {
        this.productionPlanningOrderApproval = productionPlanningOrderApproval;
    }

    public List<ProductionPlanningOrder> getListProductionPlanningOrder() {
        return listProductionPlanningOrder;
    }

    public void setListProductionPlanningOrder(List<ProductionPlanningOrder> listProductionPlanningOrder) {
        this.listProductionPlanningOrder = listProductionPlanningOrder;
    }

    public List<ProductionPlanningOrder> getListProductionPlanningOrderApproval() {
        return listProductionPlanningOrderApproval;
    }

    public void setListProductionPlanningOrderApproval(List<ProductionPlanningOrder> listProductionPlanningOrderApproval) {
        this.listProductionPlanningOrderApproval = listProductionPlanningOrderApproval;
    }

    public ProductionPlanningOrderItemDetail getProductionPlanningOrderItemDetail() {
        return productionPlanningOrderItemDetail;
    }

    public void setProductionPlanningOrderItemDetail(ProductionPlanningOrderItemDetail productionPlanningOrderItemDetail) {
        this.productionPlanningOrderItemDetail = productionPlanningOrderItemDetail;
    }

    public List<ProductionPlanningOrderItemDetail> getListProductionPlanningOrderItemDetail() {
        return listProductionPlanningOrderItemDetail;
    }

    public void setListProductionPlanningOrderItemDetail(List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderItemDetail) {
        this.listProductionPlanningOrderItemDetail = listProductionPlanningOrderItemDetail;
    }

    public List<ProductionPlanningOrderItemDetail> getListProductionPlanningOrderApprovalItemDetail() {
        return listProductionPlanningOrderApprovalItemDetail;
    }

    public void setListProductionPlanningOrderApprovalItemDetail(List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderApprovalItemDetail) {
        this.listProductionPlanningOrderApprovalItemDetail = listProductionPlanningOrderApprovalItemDetail;
    }

    public String getListProductionPlanningOrderItemDetailJSON() {
        return listProductionPlanningOrderItemDetailJSON;
    }

    public void setListProductionPlanningOrderItemDetailJSON(String listProductionPlanningOrderItemDetailJSON) {
        this.listProductionPlanningOrderItemDetailJSON = listProductionPlanningOrderItemDetailJSON;
    }

    public String getProductionPlanningOrderApprovalSearchCode() {
        return productionPlanningOrderApprovalSearchCode;
    }

    public void setProductionPlanningOrderApprovalSearchCode(String productionPlanningOrderApprovalSearchCode) {
        this.productionPlanningOrderApprovalSearchCode = productionPlanningOrderApprovalSearchCode;
    }

    public String getProductionPlanningOrderApprovalSearchRemark() {
        return productionPlanningOrderApprovalSearchRemark;
    }

    public void setProductionPlanningOrderApprovalSearchRemark(String productionPlanningOrderApprovalSearchRemark) {
        this.productionPlanningOrderApprovalSearchRemark = productionPlanningOrderApprovalSearchRemark;
    }

    public String getProductionPlanningOrderApprovalSearchRefNo() {
        return productionPlanningOrderApprovalSearchRefNo;
    }

    public void setProductionPlanningOrderApprovalSearchRefNo(String productionPlanningOrderApprovalSearchRefNo) {
        this.productionPlanningOrderApprovalSearchRefNo = productionPlanningOrderApprovalSearchRefNo;
    }

    public Date getProductionPlanningOrderApprovalSearchFirstDate() {
        return productionPlanningOrderApprovalSearchFirstDate;
    }

    public void setProductionPlanningOrderApprovalSearchFirstDate(Date productionPlanningOrderApprovalSearchFirstDate) {
        this.productionPlanningOrderApprovalSearchFirstDate = productionPlanningOrderApprovalSearchFirstDate;
    }

    public Date getProductionPlanningOrderApprovalSearchLastDate() {
        return productionPlanningOrderApprovalSearchLastDate;
    }

    public void setProductionPlanningOrderApprovalSearchLastDate(Date productionPlanningOrderApprovalSearchLastDate) {
        this.productionPlanningOrderApprovalSearchLastDate = productionPlanningOrderApprovalSearchLastDate;
    }

    public String getProductionPlanningOrderApprovalSearchCustomerCode() {
        return productionPlanningOrderApprovalSearchCustomerCode;
    }

    public void setProductionPlanningOrderApprovalSearchCustomerCode(String productionPlanningOrderApprovalSearchCustomerCode) {
        this.productionPlanningOrderApprovalSearchCustomerCode = productionPlanningOrderApprovalSearchCustomerCode;
    }

    public String getProductionPlanningOrderApprovalSearchCustomerName() {
        return productionPlanningOrderApprovalSearchCustomerName;
    }

    public void setProductionPlanningOrderApprovalSearchCustomerName(String productionPlanningOrderApprovalSearchCustomerName) {
        this.productionPlanningOrderApprovalSearchCustomerName = productionPlanningOrderApprovalSearchCustomerName;
    }

    public String getProductionPlanningOrderApprovalSearchApprovalStatus() {
        return productionPlanningOrderApprovalSearchApprovalStatus;
    }

    public void setProductionPlanningOrderApprovalSearchApprovalStatus(String productionPlanningOrderApprovalSearchApprovalStatus) {
        this.productionPlanningOrderApprovalSearchApprovalStatus = productionPlanningOrderApprovalSearchApprovalStatus;
    }

    public String getProductionPlanningOrderApprovalSearchDocumentType() {
        return productionPlanningOrderApprovalSearchDocumentType;
    }

    public void setProductionPlanningOrderApprovalSearchDocumentType(String productionPlanningOrderApprovalSearchDocumentType) {
        this.productionPlanningOrderApprovalSearchDocumentType = productionPlanningOrderApprovalSearchDocumentType;
    }

    public List<ProductionPlanningOrder> getListProductionPlanningOrderClosing() {
        return listProductionPlanningOrderClosing;
    }

    public void setListProductionPlanningOrderClosing(List<ProductionPlanningOrder> listProductionPlanningOrderClosing) {
        this.listProductionPlanningOrderClosing = listProductionPlanningOrderClosing;
    }

    public List<ProductionPlanningOrderItemDetail> getListProductionPlanningOrderClosingItemDetail() {
        return listProductionPlanningOrderClosingItemDetail;
    }

    public void setListProductionPlanningOrderClosingItemDetail(List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderClosingItemDetail) {
        this.listProductionPlanningOrderClosingItemDetail = listProductionPlanningOrderClosingItemDetail;
    }

    public String getProductionPlanningOrderClosingSearchCode() {
        return productionPlanningOrderClosingSearchCode;
    }

    public void setProductionPlanningOrderClosingSearchCode(String productionPlanningOrderClosingSearchCode) {
        this.productionPlanningOrderClosingSearchCode = productionPlanningOrderClosingSearchCode;
    }

    public String getProductionPlanningOrderClosingSearchRemark() {
        return productionPlanningOrderClosingSearchRemark;
    }

    public void setProductionPlanningOrderClosingSearchRemark(String productionPlanningOrderClosingSearchRemark) {
        this.productionPlanningOrderClosingSearchRemark = productionPlanningOrderClosingSearchRemark;
    }

    public String getProductionPlanningOrderClosingSearchRefNo() {
        return productionPlanningOrderClosingSearchRefNo;
    }

    public void setProductionPlanningOrderClosingSearchRefNo(String productionPlanningOrderClosingSearchRefNo) {
        this.productionPlanningOrderClosingSearchRefNo = productionPlanningOrderClosingSearchRefNo;
    }

    public Date getProductionPlanningOrderClosingSearchFirstDate() {
        return productionPlanningOrderClosingSearchFirstDate;
    }

    public void setProductionPlanningOrderClosingSearchFirstDate(Date productionPlanningOrderClosingSearchFirstDate) {
        this.productionPlanningOrderClosingSearchFirstDate = productionPlanningOrderClosingSearchFirstDate;
    }

    public Date getProductionPlanningOrderClosingSearchLastDate() {
        return productionPlanningOrderClosingSearchLastDate;
    }

    public void setProductionPlanningOrderClosingSearchLastDate(Date productionPlanningOrderClosingSearchLastDate) {
        this.productionPlanningOrderClosingSearchLastDate = productionPlanningOrderClosingSearchLastDate;
    }

    public String getProductionPlanningOrderClosingSearchCustomerCode() {
        return productionPlanningOrderClosingSearchCustomerCode;
    }

    public void setProductionPlanningOrderClosingSearchCustomerCode(String productionPlanningOrderClosingSearchCustomerCode) {
        this.productionPlanningOrderClosingSearchCustomerCode = productionPlanningOrderClosingSearchCustomerCode;
    }

    public String getProductionPlanningOrderClosingSearchCustomerName() {
        return productionPlanningOrderClosingSearchCustomerName;
    }

    public void setProductionPlanningOrderClosingSearchCustomerName(String productionPlanningOrderClosingSearchCustomerName) {
        this.productionPlanningOrderClosingSearchCustomerName = productionPlanningOrderClosingSearchCustomerName;
    }

    public String getProductionPlanningOrderClosingSearchClosingStatus() {
        return productionPlanningOrderClosingSearchClosingStatus;
    }

    public void setProductionPlanningOrderClosingSearchClosingStatus(String productionPlanningOrderClosingSearchClosingStatus) {
        this.productionPlanningOrderClosingSearchClosingStatus = productionPlanningOrderClosingSearchClosingStatus;
    }

    public String getProductionPlanningOrderClosingSearchDocumentType() {
        return productionPlanningOrderClosingSearchDocumentType;
    }

    public void setProductionPlanningOrderClosingSearchDocumentType(String productionPlanningOrderClosingSearchDocumentType) {
        this.productionPlanningOrderClosingSearchDocumentType = productionPlanningOrderClosingSearchDocumentType;
    }

    public ProductionPlanningOrder getProductionPlanningOrderClosing() {
        return productionPlanningOrderClosing;
    }

    public void setProductionPlanningOrderClosing(ProductionPlanningOrder productionPlanningOrderClosing) {
        this.productionPlanningOrderClosing = productionPlanningOrderClosing;
    }

    public List<ProductionPlanningOrder> getListProductionPlanningOrderItemBillOfMaterial() {
        return listProductionPlanningOrderItemBillOfMaterial;
    }

    public void setListProductionPlanningOrderItemBillOfMaterial(List<ProductionPlanningOrder> listProductionPlanningOrderItemBillOfMaterial) {
        this.listProductionPlanningOrderItemBillOfMaterial = listProductionPlanningOrderItemBillOfMaterial;
    }

    public ProductionPlanningOrder getProductionPlanningOrderItemBillOfMaterial() {
        return productionPlanningOrderItemBillOfMaterial;
    }

    public void setProductionPlanningOrderItemBillOfMaterial(ProductionPlanningOrder productionPlanningOrderItemBillOfMaterial) {
        this.productionPlanningOrderItemBillOfMaterial = productionPlanningOrderItemBillOfMaterial;
    }

    public List<ProductionPlanningOrderItemDetail> getListProductionPlanningOrderItemBillOfMaterialDetail() {
        return listProductionPlanningOrderItemBillOfMaterialDetail;
    }

    public void setListProductionPlanningOrderItemBillOfMaterialDetail(List<ProductionPlanningOrderItemDetail> listProductionPlanningOrderItemBillOfMaterialDetail) {
        this.listProductionPlanningOrderItemBillOfMaterialDetail = listProductionPlanningOrderItemBillOfMaterialDetail;
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
