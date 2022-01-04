
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

import com.inkombizz.master.bll.VendorBLL;
import com.inkombizz.master.bll.VendorContactBLL;
import com.inkombizz.master.model.Vendor;
import com.inkombizz.master.model.VendorContactTemp;
import com.inkombizz.master.model.VendorJnContactTemp;
import com.inkombizz.master.model.VendorTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class VendorJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Vendor vendor;
    private VendorTemp vendorTemp;
    private List <VendorTemp> listVendorTemp;
    private List<VendorContactTemp> listVendorContactTemp;
    private List<VendorJnContactTemp> listVendorJnContactTemp;
    private String vendorSearchCode = "";
    private String vendorSearchName = "";
    private String vendorSearchActiveStatus="true";
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
    
    @Action("vendor-data")
    public String findData() {
        try {
            VendorBLL vendorBLL = new VendorBLL(hbmSession);
            ListPaging <VendorTemp> listPaging = vendorBLL.findData(vendorSearchCode,vendorSearchName,vendorSearchActiveStatus,paging);
            
            listVendorTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-get-data")
    public String findData1() {
        try {
            VendorBLL vendorBLL = new VendorBLL(hbmSession);
            this.vendorTemp = vendorBLL.findData(this.vendor.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-get")
    public String findData2() {
        try {
            VendorBLL vendorBLL = new VendorBLL(hbmSession);
            this.vendorTemp = vendorBLL.findDataGet(this.vendor.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-authority")
    public String vendorAuthority(){
        try{
            
            VendorBLL vendorBLL = new VendorBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
     @Action("vendor-contact-reload-grid")
    public String findDataVendorContact() {
        try{
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);            
            List<VendorContactTemp> list = vendorContactBLL.findDataVendorContactTemp(this.vendor.getCode());
            
            listVendorContactTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    @Action("vendor-save")
    public String save() {
        try {
            VendorBLL vendorBLL = new VendorBLL(hbmSession);
            
            vendor.setInActiveDate(commonFunction.setDateTime(vendorTemp.getInActiveDateTemp()));
            vendor.setCreatedDate(commonFunction.setDateTime(vendorTemp.getCreatedDateTemp()));
            
            if(vendorBLL.isExist(this.vendor.getCode())){
                this.errorMessage = "CODE "+this.vendor.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                vendorBLL.save(this.vendor);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.vendor.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-update")
    public String update() {
        try {
            VendorBLL vendorBLL = new VendorBLL(hbmSession);
            vendor.setInActiveDate(commonFunction.setDateTime(vendorTemp.getInActiveDateTemp()));
            vendor.setCreatedDate(commonFunction.setDateTime(vendorTemp.getCreatedDateTemp()));
            vendorBLL.update(this.vendor);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.vendor.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-delete")
    public String delete() {
        try {
           VendorBLL vendorBLL = new VendorBLL(hbmSession);
            vendorBLL.delete(this.vendor.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.vendor.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
     @Action("vendor-jn-contact-detail-data")
    public String findEmployejnLocationDetailData() {
        try {
            VendorBLL vendorBLL = new VendorBLL(hbmSession);
            List <VendorJnContactTemp> list = vendorBLL.findVendorJnContactDetailData(this.vendor.getCode());
            
            listVendorJnContactTemp = list;
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
    }

    public VendorTemp getVendorTemp() {
        return vendorTemp;
    }

    public void setVendorTemp(VendorTemp vendorTemp) {
        this.vendorTemp = vendorTemp;
    }

    public List<VendorTemp> getListVendorTemp() {
        return listVendorTemp;
    }

    public void setListVendorTemp(List<VendorTemp> listVendorTemp) {
        this.listVendorTemp = listVendorTemp;
    }

    public String getVendorSearchCode() {
        return vendorSearchCode;
    }

    public void setVendorSearchCode(String vendorSearchCode) {
        this.vendorSearchCode = vendorSearchCode;
    }

    public String getVendorSearchName() {
        return vendorSearchName;
    }

    public void setVendorSearchName(String vendorSearchName) {
        this.vendorSearchName = vendorSearchName;
    }

    public String getVendorSearchActiveStatus() {
        return vendorSearchActiveStatus;
    }

    public void setVendorSearchActiveStatus(String vendorSearchActiveStatus) {
        this.vendorSearchActiveStatus = vendorSearchActiveStatus;
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

    public List<VendorContactTemp> getListVendorContactTemp() {
        return listVendorContactTemp;
    }

    public void setListVendorContactTemp(List<VendorContactTemp> listVendorContactTemp) {
        this.listVendorContactTemp = listVendorContactTemp;
    }

    public List<VendorJnContactTemp> getListVendorJnContactTemp() {
        return listVendorJnContactTemp;
    }

    public void setListVendorJnContactTemp(List<VendorJnContactTemp> listVendorJnContactTemp) {
        this.listVendorJnContactTemp = listVendorJnContactTemp;
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
