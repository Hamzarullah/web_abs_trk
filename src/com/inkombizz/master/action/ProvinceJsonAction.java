
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

import com.inkombizz.master.bll.ProvinceBLL;
import com.inkombizz.master.model.Province;
import com.inkombizz.master.model.ProvinceTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ProvinceJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Province province;
    private ProvinceTemp provinceTemp;
    private List <ProvinceTemp> listProvinceTemp;
    private String provinceSearchCode = "";
    private String provinceSearchName = "";
    private String provinceSearchActiveStatus="true";
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
    
    @Action("province-data")
    public String findData() {
        try {
            ProvinceBLL provinceBLL = new ProvinceBLL(hbmSession);
            ListPaging <ProvinceTemp> listPaging = provinceBLL.findData(provinceSearchCode,provinceSearchName,provinceSearchActiveStatus,paging);
            
            listProvinceTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("province-get-data")
    public String findData1() {
        try {
            ProvinceBLL provinceBLL = new ProvinceBLL(hbmSession);
            this.provinceTemp = provinceBLL.findData(this.province.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("province-get")
    public String findData2() {
        try {
            ProvinceBLL provinceBLL = new ProvinceBLL(hbmSession);
            this.provinceTemp = provinceBLL.findData(this.province.getCode(),this.province.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("province-authority")
    public String provinceAuthority(){
        try{
            
            ProvinceBLL provinceBLL = new ProvinceBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(provinceBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(provinceBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(provinceBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("province-save")
    public String save() {
        try {
            ProvinceBLL provinceBLL = new ProvinceBLL(hbmSession);
            
            province.setInActiveDate(commonFunction.setDateTime(provinceTemp.getInActiveDateTemp()));
            province.setCreatedDate(commonFunction.setDateTime(provinceTemp.getCreatedDateTemp()));
            
            if(provinceBLL.isExist(this.province.getCode())){
                this.errorMessage = "CODE "+this.province.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                provinceBLL.save(this.province);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.province.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("province-update")
    public String update() {
        try {
            ProvinceBLL provinceBLL = new ProvinceBLL(hbmSession);
            province.setInActiveDate(commonFunction.setDateTime(provinceTemp.getInActiveDateTemp()));
            province.setCreatedDate(commonFunction.setDateTime(provinceTemp.getCreatedDateTemp()));
            provinceBLL.update(this.province);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.province.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("province-delete")
    public String delete() {
        try {
           ProvinceBLL provinceBLL = new ProvinceBLL(hbmSession);
            provinceBLL.delete(this.province.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.province.getCode();
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

    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

    public ProvinceTemp getProvinceTemp() {
        return provinceTemp;
    }

    public void setProvinceTemp(ProvinceTemp provinceTemp) {
        this.provinceTemp = provinceTemp;
    }

    public List<ProvinceTemp> getListProvinceTemp() {
        return listProvinceTemp;
    }

    public void setListProvinceTemp(List<ProvinceTemp> listProvinceTemp) {
        this.listProvinceTemp = listProvinceTemp;
    }

    public String getProvinceSearchCode() {
        return provinceSearchCode;
    }

    public void setProvinceSearchCode(String provinceSearchCode) {
        this.provinceSearchCode = provinceSearchCode;
    }

    public String getProvinceSearchName() {
        return provinceSearchName;
    }

    public void setProvinceSearchName(String provinceSearchName) {
        this.provinceSearchName = provinceSearchName;
    }

    public String getProvinceSearchActiveStatus() {
        return provinceSearchActiveStatus;
    }

    public void setProvinceSearchActiveStatus(String provinceSearchActiveStatus) {
        this.provinceSearchActiveStatus = provinceSearchActiveStatus;
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
