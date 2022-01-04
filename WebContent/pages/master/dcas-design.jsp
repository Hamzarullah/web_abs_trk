
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
        txtDcasDesignCode=$("#dcasDesign\\.code"),
        txtDcasDesignName=$("#dcasDesign\\.name"),
        rdbDcasDesignActiveStatus=$("#dcasDesign\\.activeStatus"),
        txtDcasDesignRemark=$("#dcasDesign\\.remark"),
        txtDcasDesignInActiveBy = $("#dcasDesign\\.inActiveBy"),
        dtpDcasDesignInActiveDate = $("#dcasDesign\\.inActiveDate"),
        txtDcasDesignCreatedBy = $("#dcasDesign\\.createdBy"),
        dtpDcasDesignCreatedDate = $("#dcasDesign\\.createdDate"),
        
        allFieldsDcasDesign=$([])
            .add(txtDcasDesignCode)
            .add(txtDcasDesignName)
            .add(txtDcasDesignRemark)
            .add(txtDcasDesignInActiveBy)
            .add(txtDcasDesignCreatedBy);


    function reloadGridDcasDesign(){
        $("#dcasDesign_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("dcasDesign");
        
        $('#dcasDesign\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#dcasDesignSearchActiveStatusRadActive').prop('checked',true);
        $("#dcasDesignSearchActiveStatus").val("true");
        
        $('input[name="dcasDesignSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#dcasDesignSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasDesignSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasDesignSearchActiveStatus").val(value);
        });
                
        $('input[name="dcasDesignSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasDesignSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasDesignActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasDesign\\.activeStatus").val(value);
            $("#dcasDesign\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="dcasDesignActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasDesign\\.activeStatus").val(value);
        });
        
        $("#btnDcasDesignNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-design-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasDesign();
                showInput("dcasDesign");
                hideInput("dcasDesignSearch");
                $('#dcasDesignActiveStatusRadActive').prop('checked',true);
                $("#dcasDesign\\.activeStatus").val("true");
                $("#dcasDesign\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#dcasDesign\\.createdDate").val("01/01/1900 00:00:00");
                txtDcasDesignCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtDcasDesignCode.val("AUTO");
                txtDcasDesignCode.attr("readonly",true);
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasDesignSave").click(function(ev) {
           if(!$("#frmDcasDesignInput").valid()) {
//               handlers_input_dcasDesign();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           dcasDesignFormatDate();
           if (updateRowId < 0){
               url = "master/dcas-design-save";
           } else{
               url = "master/dcas-design-update";
           }
           
           var params = $("#frmDcasDesignInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    dcasDesignFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dcasDesign");
                showInput("dcasDesignSearch");
                allFieldsDcasDesign.val('').siblings('label[class="error"]').hide();
                txtDcasDesignCode.val("AUTO");
                reloadGridDcasDesign();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnDcasDesignUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-design-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasDesign();
                updateRowId=$("#dcasDesign_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var dcasDesign=$("#dcasDesign_grid").jqGrid('getRowData',updateRowId);
                var url="master/dcas-design-get-data";
                var params="dcasDesign.code=" + dcasDesign.code;

                txtDcasDesignCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtDcasDesignCode.val(data.dcasDesignTemp.code);
                        txtDcasDesignName.val(data.dcasDesignTemp.name);
                        rdbDcasDesignActiveStatus.val(data.dcasDesignTemp.activeStatus);
                        txtDcasDesignRemark.val(data.dcasDesignTemp.remark);
                        txtDcasDesignInActiveBy.val(data.dcasDesignTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.dcasDesignTemp.inActiveDate,true);
                        dtpDcasDesignInActiveDate.val(inActiveDate);
                        txtDcasDesignCreatedBy.val(data.dcasDesignTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.dcasDesignTemp.createdDate,true);
                        dtpDcasDesignCreatedDate.val(createdDate);

                        if(data.dcasDesignTemp.activeStatus===true) {
                           $('#dcasDesignActiveStatusRadActive').prop('checked',true);
                           $("#dcasDesign\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#dcasDesignActiveStatusRadInActive').prop('checked',true);              
                           $("#dcasDesign\\.activeStatus").val("false");
                        }

                        showInput("dcasDesign");
                        hideInput("dcasDesignSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasDesignDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-design-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dcasDesign_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dcasDesign=$("#dcasDesign_grid").jqGrid('getRowData',deleteRowID);
                var url="master/dcas-design-delete";
                var params="dcasDesign.code=" + dcasDesign.code;
                var message="Are You Sure To Delete(Code : "+ dcasDesign.code + ")?";
                alertMessageDelete("dcasDesign",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ dcasDesign.code+ ')?</div>');
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
//                                var url="master/dcas-design-delete";
//                                var params="dcasDesign.code=" + dcasDesign.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridDcasDesign();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + dcasDesign.code+ ")")){
//                    var url="master/dcas-design-delete";
//                    var params="dcasDesign.code=" + dcasDesign.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridDcasDesign();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnDcasDesignCancel").click(function(ev) {
            hideInput("dcasDesign");
            showInput("dcasDesignSearch");
            allFieldsDcasDesign.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnDcasDesignRefresh').click(function(ev) {
            $('#dcasDesignSearchActiveStatusRadActive').prop('checked',true);
            $("#dcasDesignSearchActiveStatus").val("true");
            $("#dcasDesign_grid").jqGrid("clearGridData");
            $("#dcasDesign_grid").jqGrid("setGridParam",{url:"master/dcas-design-data?"});
            $("#dcasDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnDcasDesignPrint").click(function(ev) {
            
            var url = "reports/dcas-design-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'dcasDesign','width=500,height=500');
        });
        
        $('#btnDcasDesign_search').click(function(ev) {
            $("#dcasDesign_grid").jqGrid("clearGridData");
            $("#dcasDesign_grid").jqGrid("setGridParam",{url:"master/dcas-design-data?" + $("#frmDcasDesignSearchInput").serialize()});
            $("#dcasDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_dcasDesign(){
//        unHandlersInput(txtDcasDesignCode);
//        unHandlersInput(txtDcasDesignName);
//    }
//
//    function handlers_input_dcasDesign(){
//        if(txtDcasDesignCode.val()===""){
//            handlersInput(txtDcasDesignCode);
//        }else{
//            unHandlersInput(txtDcasDesignCode);
//        }
//        if(txtDcasDesignName.val()===""){
//            handlersInput(txtDcasDesignName);
//        }else{
//            unHandlersInput(txtDcasDesignName);
//        }
//    }
    
    function dcasDesignFormatDate(){
        var inActiveDate=formatDate(dtpDcasDesignInActiveDate.val(),true);
        dtpDcasDesignInActiveDate.val(inActiveDate);
        $("#dcasDesignTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpDcasDesignCreatedDate.val(),true);
        dtpDcasDesignCreatedDate.val(createdDate);
        $("#dcasDesignTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlDcasDesign" action="dcas-design-data" />
<b>Dcas Design</b>
<hr>
<br class="spacer"/>


<sj:div id="dcasDesignButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDcasDesignNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDcasDesignUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDcasDesignDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDcasDesignRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDcasDesignPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="dcasDesignSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDcasDesignSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="dcasDesignSearchCode" name="dcasDesignSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="dcasDesignSearchName" name="dcasDesignSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="dcasDesignSearchActiveStatus" name="dcasDesignSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="dcasDesignSearchActiveStatusRad" name="dcasDesignSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDcasDesign_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="dcasDesignGrid">
    <sjg:grid
        id="dcasDesign_grid"
        dataType="json"
        href="%{remoteurlDcasDesign}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDcasDesignTemp"
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
    
<div id="dcasDesignInput" class="content ui-widget">
    <s:form id="frmDcasDesignInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="dcasDesign.code" name="dcasDesign.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="dcasDesign.name" name="dcasDesign.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="dcasDesignActiveStatusRad" name="dcasDesignActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="dcasDesign.activeStatus" name="dcasDesign.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="dcasDesign.remark" name="dcasDesign.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="dcasDesign.inActiveBy"  name="dcasDesign.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="dcasDesign.inActiveDate" name="dcasDesign.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasDesign.createdBy"  name="dcasDesign.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="dcasDesign.createdDate" name="dcasDesign.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasDesignTemp.inActiveDateTemp" name="dcasDesignTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="dcasDesignTemp.createdDateTemp" name="dcasDesignTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnDcasDesignSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnDcasDesignCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>