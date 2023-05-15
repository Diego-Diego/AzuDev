$(document).ready(function () {
    var contentTablet = $('.content__app');
    var btnOnline = $("p#online__show");
    var iframe = $("#iframe")[0];
    var $tabContainer = $("#tab-container");
    var today = new Date();
    var twoDigitMonth = ((today.getMonth().length+1) === 1)? (today.getMonth()+1) : '0' + (today.getMonth()+1);
    var currentDate = today.getDate() + "/" + twoDigitMonth + "/" + today.getFullYear();
    var progressBar = $('.progress');
    var altAnimate = "callout-subtitle animate__animated ";

    // START DOCUMENT

    console.log(currentDate);

    $('.get_showHours').html(today.getHours());
    $('.get_showMinutes').html(today.getMinutes());
    $('.showDate').html(currentDate);

    // END DOCUMENT

    $('#unlock-tablet').click(function(){
        var window = $('.unlock');
        var timeProgress = 1500; 
        var color = "#9b59b6";

        $(this).addClass(altAnimate + 'animate__heartBeat');

        progressBar.animate({
            width:"100%",
        }, timeProgress);

        setTimeout(function(){
            progressBar.hide();
            window.hide();
            $('.tab').fadeIn(400);
        }, timeProgress);
    });
    
    // Show or hide the page
    function SHOW_HIDE(bool) {
        if (bool) {
            $tabContainer.show();
        } else {
            $tabContainer.hide();
            window.blur() // unfocus the window
        }
    }
    
    SHOW_HIDE(false); // hide the tablet initial
    
    // Listens for NUI messages from Lua 
    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.showtab) {
            SHOW_HIDE(true)
        } // lua requested show
        else if (item.hidetab) {
            SHOW_HIDE()
        } // lua requested hide
    });
    
    // When pressed ESC dispatch escape request
    document.addEventListener('keyup', function (data) {
        if (data.which == 27 || data.which == 244) {
            SHOW_HIDE(); // hide ui
            $.post("http://My_Tab/tablet-bus", JSON.stringify({
                hide: true
            })) // tell lua to unfocus
        }
    });
    
    // When clicked the dot
    $('.tab-wrap .dot').click(function () {
        if (iframe.src == 'about:blank') {
            SHOW_HIDE(); // hide ui
            $.post("http://My_Tab/tablet-bus", JSON.stringify({
                hide: true
            })) // tell lua to unfocus
        } else {
            iframe.src = 'about:blank'; // trigger HandleLocationChange
        }
    });
    
    // Handle icon click
    $('a.nav-myframe').click(function (event) {
        event.preventDefault();
        event.stopPropagation();
        btnOnline.fadeOut(1000);
        var self = this;
        var icon = $(self).find("img, .myicon");
        icon.addClass("animate__animated animate__bounceIn")
        // bounce dat ass
        setTimeout(function () {
            iframe.src = self.href || "about:blank"; // trigger HandleLocationChange
            icon.removeClass("animate__animated animate__bounceIn");
        }, 600)
        
        return false;
    });
    
    // Tell lua the nui loaded
    $.post("http://My_Tab/tablet-bus", JSON.stringify({
        load: true
    }));
});