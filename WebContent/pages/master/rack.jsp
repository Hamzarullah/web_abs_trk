
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
        txtRackCode=$("#rack\\.code"),
        txtRackName=$("#rack\\.name"),
        txtRackWarehouseName=$("#rack\\.warehouse\\.name"),
        txtRackWarehouseCode=$("#rack\\.warehouse\\.code"),
        rdbRackActiveStatus=$("#rack\\.activeStatus"),
        rdbRackRackCategory=$("rack\\.rackCategory"),
        txtRackRemark=$("#rack\\.remark"),
        txtRackInActiveBy = $("#rack\\.inActiveBy"),
        txtRackInActiveDate = $("#rack\\.inActiveDate"),
        txtRackCreatedBy = $("#rack\\.createdBy"),
        txtRackCreatedDate = $("#rack\\.createdDate"),        
        allFieldsRack=$([])
            .add(txtRackCode)
            .add(txtRackName)
            .add(txtRackRemark)
            .add(rdbRackActiveStatus)
            .add(txtRackWarehouseName)
            .add(txtRackWarehouseCode)
            .add(txtRackInActiveBy)
            .add(txtRackInActiveDate) 
            .add(txtRackCreatedBy)
            .add(txtRackCreatedDate);


    function reloadGridRack(){
       $("#rack_grid").trigger("reloadGrid");
   };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("rack");
        $('#rack\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#rackSearchActiveStatusRadActive').prop('checked',true);
        $("#rackSearchActiveStatus").val("true");
        $('#rackRackCategoryRadRACK').prop('checked',true);
        $("#rack\\.rackCategory").val("RACK");
        
        $('input[name="rackSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#rackSearchActiveStatus").val(value);
        });
        
        $('input[name="rackSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#rackSearchActiveStatus").val(value);
        });
                
        $('input[name="rackSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#rackSearchActiveStatus").val(value);
        });
        
        $('input[name="rackActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#rack\\.activeStatus").val(value);
            $("#rack\\.inActiveDate").val("01/01/1900 00:00:00");
        });
        
        $('input[name="rackRackCategoryRad"][value="RACK"]').change(function(ev){
            var value="RACK";
            $("#rack\\.rackCategory").val(value);
        }); 
        
        $('input[name="rackRackCategoryRad"][value="DOCK\\ IN"]').change(function(ev){
            var value="DOCK_IN";
            $("#rack\\.rackCategory").val(value);
        }); 
        
        $('input[name="rackRackCategoryRad"][value="DOCK\\ DLN"]').change(function(ev){
            var value="DOCK_DLN";
            $("#rack\\.rackCategory").val(value);
        }); 
        
        $('input[name="rackActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#rack\\.activeStatus").val(value);
        });
        
         $("#btnRackNew").click(function(ev){
            var url="master/rack-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_rack();
                showInput("rack");
                hideInput("rackSearch");
                $('#rackActiveStatusRadActive').prop('checked',true);
                $("#rack\\.activeStatus").val("true");
                $("#rack\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#rack\\.createdDate").val("01/01/1900 00:00:00");
                updateRowId = -1;
                txtRackCode.attr("readonly",true);
                txtRackCode.val("AUTO");

                });
            });
