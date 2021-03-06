<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- Loading Bootstrap -->
    <link href="./flat/dist/css/vendor/bootstrap.min.css" rel="stylesheet">
    <!-- Loading Flat UI -->
    <link href="./flat/dist/css/flat-ui.css" rel="stylesheet">
    <!-- Loading DOC css -->
    <link href="./flat/docs/assets/css/docs.css" rel="stylesheet">
    <title>ZTimer</title>
</head>
<!--本地css样式-->
<style type="text/css">
    /*td, input, th, span {*/
    /*font: 9pt verdana;*/
    /*}*/

    /*div.text{
        margin-bottom: 5px;
        font-size:10pt;
    }*/
    td.text1 {
        font-family: "Droid Sans";
        font-size: 12pt;
    }
</style>

<!--js内容处理：显示、极值、监视、内容处理-->
<script type="text/javascript">


    var then; //used by show()
    var nowDec;
    var nowBest;
    var nowWorst;
    var running = 0;// stopwatch status
    var timeint;
    var i = 0;

    var totalsec;
    var sec;
    var min;
    var subsec;
    var secdis;
    var mindis;
    var subsecdis;// the var above used by show(), is pretty much temp vars

    var datas = new Array()// store the records
    var nowSecondes;
    var Max = 25; //random cube steps
    var arr = new Array();//random cube array
    var myinterval = 20; //interval for ie
    if (navigator.userAgent.indexOf("Gecko") > -1) myinterval = 10;

    function stop(evt)// handle the keyup event
    {
        if (running == 1 && evt.keyCode == 32)
            clearTimeout(timeint);
    }

    function toSeconds(dec)// convert the stopwatch display text to seconds
    {
        var Ms;
        var tmpDec = dec.split(":");
        if (tmpDec[0] * 10 / 10 > 0) {
            Ms = tmpDec[0] * 60;
            return (Ms + tmpDec[1] * 10 / 10);
        } else {
            return (tmpDec[1] * 10 / 10);
        }

    }

    function begin(evt) // handle the keydown and reset event
    {
        if (evt.keyCode == 32) {
            if (running == 0) {
                then = new Date();
                running = 1;
                show();


            }
            else if (running == 1) {
                running = 2;
                //		document.getElementById("watch1").innerHTML=running;
            }
            else {
                //     document.getElementById("watch1").innerHTML="ok";
                ShowDatas(toSeconds(nowSeconds));
                document.getElementById("watch").innerHTML = "00:00.00";
                running = 0;


            }
        }
        if (evt.keyCode == 81) {
            cancel();
            buttonstuff('notrecord1');
        }
        if (evt.keyCode == 87) {
            delrecord();
            buttonstuff('delrecord1');
        }
        if (evt.keyCode == 69) {
            mycls();
            buttonstuff('clear1')
        }
    }

    var a = 0;

    function ShowDatas(dec) //push the record in array, display the nowBest and nowWorst and display the record table
    {
        if (dec == 0) {
            return false;
        }
        if (dec != -1) {
            var newDec = get2(dec);
            datas.push(newDec);
        }

        SortDatas();

        ShowDetails();
        var tempstraa = (datas.length != 0) ? sec2minsec(nowBest) : "";
        spanBest.innerHTML = "<b style=color:red>" + tempstraa + "</b>";
        tempstraa = (datas.length != 0) ? sec2minsec(nowWorst) : "";
        spanWorst.innerHTML = "<b>" + tempstraa + "</b>";
        var tmp1 = 0;
        for (i = 0; i < datas.length; i++) {
            tmp1 += datas[i];
        }
        tempstraa = (datas.length != 0) ? sec2minsec(get2(tmp1 / datas.length)) : "";

        spanAv.innerHTML = "<b>" + tempstraa + "</b>";

    }

    function sec2minsec(n)// convert the seconds number in to **:**.** text format
    {
        if (n > 60) {
            var tmpmins = Math.floor(n / 60);
            var tmpseconds = get2(n - tmpmins * 60);
            var tmpstring;
            if (tmpseconds < 10) {
                tmpstring = tmpmins + ":0" + tmpseconds;
            }
            else tmpstring = tmpmins + ":" + tmpseconds;
            return tmpstring;
        }
        else return n;
    }

    function ShowDetails() //display the record table
    {
        if (datas.length > 12) {
            a = datas.length - 12;
        }
        var tmpTd = "<table cellspacing=\"1\" bgcolor=olive class=\"table-bordered\" align=\"center\"><tr align=center bgcolor='#EEEEEE'><td width=75 height='20'>1</td><td width=75>2</td><td width=75>3</td><td width=75>4</td><td width=75>5</td>";
        tmpTd += "<td width=75>6</td><td width=75>7</td><td width=75>8</td><td width=75>9</td><td width=75>10</td><td width=75>11</td><td width=75>12</td></tr><tr bgcolor=white>";
        for (i = a; i < (12 + a); i++) {

            tmpTd += "<td align=center width=75 height='20'>";
            if (datas[i] == undefined) {
                tmpTd += "-";
            }
            else {
                if (datas[i] == nowBest) {

                    tmpTd += "<font color=red><b>" + sec2minsec(datas[i]) + "*</b></font>";
                }
                else if (datas[i] == nowWorst) {
                    tmpTd += "<font color=green>" + sec2minsec(datas[i]) + "*</font>";

                }
                else {
                    tmpTd += sec2minsec(datas[i]);
                }
            }
            tmpTd += "</td>";
        }
        tmpTd += "</tr></table>";

        div1.innerHTML = "";
        div1.innerHTML = tmpTd;
        // 进度条加权
        var progressRe
        if(datas.length<=12) {
            progressRe = "width:" + String(75 * (datas.length)) + "px";
        }
        else if((datas.length%12)==0){
            progressRe = "width:900px";
        }

        else {
            progressRe = "width:" + String(75 * (datas.length % 12)) + "px";
        }
        document.getElementById("showProg").style=progressRe;
        randomCube();

    }


    function show() //show the stopwatch display, will run every 20 or 10 ms
    {
        var now = new Date();
        diff = now.getTime() - then.getTime();
        if (diff < 1000) {
            mindis = "00";
            secdis = "00";
            subsec = Math.floor(diff / 10);
            if (subsec < 10)
                subsecdis = "0" + subsec;
            else
                subsecdis = subsec;
        }
        else if (diff < 60000) {
            mindis = "00";
            sec = Math.floor(diff / 1000);
            if (sec < 10)
                secdis = "0" + sec;
            else
                secdis = sec;

            subsec = Math.floor((diff % 1000) / 10);
            if (subsec < 10)
                subsecdis = "0" + subsec;
            else
                subsecdis = subsec;
        }
        else {
            totalsec = Math.floor(diff / 1000);//how many seconds?
            sec = totalsec % 60; //how many seconds-60*n
            if (sec < 10)
                secdis = "0" + sec;
            else
                secdis = sec;

            min = (totalsec - sec) / 60; //how many minutes?
            if (min < 10)
                mindis = "0" + min;
            else
                mindis = min;

            subsec = Math.floor((diff % 1000) / 10);
            if (subsec < 10)
                subsecdis = "0" + subsec;
            else
                subsecdis = subsec;

        }

        nowSeconds = mindis + ":" + secdis + "." + subsecdis;
        document.getElementById("watch").innerHTML = nowSeconds;
        timeint = setTimeout("show()", myinterval)

    }


    function get2(dec) //取两位小数点
    {
        return Math.round(dec * 100) / 100;
    }

    function SortDatas()//get max and min
    {
        var tmpArr = new Array();
        for (i = 0; i < datas.length; i++) {
            tmpArr[i] = datas[i];
        }
        tmpArr.sort(function (a, b) {
            return a - b;
        });
        nowBest = tmpArr[0];
        nowWorst = tmpArr[tmpArr.length - 1];
        // ShowBestAv();
    }

    function mycls()// clear all records
    {
        clearTimeout(timeint);
        nowSeconds = "00:00:00";
        running = 0;
        datas = new Array();
        ShowDetails();
        document.getElementById("watch").innerHTML = "00:00.00";

    }

