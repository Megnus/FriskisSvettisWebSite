window.onload = function () {

    $(".wrapper-div").css('top', '-300px');
    if (window.location.href.indexOf('Settings') > 0) {
        showSettings();
    } else if (window.location.href.indexOf('Add') > 0) {
        showAddPass();
    }
    $("#message").css('opacity', 0);
}

$(function () {
    $("#datepicker").datepicker();
});

showMessage = function () {
    if (window.location.href.indexOf('Settings') < 0 && window.location.href.indexOf('Add') < 0) {
        $(".wrapper-div").css('top', '-300px');
        showSettings();
    }
    $("#message").delay(500).fadeTo('slow', 1);
}   

showSettings = function () {
    $(".wrapper-div").css('height', '260px');
    $(".wrapper-div").animate({ "top": "+=400px" }, "slow");
    $('#div-pass').hide();
    $("#div-settings").show();
}

showAddPass = function () {
    $(".wrapper-div").animate({ "top": "+=400px" }, "slow");
    $(".wrapper-div").css('height', '260px');
    $("#div-settings").hide();
    $('#div-pass').show();
}

$(function () {
    $("#datepicker").datepicker();
    $('#timepicker').timepicker();
});

var currentDate = $("#datepicker").datepicker("getDate");