<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>DataMatrix</title>

    </head>
    <style>
        @media print{
            @page {
                size: 297mm 210mm; 
                margin: 25mm;
                margin-right: 45mm;
            }
            
            .card{
                width: 2.5cm!important;
                height: 1.5cm!important;
                
                border: 0px!important;
            }

            .print {
                display:block;
            }

            .no-print { 
                display:none; 
            }
        }

        .card-body{
            padding: 0.1em;
        }

        #etiquetas{
            margin-top: 10px;
            display: inline-flex;
            justify-content: flex-start;
            flex-wrap: wrap;
            max-width: 1050px;
            line-height: 1.0;
            font-family: monospace;
        }

        #imgDataMatrix{
            position: absolute;
            right: 0px;
            bottom: 0px;
            border: 2px solid white;

        }

        img{
            height: 0.53cm;
            width: 0.53cm;
        }

        .card{
            margin: 5px; /* adjust as needed */
            padding: 0px; /* adjust as needed */

            width: 95px;
            height: 55px;

            overflow: hidden;
            border: 0.5px solid #ccc;
            border-radius: 0px;

        }
        
        .card-text{
            word-break: keep-all;
        }

        #principioAtivoEtiqueta{
            word-break: break-all;
        }


    </style>
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
            <input type="text" id="principioAtivo" value="Cloridrato de Prometazina" style="margin-bottom: 5px;"><br>
            <label for="dosagemRemedio">Dosagem Remédio:</label>
            <input type="text" id="dosagemRemedio" value="250mg" style="margin-bottom: 5px;"><br>
            <label for="tamanhoFonte">Tamanho da fonte:</label>
            <input type="number" id="tamanhoFonte" value="8" min="1"  style="margin-bottom: 5px;"><br>
            <label for="tamanhoDataMatrix">Tamanho do datamatrix</label>
            <input type="number" id="tamanhoDataMatrix" step="0.01" min="0.2" value="0.3"><br>
            <button type="button" id="gerar" class="btn btn-primary">Gerar Etiqueta</button>
            <button type="button" id="imprimir" class="btn btn-primary">Imprimir Etiqueta</button>
        </form>
        <div class="print" id="etiquetas">

        </div>


        <script src="<%=request.getContextPath()%>/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script>

            var i = 0;

            $("#gerar").click(function () {

                $("#etiquetas").append("\
                <div id='divEtiqueta" + i + "' class='divEtiqueta'>" +
                        "<div class='card'>" +
                        "<div class='card-body'>" +
                        "<span id='principioAtivoEtiqueta' class='card-title'></span>" +
                        "<div class='card-text'>" +
                        "<strong><span id='dosagemEtiqueta' style='margin-right: 5px;'></span></strong>" +
                        "<span id='loteEtiqueta'></span><br>" +
                        "<span style='width: 100%' id='validadeEtiqueta'></span>" +
                        "<div id='imgDataMatrix' >" +
                        "</div>" +
                        "</div>" +
                        "</div>" +
                        "</div>" +
                        "</div>");

                var etiquetaAtual = $("#divEtiqueta" + i);
                var codigo = $("#codigoRemedio").val();
                var lote = $("#loteRemedio").val();
                var data = $("#validadeRemedio").val();
                etiquetaAtual.find(".card-body").css('font-size', "" + $("#tamanhoFonte").val() + "px");
                etiquetaAtual.find(".card-text").css('font-size', "" + parseInt($("#tamanhoFonte").val()) - 1 + "px");
                var src = "gerarDataMatrix/?codigo=" + codigo + "&lote=" + lote + "&data=" + data + "&tamanho=" + $("#tamanhoDataMatrix").val();
                etiquetaAtual.find("#imgDataMatrix").html('<img src="' + src + '">');
                etiquetaAtual.find("#principioAtivoEtiqueta").html('' + $("#principioAtivo").val().toString().toUpperCase());
                etiquetaAtual.find("#dosagemEtiqueta").html('' + $("#dosagemRemedio").val());
                etiquetaAtual.find("#loteEtiqueta").html('L: ' + lote);
                data = data.toString().split("-");
                etiquetaAtual.find("#validadeEtiqueta").html('V: ' + data[2] + "/" + data[1] + "/" + data[0]);

                i++;
            });
            
            $("#imprimir").click(function(){
               window.print(); 
            });
        </script>

    </body>
</html>
