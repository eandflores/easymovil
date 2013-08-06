$(function(){

    $('.menu .nav > li:last-child > a').addClass('last');
    $('.slider').cycle({pager: '#pager', fx:     'scrollHorz'});
    $('.menu > .nav a.active').css( {backgroundPosition: "0 66px"} );
    $('.menu > .nav a').not('.active')
        .css( {backgroundPosition: "0 0"} )
        .mouseover(function(){
            $(this).stop().animate({backgroundPosition:"0 66px"}, {duration:50})
        })
        .mouseout(function(){
            $(this).stop().animate({backgroundPosition:"0 0"}, {duration:70});
        });

    $('a.login').click( 
        function(e){
            e.preventDefault();

            FB.login(
                function(response)
                {
                    if (response.authResponse) 
                    {
                        $('a.login').html('Conectando...');

                        $.getJSON('/auth/facebook/callback', function(json){
                            $('a.login').html('Conectado: ' + JSON.stringify(json));
                        });
                    };
                },
                {
                    scope: 'email,user_birthday,read_stream'
                }
            );
        } 
    )
})