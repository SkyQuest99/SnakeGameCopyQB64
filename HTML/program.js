async function __qbjs_run() {
QB.start(); QB.setTypeMap({ GXPOSITION:[{ name: 'x', type: 'LONG' }, { name: 'y', type: 'LONG' }], GXDEVICEINPUT:[{ name: 'deviceId', type: 'INTEGER' }, { name: 'deviceType', type: 'INTEGER' }, { name: 'inputType', type: 'INTEGER' }, { name: 'inputId', type: 'INTEGER' }, { name: 'inputValue', type: 'INTEGER' }], FETCHRESPONSE:[{ name: 'ok', type: 'INTEGER' }, { name: 'status', type: 'INTEGER' }, { name: 'statusText', type: 'STRING' }, { name: 'text', type: 'STRING' }]});
    await GX.registerGameEvents(function(e){});
    QB.sub_Screen(0);

   QB.sub_Cls(undefined, undefined);
   QB.sub__Title( "SNAKE GAME");
   var pic1 = 0;  /* LONG */ 
   QB.sub_Screen( (QB.func__NewImage(  640 ,    480 ,    32)));
   pic1 =  (await QB.func__LoadImage( "pic3.png"));
   QB.sub__PutImage(false,  0 ,   - 30, false, undefined, undefined,    pic1, undefined, false, undefined, undefined, false, undefined, undefined, false);
   var is_fullscreen = 0;  /* INTEGER */ 
   QB.sub_Randomize(false, QB.func_Timer())
   var score = 0;  /* SINGLE */ var highscore = 0;  /* INTEGER */ 
   const MAX_SNAKE_LENGTH  =    500; 
   var snakeArray = QB.initArray([{l:1,u:MAX_SNAKE_LENGTH},{l:0,u:1}], 0);  /* INTEGER */ 
   var foodx = 0;  /* INTEGER */ 
   var foody = 0;  /* INTEGER */ 
   foodx =  (QB.func_Int( QB.func_Rnd() *  70))  +  3;
   foody =  (QB.func_Int( QB.func_Rnd() *  20))  +  3;
   var sn = 0;  /* INTEGER */ 
   var snakeX = 0;  /* INTEGER */ 
   var snakeY = 0;  /* INTEGER */ 
   var snakeXd = 0;  /* INTEGER */ 
   var snakeYd = 0;  /* INTEGER */ 
   var snakeSnakeLength = 0;  /* INTEGER */ 
   var snakeAnim = 0;  /* INTEGER */ 
   var snakeDied = 0;  /* INTEGER */ 
   snakeX =   15;
   snakeY =   31;
   snakeDied =   0;
   snakeYd =   1;
   snakeXd =   0;
   snakeSnakeLength =   1;
   var keypress = '';  /* STRING */ 
   var snakeSpeed = 0;  /* INTEGER */ 
   snakeSpeed =  (await func_speed_choices(  snakeSpeed));
   QB.sub_Screen( (QB.func__NewImage(  640 ,    480 ,    256)));
   var ___v7055475 = 0; do { if (QB.halted()) { return; }___v7055475++;   if (___v7055475 % 100 == 0) { await QB.autoLimit(); }
      keypress =  QB.func_InKey();
      keypress =  (QB.func_UCase(  keypress));
      if ( keypress ==  (QB.func_Chr(  0))  + (QB.func_Chr(  72))  ||  keypress ==  "W"  ) {
         if ( snakeYd !=   1 ) {
            snakeXd =   0;
            snakeYd =   - 1;
         }
      } else if ( keypress ==  (QB.func_Chr(  0))  + (QB.func_Chr(  80))  ||  keypress ==  "S"  ) {
         if ( snakeYd !=   - 1 ) {
            snakeXd =   0;
            snakeYd =   1;
         }
      } else if ( keypress ==  (QB.func_Chr(  0))  + (QB.func_Chr(  77))  ||  keypress ==  "D"  ) {
         if ( snakeXd !=   - 1 ) {
            snakeXd =   1;
            snakeYd =   0;
         }
      } else if ( keypress ==  (QB.func_Chr(  0))  + (QB.func_Chr(  75))  ||  keypress ==  "A"  ) {
         if ( snakeXd !=   1 ) {
            snakeXd =   - 1;
            snakeYd =   0;
         }
      } else if ( keypress ==  "B"  ) {
         QB.sub_Beep();
         window.open("https://skyquestweb.wordpress.com", '_blank');
      } else if ( keypress ==  "F"  ) {
         QB.sub_Beep();
         if ( is_fullscreen ==   0 ) {
            is_fullscreen =   1;
            QB.sub__FullScreen(QB.STRETCH, false);
         } else {
            is_fullscreen =   0;
            QB.sub__FullScreen(QB.OFF, false);
         }
      }
      snakeX =   snakeX +  snakeXd;
      snakeY =   snakeY +  snakeYd;
      if ( snakeX < 4 ) {
         snakeX =   77;
      } else if ( snakeX > 77 ) {
         snakeX =   4;
      } else if ( snakeY < 2 ) {
         snakeY =   25;
      } else if ( snakeY > 25 ) {
         snakeY =   2;
      }
      var ___v5334240 = 0; for ( sn=  2 ;  sn <=  snakeSnakeLength;  sn= sn + 1) { if (QB.halted()) { return; } ___v5334240++;   if (___v5334240 % 100 == 0) { await QB.autoLimit(); }
         if ( snakeY ==  QB.arrayValue(snakeArray, [ sn ,   0]).value  &&  snakeX ==  QB.arrayValue(snakeArray, [ sn ,   1]).value  ) {
            snakeDied =   - 1;
            QB.sub_Beep();
         }
      }
      if ( snakeX ==   foodx &&  snakeY ==   foody) {
         score =   score +  1;
         snakeAnim =   1;
         QB.sub_Beep();
         var ___v5795186 = 0; while ( foodx ==   snakeX &&  foody ==   snakeY) { if (QB.halted()) { return; }___v5795186++;   if (___v5795186 % 100 == 0) { await QB.autoLimit(); }
            foodx =  (QB.func_Int( QB.func_Rnd() *  70))  +  3;
            foody =  (QB.func_Int( QB.func_Rnd() *  20))  +  3;
         }
         snakeSnakeLength =   snakeSnakeLength +  1;
      }
      if ( snakeDied) {
         keypress =  (QB.func_Chr(  27));
      }
      QB.sub_Cls(undefined, undefined);
      QB.sub_Line(false,  20 ,   10, false,  620 ,   400,    15 , 'B', undefined);
      QB.sub_Color(  2);
      QB.sub_Locate(  foody,    foodx);
      await QB.sub_Print([(QB.func_Chr(  6))]);
      QB.sub_Color(  15);
      QB.arrayValue(snakeArray, [ 1 ,   0]).value =   snakeY;
      QB.arrayValue(snakeArray, [ 1 ,   1]).value =   snakeX;
      var ___v2895625 = 0; for ( sn=  snakeSnakeLength;  sn >=  1 ;  sn= sn +  - 1) { if (QB.halted()) { return; } ___v2895625++;   if (___v2895625 % 100 == 0) { await QB.autoLimit(); }
         QB.arrayValue(snakeArray, [ sn +  1 ,   0]).value =  QB.arrayValue(snakeArray, [ sn ,   0]).value;
         QB.arrayValue(snakeArray, [ sn +  1 ,   1]).value =  QB.arrayValue(snakeArray, [ sn ,   1]).value;
         if ( sn !=   1 ) {
            QB.sub_Color(  4);
            QB.sub_Locate( QB.arrayValue(snakeArray, [ sn ,   0]).value  ,   QB.arrayValue(snakeArray, [ sn ,   1]).value);
            await QB.sub_Print(["Û"]);
            QB.sub_Color(  15);
         }
      }
      QB.arrayValue(snakeArray, [ 1 ,   0]).value =   snakeY;
      QB.arrayValue(snakeArray, [ 1 ,   1]).value =   snakeX;
      QB.sub_Color(  12);
      if ( snakeAnim ==   0 ) {
         QB.sub_Locate(  snakeY,    snakeX);
         await QB.sub_Print([(QB.func_Chr(  2))]);
      } else if ( snakeAnim ==   1 ) {
         QB.sub_Locate(  snakeY,    snakeX);
         await QB.sub_Print([(QB.func_Chr(  1))]);
      }
      QB.sub_Color(  15);
      QB.sub_Locate(  27 ,    3);
      await QB.sub_Print(["SCORE:",QB.PREVENT_NEWLINE, (QB.func_Str(  score)),QB.PREVENT_NEWLINE, "   (Press B for website, Press F for fullscreen)"]);
      highscore =  (await func_load_data(  snakeSpeed));
      if ( score > highscore) {
         await sub_save_data(  score,    snakeSpeed);
      }
      QB.sub__Display();
      snakeAnim =   0;
      if ( snakeSpeed ==   1 ) {
         await QB.sub__Limit(  7);
      } else if ( snakeSpeed ==   2 ) {
         await QB.sub__Limit(  14);
      } else if ( snakeSpeed ==   3 ) {
         await QB.sub__Limit(  20);
      }
   } while (!( keypress ==  (QB.func_Chr(  27))))
   QB.halt(); return;
QB.end();

async function func_speed_choices(snakeSpeed/*INTEGER*/) {
if (QB.halted()) { return; }
var speed_choices = null;
   await QB.sub_Print([]);
   await QB.sub_Print([]);
   await QB.sub_Print([]);
   await QB.sub_Print([]);
   await QB.sub_Print(["1. EASY"]);
   await QB.sub_Print(["2. MEDIUM"]);
   await QB.sub_Print(["3. HARD"]);
   var ___v3019480 = new Array(1); await QB.sub_Input(___v3019480, false, true, "ENTER SNAKE SPEED");  snakeSpeed = QB.toInteger(___v3019480[0]); 
   QB.sub_Beep();
   var ___v7747401 = 0; while ( snakeSpeed !=   1 &&  snakeSpeed !=   2 &&  snakeSpeed !=   3) { if (QB.halted()) { return; }___v7747401++;   if (___v7747401 % 100 == 0) { await QB.autoLimit(); }
      await QB.sub_Print(["INVALID, Please enter 1 or 2 or 3"]);
      var ___v140176 = new Array(1); await QB.sub_Input(___v140176, false, true, "ENTER SNAKE SPEED");  snakeSpeed = QB.toInteger(___v140176[0]); 
      QB.sub_Beep();
   }
   speed_choices =   snakeSpeed;
return speed_choices;
}
async function func_load_data(value1/*INTEGER*/) {
if (QB.halted()) { return; }
var load_data = null;
   var is_new_user = window.localStorage.new_user;
   if ( is_new_user != "false" ) {
      window.localStorage.new_user = "false";
      window.localStorage.highscores = ".1,1;1:";
   }
   var text = window.localStorage.highscores;  /* STRING */ 
   var text1 = '';  /* STRING */ 
   var text2 = '';  /* STRING */ 
   var text3 = '';  /* STRING */ 
   text1 =  (await func_get_highscore_type(  text,   "."  ,   ","));
   text2 =  (await func_get_highscore_type(  text,   ","  ,   ";"));
   text3 =  (await func_get_highscore_type(  text,   ";"  ,   ":"));
   QB.sub_Locate(  28 ,    3);
   await QB.sub_Print(["HIGHSCORES = EASY:",QB.PREVENT_NEWLINE,  text1,QB.PREVENT_NEWLINE, " MEDUIM:",QB.PREVENT_NEWLINE,  text2,QB.PREVENT_NEWLINE, " HARD:",QB.PREVENT_NEWLINE,  text3]);
   if ( value1 ==   1 ) {
      load_data =  (QB.func_Val(  text1));
   } else if ( value1 ==   2 ) {
      load_data =  (QB.func_Val(  text2));
   } else if ( value1 ==   3 ) {
      load_data =  (QB.func_Val(  text3));
   }
return load_data;
}
async function sub_save_data(value1/*INTEGER*/,value2/*INTEGER*/) {
if (QB.halted()) { return; }
   var values = '';  /* STRING */ 
   var text = '';  /* STRING */
   text = window.localStorage.highscores;
   if ( value2 ==   1 ) {
      values =  "."  + (QB.func_Str(  value1))  + ","  + (await func_get_highscore_type(  text,   ","  ,   ";"))  + ";"  + (await func_get_highscore_type(  text,   ";"  ,   ":"))  + ":";
   } else if ( value2 ==   2 ) {
      values =  "."  + (await func_get_highscore_type(  text,   "."  ,   ","))  + ","  + (QB.func_Str(  value1))  + ";"  + (await func_get_highscore_type(  text,   ";"  ,   ":"))  + ":";
   } else if ( value2 ==   3 ) {
      values =  "."  + (await func_get_highscore_type(  text,   "."  ,   ","))  + ","  + (await func_get_highscore_type(  text,   ","  ,   ";"))  + ";"  + (QB.func_Str(  value1))  + ":";
   }
   window.localStorage.highscores = values;
}
async function func_get_highscore_type(value1/*STRING*/,ts/*STRING*/,te/*STRING*/) {
if (QB.halted()) { return; }
var get_highscore_type = null;
   var index = 0;  /* SINGLE */ var bool = 0;  /* INTEGER */ 
   var output_text = '';  /* STRING */ 
   var ___v7607236 = 0; for ( index=  0 ;  index <= (QB.func_Len(  value1));  index= index + 1) { if (QB.halted()) { return; } ___v7607236++;   if (___v7607236 % 100 == 0) { await QB.autoLimit(); }
      if ((QB.func_Mid(  value1,    index,    1))  ==   ts ||  bool ==   1 ) {
         bool =   1;
         if ((QB.func_Mid(  value1,    index,    1))  ==   te) {
            bool =   0;
         }
         if ((QB.func_Mid(  value1,    index,    1))  !=   ts && (QB.func_Mid(  value1,    index,    1))  !=   te) {
            output_text =   output_text + (QB.func_Mid(  value1,    index,    1));
         }
      }
   } 
   get_highscore_type =   output_text;
return get_highscore_type;
}

}