</script>

<!--js内容处理：打乱、按钮处理-->
<script type="text/javascript">
    function cancel() {
        clearTimeout(timeint);

        nowSeconds = "00:00:00";

        running = 0;
        randomCube
        ();
        document.getElementById("watch").innerHTML = "00:00.00";
        //	alert("请点击一下网页上的任意空白处，让焦点从这个<不记录此次成绩>按钮上移开，即可开始新的一次计时。");

    }

    function delrecord() {
        clearTimeout(timeint);

        nowSeconds = "00:00:00";
        running = 0;
        randomCube
        ();
        document.getElementById("watch").innerHTML = "00:00.00";
        datas.pop();
        ShowDatas(-1);
    }

    function isslice(move1, move2)//to judge if 2 moves are slice moves.
    {
        if (Math.floor(move1 / 2) == Math.floor(move2 / 2)) return true;
        else return false;
    }

    function checkmove(move) {
        if (move == arr[arr.length - 1]) return true;
        else if (move == arr[arr.length - 2] && isslice(move, arr[arr.length - 1])) return true;
        else return false;
    }


    function randomCube() {
        var move = "";
        var rndMove = new Array("R", "L", "F", "B", "U", "D");
        var add = 0;
        var tmpRnd;
        arr = new Array();
        for (i = 0; i < Max; i++) {
            do {
                tmpRnd = Math.floor(Math.random() * 6);
            }
            while (checkmove(tmpRnd))

            arr.push(tmpRnd);

        }
        for (i = 0; i < arr.length; i++) {
            var tmp = Math.floor(Math.random() * 5);
            if (tmp == 4) {
                move += rndMove[arr[i]] + "2";
            }
            else if (tmp == 2 || tmp == 3) {
                move += rndMove[arr[i]] + "'";
            }
            else {
                move += rndMove[arr[i]];
            }
            move += " ";
        }


        rndDiv.innerHTML = move;
    }

    function changebg(p) {
        for (i = 1; i < 4; i++) {
            document.getElementById("big" + i).style.color = 'blue';
            document.getElementById("big" + i).style.textDecoration = 'underline';
            document.getElementById("big" + i).style.backgroundColor = 'transparent';
        }
        document.getElementById("big" + p).style.color = 'black';
        document.getElementById("big" + p).style.textDecoration = 'none';
        document.getElementById("big" + p).style.backgroundColor = '#ffd396';
    }

    function buttonstuff(p) {
        document.getElementById(p).blur();
        document.getElementById('watch').focus();
    }

