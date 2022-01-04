package com.inkombizz.action;

import com.inkombizz.common.StringValue;
import com.inkombizz.common.enumeration.EnumMonth;
import com.inkombizz.utils.DateUtils;
import static com.opensymphony.xwork2.Action.ERROR;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.util.List;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@Results({
    @Result(name="success", location="panel.jsp"),
    @Result(name="backtopanel", type="redirect", location="panel")
})
public class PanelAction extends BaseSession {
    private int panel_periodYear = 0;
    private int panel_periodMonth = 0;
    private String panel_periodMonth_Str = "";
    private List<StringValue> monthlyList;
    private List<StringValue> yearList;
    
    @Override
    public String execute() {
        try {
            if (!isSessionValid())
                return ERROR;
            else
                panel_periodMonth = BaseSession.loadProgramSession().periodMonth;
                panel_periodYear = BaseSession.loadProgramSession().periodYear;
                panel_periodMonth_Str = EnumMonth.toString(panel_periodMonth, false);
                
                monthlyList = DateUtils.getMonthlyList();
                yearList = DateUtils.getYearList();
                
                return SUCCESS;
        }
        catch(Exception ex) {
            ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("panel-change-period")
    public String changePeriod() {
        try {
            if (!isSessionValid())
                return ERROR;
            else {
                //set new Session
                ProgramSession prgSession = BaseSession.loadProgramSession();

                prgSession.periodMonth = panel_periodMonth;
                prgSession.periodYear = panel_periodYear;

                BaseSession.settingSession(prgSession);

                panel_periodMonth_Str = EnumMonth.toString(panel_periodMonth, false);

                //monthlyList = generateMonth();
                monthlyList = DateUtils.getMonthlyList();
                
                //System.out.print("PANEL Month : " + periodMonth + "    Year : " + periodYear);

                return "backtopanel";       
            }
        }
        catch (Exception ex) {
            return ERROR;      
        }
    }

    public int getPanel_periodYear() {
        return panel_periodYear;
    }

    public void setPanel_periodYear(int panel_periodYear) {
        this.panel_periodYear = panel_periodYear;
    }

    public int getPanel_periodMonth() {
        return panel_periodMonth;
    }

    public void setPanel_periodMonth(int panel_periodMonth) {
        this.panel_periodMonth = panel_periodMonth;
    }

    public String getPanel_periodMonth_Str() {
        return panel_periodMonth_Str;
    }

    public void setPanel_periodMonth_Str(String panel_periodMonth_Str) {
        this.panel_periodMonth_Str = panel_periodMonth_Str;
    }

    public List<StringValue> getMonthlyList() {
        return monthlyList;
    }

    public void setMonthlyList(List<StringValue> monthlyList) {
        this.monthlyList = monthlyList;
    }

    public List<StringValue> getYearList() {
        return yearList;
    }

    public void setYearList(List<StringValue> yearList) {
        this.yearList = yearList;
    }

}
