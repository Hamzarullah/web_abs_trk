package com.inkombizz.security.action;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inkombizz.action.BaseSession;
import com.inkombizz.action.ProgramSession;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.SessionGetter;
import com.inkombizz.common.enumeration.EnumAuthorizationString;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.bll.UserBLL;
import com.inkombizz.security.model.ChangePassword;
//import com.inkombizz.security.model.ChangePassword;
import com.inkombizz.security.model.Login;
import com.inkombizz.security.model.User;
import com.inkombizz.security.model.UserBranch;
import com.inkombizz.security.model.UserBranchTemp;
import com.inkombizz.security.model.UserDivision;
import com.inkombizz.security.model.UserDivisionTemp;
import com.inkombizz.security.model.UserTemp;
import com.inkombizz.system.model.Setup;
import com.inkombizz.utils.MD5Encrypt;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

@Result(type = "json")
public class UserJsonAction extends BaseSession {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private User user;
    private UserTemp userTemp;
    //private ChangePassword changePassword;
    private User searchUser;
    private List<User> listUser; 
    private List<UserBranch> listUserBranch;
    private List<UserDivision> listUserDivision;
    private List <UserTemp> listUserTemp;
    private List <UserBranchTemp> listUserBranchTemp;
    private List <UserDivisionTemp> listUserDivisionTemp;
    private String userSearchUsername = "";
    private String userSearchFullName = "";
    private String userSearchEmployeeCode = "";
    private String userSearchEmployeeName = "";
    private String userSearchRoleCode = "";
    private String userSearchRoleName = "";
    private String userSearchActiveStatus="true";
    
    private boolean loginSuccess=false;
    private String username="";
    private String fullName="";
    private String employeeCode;
    private String password = "";    
    private int login_periodYear = 0;
    private int login_periodMonth = 0;
    private String roleCode;
    private Setup setup;
    private UserBranch userBranch;
    private String branchCode="";
    private ChangePassword changePassword;
    private String listUserJSON;
    private String listUserBranchJSON;
    private String listUserDivisionJSON;
    private String headerCode;
    private boolean userStatus;
    
