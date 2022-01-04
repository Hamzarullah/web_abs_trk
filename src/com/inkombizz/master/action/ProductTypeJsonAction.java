
package com.inkombizz.master.action;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.ProductTypeBLL;
import com.inkombizz.master.model.ProductType;
import com.inkombizz.master.model.ProductTypeTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;


@Result (type="json")
public class ProductTypeJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private ProductType productType;
    private ProductTypeTemp productTypeTemp;
    private List <ProductTypeTemp> listProductTypeTemp;
    private String productTypeSearchCode = "";
    private String productTypeSearchName = "";
    private String productTypeSearchActiveStatus="true";
    private String actionAuthority="";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("product-type-data")
    public String findData() {
        try {
            ProductTypeBLL productTypeBLL = new ProductTypeBLL(hbmSession);
            ListPaging <ProductTypeTemp> listPaging = productTypeBLL.findData(productTypeSearchCode,productTypeSearchName,productTypeSearchActiveStatus,paging);
            
            listProductTypeTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("product-type-get-data")
    public String findData1() {
        try {
            ProductTypeBLL productTypeBLL = new ProductTypeBLL(hbmSession);
            this.productTypeTemp = productTypeBLL.findData(this.productType.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("product-type-get")
    public String findData2() {
        try {
            ProductTypeBLL productTypeBLL = new ProductTypeBLL(hbmSession);
            this.productTypeTemp = productTypeBLL.findData(this.productType.getCode(),this.productType.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("product-type-authority")
    public String productTypeAuthority(){
        try{
            
            ProductTypeBLL productTypeBLL = new ProductTypeBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(productTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(productTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(productTypeBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                
            }
            
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("product-type-save")
    public String save() {
        try {
            ProductTypeBLL productTypeBLL = new ProductTypeBLL(hbmSession);
            
            productType.setInActiveDate(commonFunction.setDateTime(productTypeTemp.getInActiveDateTemp()));
            productType.setCreatedDate(commonFunction.setDateTime(productTypeTemp.getCreatedDateTemp()));
            
            if(productTypeBLL.isExist(this.productType.getCode())){
                this.errorMessage = "CODE "+this.productType.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                productTypeBLL.save(this.productType);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.productType.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("product-type-update")
    public String update() {
        try {
            ProductTypeBLL productTypeBLL = new ProductTypeBLL(hbmSession);
            productType.setInActiveDate(commonFunction.setDateTime(productTypeTemp.getInActiveDateTemp()));
            productType.setCreatedDate(commonFunction.setDateTime(productTypeTemp.getCreatedDateTemp()));
            productTypeBLL.update(this.productType);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.productType.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("product-type-delete")
    public String delete() {
        try {
           ProductTypeBLL productTypeBLL = new ProductTypeBLL(hbmSession);
            productTypeBLL.delete(this.productType.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.productType.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    public ProductTypeTemp getProductTypeTemp() {
        return productTypeTemp;
    }

    public void setProductTypeTemp(ProductTypeTemp productTypeTemp) {
        this.productTypeTemp = productTypeTemp;
    }

    public List<ProductTypeTemp> getListProductTypeTemp() {
        return listProductTypeTemp;
    }

    public void setListProductTypeTemp(List<ProductTypeTemp> listProductTypeTemp) {
        this.listProductTypeTemp = listProductTypeTemp;
    }

    public String getProductTypeSearchCode() {
        return productTypeSearchCode;
    }

    public void setProductTypeSearchCode(String productTypeSearchCode) {
        this.productTypeSearchCode = productTypeSearchCode;
    }

    public String getProductTypeSearchName() {
        return productTypeSearchName;
    }

    public void setProductTypeSearchName(String productTypeSearchName) {
        this.productTypeSearchName = productTypeSearchName;
    }

    public String getProductTypeSearchActiveStatus() {
        return productTypeSearchActiveStatus;
    }

    public void setProductTypeSearchActiveStatus(String productTypeSearchActiveStatus) {
        this.productTypeSearchActiveStatus = productTypeSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
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