//            ev.preventDefault();
       
        
        
        $("#btnRackSave").click(function(ev) {
                if (!$("#frmRackInput").valid()) {
                ev.preventDefault();
                return;
            }
           if (txtRackCode.val()<=0){
                alertMessage("Code Can't Be Empty !");
                return;
            }
           
            var url = "";
           if (updateRowId < 0){
               url = "master/rack-save";
                 
           } else{
               url = "master/rack-update";
             
           }
           
           var params = $("#frmRackInput").serialize()
           
           $.post(url, params, function(data) {
                if (data.error) {
                    rackFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("rack");
                showInput("rackSearch");
                allFieldsRack.val('').removeClass('ui-state-error');
                txtRackCode.val("AUTO");
                reloadGridRack();
           });
           
       //    ev.preventDefault();
        });
        $("#btnRackUpdate").click(function(ev){
            var selectRowId = $("#rack_grid").jqGrid('getGridParam','selrow');
            var rack = $("#rack_grid").jqGrid("getRowData", selectRowId);
            
            if (rack.rackCategory === "DOCK_DLN" ){
                alertMessage("Cannot Update");
                return;
            }else if (rack.rackCategory === "DOCK_IN" ){
                alertMessage("Cannot Update");
                return;
            }else{
            var url="master/rack-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_rack();
                updateRowId=$("#rack_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                    
                }
                
                var rack=$("#rack_grid").jqGrid('getRowData',updateRowId);
                var url="master/rack-get";
                var params="rack.code=" + rack.code;
                
                txtRackCode.attr("readonly",true);
                
                $.post(url,params,function (result){
                    var data=(result);
                        
                        txtRackCode.val(data.rackTemp.code);
                        txtRackName.val(data.rackTemp.name);
                        rdbRackActiveStatus.val(data.rackTemp.activeStatus);
                        rdbRackRackCategory.val(data.rackTemp.rackCategory);
                        txtRackRemark.val(data.rackTemp.remark);
                        txtRackWarehouseCode.val(data.rackTemp.warehouseCode);
                        txtRackWarehouseName.val(data.rackTemp.warehouseName);
                        txtRackInActiveBy.val(data.rackTemp.inActiveBy);
                        txtRackInActiveDate.val(data.rackTemp.inActiveDate);
                        txtRackCreatedBy.val(data.rackTemp.createdBy);
                        txtRackCreatedDate.val(data.rackTemp.createdDate);
                        
                        
                        if(data.rackTemp.activeStatus===true) {
                           $('#rackActiveStatusRadActive').prop('checked',true);
                           $("#rack\\.activeStatus").val("true");
                           $('#rackRackCategoryRadRACK').prop('checked',true);
                           $("#rack\\.rackCategory").val("RACK");
                        }
                        else {                        
                           $('#rackActiveStatusRadInActive').prop('checked',true);              
                           $("#rack\\.activeStatus").val("false");
                           $('#rackRackCategoryRadRACK').prop('checked',true);
                           $("#rack\\.rackCategory").val("RACK");
                        }

                        showInput("rack");
                        hideInput("rackSearch");
                });
            });
           ev.preventDefault();
        }   
    });
        
        
        $("#btnRackDelete").click(function (ev){
            var selectRowId = $("#rack_grid").jqGrid('getGridParam','selrow');
            var rack = $("#rack_grid").jqGrid("getRowData", selectRowId);
            
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";
            
            if (rack.rackCategory === "DOCK_DLN" ){
                alertMessage("Cannot Delete");
                return;
            }else if (rack.rackCategory === "DOCK_IN" ){
                alertMessage("Cannot Delete");
                return;
            }else{
            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/rack-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#rack_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var rack=$("#rack_grid").jqGrid('getRowData',deleteRowID);
                var url="master/rack-delete";
                var params="rack.code=" + rack.code;
                var message="Are You Sure To Delete(Code : "+ rack.code + ")?";
                alertMessageDelete("rack",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ rack.code+ ')?</div>');
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
//                                var url="master/rack-delete";
//                                var params="rack.code=" + rack.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridRack();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + rack.code+ ")")){
//                    var url="master/rack-delete";
//                    var params="rack.code=" + rack.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridRack();
//                    });
//                }
                });
            });
        }
//            ev.preventDefault();
    });
        

        $("#btnRackCancel").click(function(ev) {
            hideInput("rack");
            showInput("rackSearch");
            allFieldsRack.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnRackRefresh').click(function(ev) {
            $('#rackSearchActiveStatusRadActive').prop('checked',true);
            $("#rackSearchActiveStatus").val("true");
            $("#rack_grid").jqGrid("clearGridData");
            $("#rack_grid").jqGrid("setGridParam",{url:"master/rack-search-data?"});
            $("#rack_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnRackPrint").click(function(ev) {
            
            var url = "reports/rack-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'rack','width=500,height=500');
        });
        
        $('#btnRack_search').click(function(ev) {
            $("#rack_grid").jqGrid("clearGridData");
            $("#rack_grid").jqGrid("setGridParam",{url:"master/rack-search-data?" + $("#frmRackSearchInput").serialize()});
            $("#rack_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#rack_btnWarehouse').click(function(ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=rack&idsubdoc=warehouse","Search", "width=600, height=500");
        });
        
    });
    
    
