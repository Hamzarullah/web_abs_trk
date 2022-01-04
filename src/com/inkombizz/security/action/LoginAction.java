package com.inkombizz.security.action;

import com.inkombizz.action.BaseSession;
import com.inkombizz.action.ProgramSession;
import com.inkombizz.common.StringValue;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.Branch;
import com.inkombizz.security.bll.UserBLL;
import com.inkombizz.security.model.User;
import com.inkombizz.system.model.Setup;
import com.inkombizz.utils.DateUtils;
import java.util.List;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="login.jsp")
})
public class LoginAction extends BaseSession {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private User user;
    private int login_periodYear = 0;
    private int login_periodMonth = 0;
    private List<StringValue> login_monthlyList;
    private List<StringValue> login_yearList;  
    private List<Branch> listBranch;
    private Setup setup;
    
    @Override 
    public String execute(){
        try{
            login_periodYear = DateUtils.getYear();
            login_periodMonth = DateUtils.getMonth();
            
            login_monthlyList = DateUtils.getMonthlyList();
            login_yearList = DateUtils.getYearList();
            
            UserBLL userBLL = new UserBLL(hbmSession);
//            listBranch=userBLL.getBranchList();
            
            ProgramSession prgSession = new ProgramSession();
            setup=userBLL.getSetup();
            prgSession.setSetup(setup);
            this.settingSession(prgSession);
            return SUCCESS;
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
       
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public int getLogin_periodMonth() {
        return login_periodMonth;
    }
    public void setLogin_periodMonth(int login_periodMonth) {
        this.login_periodMonth = login_periodMonth;
    }

    public int getLogin_periodYear() {
        return login_periodYear;
    }
    public void setLogin_periodYear(int login_periodYear) {
        this.login_periodYear = login_periodYear;
    }

    public List<StringValue> getLogin_monthlyList() {
        return login_monthlyList;
    }

    public void setLogin_monthlyList(List<StringValue> login_monthlyList) {
        this.login_monthlyList = login_monthlyList;
    }

    public List<Branch> getListBranch() {
        return listBranch;
    }

    public void setListBranch(List<Branch> listBranch) {
        this.listBranch = listBranch;
    }

    public Setup getSetup() {
        return setup;
    }

    public void setSetup(Setup setup) {
        this.setup = setup;
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public List<StringValue> getLogin_yearList() {
        return login_yearList;
    }

    public void setLogin_yearList(List<StringValue> login_yearList) {
        this.login_yearList = login_yearList;
    }
    
}