function pageLoad(path) {
    showLoading();
    $.ajax({
        type: 'get', 
        url: path,
        data: {},
        contentType: 'text/html;',
        dataType: 'html',
        error: function(){
            alert('Error loading document ' + path);
        },
        success: function(result) {
            closeLoading();
            var data = result;
        
            data = data.replace(/<\/?html.*>/ig,""); //Remove html tag
            data = data.replace(/<\/?body.*>/ig,""); //Remove body tag
            data = data.replace(/<\/?head.*>/ig,""); //Remove head tag
            data = data.replace(/<\/?!doctype.*>/ig,""); //Remove doctype
            data = data.replace(/<title.*>.*<\/title>/ig,""); // Remove title tags

            $('#right').html(data);
        }
        
    });  
}

function pageLoad(path, params, tabContainerID) {
    showLoading();
    $.ajax({
        type: 'get',
        url: path,
        data: params,
        contentType: 'text/html;',
        dataType: 'html',
        error: function(){
            alert('Error loading document ' + path);
        },
        beforeSend:function(){
            //alert('send');  
        },
        success: function(result) {
            closeLoading();
            var data = result;
            
            data = data.replace(/<\/?html.*>/ig,""); //Remove html tag
            data = data.replace(/<\/?body.*>/ig,""); //Remove body tag
            data = data.replace(/<\/?head.*>/ig,""); //Remove head tag
            data = data.replace(/<\/?!doctype.*>/ig,""); //Remove doctype
            data = data.replace(/<title.*>.*<\/title>/ig,""); // Remove title tags

            $(tabContainerID).html(data);
            //alert('complit');
        }
    }); 
}

function hoverButton() {
	$('.ikb-button')
		.hover(
			function(){ 
				$(this).addClass("ui-state-hover"); 
			},
			function(){ 
				$(this).removeClass("ui-state-hover"); 
		})
		.mousedown(function(){
			$(this).addClass("ui-state-active"); 
		})
		.mouseup(function(){
				$(this).removeClass("ui-state-active");
		});
}

/************************************
 * FUNCTION JQUERY
*************************************/

function showInput(mod) {
    $("#" + mod + "Input").show();
    $("#" + mod + "Grid").hide();
    $("#" + mod + "Button").hide();
    $("div.error").hide();
}

function hideInput(mod) {
    $("#" + mod + "Grid").show();
    $("#" + mod + "Button").show();
    $("#" + mod + "Input").hide();
    $("div.error").hide();
}



/************************************
 * Number Function 
*************************************/

function isEven(num) {
        if (num % 2 == 0)
                return true;
        else
                return false;
}
	
/************************************
 * String Function 
*************************************/

function trim(str) {
        return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
}

function showLoading() {
    $.blockUI({ 
        message: '<img src="images/busy.gif" />',
        css: { 
            border: 'none', 
            padding: '10px', 
            backgroundColor: 'transparent', 
            '-webkit-border-radius': '10px', 
            '-moz-border-radius': '10px',
            color: '#fff'
        },
        overlayCSS:  { 
            backgroundColor: '#FFFFFF', 
            opacity: 0.6
        }
    }); 
}

/************************************
 * String Function 
 * IF Field Empty Make It Red Border
*************************************/
function unHandlersInput(field) {
    field.css({"border": "","background": ""});
}

function handlersInput(field) {
    field.css({"border": "1px solid red","background": "#FFFFFF"});
}

