package com.inkombizz.security.action;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.dao.MenuDAO;
import com.inkombizz.security.model.MenuTree;
import com.opensymphony.xwork2.ActionSupport;

@Result(type = "json")
public class MenuJsonAction extends ActionSupport {
    
    private static final long serialVersionUID = 1L;

    private static final Log log = LogFactory.getLog(MenuJsonAction.class);
    
    protected HBMSession hbmSession = new HBMSession();
    private MenuDAO menuDAO = new MenuDAO(hbmSession);
    
    private List<MenuTree> listmenu;
    
    private List<MenuTree> initMenu() {
    	return menuDAO.getMenuTree();
    }
    
    public String execute() {
        
    	listmenu = initMenu();
        
    	return SUCCESS;
    }
    
    public List<MenuTree> getListmenu() {
        return listmenu;
    }
    
    public void setListmenu(List<MenuTree> listmenu) {
        this.listmenu = listmenu;
    }
    
}