</script>

<body onkeyup="begin(event)" onkeydown="stop(event)" onLoad="randomCube()">
<%
    String userN=(String)session.getAttribute("userN");
    String userID=(String) session.getAttribute("userID");
%>
<!--导航栏-->
<nav class="navbar navbar-inverse navbar-embossed navbar-expand-lg" role="navigation">
    <a class="navbar-brand" href="#">Ztimer</a>
    <ul class="nav navbar-nav mr-auto">
        <li class="active">
            <a herf="./index.jsp">首页</a>
        </li>
        <li>
            <a herf="/showScore.jsp">详情</a>
        </li>
    </ul>
    <%if(userN==null){%>
    <ul class="nav navbar-nav navbar-right">
        <form class="navbar-form navbar-right form-inline my-2 my-lg-0" action="/process/dologin.jsp" method="post">
            <div class="form-group" style="margin-right: 2px">
                <input type="text" placeholder="Email" name="user[email]" class="form-control">
            </div>
            <div class="form-group">
                <input type="password" placeholder="Password" name="user[password]" class="form-control">
            </div>
            <button type="submit" class="btn btn-default">Sign in</button>
        </form>
    </ul>
    <%}%>
    <%if(userN!=null){%>
    <div class="collapse navbar-collapse justify-content-end">
        <p class="navbar-text navbar-right">Signed in as <a class="navbar-link" href="#"><%=userN%></a></p>
        <p class="navbar-text navbar-right"><a class="navbar-link" href="process/destroySession.jsp">退了</a></p>
    </div>
    <%}%>
