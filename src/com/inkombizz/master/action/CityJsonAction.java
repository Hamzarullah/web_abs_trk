package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.opensymphony.xwork2.ActionSupport;

import com.inkombizz.master.bll.CityBLL;
import com.inkombizz.master.model.City;
import com.inkombizz.master.model.CityTemp;


@Result (type="json")
public class CityJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private City city;
    private CityTemp cityTemp;
    private List <CityTemp> listCityTemp;
    private String citySearchCode = "";
    private String citySearchName = "";
    private String citySearchActiveStatus = "true";
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
    
    @Action("city-data")
    public String findData() {
        try {
            CityBLL cityBLL = new CityBLL(hbmSession);
            ListPaging <CityTemp> listPaging = cityBLL.findData(paging,citySearchCode,citySearchName,citySearchActiveStatus);
            
            listCityTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("city-get-data")
    public String findData1() {
        try {
            CityBLL cityBLL = new CityBLL(hbmSession);
            this.cityTemp = cityBLL.findData(this.city.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("city-get")
    public String findData2() {
        try {
            CityBLL cityBLL = new CityBLL(hbmSession);
            this.cityTemp = cityBLL.findData(this.city.getCode(),this.city.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("city-authority")
    public String cityAuthority(){
        try{
            
            CityBLL cityBLL = new CityBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(cityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(cityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(cityBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("city-save")
    public String save() {
        try {
            CityBLL cityBLL = new CityBLL(hbmSession);
            
            city.setInActiveDate(commonFunction.setDateTime(cityTemp.getInActiveDateTemp()));
            city.setCreatedDate(commonFunction.setDateTime(cityTemp.getCreatedDateTemp()));
            if(cityBLL.isExist(this.city.getCode())){
                this.errorMessage = "Code "+this.city.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                cityBLL.save(this.city);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.city.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("city-update")
    public String update() {
        try {
            CityBLL cityBLL = new CityBLL(hbmSession);
            
            city.setInActiveDate(commonFunction.setDateTime(cityTemp.getInActiveDateTemp()));
            city.setCreatedDate(commonFunction.setDateTime(cityTemp.getCreatedDateTemp()));
            cityBLL.update(this.city);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.city.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("city-delete")
//    public String delete() {
//        try {
//            CityBLL cityBLL = new CityBLL(hbmSession);
//            GlobalBLL globalBLL=new GlobalBLL(hbmSession);
//            
//            lstGlobal=globalBLL.usedCity(this.city.getCode());
//            
//            if(lstGlobal.isEmpty()){
//                cityBLL.delete(this.city.getCode());
//                this.message = "DELETE DATA SUCCESS. \n Code : " + this.city.getCode();
//            }else{
//                this.message = "Code: "+this.city.getCode() + " Is Used By "+lstGlobal.get(0).getUsedName()+" [ Code: "+ lstGlobal.get(0).getUsedCode() +" ]!";
//            }
//      
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }
    
    @Action("city-delete")
    public String delete() {
        try {
           CityBLL cityBLL = new CityBLL(hbmSession);
            cityBLL.delete(this.city.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.city.getCode();
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

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public CityTemp getCityTemp() {
        return cityTemp;
    }

    public void setCityTemp(CityTemp cityTemp) {
        this.cityTemp = cityTemp;
    }

    public List<CityTemp> getListCityTemp() {
        return listCityTemp;
    }

    public void setListCityTemp(List<CityTemp> listCityTemp) {
        this.listCityTemp = listCityTemp;
    }

    public String getCitySearchCode() {
        return citySearchCode;
    }

    public void setCitySearchCode(String citySearchCode) {
        this.citySearchCode = citySearchCode;
    }

    public String getCitySearchName() {
        return citySearchName;
    }

    public void setCitySearchName(String citySearchName) {
        this.citySearchName = citySearchName;
    }

    public String getCitySearchActiveStatus() {
        return citySearchActiveStatus;
    }

    public void setCitySearchActiveStatus(String citySearchActiveStatus) {
        this.citySearchActiveStatus = citySearchActiveStatus;
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
    
    Paging paging = new Paging();

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