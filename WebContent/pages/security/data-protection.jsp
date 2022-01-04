<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<style>
    input{border-radius: 3px; height:18px;}
</style>

<script type="text/javascript">
    $(document).ready(function (){
        hoverButton();
        hideInput("dataProtection");

        $("#btnDataProtectionNew").click(function(ev){
            var url="security/data-protection-authority";
            var params="actionAuthority=INSERT";

            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                showInput("dataProtection");
                hideInput("dataProtectionInput");

            });
            ev.preventDefault();
        });
        
        $("#btnDataProtectionSave").click(function(ev) {
            if(!$("#frmDataProtectionInput").valid()) {
               ev.preventDefault();
               return;
            };
            
            var url = "security/data-protection-save";
            var params = "dataProtection_periodMonth="+$("#dataProtection_periodMonth").val();
                params += "&dataProtection_periodYear="+$("#dataProtection_periodYear").val();
            
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dataProtection");
                showInput("dataProtectionInput");
                reloadGridDataProtection();           
           });
           
           ev.preventDefault();
        });
        
        $("#btnDataProtectionDelete").click(function (ev){
            var url="security/data-protection-authority";
            var params="actionAuthority=DELETE";
            
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dataProtection_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dataProtection=$("#dataProtection_grid").jqGrid('getRowData',deleteRowID);

                if(confirm("Are You Sure To Delete(Code : " + dataProtection.monthPeriod +" - "+ dataProtection.yearPeriod + ")" )){
                    
                    var url="security/data-protection-delete";
                    var params="dataProtection_periodMonth=" + dataProtection.monthPeriod;
                        params += "&dataProtection_periodYear="+ dataProtection.yearPeriod;

                    $.post(url,params,function (data){
                        if(data.error){
                            alertMessage(data.errorMessage);
                            return;
                        }

                        alertMessage(data.message);
                        reloadGridDataProtection();
                    });
                }
                
            });
             ev.preventDefault();
        });
        
        $("#btnDataProtectionCancel").click(function(ev) {
            hideInput("dataProtection");
            showInput("dataProtectionInput");
            ev.preventDefault();
        });
        
        $('#btnDataProtectionRefresh').click(function(ev) {
            $("#dataProtection_grid").jqGrid("clearGridData");
            $("#dataProtection_grid").jqGrid("setGridParam",{url:"security/data-protection-data?"});
            $("#dataProtection_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
    });
    
    function reloadGridDataProtection(){
        $('#btnDataProtectionRefresh').trigger('click');
    };
</script>

<s:url id="remoteurlDataProtection" action="data-protection-data"/>
<b>DATA PROTECTION</b>
<hr/>
<br class="spacer"/>
        <sj:div id="dataProtectionButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
           <tr>
            <td><a href="#" id="btnDataProtectionNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a></td>
            <td><a href="#" id="btnDataProtectionDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete" /><br/>Delete</a></td>
            <td><a href="#" id="btnDataProtectionRefresh" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a></td>
            </tr>
        </table>    
        </sj:div>
    <br class="spacer"/>
    <br class="spacer"/>
       
    <div id="dataProtectionGrid">
        <sjg:grid
            id="dataProtection_grid"
            dataType="json"
            href="%{remoteurlDataProtection}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listDataProtectionTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="200" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="monthPeriod" index="monthPeriod" key="monthPeriod" title="Month Period" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="yearPeriod" index="yearPeriod" key="yearPeriod" title="Year Period" width="200" sortable="true"
                />
        </sjg:grid>
    </div>
    
    <div id="dataProtectionInput" class="content ui-widget">
        <s:form id="frmDataProtectionInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period Date *</b></td>
                    <td>
                        <s:select id="dataProtection_periodMonth" name="dataProtection_periodMonth" width="20" list="monthlyList" listKey="code" listValue="name" key="dataProtection_periodMonth"/>
                    &nbsp;<s:select id="dataProtection_periodYear" name="dataProtection_periodYear" width="5" list="yearList" listKey="code" listValue="name" key="dataProtection_periodYear"/>
                    </td>
                </tr>
                <tr height="50">
                    <td></td>
                    <td>
                        <sj:a href="#" id="btnDataProtectionSave" button="true">Save</sj:a>
                        <sj:a href="#" id="btnDataProtectionCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </s:form>
    </div>
    
   