</nav>
<!--主体-->
<div class="container">
    <div id="pc">
        <!--表盘-->
        <div id="watch"
             style="font-size:130px; font-family:Arial, Helvetica, sans-serif; font-weight:bold; color:navy; text-align:center">
            00:00.00
        </div>
        <div id="mytext">
            <div id="rndDiv" style="margin-top:20px;font:12pt Arial;font-weight:bold" align="center"></div>
            <div id="buttons" align="center">
                <input type='button' class="btn btn-primary" value="不记录此次成绩" id="notrecord1"
                       onclick="cancel();buttonstuff('notrecord1');"
                       title="快捷键：Q">
                <input type='button' class="btn btn-warning" value="清除上次成绩" id="delrecord1"
                       onclick="delrecord();buttonstuff('delrecord1');"
                       title="快捷键：W">
                <input type='button' class="btn btn-danger" value="清除所有记录" id="clear1"
                       onClick="mycls();buttonstuff('clear1')"
                       title="快捷键：E">
                <%if(userN!=null){%>
                <input type='button' class="btn btn-success" value="手动同步"
                       title="快捷键：S">
                <%}%>
                <span style="display: inline;">秒表尺寸：
<a href="#"
   onClick="changebg(1);document.getElementById('watch').style.fontSize=200+'px';this.blur();document.getElementById('watch').focus();return false;"
   id="big1">大</a>，
<a href="#"
   onClick="changebg(2);document.getElementById('watch').style.fontSize=130+'px';this.blur();document.getElementById('watch').focus();return false;"
   id="big2">中</a>，
<a href="#"
   onClick="changebg(3);document.getElementById('watch').style.fontSize=70+'px';this.blur();document.getElementById('watch').focus();return false;"
   id="big3">
小</a></span></div>
            <div id=div1>
                <table cellspacing="1" bgcolor=olive class="table-bordered" align="center">
                    <tr bgcolor=#EEEEEE align=center>
                        <td width=75 height=20>1</td>
                        <td width=75>2</td>
                        <td width=75>3</td>
                        <td width=75>4</td>
                        <td width=75>5</td>
                        <td width=75>6</td>
                        <td width=75>7</td>
                        <td width=75>8</td>
                        <td width=75>9</td>
                        <td width=75>10</td>
                        <td width=75>11</td>
                        <td width=75>12</td>
                    </tr>
                    <tr bgcolor=white align=center>
                        <td width=75 height="20">-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                        <td width=75>-</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="progress" style="width:900px;margin:0 auto">
            <div id=showProg class="progress-bar" style="width:0px"></div>
            <!--<div class="progress-bar" role="progressbar"  style="width: 75%"></div>-->
        </div>
        <!--极值显示-->
        <div style="padding-top:10px" align="center">
            <table border="0">
                <tr>
                    <td class="text1">最快:</td>
                    <td><span id=spanBest class="text2"></span></td>
                </tr>
                <tr>
                    <td class="text1">最慢:</td>
                    <td><span id=spanWorst class="text2"></span></td>
                </tr>
                <tr>
                    <td class="text1">平均:</td>
                    <td><span id=spanAv class="text2"></span></td>
                </tr>
            </table>
        </div>
        </center>
    </div>
</div>
<!--表盘大小-->
<script type="text/javascript">
    document.getElementById("watch").focus();
    document.getElementById("big2").style.color = 'black';
    document.getElementById("big2").style.textDecoration = 'none';
    document.getElementById("big2").style.backgroundColor = '#FFCCFF';
</script>
<!--<div class="modal-footer">-->
<!--<p>asdasd</p>-->
<!--</div>-->
</body>
</html>