//    function unHandlers_input_rack(){
//        unHandlersInput(txtRackCode);
//        unHandlersInput(txtRackName);
//    }
//
//    function handlers_input_rack(){
//        if(txtRackCode.val()===""){
//            handlersInput(txtRackCode);
//        }else{
//            unHandlersInput(txtRackCode);
//        }
//        if(txtRackName.val()===""){
//            handlersInput(txtRackName);
//        }else{
//            unHandlersInput(txtRackName);
//        }
//    }
    
    function rackFormatDate(){
        var inActiveDate=formatDate(dtpRackInActiveDate.val(),true);
        dtpRackInActiveDate.val(inActiveDate);
        $("#rackTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpRackCreatedDate.val(),true);
        dtpRackCreatedDate.val(createdDate);
        $("#rackTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>
<s:url id="remoteurlRack" action="rack-search-data" />
<b>RACK</b>
<hr>
<br class="spacer" />

    <sj:div id="rackButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
        <tr>
            <td><a href="#" id="btnRackNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnRackUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnRackDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnRackRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnRackPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
    </sj:div>
    <div id="rackSearchInput" class="content ui-widget">
        <br class="spacer" />
        <br class="spacer" />
        <s:form id="frmRackSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right" valign="centre"><b>Code</b></td>
                    <td>
                        <s:textfield id="rackSearchCode" name="rackSearchCode" size="20"></s:textfield>
                    </td>
                    <td align="right" valign="centre"><b>Name</b></td>
                    <td>
                        <s:textfield id="rackSearchName" name="rackSearchName" size="50"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right">Status
                        <s:textfield id="rackSearchActiveStatus" name="rackSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    </td>
                    <td>
                        <s:radio id="rackSearchActiveStatusRad" name="rackSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                    </td>
                </tr>  
            </table>
            <br />
            <sj:a href="#" id="btnRack_search" button="true">Search</sj:a>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
        </s:form>
    </div>
    <br class="spacer" />  
<div id="rackGrid">
    <sjg:grid
        id="rack_grid"
        dataType="json"
        href="%{remoteurlRack}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listRackTemp"
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
            name="warehouseCode" index="warehouseCode" title="Warehouse Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="warehouseName" index="warehouseName" title="Warehouse Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="rackCategory" index="rackCategory" title="rackCategory" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>

    
<div id="rackInput" class="content ui-widget">
    <s:form id="frmRackInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="rack.code" name="rack.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="rack.name" name="rack.name" size="30" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Rack Category *</B></td>
                <td colspan="2">
                    <s:radio id="rackRackCategoryRad" name="rackRackCategoryRad" list="{'RACK','DOCK DLN','DOCK IN'}"></s:radio>
                    <s:textfield id="rack.rackCategory" name="rack.rackCategory" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right"><B>Warehouse *</B></td>
                <td>
                    <script type = "text/javascript">    
                    txtRackWarehouseCode.change(function(ev) {

                        if(txtRackWarehouseCode.val()===""){
                            txtRackWarehouseName.val("");
                            return;
                        }

                        var url = "master/warehouse-get";
                        var params = "warehouseCode=" + txtRackWarehouseCode.val();
                            params += "&warehouse.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.warehouseTemp){
                                txtRackWarehouseCode.val(data.warehouseTemp.code);
                                txtRackWarehouseName.val(data.warehouseTemp.name);
                            }
                            else{
                                alertMessage("Warehouse Not Found!",txtRackWarehouseCode);
                                txtRackWarehouseCode.val("");
                                txtRackWarehouseName.val("");
                            }
                        });
                    });
                    </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="rack.warehouse.code" name="rack.warehouse.code" title=" " required="true" cssClass="required" size="25"></s:textfield>
                            <sj:a id="rack_btnWarehouse" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="rack.warehouse.name" name="rack.warehouse.name" size="25" readonly="true"></s:textfield> 
                </td>
            </tr>
            <tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="rackActiveStatusRad" name="rackActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="rack.activeStatus" name="rack.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="rack.remark" name="rack.remark"  cols="27" rows="2" height="20"></s:textarea>
                </td>
            </tr>
            
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="rack.inActiveBy"  name="rack.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="rack.inActiveDate" name="rack.inActiveDate" title=" " disabled = "true" displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="rack.createdBy"  name="rack.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="rack.createdDate" name="rack.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="rackTemp.inActiveDateTemp" name="rackTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="rackTemp.createdDateTemp" name="rackTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnRackSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnRackCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>