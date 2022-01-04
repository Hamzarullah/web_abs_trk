
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
        txtWarehouseCode=$("#warehouse\\.code"),
        txtWarehouseName=$("#warehouse\\.name"),
        txtWarehouseAddress=$("#warehouse\\.address"),
        txtWarehousePhone1=$("#warehouse\\.phone1"),
        txtWarehousePhone2=$("#warehouse\\.phone2"),
        txtWarehouseEmailAddress=$("#warehouse\\.emailAddress"),
        txtWarehouseFax=$("#warehouse\\.fax"),
        txtWarehouseContactPerson=$("#warehouse\\.contactPerson"),
        txtWarehouseDockDlnCode=$("#warehouse\\.dockDlnCode"),
        txtWarehouseDockInCode=$("#warehouse\\.dockInCode"),
        txtWarehouseZipCode=$("#warehouse\\.zipCode"),
        txtWarehouseCityCode=$("#warehouse\\.city\\.code"),
        txtWarehouseCityName=$("#warehouse\\.city\\.name"),
        txtWarehouseProvinceCode=$("#warehouse\\.city\\.province\\.code"),
        txtWarehouseProvinceName=$("#warehouse\\.city\\.province\\.name"),
        rdbWarehouseActiveStatus=$("#warehouse\\.activeStatus"),
        txtWarehouseRemark=$("#warehouse\\.remark"),
        txtWarehouseInActiveBy = $("#warehouse\\.inActiveBy"),
        dtpWarehouseInActiveDate = $("#warehouse\\.inActiveDate"),
        txtWarehouseCreatedBy = $("#warehouse\\.createdBy"),
        dtpWarehouseCreatedDate = $("#warehouse\\.createdDate"),
        
        allFieldsWarehouse=$([])
            .add(txtWarehouseCode)
            .add(txtWarehouseName)
            .add(txtWarehouseAddress)
            .add(txtWarehousePhone1)
            .add(txtWarehousePhone2)
            .add(txtWarehouseEmailAddress)
            .add(txtWarehouseFax)
            .add(txtWarehouseContactPerson)
            .add(txtWarehouseDockDlnCode)
            .add(txtWarehouseDockInCode)
            .add(txtWarehouseZipCode)
            .add(txtWarehouseCityCode)
            .add(txtWarehouseCityName)
            .add(txtWarehouseProvinceCode)
            .add(txtWarehouseProvinceName)
            .add(txtWarehouseRemark)
            .add(txtWarehouseInActiveBy)
            .add(txtWarehouseCreatedBy);


    function reloadGridWarehouse(){
        $("#warehouse_grid").trigger("reloadGrid");
        closeLoading();
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("warehouse");
        
        $('#warehouse\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#warehouseSearchActiveStatusRadActive').prop('checked',true);
        $("#warehouseSearchActiveStatus").val("true");
        
        $('input[name="warehouseSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#warehouseSearchActiveStatus").val(value);
        });
        
        $('input[name="warehouseSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#warehouseSearchActiveStatus").val(value);
        });
                
        $('input[name="warehouseSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#warehouseSearchActiveStatus").val(value);
        });
        
        $('input[name="warehouseActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#warehouse\\.activeStatus").val(value);
            $("#warehouse\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="warehouseActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#warehouse\\.activeStatus").val(value);
        });
        
        $("#btnWarehouseNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
            var url="master/warehouse-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_warehouse();
                showInput("warehouse");
                hideInput("warehouseSearch");
                $('#warehouseActiveStatusRadActive').prop('checked',true);
                $("#warehouse\\.activeStatus").val("true");
                $("#warehouse\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#warehouse\\.createdDate").val("01/01/1900 00:00:00");
                txtWarehouseCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtWarehouseCode.attr("readonly",true);
                txtWarehouseCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnWarehouseSave").click(function(ev) {
//           if(!$("#frmWarehouseInput").valid()) {
//               handlers_input_warehouse();
//               ev.preventDefault();
//               return;
//           };
           
           
           
           var url = "";
           warehouseFormatDate();
           if (updateRowId < 0){
               url = "master/warehouse-save";
           } else{
               url = "master/warehouse-update";
           }
           
           var params = $("#frmWarehouseInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    warehouseFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                showLoading();
                alertMessage(data.message);
                
                hideInput("warehouse");
                closeLoading();
                showInput("warehouseSearch");
                allFieldsWarehouse.val('').siblings('label[class="error"]').hide();
                txtWarehouseCode.val("AUTO");
                reloadGridWarehouse();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnWarehouseUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/warehouse-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_warehouse();
                updateRowId=$("#warehouse_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var warehouse=$("#warehouse_grid").jqGrid('getRowData',updateRowId);
                var url="master/warehouse-get-data";
                var params="warehouse.code=" + warehouse.code;

                txtWarehouseCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtWarehouseCode.val(data.warehouseTemp.code);
                        txtWarehouseName.val(data.warehouseTemp.name);
                        txtWarehouseCityCode.val(data.warehouseTemp.cityCode);
                        txtWarehouseCityName.val(data.warehouseTemp.cityName);
                        txtWarehouseProvinceCode.val(data.warehouseTemp.provinceCode);
                        txtWarehouseProvinceName.val(data.warehouseTemp.provinceName);
                        txtWarehousePhone1.val(data.warehouseTemp.phone1);
                        txtWarehousePhone2.val(data.warehouseTemp.phone2);
                        txtWarehouseEmailAddress.val(data.warehouseTemp.emailAddress);
                        txtWarehouseFax.val(data.warehouseTemp.Fax);
                        txtWarehouseAddress.val(data.warehouseTemp.address);
                        txtWarehouseContactPerson.val(data.warehouseTemp.contactPerson);
                        txtWarehouseDockDlnCode.val(data.warehouseTemp.dockDlnCode);
                        txtWarehouseDockInCode.val(data.warehouseTemp.dockInCode);
                        txtWarehouseZipCode.val(data.warehouseTemp.zipCode);
                        rdbWarehouseActiveStatus.val(data.warehouseTemp.activeStatus);
                        txtWarehouseRemark.val(data.warehouseTemp.remark);
                        txtWarehouseInActiveBy.val(data.warehouseTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.warehouseTemp.inActiveDate,true);
                        dtpWarehouseInActiveDate.val(inActiveDate);
                        txtWarehouseCreatedBy.val(data.warehouseTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.warehouseTemp.createdDate,true);
                        dtpWarehouseCreatedDate.val(createdDate);

                        if(data.warehouseTemp.activeStatus===true) {
                           $('#warehouseActiveStatusRadActive').prop('checked',true);
                           $("#warehouse\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#warehouseActiveStatusRadInActive').prop('checked',true);              
                           $("#warehouse\\.activeStatus").val("false");
                        }

                        showInput("warehouse");
                        hideInput("warehouseSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnWarehouseDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/warehouse-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#warehouse_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var warehouse=$("#warehouse_grid").jqGrid('getRowData',deleteRowID);
                var url="master/warehouse-delete";
                var params="warehouse.code=" + warehouse.code;
                var message="Are You Sure To Delete(Code : "+ warehouse.code + ")?";
                alertMessageDelete("warehouse",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ warehouse.code+ ')?</div>');
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
//                                var url="master/warehouse-delete";
//                                var params="warehouse.code=" + warehouse.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridWarehouse();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + warehouse.code+ ")")){
//                    var url="master/warehouse-delete";
//                    var params="warehouse.code=" + warehouse.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridWarehouse();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnWarehouseCancel").click(function(ev) {
            hideInput("warehouse");
            showInput("warehouseSearch");
            allFieldsWarehouse.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnWarehouseRefresh').click(function(ev) {
            $('#warehouseSearchActiveStatusRadActive').prop('checked',true);
            $("#warehouseSearchActiveStatus").val("true");
            $("#warehouse_grid").jqGrid("clearGridData");
            $("#warehouse_grid").jqGrid("setGridParam",{url:"master/warehouse-data?"});
            $("#warehouse_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnWarehousePrint").click(function(ev) {
            
            var url = "reports/warehouse-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'warehouse','width=500,height=500');
        });
        
        $('#btnWarehouse_search').click(function(ev) {
            $("#warehouse_grid").jqGrid("clearGridData");
            $("#warehouse_grid").jqGrid("setGridParam",{url:"master/warehouse-data?" + $("#frmWarehouseSearchInput").serialize()});
            $("#warehouse_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        $('#warehouse_btnRack').click(function(ev) {
            window.open("./pages/search/search-rack.jsp?iddoc=warehouse&idsubdoc=rack&idwarehouse="+txtWarehouseCode.val(),"Search", "Scrollbars=1,width=600, height=500");
        });
       
        $('#warehouse_btnCity').click(function(ev) {
            window.open("./pages/search/search-city.jsp?iddoc=warehouse&idsubdoc=city","Search", "Scrollbars=1,width=600, height=500");
        });
    });
    
    function unHandlers_input_warehouse(){
        unHandlersInput(txtWarehouseCode);
        unHandlersInput(txtWarehouseName);
    }

    function handlers_input_warehouse(){
        if(txtWarehouseCode.val()===""){
            handlersInput(txtWarehouseCode);
        }else{
            unHandlersInput(txtWarehouseCode);
        }
        if(txtWarehouseName.val()===""){
            handlersInput(txtWarehouseName);
        }else{
            unHandlersInput(txtWarehouseName);
        }
    }
    
    function warehouseFormatDate(){
        var inActiveDate=formatDate(dtpWarehouseInActiveDate.val(),true);
        dtpWarehouseInActiveDate.val(inActiveDate);
        $("#warehouseTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpWarehouseCreatedDate.val(),true);
        dtpWarehouseCreatedDate.val(createdDate);
        $("#warehouseTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlWarehouse" action="warehouse-data" />
<b>WAREHOUSE</b>
<hr>
<br class="spacer"/>


<sj:div id="warehouseButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnWarehouseNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnWarehouseUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnWarehouseDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnWarehouseRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnWarehousePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="warehouseSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmWarehouseSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="warehouseSearchCode" name="warehouseSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="warehouseSearchName" name="warehouseSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="warehouseSearchActiveStatus" name="warehouseSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="warehouseSearchActiveStatusRad" name="warehouseSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnWarehouse_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="warehouseGrid">
    <sjg:grid
        id="warehouse_grid"
        dataType="json"
        href="%{remoteurlWarehouse}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listWarehouseTemp"
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
            name="name" index="name" title="Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="address" index="address" title="Address" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="phone1" index="phone1" title="Phone1" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="phone2" index="phone2" title="Phone2" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="cityCode" index="cityCode" title="CityCode" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="cityName" index="cityName" title="CityName" width="100" sortable="true"
        />

        <sjg:gridColumn
            name="zipCode" index="zipCode" title="ZipCode" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="emailAddress" index="emailAddress" title="Email Address" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="fax" index="fax" title="Fax" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="contactPerson" index="contactPerson" title="ContactPerson" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="warehouseInput" class="content ui-widget">
    <s:form id="frmWarehouseInput">
        <table cellpadding="2" cellspacing="2" style="float: left">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="warehouse.code" name="warehouse.code" title="*" size="25" required="true" cssClass="required" maxLength="45" cssStyle="text-align: left;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="warehouse.name" name="warehouse.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
             <tr>
                <td align="right" valign="top">Address</td>
                <td colspan="3">
                    <s:textarea id="warehouse.address" name="warehouse.address"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right"><B>City *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearWarehouseCityFields(){
                            txtWarehouseCityCode.val("");
                            txtWarehouseCityName.val("");
                            txtWarehouseProvinceCode.val("");
                            txtWarehouseProvinceName.val("");
                            
                        }
                        
                        txtWarehouseCityCode.change(function(ev) {
                            
                            if(txtWarehouseCityCode.val()===""){
                                clearWarehouseCityFields();
                                return;
                            }
                            var url = "master/city-get";
                            var params = "city.code=" + txtWarehouseCityCode.val();
                                params+= "&city.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.cityTemp){
                                    txtWarehouseCityCode.val(data.cityTemp.code);
                                    txtWarehouseCityName.val(data.cityTemp.name);
                                    txtWarehouseProvinceCode.val(data.cityTemp.provinceCode);
                                    txtWarehouseProvinceName.val(data.cityTemp.provinceName);
                                    
                                }
                                else{
                                    alertMessage("City Not Found!",txtWarehouseCityCode);
                                    clearWarehouseCityFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="warehouse.city.code" name="warehouse.city.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="warehouse_btnCity" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="warehouse.city.name" name="warehouse.city.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
             <tr>
                <td align="right">Province</td>
                <td colspan="2">
                    <s:textfield id="warehouse.city.province.code" name="warehouse.city.province.code" size="25" readonly="true"></s:textfield>
                    <s:textfield id="warehouse.city.province.name" name="warehouse.city.province.name" size="25" readonly="true"></s:textfield>    
                </td>
            </tr>
             <tr>
                <td align="right"><B>Zip Code *</B></td>
                <td><s:textfield id="warehouse.zipCode" name="warehouse.zipCode" size="25" title=" " required="true" cssClass="required"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Phone1 *</b></td>
                <td><s:textfield id="warehouse.phone1" name="warehouse.phone1" size="25" title="*" required="true" cssClass="required" maxLength="45"></s:textfield>
                Phone2 
                <s:textfield id="warehouse.phone2" name="warehouse.phone2" size="25" maxLength="25"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Email</td>
                <td><s:textfield id="warehouse.emailAddress" name="warehouse.emailAddress" size="25" title="*" required="true" cssClass="required" maxLength="45"></s:textfield>
                Fax 
                <s:textfield id="warehouse.fax" name="warehouse.fax" size="25" maxLength="25"></s:textfield></td>
            </tr>
<!--            <tr>
                <td align="right"><b>Contact Person *</b></td>
                <td>s:textfield id="warehouse.contactPerson" name="warehouse.contactPerson" size="50" title="*" required="true" cssClass="required" maxLength="95">/s:textfield></td>
            </tr>-->
            
            </table>
            <table>
            <tr>
                <td align="right"> Dock DLN Rack Code </td>
                <td colspan="2">
                        <s:textfield id="warehouse.dockDlnCode" name="warehouse.dockDlnCode" size="20" title="" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"> Dock IN Rack Code </td>
                <td colspan="2">
                        <s:textfield id="warehouse.dockInCode" name="warehouse.dockInCode" size="20" title="" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="warehouseActiveStatusRad" name="warehouseActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="warehouse.activeStatus" name="warehouse.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="warehouse.remark" name="warehouse.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="warehouse.inActiveBy"  name="warehouse.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="warehouse.inActiveDate" name="warehouse.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="warehouse.createdBy"  name="warehouse.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="warehouse.createdDate" name="warehouse.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="warehouseTemp.inActiveDateTemp" name="warehouseTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="warehouseTemp.createdDateTemp" name="warehouseTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnWarehouseSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnWarehouseCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>