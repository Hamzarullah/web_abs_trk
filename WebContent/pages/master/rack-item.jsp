<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    var rackItemlastRowId = 0, rackItem_lastSel = -1;
    var     txtRackWarehouseCode = $("#rack\\.warehouse\\.code"),
            txtRackWarehouseName = $("#rack\\.warehouse\\.name"),
            txtRackRackTypeCode = $("#rack\\.rackType\\.code"),
            txtRackRackTypeName = $("#rack\\.rackType\\.name"),
            txtRackCode = $("#rack\\.code"),
            txtRackName = $("#rack\\.name"),
            txtRackActiveStatus = $("#rack\\.activeStatus"),
            chkRackActiveStatus = $("#rackItemActiveStatus"),
            txtRackCategory = $("#rack\\.rackCategory"),
            chkRackCategory = $("#rackCategory"),
            lblActiveRack = $("#lblActiveRack"),
            txtRackRemark = $("#rack\\.remark"),
            txtRackInActiveBy = $("#rack\\.inActiveBy"),
            txtRackInActiveDate = $("#rack\\.inActiveDate"),
            txtRackCreatedBy = $("#rack\\.createdBy"), 
            txtRackCreatedDate = $("#rack\\.createdDate"),
            allFieldsRack = $([])
            .add(txtRackWarehouseCode)
            .add(txtRackWarehouseName)
            .add(txtRackCode)
            .add(txtRackName)
            .add(txtRackRemark)
            .add(txtRackInActiveBy)
            .add(txtRackInActiveDate);

    function loadRackItem(code) {
            $("#rackItemInput_grid").jqGrid('clearGridData');
            var url = "master/rack-item-data";
//            var url = "master/warehouse-item-category";
            var params = "rack.code=" + code;

            showLoading();
            $.post(url, params, function (data) {
                rackItemlastRowId = 0;
                for (var i = 0; i < data.listRackItemTemp.length; i++) {
                    rackItemlastRowId++;

                    $("#rackItemInput_grid").jqGrid("addRowData", rackItemlastRowId, data.listRackItemTemp[i]);
                    $("#rackItemInput_grid").jqGrid('setRowData', rackItemlastRowId, {
                       rackItemDelete                           : "delete",
                       rackItemSearch                           : "..",
                       rackItemItemMaterialCode                 : data.listRackItemTemp[i].itemCode,
                       rackItemItemMaterialName                 : data.listRackItemTemp[i].itemName,
                       rackItemRackCode                         : data.listRackItemTemp[i].rackCode,
                       rackItemRackName                         : data.listRackItemTemp[i].rackName,
                       rackItemItemQuantity                     : data.listRackItemTemp[i].quantity,
                       rackItemItemMaterialUnitOfMeasureCode    : data.listRackItemTemp[i].UOM
                       
                    });
                }
                closeLoading();
            });

    }
    function setRackCategory(rackCategory){
        switch(rackCategory){
            case "RACK":
                $('input[name="rackCategory"][value="Rack"]').prop('checked',true);
                $('#rackCategoryDock\\ In').attr('disabled', true);
                $("#rack\\.rackCategory").val("RACK");
                break;
            case "DOCK_IN":
                $('input[name="rackCategory"][value="Dock In"]').prop('checked',true);
                $('#rackCategoryRack').attr('disabled', true);
                $("#rack\\.rackCategory").val("DOCK_IN");
                break;
        } 
    }
    function rackItemInputGrid_Delete_OnClick() {
        var selectDetailRowId = $("#rackItemInput_grid").jqGrid('getGridParam', 'selrow');
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row");
            return;
        }
        $("#rackItemInput_grid").jqGrid('delRowData', selectDetailRowId);
    }
    function reloadGridRack() {
        $("#rackHeader_grid").jqGrid('setGridWidth', $("#tabs").width() - 30, false);
        $("#rackHeader_grid").trigger("reloadGrid");
    }

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("rackItem");
        $('#rackItem\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        $("#searchRackItemInput").show();
        $('#rackItemSearchRackActiveStatusRADActive').prop('checked',true);
        var value="true";
        $("#rackItemSearchRackActiveStatus").val(value);
        $('#rackItemSearchRackActiveStatusRADActive').change(function(ev){
            var value="true";
            $("#rackItemSearchRackActiveStatus").val(value);
        });
                
        $('#rackItemSearchRackActiveStatusRADInActive').change(function(ev){
            var value="false";
            $("#rackItemSearchRackActiveStatus").val(value);
        });
//
//        $('#activeStatusActive').change(function(ev){
//            var value="true";
//            $("#rack\\.activeStatus").val(value);
//        });
//                
//        $('#activeStatusInActive').change(function(ev){
//            var value="false";
//            $("#rack\\.activeStatus").val(value);
//        });
//
//        $('#btnRackNew').click(function (ev) {
//            showInput("rack");
//            txtRackCode.attr("readonly", false);
//            updateRowId = -1;
//            $('#activeStatusActive').prop('checked',true);
//            var value="true";
//            $("#rack\\.activeStatus").val(value);
//            $("#rack\\.inActiveDate").val("01/01/1900");
//            //txtRackCode.attr("readonly", false);
//            ev.preventDefault();
//        });
//
//        $('#btnRackUpdate').click(function (ev) {
//            updateRowId = $("#rackHeader_grid").jqGrid('getGridParam', 'selrow');
//            if (updateRowId == null) {
//                alert("Please Select Row");
//            } else {
//                chkRackActiveStatus.attr("disabled", false);
//                txtRackCode.attr("readonly", true);
//
//                var rack = $("#rackHeader_grid").jqGrid('getRowData', updateRowId);
//                var url = "master/rack-get";
//                var params = "rack.code=" + rack.code;
//                $.post(url, params, function (result) {
//                    var data = (result);
//                    txtRackCreatedBy.val(data.rack.createdBy);
//                    txtRackCreatedDate.val(data.rack.createdDate);
//                    txtRackWarehouseCode.val(data.rack.warehouse.code);
//                    txtRackWarehouseName.val(data.rack.warehouse.name);
//                    txtRackCode.val(data.rack.code);
//                    txtRackName.val(data.rack.name);
//                    chkRackActiveStatus.attr('checked', data.rack.activeStatus);
//                    txtRackRemark.val(data.rack.remark);
//                    txtRackInActiveBy.val(data.rack.inActiveBy);
//                    var inActiveDate = data.rack.inActiveDate;
//                    var inActiveDate = inActiveDate.split('T')[0];
//                    var inActiveDate = inActiveDate.split('-');
//                    var inActiveDate = inActiveDate[1]+"/"+inActiveDate[2]+"/"+inActiveDate[0];
//                    txtRackInActiveDate.val(inActiveDate);
//
//                    if(data.rack.activeStatus===true) {
//                       $('#activeStatusActive').prop('checked',true);
//                       $("#rack\\.activeStatus").val("true");
//                    }
//                    else {                        
//                       $('#activeStatusInActive').prop('checked',true);              
//                       $("#rack\\.activeStatus").val("false");
//                    }
//
//                    showInput("rack");
//                });
//            }
//            ev.preventDefault();
//        });
//
        $('#btnRackItemSave').click(function (ev) {
            if (!$("#frmRackItemInput").valid()) {
                ev.preventDefault();
                return;
            }
            if (rackItem_lastSel !== -1) {
                $('#rackItemInput_grid').jqGrid("saveRow", rackItem_lastSel);
            }

            var url = "";

            if (updateRowId < 0){
                url = "master/rack-item-save";}
            else
                url = "master/rack-item-save";
           
            var ids = jQuery("#rackItemInput_grid").jqGrid('getDataIDs');
            var params = $("#frmRackItemInput").serialize();
           
            if($("#rackItemInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessageNotif("Grid Rack Item Can't Be Empty!");;
                return;}
                
            }
           
           
            var listRackItemTemp = new Array();
            for (var i = 0; i < ids.length; i++) { 
                var data = $("#rackItemInput_grid").jqGrid('getRowData', ids[i]);
                var rackItem = {
//                    code: "",
                    itemMaterial :{code: data.rackItemItemMaterialCode},
                    rack         : {code: data.rackItemRackCode},
                    quantity     : data.rackItemItemQuantity,
                    UOM          : data.rackItemUOM
                };
                listRackItemTemp[i] = rackItem;
            }
            params += "&listRackItemJSON=" + $.toJSON(listRackItemTemp);
            
           $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                if (data.errorMessage) {
                    alertMessage(data.errorMessage);
                    return;
                }

                alertMessage(data.message);

                hideInput("rackItem");
                 $("#searchRackItemInput").show();
//                allFieldsWarehouse.val('').siblings('label[class="error"]').hide();
                reloadGridRack();
            });

            ev.preventDefault();
        });