    @Override 
    public String execute(){
        try{
            return findData();
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
  
    @Action("user-login")
    public String userLogIn(){
      try{
            UserBLL userBLL = new UserBLL(hbmSession);

            String md5_password = MD5Encrypt.md5_encrypt(user.getPassword());
            user =userBLL.isLogin(user.getUsername(), md5_password);

            if(user != null && !user.getCode().trim().equals("")){
              
                setup=userBLL.getSetup();
                if(user.isActiveStatus()){
                    setLogin(true);
                }else{
                    setLogin(false);
                }
            }else{
                setLogin(false);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
      try{
          if (this.loginSuccess) {
              ProgramSession prgSession = new ProgramSession();
              
              prgSession.setUserName(user.getUsername());
//              prgSession.setBranchCode(userBranch.getBranch().getCode());
//              prgSession.setBranchName(userBranch.getBranch().getName());
              prgSession.setGroupCode(user.getRole().getCode());
              
              prgSession.setPeriodYear(this.login_periodYear);
              prgSession.setPeriodMonth(this.login_periodMonth);
              prgSession.setRoleCode(user.getRole().getCode());
              prgSession.setSetup(setup);
              
              Login.setUser(user);
              SessionGetter.setLengthTime(18000);
              
              //Comment
//               if(prgSession.getRoleCode().equals(AuthorizationField.ROLECHECKIN)){
//                  if(LoginCheckIn.getUser() == null){
//                      LoginCheckIn.setUser(user);
//                  }
//                  if(LoginCheckIn.getUser().getCode() != null && LoginCheckIn.getUser().getCode() != user.getCode()){                      
//                      LoginCheckIn.setUser(user);
//                  }
////                  SessionGetter.setLengthTime(14400);
//                  SessionGetter.setLengthTime(18000);
//                  LoginCheckIn.setImageMemberPath(setup.getMemberImagePath());
//                  roleCode = AuthorizationField.ROLECHECKIN;
//              }
              
              
              
//              setup = userBLL.getSetup();
//              prgSession.setSetup(setup);
              
//              setup = setupBLL.get("IKB");
//              
//              prgSession.setDefaultTimeIn(setup.getDefaultTimeIn());
//              prgSession.setDefaultTimeOut(setup.getDefaultTimeOut());
              
              this.settingSession(prgSession);
              //this.settingSession(user);
          }
          
          return SUCCESS;
      }  
      catch(Exception ex){
          ex.printStackTrace();
        this.error = true;
        this.errorMessage = "LOGIN FAILED. \n MESSAGE : " + ex.getMessage();
        
        return SUCCESS;
      }
    };
    
    @Action("user-branch-update-get")
    public String populateListBranchGetDetail(){
       try{
            UserBLL userBLL = new UserBLL(hbmSession);
            List<UserBranchTemp> list = userBLL.getListUserBranchManual(user.getCode());
            listUserBranchTemp = list;            
            return SUCCESS;
        }
        catch(Exception ex){
             ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("user-division-update-get")
    public String populateListDivisionGetDetail(){
       try{
            UserBLL userBLL = new UserBLL(hbmSession);
            List<UserDivisionTemp> list = userBLL.getListUserDivisionManual(user.getCode());
            listUserDivisionTemp = list;            
            return SUCCESS;
        }
        catch(Exception ex){
             ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("user-search")
    public String search() {
        try {
            UserBLL userBLL = new UserBLL(hbmSession);
            ListPaging <User> listPaging = userBLL.search(paging, searchUser.getCode(), searchUser.getCode(), Enum_TriState.YES);
            
            listUser = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SEARCH DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("user-branch-data")
    public String populateListDetail(){
        try{
            UserBLL userBLL = new UserBLL(hbmSession);
            ListPaging<UserBranch> listPaging = userBLL.listDetail(paging, headerCode);
                        
            listUserBranch = listPaging.getList();            
            return SUCCESS;
        }
        catch(Exception ex){
             ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("user-division-data")
    public String populateListDetailDivision(){
        try{
            UserBLL userBLL = new UserBLL(hbmSession);
            ListPaging<UserDivision> listPaging = userBLL.listDetailDivision(paging, headerCode);
                        
            listUserDivision = listPaging.getList();            
            return SUCCESS;
        }
        catch(Exception ex){
             ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("user-data2")
    public String populateData() {
        try {
            UserBLL userBLL = new UserBLL(hbmSession);
            ListPaging <User> listPaging = userBLL.get(paging);
            
            listUser = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("user-data")
    public String findData() {
        try {
            UserBLL userBLL = new UserBLL(hbmSession);
            ListPaging <UserTemp> listPaging = userBLL.findData(userSearchUsername,userSearchFullName,userSearchEmployeeCode,userSearchEmployeeName,userSearchRoleCode,userSearchRoleName,userSearchActiveStatus,paging);
            
            listUserTemp = listPaging.getList();
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("user-get")
    public String get() {
        try {
            UserBLL userBLL = new UserBLL(hbmSession);
            this.user = userBLL.get(this.user.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("user-get-for-update")
    public String getUpdate() {
        try {
            UserBLL userBLL = new UserBLL(hbmSession);
            this.userTemp= userBLL.getUpdate(this.user.getCode());
            
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("user-save")
    public String save() {
            String _messg = "";
        try{
            UserBLL userBLL = new UserBLL(hbmSession);
            
            Gson gson1 = new Gson();
            this.listUserBranch = gson1.fromJson(this.listUserBranchJSON, new TypeToken<List<UserBranch>>(){}.getType());
            this.listUserDivision = gson1.fromJson(this.listUserDivisionJSON, new TypeToken<List<UserDivision>>(){}.getType());
            
            String md_5password = MD5Encrypt.md5_encrypt(user.getPassword());
            this.user.setPassword(md_5password);
            this.user.setUsername(this.user.getCode());
            
            _messg = "SAVED ";

            if (!BaseSession.loadProgramSession().hasAuthority(UserBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.INSERT), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.INSERT));
            }   

            userBLL.save(this.user,listUserBranch,listUserDivision, UserBLL.MODULECODE);
            
            this.message = _messg + "DATA SUCCESS. \n User Name : " + this.user.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("user-update")
    public String update() {
        String _messg = "";
        try {
            UserBLL userBLL = new UserBLL(hbmSession);
            Gson gson1 = new Gson();
            this.listUserBranch = gson1.fromJson(this.listUserBranchJSON, new TypeToken<List<UserBranch>>(){}.getType());
            this.listUserDivision = gson1.fromJson(this.listUserDivisionJSON, new TypeToken<List<UserDivision>>(){}.getType());
            
            String password="";
            if(this.userStatus){
                password = MD5Encrypt.md5_encrypt(user.getPassword());
            }else{
                password = user.getPassword();
            }
            
            this.user.setPassword(password);
            this.user.setUsername(this.user.getCode());
            
            _messg = "UPDATED ";
            
            if (!BaseSession.loadProgramSession().hasAuthority(UserBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.UPDATE));
            }
            
            userBLL.update(this.user,listUserBranch,listUserDivision);
            this.message = _messg + "DATA SUCCESS. \n User Name : " + this.user.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "UPDATE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    @Action("user-delete")
    public String delete() {
        try {
            if (!BaseSession.loadProgramSession().hasAuthority(UserBLL.MODULECODE, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.DELETE), hbmSession)) {
                throw new Exception(EnumAuthorizationString.messages(EnumAuthorizationString.ENUM_AuthorizationString.DELETE));
            }
            
            UserBLL userBLL = new UserBLL(hbmSession);
            
            userBLL.delete(this.user.getCode());
            this.message = "DELETE DATA SUCCESS. \n User Name : " + this.user.getCode();
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "DELETE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
    
    @Action("change-password-user")
    public String ChangePasswordUser() {
        try{
            UserBLL userBLL = new UserBLL(hbmSession);

            String md_5password = MD5Encrypt.md5_encrypt(changePassword.getPassword());
            String oldPassword = MD5Encrypt.md5_encrypt(changePassword.getOldPassword());
            this.changePassword.setPassword(md_5password);
            this.changePassword.setOldPassword(oldPassword);
            
            User user = userBLL.get(changePassword.getUsername());
            if(user.getPassword().equals(changePassword.getOldPassword())){
                userBLL.ChangePassword(this.changePassword,"001_SCR_0004");
            }else{
                 this.message = "Wrong Old Password";
                 return SUCCESS;
            }
            this.message = "CHANGE PASSWORD SUCCESS.";
            return SUCCESS;
        }
        catch(Exception ex) {
            this.error = true;
            this.errorMessage = "SAVE DATA FAILED. \n MESSAGE : " + ex.getMessage();
            return SUCCESS;
        }
    }
    
//    @Action("user-check-price-authority")
//    public String checkPriceAuthority() {
//        try {
//            UserBLL userBLL = new UserBLL(hbmSession);
//            this.user = userBLL.checkBasedPriceAuthority(this.user.getUsername());
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            this.error = true;
//            this.errorMessage = "GET DATA FAILED. \n MESSAGE : " + ex.getMessage();
//            return SUCCESS;
//        }
//    }

    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getSearchUser() {
        return searchUser;
    }

    public void setSearchUser(User searchUser) {
        this.searchUser = searchUser;
    }

    public List<User> getListUser() {
        return listUser;
    }

    public void setListUser(List<User> listUser) {
        this.listUser = listUser;
    }

    public List<UserBranch> getListUserBranch() {
        return listUserBranch;
    }

    public void setListUserBranch(List<UserBranch> listUserBranch) {
        this.listUserBranch = listUserBranch;
    }

    public boolean isLoginSuccess() {
        return loginSuccess;
    }

    public void setLoginSuccess(boolean loginSuccess) {
        this.loginSuccess = loginSuccess;
    }

    public boolean isLogin(){
        return this.loginSuccess;
    };
    
    public void setLogin(boolean isLogin){
        this.loginSuccess = isLogin;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }


    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getLogin_periodYear() {
        return login_periodYear;
    }

    public void setLogin_periodYear(int login_periodYear) {
        this.login_periodYear = login_periodYear;
    }

    public int getLogin_periodMonth() {
        return login_periodMonth;
    }

    public void setLogin_periodMonth(int login_periodMonth) {
        this.login_periodMonth = login_periodMonth;
    }

    public String getRoleCode() {
        return roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode;
    }

    public Setup getSetup() {
        return setup;
    }

    public void setSetup(Setup setup) {
        this.setup = setup;
    }

    public UserBranch getUserBranch() {
        return userBranch;
    }

    public void setUserBranch(UserBranch userBranch) {
        this.userBranch = userBranch;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public ChangePassword getChangePassword() {
        return changePassword;
    }

    public void setChangePassword(ChangePassword changePassword) {
        this.changePassword = changePassword;
    }

    public String getListUserJSON() {
        return listUserJSON;
    }

    public void setListUserJSON(String listUserJSON) {
        this.listUserJSON = listUserJSON;
    }

    public String getListUserBranchJSON() {
        return listUserBranchJSON;
    }

    public void setListUserBranchJSON(String listUserBranchJSON) {
        this.listUserBranchJSON = listUserBranchJSON;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public boolean isUserStatus() {
        return userStatus;
    }

    public void setUserStatus(boolean userStatus) {
        this.userStatus = userStatus;
    }

    public List<UserTemp> getListUserTemp() {
        return listUserTemp;
    }

    public void setListUserTemp(List<UserTemp> listUserTemp) {
        this.listUserTemp = listUserTemp;
    }

    public String getUserSearchUsername() {
        return userSearchUsername;
    }

    public void setUserSearchUsername(String userSearchUsername) {
        this.userSearchUsername = userSearchUsername;
    }

    public String getUserSearchFullName() {
        return userSearchFullName;
    }

    public void setUserSearchFullName(String userSearchFullName) {
        this.userSearchFullName = userSearchFullName;
    }

    public String getUserSearchRoleCode() {
        return userSearchRoleCode;
    }

    public void setUserSearchRoleCode(String userSearchRoleCode) {
        this.userSearchRoleCode = userSearchRoleCode;
    }

    public String getUserSearchRoleName() {
        return userSearchRoleName;
    }

    public void setUserSearchRoleName(String userSearchRoleName) {
        this.userSearchRoleName = userSearchRoleName;
    }

    public String getUserSearchEmployeeCode() {
        return userSearchEmployeeCode;
    }

    public void setUserSearchEmployeeCode(String userSearchEmployeeCode) {
        this.userSearchEmployeeCode = userSearchEmployeeCode;
    }

    public String getUserSearchEmployeeName() {
        return userSearchEmployeeName;
    }

    public void setUserSearchEmployeeName(String userSearchEmployeeName) {
        this.userSearchEmployeeName = userSearchEmployeeName;
    }

    public String getUserSearchActiveStatus() {
        return userSearchActiveStatus;
    }

    public void setUserSearchActiveStatus(String userSearchActiveStatus) {
        this.userSearchActiveStatus = userSearchActiveStatus;
    }

    public UserTemp getUserTemp() {
        return userTemp;
    }

    public void setUserTemp(UserTemp userTemp) {
        this.userTemp = userTemp;
    }

    public List<UserBranchTemp> getListUserBranchTemp() {
        return listUserBranchTemp;
    }

    public void setListUserBranchTemp(List<UserBranchTemp> listUserBranchTemp) {
        this.listUserBranchTemp = listUserBranchTemp;
    }

    public List<UserDivisionTemp> getListUserDivisionTemp() {
        return listUserDivisionTemp;
    }

    public void setListUserDivisionTemp(List<UserDivisionTemp> listUserDivisionTemp) {
        this.listUserDivisionTemp = listUserDivisionTemp;
    }

    public List<UserDivision> getListUserDivision() {
        return listUserDivision;
    }

    public void setListUserDivision(List<UserDivision> listUserDivision) {
        this.listUserDivision = listUserDivision;
    }

    public String getListUserDivisionJSON() {
        return listUserDivisionJSON;
    }

    public void setListUserDivisionJSON(String listUserDivisionJSON) {
        this.listUserDivisionJSON = listUserDivisionJSON;
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

    // <editor-fold defaultstate="collapsed" desc="SET N GET DEFAULT">
    
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
