
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

import com.inkombizz.master.bll.PaymentTermBLL;
import com.inkombizz.master.model.PaymentTerm;
import com.inkombizz.master.model.PaymentTermTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class PaymentTermJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private PaymentTerm paymentTerm;
    private PaymentTermTemp paymentTermTemp;
    private List <PaymentTermTemp> listPaymentTermTemp;
    private String paymentTermSearchVendorCode = "";
    private String paymentTermSearchCode = "";
    private String paymentTermSearchName = "";
    private String paymentTermSearchDays = "";
    private String code = "";
    private String vendorCode = "";
    private String paymentTermSearchActiveStatus="true";
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
    
    @Action("payment-term-data")
    public String findData() {
        try {
            PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            ListPaging <PaymentTermTemp> listPaging = paymentTermBLL.findData(paymentTermSearchCode,paymentTermSearchName,paymentTermSearchActiveStatus,paging);
            
            listPaymentTermTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-term-data-by-vendor")
    public String findDataVendor() {
        try {
            PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            ListPaging <PaymentTermTemp> listPaging = paymentTermBLL.findDataByVendor(paymentTermSearchVendorCode, paymentTermSearchCode,paymentTermSearchName,paging);
            
            listPaymentTermTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-term-get-data")
    public String findData1() {
        try {
            PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            this.paymentTermTemp = paymentTermBLL.findData(this.paymentTerm.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-term-get")
    public String findData2() {
        try {
            PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            this.paymentTermTemp = paymentTermBLL.findData(this.paymentTerm.getCode(),this.paymentTerm.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-term-get-by-vendor")
    public String findData2Vendor() {
        try {
            PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            this.paymentTermTemp = paymentTermBLL.findDataByVendor(vendorCode,code);
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-term-authority")
    public String paymentTermAuthority(){
        try{
            
            PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(paymentTermBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(paymentTermBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(paymentTermBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("payment-term-save")
    public String save() {
        try {
            PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            
          paymentTerm.setInActiveDate(commonFunction.setDateTime(paymentTermTemp.getInActiveDateTemp()));
         paymentTerm.setCreatedDate(commonFunction.setDateTime(paymentTermTemp.getCreatedDateTemp()));
            
            if(paymentTermBLL.isExist(this.paymentTerm.getCode())){
                this.errorMessage = "CODE "+this.paymentTerm.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                paymentTermBLL.save(this.paymentTerm);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.paymentTerm.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-term-update")
    public String update() {
        try {
            PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            paymentTerm.setInActiveDate(commonFunction.setDateTime(paymentTermTemp.getInActiveDateTemp()));
            paymentTerm.setCreatedDate(commonFunction.setDateTime(paymentTermTemp.getCreatedDateTemp()));
            paymentTermBLL.update(this.paymentTerm);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.paymentTerm.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("payment-term-delete")
    public String delete() {
        try {
           PaymentTermBLL paymentTermBLL = new PaymentTermBLL(hbmSession);
            paymentTermBLL.delete(this.paymentTerm.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.paymentTerm.getCode();
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

    public PaymentTerm getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(PaymentTerm paymentTerm) {
        this.paymentTerm = paymentTerm;
    }

    public PaymentTermTemp getPaymentTermTemp() {
        return paymentTermTemp;
    }

    public void setPaymentTermTemp(PaymentTermTemp paymentTermTemp) {
        this.paymentTermTemp = paymentTermTemp;
    }

    public List<PaymentTermTemp> getListPaymentTermTemp() {
        return listPaymentTermTemp;
    }

    public void setListPaymentTermTemp(List<PaymentTermTemp> listPaymentTermTemp) {
        this.listPaymentTermTemp = listPaymentTermTemp;
    }

    public String getPaymentTermSearchCode() {
        return paymentTermSearchCode;
    }

    public void setPaymentTermSearchCode(String paymentTermSearchCode) {
        this.paymentTermSearchCode = paymentTermSearchCode;
    }

    public String getPaymentTermSearchName() {
        return paymentTermSearchName;
    }

    public void setPaymentTermSearchName(String paymentTermSearchName) {
        this.paymentTermSearchName = paymentTermSearchName;
    }

    public String getPaymentTermSearchDays() {
        return paymentTermSearchDays;
    }

    public void setPaymentTermSearchDays(String paymentTermSearchDays) {
        this.paymentTermSearchDays = paymentTermSearchDays;
    }

    
    public String getPaymentTermSearchActiveStatus() {
        return paymentTermSearchActiveStatus;
    }

    public void setPaymentTermSearchActiveStatus(String paymentTermSearchActiveStatus) {
        this.paymentTermSearchActiveStatus = paymentTermSearchActiveStatus;
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

    public String getPaymentTermSearchVendorCode() {
        return paymentTermSearchVendorCode;
    }

    public void setPaymentTermSearchVendorCode(String paymentTermSearchVendorCode) {
        this.paymentTermSearchVendorCode = paymentTermSearchVendorCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
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
