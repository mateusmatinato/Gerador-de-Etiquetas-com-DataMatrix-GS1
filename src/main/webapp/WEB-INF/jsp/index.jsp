<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/pimaco.css" crossorigin="anonymous">
        <title>DataMatrix</title>

    </head>

    <body>
        <h1 class="no-print">Gerar DataMatrix</h1>
        <form class="no-print" id="formDataMatrix">
            <label for="codigoRemedio">Código do Remédio:</label>
            <input type="number" id="codigoRemedio" min="0" style="margin-bottom: 5px;" value="07896676422740"><br>
            <label for="validadeRemedio">Validade do Remédio:</label>
            <input type="date" id="validadeRemedio" style="margin-bottom: 5px;" ><br>
            <label for="loteRemedio">Lote do Remédio:</label>
            <input type="text" id="loteRemedio" value="18090014" style="margin-bottom: 5px;"><br>
            <label for="principioAtivo">Principio Ativo:</label>
            <input type="text" id="principioAtivo" value="Cloridrato de Prometazina (250mg)" style="margin-bottom: 5px;"><br>
            <label for="tamanhoFonte">Tamanho da fonte:</label>
            <input type="number" id="tamanhoFonte" value="8" min="1"  style="margin-bottom: 5px;"><br>
            <label for="tamanhoDataMatrix">Tamanho do datamatrix</label>
            <input type="number" id="tamanhoDataMatrix" step="0.01" min="0.2" value="0.3"><br>
            <button type="button" id="gerar" class="btn btn-primary">Gerar Etiqueta</button>
            <button type="button" id="imprimir" class="btn btn-primary">Imprimir Etiqueta</button>
        </form>
        <div class="print page" id="etiquetas">
            <!--
            <div id="divEtiqueta0" class="divEtiqueta">
                <div class="card">
                    <div class="card-body" style="font-size: 8px;">
                        <span id="principioAtivoEtiqueta" class="card-title">CLORIDRATO DE PROMETAZINA (250MG)</span>
                        <div class="card-text" style="font-size: 6px;"><span id="loteEtiqueta">L:18090014</span><br>
                            <span style="width: 100%" id="validadeEtiqueta">V: 30/04/2019</span>
                        </div>
                        <div id="imgDataMatrix">
                            <img src="gerarDataMatrix/?codigo=07896676422740&amp;lote=18090014&amp;data=2019-04-30&amp;tamanho=0.3">
                        </div>
                    </div>
                </div>
            </div>
            -->
        </div>


        <script src="<%=request.getContextPath()%>/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script>

            var i = 0;

            $("#gerar").click(function () {
                for (i = 0; i < 70; i++) {
                    //gera quantas quiser em branco
                    $("#etiquetas").append("\
                <div id='divEtiqueta' class='divEtiqueta'>" +
                            "<div class='card " + (i % 7 === 0 || i % 7 === 7 ? "first" : "") + "'>" +
                            "<div class='card-body'>" +
                            "<span id='principioAtivoEtiqueta' class='card-title'></span>" +
                            "<div class='card-text'>" +
                            "<span id='loteEtiqueta'></span><br>" +
                            "<span style='width: 100%' id='validadeEtiqueta'></span>" +
                            "</div>" +
                            "<div id='imgDataMatrix' >" +
                            "</div>" +
                            "</div>" +
                            "</div>" +
                            "</div>");
                }
                for (i = 0; i < 14; i++) {

                    $("#etiquetas").append("\
                <div id='divEtiqueta" + i + "' class='divEtiqueta'>" +
                            "<div class='card " + (i % 7 === 0 || i % 7 === 7 ? "first" : "") + "'>" +
                            "<div class='card-body'>" +
                            "<span id='principioAtivoEtiqueta' class='card-title'></span>" +
                            "<div class='card-text'>" +
                            "<span id='loteEtiqueta'></span><br>" +
                            "<span style='width: 100%' id='validadeEtiqueta'></span>" +
                            "</div>" +
                            "<div id='imgDataMatrix' >" +
                            "</div>" +
                            "</div>" +
                            "</div>" +
                            "</div>");

                    var etiquetaAtual = $("#divEtiqueta" + i);
                    var codigo = $("#codigoRemedio").val();
                    var lote = $("#loteRemedio").val();
                    var data = $("#validadeRemedio").val();
                    etiquetaAtual.find(".card-body").css('font-size', "" + $("#tamanhoFonte").val() + "px");
                    etiquetaAtual.find(".card-text").css('font-size', "" + parseInt($("#tamanhoFonte").val()) - 2 + "px");
                    var src = "gerarDataMatrix/?codigo=" + codigo + "&lote=" + lote + "&data=" + data + "&tamanho=" + $("#tamanhoDataMatrix").val();
                    etiquetaAtual.find("#imgDataMatrix").html('<img src="' + src + '">');
                    etiquetaAtual.find("#principioAtivoEtiqueta").html('' + $("#principioAtivo").val().toString().toUpperCase());
                    etiquetaAtual.find("#loteEtiqueta").html('L:' + lote);
                    data = data.toString().split("-");
                    etiquetaAtual.find("#validadeEtiqueta").html('V: ' + data[2] + "/" + data[1] + "/" + data[0]);
                }
                i++;
            });

            $("#imprimir").click(function () {
                window.print();
            });
        </script>

    </body>
</html>
