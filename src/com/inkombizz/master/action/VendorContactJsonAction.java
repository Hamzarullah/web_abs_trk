package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.bll.VendorBLL;
import com.inkombizz.master.bll.VendorContactBLL;
import com.inkombizz.master.model.Vendor;
import com.inkombizz.master.model.VendorContact;
import com.inkombizz.master.model.VendorContactTemp;
import com.inkombizz.master.model.VendorTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.logging.Logger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Result(type = "json")
public class VendorContactJsonAction extends ActionSupport {
    
    private static final long serialVersionUID=1L;
    
    protected HBMSession hbmSession=new HBMSession();
    
    private VendorContact vendorContact;
    private VendorContactTemp vendorContactTemp;
    private List <VendorContactTemp> listVendorContactTemp;
    private Vendor vendor;
    private VendorTemp vendorTemp;
    private List <VendorTemp> listVendorTemp;
    private String vendorContactSearchCode = "";
    private String vendorCode="";
    private String vendorContactSearchName = "";
    private String vendorContactSearchActiveStatus="TRUE";
    private String vendorContactSearchCodeConcat = "";
    private String actionAuthority="";
    private String code = "";
    
    @Override
    public String execute() {
        try {
            return findData();
        }
        catch(Exception ex) {
            return SUCCESS;
        }
    }
    
    @Action("vendor-contact-data")
    public String findData() {
        try {
            VendorBLL vendorBLL = new VendorBLL(hbmSession);
            ListPaging <VendorTemp> listPaging = vendorBLL.findData(vendorContactSearchCode,vendorContactSearchName,vendorContactSearchActiveStatus,paging);
            
            listVendorTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("vendor-contact-search-data")
    public String findDataForVendor() {
        try {
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            ListPaging <VendorContactTemp> listPaging = vendorContactBLL.findDataForVendor(vendorCode,vendorContactSearchCode,vendorContactSearchName,vendorContactSearchActiveStatus,paging);
            
            listVendorContactTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-contact-search-data-with-array")
    public String polulateSearchDataWithArray(){
        try{
            
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            ListPaging<VendorContactTemp> listPaging = vendorContactBLL.polulateSearchDataWithArray(vendorContactSearchCode, vendorContactSearchName, vendorContactSearchCodeConcat, paging); 
            
            listVendorContactTemp=listPaging.getList();
            
            return SUCCESS;
        }catch(Exception e){
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + e.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-contact-get-data")
    public String findData1() {
        try {
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            this.vendorContactTemp = vendorContactBLL.findData(this.vendorContact.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-contact-get")
    public String findData2() {
        try {
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            this.vendorContactTemp = vendorContactBLL.findData(this.vendorContact.getCode(),this.vendorContact.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("vendor-contact-for-vendor-search-data")
    public String findDataVendorContactForVendor() {
        try {
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            this.vendorContactTemp = vendorContactBLL.findDataVendorContactForVendor(this.vendorCode,this.vendorContactSearchCode);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-contact-find-one-data")
    public String findOneData() {
        try {
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            this.vendorContact = vendorContactBLL.get(code);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-contact-authority")
    public String vendorContactAuthority(){
        try{
            
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorContactBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorContactBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(vendorContactBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("vendor-contact-save")
    public String save() {
        try {
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss", Locale.ENGLISH);
//
//            Date BirthDateTemp = sdf.parse(vendorContactTemp.getBirthDateTemp());
//            vendorContact.setBirthDate(BirthDateTemp);
            
            if(vendorContactBLL.isExist(this.vendorContact.getCode())){
                this.errorMessage = "CODE "+this.vendorContact.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                vendorContactBLL.save(this.vendorContact);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.vendorContact.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-contact-update")
    public String update() {
        try {
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
            
            vendorContactBLL.update(this.vendorContact);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.vendorContact.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("vendor-contact-delete")
    public String delete() {
        try {
            VendorContactBLL vendorContactBLL = new VendorContactBLL(hbmSession);
//            boolean check=false;// = vendorContactBLL.isExistToDelete(this.vendor.getCode());
//            if(check == true){
//                this.message = "CODE "+this.vendor.getCode() + " : IS READY BE USE...!!!  ";
//            }else{
                vendorContactBLL.delete(this.vendorContact.getCode());
                this.message = "DELETE DATA SUCCESS. \n Code : " + this.vendorContact.getCode();
//            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }

        
    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">
    
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
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public VendorContact getVendorContact() {
        return vendorContact;
    }

    public void setVendorContact(VendorContact vendorContact) {
        this.vendorContact = vendorContact;
    }

    public VendorContactTemp getVendorContactTemp() {
        return vendorContactTemp;
    }

    public void setVendorContactTemp(VendorContactTemp vendorContactTemp) {
        this.vendorContactTemp = vendorContactTemp;
    }

    public List<VendorContactTemp> getListVendorContactTemp() {
        return listVendorContactTemp;
    }

    public void setListVendorContactTemp(List<VendorContactTemp> listVendorContactTemp) {
        this.listVendorContactTemp = listVendorContactTemp;
    }

    public String getVendorContactSearchCode() {
        return vendorContactSearchCode;
    }

    public void setVendorContactSearchCode(String vendorContactSearchCode) {
        this.vendorContactSearchCode = vendorContactSearchCode;
    }

    public String getVendorContactSearchName() {
        return vendorContactSearchName;
    }

    public void setVendorContactSearchName(String vendorContactSearchName) {
        this.vendorContactSearchName = vendorContactSearchName;
    }

    public String getVendorContactSearchActiveStatus() {
        return vendorContactSearchActiveStatus;
    }

    public void setVendorContactSearchActiveStatus(String vendorContactSearchActiveStatus) {
        this.vendorContactSearchActiveStatus = vendorContactSearchActiveStatus;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public static Logger getLOG() {
        return LOG;
    }

    public static void setLOG(Logger LOG) {
        ActionSupport.LOG = LOG;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
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

    public String getVendorContactSearchCodeConcat() {
        return vendorContactSearchCodeConcat;
    }

    public void setVendorContactSearchCodeConcat(String vendorContactSearchCodeConcat) {
        this.vendorContactSearchCodeConcat = vendorContactSearchCodeConcat;
    }

  
}