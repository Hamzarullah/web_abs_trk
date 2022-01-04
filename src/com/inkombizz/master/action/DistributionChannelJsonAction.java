package com.inkombizz.master.action;

import com.inkombizz.action.BaseSession;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.master.bll.DistributionChannelBLL;
import com.inkombizz.master.model.DistributionChannel;
import com.inkombizz.master.model.DistributionChannelTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;

@Result(type = "json")
public class DistributionChannelJsonAction extends ActionSupport {
    
    protected HBMSession hbmSession = new HBMSession();
    
    private static final long serialVersionUID = 1L;
    
    private DistributionChannel distributionChannel;
    private DistributionChannel searchDistributionChannel;
    private List<DistributionChannel> listDistributionChannel;
     private List <DistributionChannelTemp> listDistributionChannelTemp;
    private String distributionChannelSearchCode = "";
    private String distributionChannelSearchName = "";
    private String distributionChannelSearchActiveStatus = "Active";
    private String actionAuthority="";

    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    @Action("distribution-channel-search-data")
    public String findData() {
        try {
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            ListPaging<DistributionChannelTemp> listPaging = distributionChannelBLL.findSearchData(paging,distributionChannelSearchCode,distributionChannelSearchName,distributionChannelSearchActiveStatus);
            
            listDistributionChannelTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("distribution-channel-search")
    public String search() {
        try {
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            
            if(searchDistributionChannel == null)
            {
                searchDistributionChannel = new DistributionChannel();
                
                searchDistributionChannel.setCode("");
                searchDistributionChannel.setName("");
            }
            
            ListPaging <DistributionChannel> listPaging = distributionChannelBLL.search(paging, searchDistributionChannel.getCode(), searchDistributionChannel.getName(), Enum_TriState.YES);
            
            listDistributionChannel = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("distribution-channel-data")
    public String populateData() {
        try {
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            ListPaging<DistributionChannel> listPaging = distributionChannelBLL.get(paging);
            listDistributionChannel = listPaging.getList();
            return SUCCESS;
        }
        catch(Exception ex) {         
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("distribution-channel-get")
    public String populateDataForUpdate() {
        try {
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            this.distributionChannel = distributionChannelBLL.get(this.distributionChannel.getCode());
                return SUCCESS;
        }
        catch(Exception ex) {          
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("distribution-channel-save")
    public String save() {
        try {
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DistributionChannelBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }              
            
            if(distributionChannel.isActiveStatus() == false){
                distributionChannel.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                distributionChannel.setInActiveDate(new Date());
            }
            distributionChannelBLL.save(this.distributionChannel);
            
            this.message = "SAVE DATA SUCCESS. \n Code : " + this.distributionChannel.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("distribution-channel-update")
    public String update() {
        try {
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DistributionChannelBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }            
            
             if(distributionChannel.isActiveStatus() == false){
                distributionChannel.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                distributionChannel.setInActiveDate(new Date());
            }
            
            distributionChannelBLL.update(this.distributionChannel);
           
            
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.distributionChannel.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {   
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
	
    @Action("distribution-channel-delete")
    public String delete() {
        try {
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            
            if (!BaseSession.loadProgramSession().hasAuthority(DistributionChannelBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }            
            
            distributionChannelBLL.delete(this.distributionChannel.getCode());
            
            this.message = "DELETE DATA SUCCESS. \n Code : " + this.distributionChannel.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {           
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    @Action("distribution-channel-authority")
    public String distributionChannelAuthority(){
        try{
            
            DistributionChannelBLL distributionChannelBLL = new DistributionChannelBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(distributionChannelBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(distributionChannelBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(distributionChannelBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    public DistributionChannel getDistributionChannel() {
        return distributionChannel;
    }
    public void setDistributionChannel(DistributionChannel distributionChannel) {
        this.distributionChannel = distributionChannel;
    }
	
    public List<DistributionChannel> getListDistributionChannel() {
        return listDistributionChannel;
    }
    public void setListDistributionChannel(List<DistributionChannel> listDistributionChannel) {
        this.listDistributionChannel = listDistributionChannel;
    }

    public DistributionChannel getSearchDistributionChannel() {
        return searchDistributionChannel;
    }
    public void setSearchDistributionChannel(DistributionChannel searchDistributionChannel) {
        this.searchDistributionChannel = searchDistributionChannel;
    }   
	
    Paging paging = new Paging();

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

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public List<DistributionChannelTemp> getListDistributionChannelTemp() {
        return listDistributionChannelTemp;
    }

    public void setListDistributionChannelTemp(List<DistributionChannelTemp> listDistributionChannelTemp) {
        this.listDistributionChannelTemp = listDistributionChannelTemp;
    }

    public String getDistributionChannelSearchCode() {
        return distributionChannelSearchCode;
    }

    public void setDistributionChannelSearchCode(String distributionChannelSearchCode) {
        this.distributionChannelSearchCode = distributionChannelSearchCode;
    }

    public String getDistributionChannelSearchName() {
        return distributionChannelSearchName;
    }

    public void setDistributionChannelSearchName(String distributionChannelSearchName) {
        this.distributionChannelSearchName = distributionChannelSearchName;
    }

    public String getDistributionChannelSearchActiveStatus() {
        return distributionChannelSearchActiveStatus;
    }

    public void setDistributionChannelSearchActiveStatus(String distributionChannelSearchActiveStatus) {
        this.distributionChannelSearchActiveStatus = distributionChannelSearchActiveStatus;
    }

    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }

    public String getActionAuthority() {
        return actionAuthority;
    }

    public void setActionAuthority(String actionAuthority) {
        this.actionAuthority = actionAuthority;
    }
    
}