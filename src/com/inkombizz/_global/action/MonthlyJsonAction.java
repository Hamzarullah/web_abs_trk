package com.inkombizz._global.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import com.inkombizz.common.StringValue;
import com.inkombizz.common.enumeration.EnumMonth;
import com.inkombizz.dao.HBMSession;
import java.util.ArrayList;

@Result(type = "json")
public class MonthlyJsonAction extends ActionSupport{
    
    private static final long serialVersionUID = 1L;    
    protected HBMSession hbmSession = new HBMSession();
    
    private StringValue stringValue = new StringValue();
    private List<StringValue> monthlyList;
    
    @Override 
    public String execute(){
        try{
            return getListMonthly();
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
    
    @Action("monthly-list")
    public String getListMonthly(){
        try{
            this.monthlyList = new ArrayList<StringValue>();
            for(int i=1;i<=12;i++){
                StringValue sv = new StringValue();
                
                sv.setCode(Integer.toString(i));
                sv.setName(EnumMonth.toString(i,false));
                        
                this.monthlyList.add(sv);
            }
            
            return SUCCESS;
        }
        catch(Exception ex){
            return SUCCESS;
        }
    }
    
    public List<StringValue> getMonthlyList(){
        return this.monthlyList;
    }
    
    public void setMonthlyList(List<StringValue> monthlyList){
        this.monthlyList = monthlyList;
    }
}
