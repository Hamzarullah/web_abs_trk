
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
     
    var 
        txtDcasFireSafeByDesignCode=$("#dcasFireSafeByDesign\\.code"),
        txtDcasFireSafeByDesignName=$("#dcasFireSafeByDesign\\.name"),
        rdbDcasFireSafeByDesignActiveStatus=$("#dcasFireSafeByDesign\\.activeStatus"),
        txtDcasFireSafeByDesignRemark=$("#dcasFireSafeByDesign\\.remark"),
        txtDcasFireSafeByDesignInActiveBy = $("#dcasFireSafeByDesign\\.inActiveBy"),
        dtpDcasFireSafeByDesignInActiveDate = $("#dcasFireSafeByDesign\\.inActiveDate"),
        txtDcasFireSafeByDesignCreatedBy = $("#dcasFireSafeByDesign\\.createdBy"),
        dtpDcasFireSafeByDesignCreatedDate = $("#dcasFireSafeByDesign\\.createdDate"),
        
        allFieldsDcasFireSafeByDesign=$([])
            .add(txtDcasFireSafeByDesignCode)
            .add(txtDcasFireSafeByDesignName)
            .add(txtDcasFireSafeByDesignRemark)
            .add(txtDcasFireSafeByDesignInActiveBy)
            .add(txtDcasFireSafeByDesignCreatedBy);


    function reloadGridDcasFireSafeByDesign(){
        $("#dcasFireSafeByDesign_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("dcasFireSafeByDesign");
        
        $('#dcasFireSafeByDesign\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#dcasFireSafeByDesignSearchActiveStatusRadActive').prop('checked',true);
        $("#dcasFireSafeByDesignSearchActiveStatus").val("true");
        
        $('input[name="dcasFireSafeByDesignSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#dcasFireSafeByDesignSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasFireSafeByDesignSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasFireSafeByDesignSearchActiveStatus").val(value);
        });
                
        $('input[name="dcasFireSafeByDesignSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasFireSafeByDesignSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasFireSafeByDesignActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasFireSafeByDesign\\.activeStatus").val(value);
            $("#dcasFireSafeByDesign\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="dcasFireSafeByDesignActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasFireSafeByDesign\\.activeStatus").val(value);
        });
        
        $("#btnDcasFireSafeByDesignNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-fire-safe-by-design-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasFireSafeByDesign();
                showInput("dcasFireSafeByDesign");
                hideInput("dcasFireSafeByDesignSearch");
                $('#dcasFireSafeByDesignActiveStatusRadActive').prop('checked',true);
                $("#dcasFireSafeByDesign\\.activeStatus").val("true");
                $("#dcasFireSafeByDesign\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#dcasFireSafeByDesign\\.createdDate").val("01/01/1900 00:00:00");
                txtDcasFireSafeByDesignCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtDcasFireSafeByDesignCode.val("AUTO");
                txtDcasFireSafeByDesignCode.attr("readonly",true);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasFireSafeByDesignSave").click(function(ev) {
           if(!$("#frmDcasFireSafeByDesignInput").valid()) {
//               handlers_input_dcasFireSafeByDesign();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           dcasFireSafeByDesignFormatDate();
           if (updateRowId < 0){
               url = "master/dcas-fire-safe-by-design-save";
           } else{
               url = "master/dcas-fire-safe-by-design-update";
           }
           
           var params = $("#frmDcasFireSafeByDesignInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    dcasFireSafeByDesignFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dcasFireSafeByDesign");
                showInput("dcasFireSafeByDesignSearch");
                allFieldsDcasFireSafeByDesign.val('').siblings('label[class="error"]').hide();
                txtDcasFireSafeByDesignCode.val("AUTO");
                reloadGridDcasFireSafeByDesign();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnDcasFireSafeByDesignUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-fire-safe-by-design-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasFireSafeByDesign();
                updateRowId=$("#dcasFireSafeByDesign_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var dcasFireSafeByDesign=$("#dcasFireSafeByDesign_grid").jqGrid('getRowData',updateRowId);
                var url="master/dcas-fire-safe-by-design-get-data";
                var params="dcasFireSafeByDesign.code=" + dcasFireSafeByDesign.code;

                txtDcasFireSafeByDesignCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtDcasFireSafeByDesignCode.val(data.dcasFireSafeByDesignTemp.code);
                        txtDcasFireSafeByDesignName.val(data.dcasFireSafeByDesignTemp.name);
                        rdbDcasFireSafeByDesignActiveStatus.val(data.dcasFireSafeByDesignTemp.activeStatus);
                        txtDcasFireSafeByDesignRemark.val(data.dcasFireSafeByDesignTemp.remark);
                        txtDcasFireSafeByDesignInActiveBy.val(data.dcasFireSafeByDesignTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.dcasFireSafeByDesignTemp.inActiveDate,true);
                        dtpDcasFireSafeByDesignInActiveDate.val(inActiveDate);
                        txtDcasFireSafeByDesignCreatedBy.val(data.dcasFireSafeByDesignTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.dcasFireSafeByDesignTemp.createdDate,true);
                        dtpDcasFireSafeByDesignCreatedDate.val(createdDate);

                        if(data.dcasFireSafeByDesignTemp.activeStatus===true) {
                           $('#dcasFireSafeByDesignActiveStatusRadActive').prop('checked',true);
                           $("#dcasFireSafeByDesign\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#dcasFireSafeByDesignActiveStatusRadInActive').prop('checked',true);              
                           $("#dcasFireSafeByDesign\\.activeStatus").val("false");
                        }

                        showInput("dcasFireSafeByDesign");
                        hideInput("dcasFireSafeByDesignSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasFireSafeByDesignDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-fire-safe-by-design-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dcasFireSafeByDesign_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dcasFireSafeByDesign=$("#dcasFireSafeByDesign_grid").jqGrid('getRowData',deleteRowID);
                var url="master/dcas-fire-safe-by-design-delete";
                var params="dcasFireSafeByDesign.code=" + dcasFireSafeByDesign.code;
                var message="Are You Sure To Delete(Code : "+ dcasFireSafeByDesign.code + ")?";
                alertMessageDelete("dcasFireSafeByDesign",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ dcasFireSafeByDesign.code+ ')?</div>');
//
//                dynamicDialog.dialog({
//                    title : "Confirmation:",
//                    closeOnEscape: false,
//                    modal : true,
//                    width: 500,
//                    resizable: false,
//                    buttons : 
//                        [{
//                            text : "Yes",
//                            click : function() {
//
//                                $(this).dialog("close");
//                                var url="master/dcas-fire-safe-by-design-delete";
//                                var params="dcasFireSafeByDesign.code=" + dcasFireSafeByDesign.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridDcasFireSafeByDesign();
//                                });
//                            }
//                        },
//                        {
//                            text : "No",
//                            click : function() {
//
//                                $(this).dialog("close");
//                            }
//                        }]
//                });
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + dcasFireSafeByDesign.code+ ")")){
//                    var url="master/dcas-fire-safe-by-design-delete";
//                    var params="dcasFireSafeByDesign.code=" + dcasFireSafeByDesign.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridDcasFireSafeByDesign();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnDcasFireSafeByDesignCancel").click(function(ev) {
            hideInput("dcasFireSafeByDesign");
            showInput("dcasFireSafeByDesignSearch");
            allFieldsDcasFireSafeByDesign.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnDcasFireSafeByDesignRefresh').click(function(ev) {
            $('#dcasFireSafeByDesignSearchActiveStatusRadActive').prop('checked',true);
            $("#dcasFireSafeByDesignSearchActiveStatus").val("true");
            $("#dcasFireSafeByDesign_grid").jqGrid("clearGridData");
            $("#dcasFireSafeByDesign_grid").jqGrid("setGridParam",{url:"master/dcas-fire-safe-by-design-data?"});
            $("#dcasFireSafeByDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnDcasFireSafeByDesignPrint").click(function(ev) {
            
            var url = "reports/dcas-fire-safe-by-design-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'dcasFireSafeByDesign','width=500,height=500');
        });
        
        $('#btnDcasFireSafeByDesign_search').click(function(ev) {
            $("#dcasFireSafeByDesign_grid").jqGrid("clearGridData");
            $("#dcasFireSafeByDesign_grid").jqGrid("setGridParam",{url:"master/dcas-fire-safe-by-design-data?" + $("#frmDcasFireSafeByDesignSearchInput").serialize()});
            $("#dcasFireSafeByDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_dcasFireSafeByDesign(){
//        unHandlersInput(txtDcasFireSafeByDesignCode);
//        unHandlersInput(txtDcasFireSafeByDesignName);
//    }
//
//    function handlers_input_dcasFireSafeByDesign(){
//        if(txtDcasFireSafeByDesignCode.val()===""){
//            handlersInput(txtDcasFireSafeByDesignCode);
//        }else{
//            unHandlersInput(txtDcasFireSafeByDesignCode);
//        }
//        if(txtDcasFireSafeByDesignName.val()===""){
//            handlersInput(txtDcasFireSafeByDesignName);
//        }else{
//            unHandlersInput(txtDcasFireSafeByDesignName);
//        }
//    }
    
    function dcasFireSafeByDesignFormatDate(){
        var inActiveDate=formatDate(dtpDcasFireSafeByDesignInActiveDate.val(),true);
        dtpDcasFireSafeByDesignInActiveDate.val(inActiveDate);
        $("#dcasFireSafeByDesignTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpDcasFireSafeByDesignCreatedDate.val(),true);
        dtpDcasFireSafeByDesignCreatedDate.val(createdDate);
        $("#dcasFireSafeByDesignTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlDcasFireSafeByDesign" action="dcas-fire-safe-by-design-data" />
<b>Dcas Fire Safe by Design</b>
<hr>
<br class="spacer"/>


<sj:div id="dcasFireSafeByDesignButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDcasFireSafeByDesignNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDcasFireSafeByDesignUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDcasFireSafeByDesignDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDcasFireSafeByDesignRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDcasFireSafeByDesignPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="dcasFireSafeByDesignSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDcasFireSafeByDesignSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="dcasFireSafeByDesignSearchCode" name="dcasFireSafeByDesignSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="dcasFireSafeByDesignSearchName" name="dcasFireSafeByDesignSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="dcasFireSafeByDesignSearchActiveStatus" name="dcasFireSafeByDesignSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="dcasFireSafeByDesignSearchActiveStatusRad" name="dcasFireSafeByDesignSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDcasFireSafeByDesign_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="dcasFireSafeByDesignGrid">
    <sjg:grid
        id="dcasFireSafeByDesign_grid"
        dataType="json"
        href="%{remoteurlDcasFireSafeByDesign}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDcasFireSafeByDesignTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="dcasFireSafeByDesignInput" class="content ui-widget">
    <s:form id="frmDcasFireSafeByDesignInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="dcasFireSafeByDesign.code" name="dcasFireSafeByDesign.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="dcasFireSafeByDesign.name" name="dcasFireSafeByDesign.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="dcasFireSafeByDesignActiveStatusRad" name="dcasFireSafeByDesignActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="dcasFireSafeByDesign.activeStatus" name="dcasFireSafeByDesign.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="dcasFireSafeByDesign.remark" name="dcasFireSafeByDesign.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="dcasFireSafeByDesign.inActiveBy"  name="dcasFireSafeByDesign.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="dcasFireSafeByDesign.inActiveDate" name="dcasFireSafeByDesign.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasFireSafeByDesign.createdBy"  name="dcasFireSafeByDesign.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="dcasFireSafeByDesign.createdDate" name="dcasFireSafeByDesign.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasFireSafeByDesignTemp.inActiveDateTemp" name="dcasFireSafeByDesignTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="dcasFireSafeByDesignTemp.createdDateTemp" name="dcasFireSafeByDesignTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnDcasFireSafeByDesignSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnDcasFireSafeByDesignCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>