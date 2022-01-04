//
//package com.inkombizz.system.action;
//
//import com.inkombizz.action.BaseSession;
//import com.inkombizz.common.enumeration.EnumAuthorizationString;
//import com.inkombizz.dao.HBMSession;
//import com.inkombizz.master.bll.SerialNoDetailBLL;
//import static com.opensymphony.xwork2.Action.SUCCESS;
//import com.opensymphony.xwork2.ActionSupport;
//import org.apache.struts2.convention.annotation.Result;
//import org.apache.struts2.convention.annotation.Results;
//
//
//@Results({
//    @Result(name="success", location="system/item-date-check-error.jsp"),
//    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp")
//})
//public class ItemDateCheckErrorAction extends ActionSupport{
//    
//    private static final long serialVersionUID = 1L;
//    
//    protected HBMSession hbmSession = new HBMSession();
//
//    
//    @Override
//    public String execute() {
//        try {
//            SerialNoDetailBLL serialNoDetailBLL = new SerialNoDetailBLL(hbmSession);            
//            if (!BaseSession.loadProgramSession().hasAuthority(serialNoDetailBLL.MODULECODE_CHECK, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
//                return "redirect";
//            }           
//            
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            return SUCCESS;
//        }
//    }
//
//    public HBMSession getHbmSession() {
//        return hbmSession;
//    }
//
//    public void setHbmSession(HBMSession hbmSession) {
//        this.hbmSession = hbmSession;
//    }
//
//    
//}
