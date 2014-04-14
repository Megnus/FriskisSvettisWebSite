window.onload = function () {
    if (window.location.href.indexOf('loginfailure') > 0) {
        $(".wrapper-div").css({ top: '100px' });
    } else {
        $(".wrapper-div").animate({ "top": "+=400px" }, "slow");
    }

    $('input:radio[name="radio-group"]').change(function () {
        if ($(this).val() == 'login-user') {
            $("#create-user").fadeOut("fast", function () {
                $("#login-user").fadeIn("slow").css("display", "inline-block");;
                $("#background-wrapper-div").animate({ "height": "220px" }, "fast");
            });
        }

        if ($(this).val() == 'create-user') {
            $("#login-user").fadeOut("fast", function () {
                $("#create-user").fadeIn('slow').css("display", "inline-block");
                $("#background-wrapper-div").animate({ "height": "280px" }, "fast");
            });
        }
    });
}

/* Some useful tools for handeling url */
// document.URL;
// window.location.href;
// parent.location.hash = "loaded";
// this.href.toString();
// var second = getUrlVars()["ReturnUrl"];
// window.location = window.location + '?loaded';