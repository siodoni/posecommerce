<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>teste </title>
        <meta   name="generator"       content="HelpNDoc v1.10 Free">
        <link   rel="StyleSheet"       href="css/dtree.css" type="text/css">
        <script type="text/javascript" src="js/dtree.js"></script>
    </head>
    <body>
        <table width="100%" border="0"  align="center">
            <tr>
                <td width="20%"  height="100%" valign="top">
                    <script type="text/javascript" >
                        d = new dTree('d');
                        d.config.target = 'FrameMain';
                        d.add(0,-1,'Menu','javascript:document.write()');
                        d.add(1,0,'CORDAS','javascript:document.write()');
                        d.add(11,1,'GUITARRAS','javascript:document.write()');
                        d.add(12,1,'BAIXOS','javascript:document.write()');
                        d.add(111,11,'FENDER','javascript:document.write()');
                        d.add(121,12,'FENDER','javascript:document.write()');
                        d.add(1112,111,'STRATO','#');
                        d.add(1211,121,'JAZZ BASS','#');
                        document.write(d)
                    </script>
                </td>
            </tr>
        </table>
    </body>
</html>