//
//        $('#btnRackDelete').click(function (ev) {
//            var deleteRowId = $("#rackHeader_grid").jqGrid('getGridParam', 'selrow');
//            if (deleteRowId == null) {
//                alert("Please Select Row");
//            } else {
//                var rack = $("#rackHeader_grid").jqGrid('getRowData', deleteRowId);
//                if (confirm("Are You Sure To Delete (Code : " + rack.code + ")")) {
//                    var url = "master/rack-delete";
//                    var params = "rack.code=" + rack.code;
//                    $.post(url, params, function () {
//                        reloadGridRack();
//                    });
//                }
//            }
//            ev.preventDefault();
//        });
//
        $('#btnRackItemCancel').click(function (ev) {
            hideInput("rackItem");
            $("#searchRackItemInput").show();
            allFieldsRack.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
//
//        $('#btnRackRefresh').click(function (ev) {
//            reloadGridRack();
//        });


        $.subscribe("rackHeaderItem_grid_onSelect", function(event, data){
           var selectedRowID = $("#rackHeader_grid").jqGrid("getGridParam", "selrow"); 
           var rackHeaderItem = $("#rackHeader_grid").jqGrid("getRowData", selectedRowID);
                      
           $("#rackItem_grid").jqGrid("setGridParam",{url:"security/rack-item-data?rack.code=" + rackHeaderItem.code});
           $("#rackItem_grid").jqGrid("setCaption", "Rack Item : " + rackHeaderItem.code);
           $("#rackItem_grid").trigger("reloadGrid");
        });
        
        $.subscribe("rackItemInput_grid_onSelect", function () {
            var selectedRowID = $("#rackItemInput_grid").jqGrid("getGridParam", "selrow");
            if (selectedRowID !== rackItem_lastSel) {
                $('#rackItemInput_grid').jqGrid("saveRow", rackItem_lastSel);
                $('#rackItemInput_grid').jqGrid("editRow", selectedRowID, true);
                rackItem_lastSel = selectedRowID;
            } else {
                $('#rackItemInput_grid').jqGrid("saveRow", selectedRowID);
            }
        });
        $('#btnRackItemAddDetail').click(function (ev) {
            var defRow = {
                rackItemDelete          : "delete",
                rackItemSearch          : "..",
                rackItemItemMaterialCode  : "",
                rackItemItemMaterialName  : "",
                rackItemRackCode  : txtRackCode.val(),
                rackItemRackName  : txtRackName.val(),
                rackItemItemQuantity:"0.00",
                rackItemItemMaterialUnitOfMeasureCode : ""
            };
            rackItemlastRowId++;
            $("#rackItemInput_grid").jqGrid("addRowData", rackItemlastRowId, defRow);
            be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alertMessageNotif('click ni');\" />";
            $("#rackItemInput_grid").jqGrid('setRowData', rackItemlastRowId, {Buttons: be});
        });
        $('#btnRackItem_Assign').click(function (ev) {
                    updateRowId = $("#rackHeader_grid").jqGrid('getGridParam', 'selrow');
                    if (updateRowId === null) {
                        alertMessage("Please Select Row");
                    }else{
                        chkRackActiveStatus.attr("disabled", false);
                        txtRackCode.attr("readonly", true);

                        var rack = $("#rackHeader_grid").jqGrid('getRowData', updateRowId);
                        var url = "master/rack-get";
                        var params = "rack.code=" + rack.code;
                        $.post(url, params, function (result) {
                            var data = (result);
                            txtRackCreatedBy.val(data.rackTemp.createdBy);
                            txtRackCreatedDate.val(data.rackTemp.createdDate);
                            txtRackWarehouseCode.val(data.rackTemp.warehouseCode);
                            txtRackRackTypeCode.val(data.rackTemp.rackTypeCode);
                            txtRackRackTypeName.val(data.rackTemp.rackTypeName);
                            txtRackWarehouseName.val(data.rackTemp.warehouseName);
                            txtRackCode.val(data.rackTemp.code);
                            txtRackName.val(data.rackTemp.name);
                            chkRackActiveStatus.attr('checked', data.rackTemp.activeStatus);
                            txtRackRemark.val(data.rackTemp.remark);
                            txtRackInActiveBy.val(data.rackTemp.inActiveBy);
                            var inActiveDate = data.rackTemp.inActiveDate;
                            var inActiveDate = inActiveDate.split('T')[0];
                            var inActiveDate = inActiveDate.split('-');
                            var inActiveDate = inActiveDate[1]+"/"+inActiveDate[2]+"/"+inActiveDate[0];
                            txtRackInActiveDate.val(inActiveDate);

                            if(data.rackTemp.activeStatus===true) {
                               $('#rackItemActiveStatusActive').prop('checked',true);
                               $('#rackItemActiveStatusInActive').attr('disabled', true);
                               $("#rack\\.activeStatus").val("true");
                            }
                            else {                        
                               $('#rackItemActiveStatusInActive').prop('checked',true);
                               $('#rackItemActiveStatusActive').attr('disabled', true);
                               $("#rack\\.activeStatus").val("false");
                            }

                            setRackCategory(data.rackTemp.rackCategory);

                            showInput("rackItem");
                            $("#searchRackItemInput").hide();
                            loadRackItem(data.rack.code);
                        });
                    }
                    ev.preventDefault();
            
                });
        
        $("#btnRackItem_search").click(function(ev) {
            $("#rackHeader_grid").jqGrid("setGridParam",{url:"master/rack-item-search-rack-data-list?" + $("#frmRackItemSearchInput").serialize(), page:1});
            $("#rackHeader_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#btnRackItemSearchItemMaterial').click(function(ev) {
            var ids = jQuery("#rackItemInput_grid").jqGrid('getDataIDs');
             window.open("./pages/search/search-item-material-multiple.jsp?iddoc=rackItem&type=grid&rowLast="+ids.length,"Search", "scrollbars=1,width=600, height=500");
        });
    });
    
    function addRowDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#rackItemInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
            $("#rackItemInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#rackItemInput_grid").jqGrid('setRowData',lastRowId,{
                    rackItemDelete                          : defRow.rackItemDelete,
                    rackItemItemMaterialCode                : defRow.rackItemItemMaterialCode,
                    rackItemItemMaterialName                : defRow.rackItemItemMaterialName,
                    rackItemItemMaterialUnitOfMeasureCode   : defRow.rackItemItemMaterialUnitOfMeasureCode,
                    rackItemRackCode  : txtRackCode.val()
            });
            
        setHeightGridRackItem();
 }
 
 function setHeightGridRackItem(){
        var ids = jQuery("#rackItemInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#rackItemInput_grid"+" tr").eq(1).height();
            $("#rackItemInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#rackItemInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }

</script>

<s:url id="remoteurlRackHeader" action="rack-item-search-rack-data-list" />
<s:url id="remoteurlRackItem" action="" />
<s:url id="remoteurlrackiteminput" action="" />

<b>RACK ITEM</b>
<hr>
<br class="spacer"/>

<sj:div id="rackButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a style="display:none" href="#" id="btnRackNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a style="display:none" href="#" id="btnRackUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a style="display:none" href="#" id="btnRackDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a style="display:none" href="#" id="btnRackRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a style="display:none" href="#" id="btnPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
      
    </table>
</sj:div>    
<div id="searchRackItemInput" class="content ui-widget">
    <s:form id="frmRackItemSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Rack Code</td>
                <td>
                    <s:textfield id="rackItemSearchRackCode" name="rackItemSearchRackCode" size="20"></s:textfield>
                </td>
                <td align="right" valign="center" >Rack Type Code</td>
                <td>
                    <s:textfield id="rackItemSearchRackTypeCode" name="rackItemSearchRackTypeCode" size="20"></s:textfield>
                </td>
                <td align="right" valign="center" >Warehouse Code</td>
                <td>
                    <s:textfield id="rackItemSearchWarehouseCode" name="rackItemSearchWarehouseCode" size="20"></s:textfield>
                </td>
                <td/> 
            </tr>  
            <tr>
                <td align="right" valign="center" >Rack Name</td>
                <td>
                    <s:textfield id="rackItemSearchRackName" name="rackItemSearchRackName" size="20"></s:textfield>
                </td>
                <td align="right" valign="center" >Rack Type Name</td>
                <td>
                    <s:textfield id="rackItemSearchRackTypeName" name="rackItemSearchRackTypeName" size="20"></s:textfield>
                </td>
                <td align="right" valign="center" >Warehouse Name</td>
                <td>
                    <s:textfield id="rackItemSearchWarehouseName" name="rackItemSearchWarehouseName" size="20"></s:textfield>
                </td>
                <td/> 
            </tr> 
            <tr>
                <td align="right">Status
                    <s:textfield id="rackItemSearchRackActiveStatus" name="rackItemSearchRackActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="rackItemSearchRackActiveStatusRAD" name="rackItemSearchRackActiveStatusRAD" list="{'Active','InActive','All'}"></s:radio>
                </td>
                <td/>
                <td/> 
                <td/> 
                <td/> 
                <td/> 
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnRackItem_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
   
    </s:form>
</div>   
<br class="spacer" />   
<div id="rackItemGrid">
    <sjg:grid
        id="rackHeader_grid"
        caption="Rack"
        dataType="json"
        href="%{remoteurlRackHeader}"
        pager="true"
        navigator="true"
        navigatorView="true"
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
        width="$('#tabmnuRackItem').width()"
        onSelectRowTopics="rackHeaderItem_grid_onSelect"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="50" sortable="true"
            />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="rackTypeCode" index="rackTypeCode" title="Rack Type Code" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="rackTypeName" index="rackTypeName" title="Rack Type Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="warehouseCode" index="warehouseCode" title="Warehouse Code" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="warehouseName" index="warehouseName" title="Warehouse Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />  
    </sjg:grid >
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnRackItem_Assign" button="true">Assign</sj:a>
                </td>
            </tr>
        </table>
    <br class="spacer" />
    <sjg:grid
        id="rackItem_grid"
        caption="RACK ITEM"
        dataType="json"
        href="%{remoteurlRackItem}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listRackItemTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuRACKITEM').width()"
        >
        <sjg:gridColumn
            name="itemCode" index="itemCode" key="itemCode" title="Item Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="itemName" index="itemName" title="Item Name" width="300" sortable="false"
        />  
        <sjg:gridColumn
            name="quantity" index="quantity" title="Quantity" width="100" 
        /> 
        <sjg:gridColumn
            name="UOM" index="UOM" title="UOM" width="150" sortable="false"
        />  
    </sjg:grid >
</div>

<div id="rackItemInput" class="content ui-widget">
    <s:form id="frmRackItemInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="rack.code" name="rack.code" title="Please Enter Code <br>" required="true" cssClass="required" readonly="true" cssStyle="text-align: center;" ></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="rack.name" name="rack.name" size="50" title="Please Enter Name <br>" required="true" cssClass="required" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                <td align="right"><B>Rack Type *</B></td>
                <td><s:textfield id="rack.rackType.code" name="rack.rackType.code" title="Please Enter Code <br>" required="true" cssClass="required" readonly="true"></s:textfield>
                    <s:textfield id="rack.rackType.name" name="rack.rackType.name" title="Please Enter Code <br>" required="true" cssClass="required" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Rack Category</B></td>
                    <td><s:radio id="rackCategory" name="rackCategory" list="{'Rack','Dock In'}"></s:radio></td>
                    <td>
                    <s:textfield style="display:none" id="rack.rackCategory" name="rack.rackCategory" title="Please Enter Role Name" required="true" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Warehouse*</td>
                    <td>
                        <script type = "text/javascript">
//                            $('#rack_btnWarehouse').click(function (ev) {
//                               window.open("./pages/search/search-warehouse.jsp?iddoc=rack&idsubdoc=warehouse","Search", "width=600, height=500");
//                            });

                            txtRackWarehouseCode.change(function (ev) {
                                var url = "master/warehouse-get";
                                var params = "warehouse.code=" + txtRackWarehouseCode.val();
                                $.post(url, params, function (result) {
                                    var data = (result);
                                    if (data.warehouse)
                                        txtRackWarehouseName.val(data.warehouse.name);
                                    else
                                        alert("Rack Not Found");
                                    //txtCarTypeName.val("");
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="rack.warehouse.code" name="rack.warehouse.code" title="Please Rack Code" required="true" cssClass="required" readonly="true"></s:textfield>
                            <%--<sj:a cssStyle="diplay:none" id="rack_btnWarehouse" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>--%>
                        </div>
                    <s:textfield id="rack.warehouse.name" name="rack.warehouse.name" title="Please Enter Rack Name" required="true" size="50" disabled="true"  readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Active Status</B></td>
                    <td><s:radio id="rackItemActiveStatus" name="rackItemActiveStatus" list="{'Active','InActive'}"></s:radio></td>
                    <td>
                    <s:textfield style="display:none" id="rack.activeStatus" name="rack.activeStatus" title="Please Enter Role Name" required="true" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                 <tr>
                    <td align="right"><B>Remark</B></td>
                    <td>
                    <s:textfield id="rack.remark" name="rack.remark" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>InActive By</B></td>
                    <td>
                    <s:textfield disabled="true" id="rack.inActiveBy" name="rack.inActiveBy" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>InActive Date</B></td>
                    <td>
                    <s:textfield disabled="true" id="rack.inActiveDate" name="rack.inActiveDate" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr> 
                    <td><s:textfield id="rack.createdBy"  name="rack.createdBy" size="20" style="display:none"></s:textfield></td>
                    <td><s:textfield id="rack.createdDate" name="rack.createdDate" size="20" style="display:none"></s:textfield></td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <sj:a href="#" id="btnRackItemSearchItemMaterial" button="true" style="width: 200px">Search Item Material</sj:a>
                    </td>
                </tr>
            </table>    
            <table>
             <tr>
                <td>    
                    <br/>
                    <div id="rackItemInputGrid">
                        <sjg:grid
                            id="rackItemInput_grid"
                            caption="RACK ITEM"
                            dataType="json"                    
                            pager="true"
                            navigator="true"
                            navigatorView="true"
                            navigatorRefresh="false"
                            navigatorDelete="false"
                            navigatorAdd="false"
                            navigatorEdit="false"
                            gridModel="listRackItemTemp"
                            rowList="10,20,30"
                            rowNum="10"
                            viewrecords="true"
                            rownumbers="true"
                            shrinkToFit="false"
                            width="800"
                            editinline="true"
                            editurl="%{remoteurlrackiteminput}"
                            onSelectRowTopics="rackItemInput_grid_onSelect"

                            >
                            <sjg:gridColumn
                                name="rackItem" index="rackItem" key="rackItem" title="" hidden="true" editable="true" edittype="text"
                            />
                            <sjg:gridColumn
                                name="rackItemDelete" index="rackItemDelete" title="" width="50" align="centre"
                                editable="true"
                                edittype="button"
                                editoptions="{onClick:'rackItemInputGrid_Delete_OnClick()', value:'delete'}"
                            />
                            <sjg:gridColumn
                                name="rackItemItemMaterialCode" index="rackItemItemMaterialCode" key="rackItemItemMaterialCode" title="Item Code" 
                                width="150" sortable="true" editable="true" edittype="text"
                            />
                            <sjg:gridColumn
                                name="rackItemItemMaterialName" index="rackItemItemMaterialName" key="rackItemItemMaterialName" title="Item Name" width="150" sortable="true" editable="false"
                            />
                            <sjg:gridColumn
                                name="rackItemItemQuantity" index="rackItemItemQuantity" key="rackItemItemQuantity" title="Quantity" width="150" sortable="true"
                                edittype="text" editable="true" formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                            />
                            <sjg:gridColumn
                                name="rackItemRackName" index="rackItemRackName" key="rackItemRackName" title="Rack Name" width="150" sortable="true" editable="false" hidden="true"
                            />
                            <sjg:gridColumn
                                name="rackItemRackCode" index="rackItemRackCode" key="rackItemRackCode" title="Rack Code" width="150" sortable="true" 
                            />
                            <sjg:gridColumn
                                name="rackItemItemMaterialUnitOfMeasureCode" index="rackItemItemMaterialUnitOfMeasureCode" key="rackItemItemMaterialUnitOfMeasureCode" title="UOM" width="150" sortable="true" editable="false"
                            />
                        </sjg:grid >
                    </div>
                </td>
            </tr>
                
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
        <sj:a href="#" id="btnRackItemSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnRackItemCancel" button="true">Cancel</sj:a>
            <br /><br />
    </s:form>
</div>