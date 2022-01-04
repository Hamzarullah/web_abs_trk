package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.master.bll.CustomerCategoryBLL;
import com.inkombizz.master.model.CustomerCategory;
import com.inkombizz.master.model.CustomerCategoryTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class CustomerCategoryJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private CustomerCategory customerCategory;
    private CustomerCategoryTemp customerCategoryTemp;
    private List <CustomerCategoryTemp> listCustomerCategoryTemp;
    private String customerCategorySearchCode = "";
    private String customerCategorySearchName = "";
    private String customerCategorySearchActiveStatus="true";
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
    
    @Action("customer-category-data")
    public String findData() {
        try {
            CustomerCategoryBLL customerCategoryBLL = new CustomerCategoryBLL(hbmSession);
            ListPaging <CustomerCategoryTemp> listPaging = customerCategoryBLL.findData(customerCategorySearchCode,customerCategorySearchName,customerCategorySearchActiveStatus,paging);
            
            listCustomerCategoryTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-category-get-data")
    public String findData1() {
        try {
            CustomerCategoryBLL customerCategoryBLL = new CustomerCategoryBLL(hbmSession);
            this.customerCategoryTemp = customerCategoryBLL.findData(this.customerCategory.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-category-get")
    public String findData2() {
        try {
            CustomerCategoryBLL customerCategoryBLL = new CustomerCategoryBLL(hbmSession);
            this.customerCategoryTemp = customerCategoryBLL.findData(this.customerCategory.getCode(),this.customerCategory.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-category-authority")
    public String customerCategoryAuthority(){
        try{
            
            CustomerCategoryBLL customerCategoryBLL = new CustomerCategoryBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(customerCategoryBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("customer-category-save")
    public String save() {
        try {
            CustomerCategoryBLL customerCategoryBLL = new CustomerCategoryBLL(hbmSession);
            
          customerCategory.setInActiveDate(commonFunction.setDateTime(customerCategoryTemp.getInActiveDateTemp()));
         customerCategory.setCreatedDate(commonFunction.setDateTime(customerCategoryTemp.getCreatedDateTemp()));
            
            if(customerCategoryBLL.isExist(this.customerCategory.getCode())){
                this.errorMessage = "CODE "+this.customerCategory.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                customerCategoryBLL.save(this.customerCategory);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.customerCategory.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-category-update")
    public String update() {
        try {
            CustomerCategoryBLL customerCategoryBLL = new CustomerCategoryBLL(hbmSession);
            customerCategory.setInActiveDate(commonFunction.setDateTime(customerCategoryTemp.getInActiveDateTemp()));
            customerCategory.setCreatedDate(commonFunction.setDateTime(customerCategoryTemp.getCreatedDateTemp()));
            customerCategoryBLL.update(this.customerCategory);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.customerCategory.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("customer-category-delete")
    public String delete() {
        try {
           CustomerCategoryBLL customerCategoryBLL = new CustomerCategoryBLL(hbmSession);
            customerCategoryBLL.delete(this.customerCategory.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.customerCategory.getCode();
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

    public CustomerCategory getCustomerCategory() {
        return customerCategory;
    }

    public void setCustomerCategory(CustomerCategory customerCategory) {
        this.customerCategory = customerCategory;
    }

    public CustomerCategoryTemp getCustomerCategoryTemp() {
        return customerCategoryTemp;
    }

    public void setCustomerCategoryTemp(CustomerCategoryTemp customerCategoryTemp) {
        this.customerCategoryTemp = customerCategoryTemp;
    }

    public List<CustomerCategoryTemp> getListCustomerCategoryTemp() {
        return listCustomerCategoryTemp;
    }

    public void setListCustomerCategoryTemp(List<CustomerCategoryTemp> listCustomerCategoryTemp) {
        this.listCustomerCategoryTemp = listCustomerCategoryTemp;
    }

    public String getCustomerCategorySearchCode() {
        return customerCategorySearchCode;
    }

    public void setCustomerCategorySearchCode(String customerCategorySearchCode) {
        this.customerCategorySearchCode = customerCategorySearchCode;
    }

    public String getCustomerCategorySearchName() {
        return customerCategorySearchName;
    }

    public void setCustomerCategorySearchName(String customerCategorySearchName) {
        this.customerCategorySearchName = customerCategorySearchName;
    }

    public String getCustomerCategorySearchActiveStatus() {
        return customerCategorySearchActiveStatus;
    }

    public void setCustomerCategorySearchActiveStatus(String customerCategorySearchActiveStatus) {
        this.customerCategorySearchActiveStatus = customerCategorySearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
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
