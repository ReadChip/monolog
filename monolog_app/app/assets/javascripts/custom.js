//このjsはTOPページなどで使用します。
        //<!--フォームの色変更-->
            $(function(){
            $('input').focus(function(){
                $(this).addClass('focus');
            }).blur(function(){
                $(this).removeClass('focus');
            });
            });

        //<!--画像のスライド-->
            $(function() {
            $('.slick-box').slick({
                    autoplay: true, //オートプレイ
                        autoplaySpeed: 3000 //オートプレイの切り替わり時間
    
            }); 
            });
