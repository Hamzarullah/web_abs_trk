package com.inkombizz.security.dao;

import com.inkombizz.action.BaseSession;
import java.util.ArrayList;
import java.util.List;

import com.inkombizz.dao.AbstractGenericDao;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.model.Menu;
import com.inkombizz.security.model.MenuTree;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

public class MenuDAO extends AbstractGenericDao<Menu, String> {
	
    public MenuDAO(HBMSession session) {
        super.hbmSession = session;
    }
	
    private MenuTree createMenuTree(Menu menu) {
        MenuTree tree = new MenuTree();

        tree.setCode(menu.getCode());
        tree.setText(menu.getText());
        tree.setClasses(menu.getClasses());
        tree.setParentCode(menu.getParentCode());
        tree.setLink(menu.getLink());
        tree.setChildren(null);

        return tree;
    }
        
    public List<MenuTree> getMenuTree() {
        //get root
        String rolecodesession = BaseSession.loadProgramSession().getRoleCode();
	String sql = "CALL usp_menu_active_list('"+rolecodesession+"')";
        
        List<Menu> rootMenu = hbmSession.hSession.createSQLQuery(sql)
            .addScalar("code", Hibernate.STRING)
            .addScalar("text", Hibernate.STRING)
            .addScalar("classes", Hibernate.STRING)
            .addScalar("parentCode", Hibernate.STRING)
            .addScalar("link", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(Menu.class))
            .list();
        
        String sql2 = "SELECT * FROM scr_menu  WHERE scr_menu.`classes`='folder' AND scr_menu.`parentcode`='' ORDER BY scr_menu.`sortno` ASC";
        
        List<Menu> menu_all = hbmSession.hSession.createSQLQuery(sql2)
            .addScalar("code", Hibernate.STRING)
            .addScalar("text", Hibernate.STRING)
            .addScalar("classes", Hibernate.STRING)
            .addScalar("parentCode", Hibernate.STRING)
            .addScalar("link", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(Menu.class))
            .list();
        
        
        List<MenuTree> listMenuTree = new ArrayList<MenuTree>();
        
        for (Menu menu : rootMenu) {
            MenuTree tree = createMenuTree(menu); 
            
            for(Menu menu_temp:menu_all){
                if(menu.getCode().equals(menu_temp.getCode())){
                    
                    List<MenuTree> subMenu = generateSubMenu1(tree);
                    if (subMenu.size() > 0){
                        tree.setChildren(subMenu);
                    }
                
                    List<MenuTree> children = generateChildren(tree);
                    if (subMenu.size()>0 && children.size() > 0){
                        tree.addChildren(children);
                    }
                    if (subMenu.size()==0 && children.size()>0){
                        tree.setChildren(children);
                    }
                    
                    listMenuTree.add(tree);
                }
            }
            
        }
        return listMenuTree;
    }
    
    public List<MenuTree> generateSubMenu1(MenuTree parent) {
        
        String sql = "SELECT * FROM scr_menu  WHERE scr_menu.`classes`='folder' AND scr_menu.`parentcode`<>'' "
                    + "AND scr_menu.`parentcode`='"+parent.getCode()+"' ORDER BY scr_menu.`sortno` ASC";
        List<Menu> subMenu = (List<Menu>)hbmSession.hSession.createSQLQuery(sql)
            .addScalar("code", Hibernate.STRING)
            .addScalar("text", Hibernate.STRING)
            .addScalar("classes", Hibernate.STRING)
            .addScalar("parentCode", Hibernate.STRING)
            .addScalar("link", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(Menu.class))
            .list(); 
        
        List<MenuTree> listMenuTree = new ArrayList<MenuTree>();
        
        for (Menu menu : subMenu) {
            MenuTree tree = createMenuTree(menu);
            
            List<MenuTree> subMenu2 = generateSubMenu2(tree);
            if (subMenu2.size() > 0){
                tree.setChildren(subMenu2);
            }
                
            List<MenuTree> children = generateChildren(tree);
            
            if(children.size() > 0){
                if (subMenu2.size()>0){
                    tree.addChildren(children);
                }
                if (subMenu2.size()==0){
                    tree.setChildren(children);
                }
            }
            
            if(subMenu2.size() > 0 || children.size() > 0){
                listMenuTree.add(tree);
            }
        }
        
        return listMenuTree;
        
    }
    
    public List<MenuTree> generateSubMenu2(MenuTree parent) {
               
        String sql = "SELECT * FROM scr_menu  WHERE scr_menu.`classes`='folder' AND scr_menu.`parentcode`<>'' "
                    + "AND scr_menu.`parentcode`='"+parent.getCode()+"' "
                    + "ORDER BY scr_menu.`sortno` ASC";
        List<Menu> subMenu = (List<Menu>)hbmSession.hSession.createSQLQuery(sql)
            .addScalar("code", Hibernate.STRING)
            .addScalar("text", Hibernate.STRING)
            .addScalar("classes", Hibernate.STRING)
            .addScalar("parentCode", Hibernate.STRING)
            .addScalar("link", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(Menu.class))
            .list(); 
        
        List<MenuTree> listMenuTree = new ArrayList<MenuTree>();
        
        for (Menu menu : subMenu) {
            MenuTree tree = createMenuTree(menu);
            
            List<MenuTree> children = generateChildren(tree);
            if (children.size() > 0){
                tree.setChildren(children);
                
                listMenuTree.add(tree);
            }
        }
        
        return listMenuTree;
        
    }
        
    public List<MenuTree> generateChildren(MenuTree parent) {
        
        String rolecodesession = BaseSession.loadProgramSession().getRoleCode();
        String sql ="SELECT scr_menu.* FROM scr_menu "
            + "INNER JOIN scr_authorization ON scr_authorization.ModuleCode = scr_menu.Code "
            + "INNER JOIN scr_role_authorization ON scr_role_authorization.AuthorizationCode = scr_authorization.Code "
            + "WHERE scr_role_authorization.AssignAuthority = 1 "
            + "AND scr_role_authorization.headercode = '" + rolecodesession + "' "
            + "AND scr_menu.ParentCode = '" + parent.getCode() + "' "
            + "Order By scr_menu.sortNo ASC";

        List<Menu> childrenMenu = (List<Menu>)hbmSession.hSession.createSQLQuery(sql)
            .addScalar("code", Hibernate.STRING)
            .addScalar("text", Hibernate.STRING)
            .addScalar("classes", Hibernate.STRING)
            .addScalar("parentCode", Hibernate.STRING)
            .addScalar("link", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(Menu.class))
            .list(); 
        
        List<MenuTree> listMenuTree = new ArrayList<MenuTree>();
        
        for (Menu menu : childrenMenu) {
            MenuTree tree = createMenuTree(menu);
            
            listMenuTree.add(tree);
        }
		
        return listMenuTree;
    }
    
}