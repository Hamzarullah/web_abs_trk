
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

import com.inkombizz.master.bll.ServerBLL;
import com.inkombizz.master.model.Server;
import com.inkombizz.master.model.ServerTemp;
import static com.opensymphony.xwork2.Action.SUCCESS;


@Result (type="json")
public class ServerJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    private CommonFunction commonFunction=new CommonFunction();
    
    private Server server;
    private ServerTemp serverTemp;
    private List <ServerTemp> listServerTemp;
    private String serverSearchCode = "";
    private String serverSearchName = "";
    private String serverSearchActiveStatus="true";
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
    
    @Action("server-data")
    public String findData() {
        try {
            ServerBLL serverBLL = new ServerBLL(hbmSession);
            ListPaging <ServerTemp> listPaging = serverBLL.findData(serverSearchCode,serverSearchName,serverSearchActiveStatus,paging);
            
            listServerTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("server-get-data")
    public String findData1() {
        try {
            ServerBLL serverBLL = new ServerBLL(hbmSession);
            this.serverTemp = serverBLL.findData(this.server.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("server-get")
    public String findData2() {
        try {
            ServerBLL serverBLL = new ServerBLL(hbmSession);
            this.serverTemp = serverBLL.findData(this.server.getCode(),this.server.isActiveStatus());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("server-authority")
    public String serverAuthority(){
        try{
            
            ServerBLL serverBLL = new ServerBLL(hbmSession);
            
            switch(actionAuthority){
                case "INSERT":
                    if (!BaseSession.loadProgramSession().hasAuthority(serverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "UPDATE":
                    if (!BaseSession.loadProgramSession().hasAuthority(serverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                        this.error = true;
                        this.errorMessage ="YOU DON'T HAVE AUTHORITY";
                        return SUCCESS;
                    }
                    break;
                case "DELETE":
                    if (!BaseSession.loadProgramSession().hasAuthority(serverBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
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
    
    @Action("server-save")
    public String save() {
        try {
            ServerBLL serverBLL = new ServerBLL(hbmSession);
            
            server.setInActiveDate(commonFunction.setDateTime(serverTemp.getInActiveDateTemp()));
            server.setCreatedDate(commonFunction.setDateTime(serverTemp.getCreatedDateTemp()));
            
            if(serverBLL.isExist(this.server.getCode())){
                this.errorMessage = "CODE "+this.server.getCode()+" HAS BEEN EXISTS IN DATABASE!";
            }else{
                serverBLL.save(this.server);
                this.message = "SAVE DATA SUCCESS. \n Code : " + this.server.getCode();
            }
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("server-update")
    public String update() {
        try {
            ServerBLL serverBLL = new ServerBLL(hbmSession);
            server.setInActiveDate(commonFunction.setDateTime(serverTemp.getInActiveDateTemp()));
            server.setCreatedDate(commonFunction.setDateTime(serverTemp.getCreatedDateTemp()));
            serverBLL.update(this.server);
            this.message = "UPDATE DATA SUCCESS. \n Code : " + this.server.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("server-delete")
    public String delete() {
        try {
           ServerBLL serverBLL = new ServerBLL(hbmSession);
            serverBLL.delete(this.server.getCode());

            this.message = "DELETE DATA SUCCESS. \n Code : " + this.server.getCode();
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

    public Server getServer() {
        return server;
    }

    public void setServer(Server server) {
        this.server = server;
    }

    public ServerTemp getServerTemp() {
        return serverTemp;
    }

    public void setServerTemp(ServerTemp serverTemp) {
        this.serverTemp = serverTemp;
    }

    public List<ServerTemp> getListServerTemp() {
        return listServerTemp;
    }

    public void setListServerTemp(List<ServerTemp> listServerTemp) {
        this.listServerTemp = listServerTemp;
    }

    public String getServerSearchCode() {
        return serverSearchCode;
    }

    public void setServerSearchCode(String serverSearchCode) {
        this.serverSearchCode = serverSearchCode;
    }

    public String getServerSearchName() {
        return serverSearchName;
    }

    public void setServerSearchName(String serverSearchName) {
        this.serverSearchName = serverSearchName;
    }

    public String getServerSearchActiveStatus() {
        return serverSearchActiveStatus;
    }

    public void setServerSearchActiveStatus(String serverSearchActiveStatus) {
        this.serverSearchActiveStatus = serverSearchActiveStatus;
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
