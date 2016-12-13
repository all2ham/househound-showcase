$(document).ready(function(){
    //removes css transition for loading
    $('.learnmore').addClass('notransition');

    //$('#buyer-selector').addClass('selector-hover')
    //$('#agent-description').hide();
    //$('#seller-description').hide();
    //$('#buyer-selector').mouseover(function(){
		//$('#buyer-selector').addClass('selector-hover')
		//$('#agent-selector').removeClass('selector-hover')
		//$('#seller-selector').removeClass('selector-hover')
		//$('#buyer-description').show();
		//$('#agent-description').hide();
		//$('#seller-description').hide();
    //});
    //$('#agent-selector').mouseover(function(){
    //    $('#buyer-selector').removeClass('selector-hover')
    //    $('#agent-selector').addClass('selector-hover')
		//$('#seller-selector').removeClass('selector-hover')
		//$('#buyer-description').hide();
    //    $('#agent-description').show();
    //    $('#seller-description').hide();
    //});
    //$('#seller-selector').mouseover(function(){
    //    $('#buyer-selector').removeClass('selector-hover')
    //    $('#agent-selector').removeClass('selector-hover')
    //    $('#seller-selector').addClass('selector-hover')
    //    $('#buyer-description').hide();
		//$('#agent-description').hide();
    //    $('#seller-description').show();
    //});

    // Cycle Height
    var cyclewidth = $('.cycle').width();
    var newcyclewidth = cyclewidth * 1372/1720;
    $('.cycle').css('height',newcyclewidth);

    //Setting up page1 and contact divs height to be exact
    var winheight = $( window ).height();
    var winwidth = $ ( window).width();
    var leftLearnMorePadding = winwidth/2 - $('.learnmore').width()/2;
    var p1height = winheight;
    var moreinfoheight = winheight - 50;

    //positions learnmore button
    $('.learnmore').css('margin-top',-77);
    $('.learnmore').css('margin-left',leftLearnMorePadding);
    $('.learnmore').removeClass('notransition');
    if (winheight >= 635){

    }

    if (p1height > 500){
        $('.page1').css('height',p1height)
        $('.moreinfoform').css('height',moreinfoheight)
    }
    if ($( window ).width() < 500){
        $('.page1').css('height',870)
        $('.moreinfoform').css('padding-top',0)
    }
    $('.learnmore').on('click', function() {
        $.smoothScroll({
            scrollTarget: '.learnmore',
            offset:70
        });
        return false;
    });
    $('#feedback').on('click', function() {
        $.smoothScroll({
            scrollTarget: '.moreinfoform',
            offset:-45
        });
        return false;
    });
    $('.swb1').on('click', function() {
        $.smoothScroll({
            scrollTarget: '.howitworkssmall',
            offset:0
        });
        return false;
    });
    $('.swb2').on('click', function() {
        $.smoothScroll({
            scrollTarget: '.moreinfoform',
            offset:-45
        });
        return false;
    });
    $('.clickhereforpromo').on('click', function() {
        $.smoothScroll({
            scrollTarget: '.moreinfoform',
            offset:-45
        });
        return false;
    });
    var scroll_start = 0;
    var startchange = $('#scrollpoint');
    var offset = startchange.offset();
    //$('.sticky').css('background-color', 'transparent');
    //$('#nsi_topbarJS .top-bar').css('background-color', 'transparent');
    //$(document).scroll(function() {
    //    scroll_start = $(this).scrollTop();
    //    console.log(scroll_start);
    //    //if(scroll_start > 10) {
    //    //if(scroll_start > offset.top) {
    //        $('#nsi_topbarJS .sticky').css('background-color', '#373737');
    //    //} else {
    //    //    $('#nsi_topbarJS .sticky').css('background-color', 'transparent');
    //    //}
    //});




        //Set Pricing Table Dimensions
    var pricingwidth = $('.pricingrowJS').width();
    var pricingcolumnwidth = pricingwidth/3 - 30;
    if ($( window ).width() > 1000) {
        $(".pricing-table").css('width', pricingcolumnwidth);
        $(".pricing-table").css('margin-left', 15);
        $(".pricing-table").css('margin-right', 15);
    }
    else {
        $(".pricing-table").css('width','90%');
        $(".pricing-table").css('margin-top',40);
        $(".pricing-table").removeClass('left');
        $(".pricing-table").addClass('small-centered');
    }
});

//moves learnmore button with windo resizing
$( window ).resize(function() {
    var winwidth = $ ( window).width();
    var leftLearnMorePadding = winwidth/2 - $('.learnmore').width()/2;
    $('.learnmore').css('margin-left',leftLearnMorePadding);
})

