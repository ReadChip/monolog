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


            $(function(){
                //Ctrlキー+エンター
                $(window).keydown(function(e){
                    if(event.ctrlKey){
                        if(e.keyCode === 13){
                            alert("ctrl+enter");
                            return false;
                        }
                    }
                });
                //Shiftキー+エンター ←今回のやりたかったこと
                $(window).keydown(function(e){
                    if(event.shiftKey){
                        if(e.keyCode === 13){
                            alert("shift+enter");
                            return false;
                        }
                    }
                });
            });