var express = require('express');
const res = require('express/lib/response');
var app = express();

const scrape = require('./scrape');



async function goServer(){
app.get('/', function(req,res){
    res.send('Servidor rodando liso');
});

app.post('/', function(req,res){

    req.on('data', function(chunk){
        let x = Buffer.from(chunk);             //pega os dados, bufferiza e joga na viavel x
        let stringData = x.toString();          //converte os bytes em string

        /**
         * Faz interface entra o modúlo scrape e server
         * retorna as informaçãoes da notafiscal e envia no corpo da respota
         */
        const getInfoNF = async () =>{
        //    console.log(stringData);
            const response  = await scrape.inciaCaptura(dados(stringData));
             res.send(await response);
        }

        getInfoNF();       

    });
});

app.listen(3000, function(){
    console.log('servidor iniciado');
});


/**
 *Recebe url da Nota Fiscal/
* Retorna url formatada(url que contem informações da nota)
*/
 function dados(string = ''){
    
    let stringComplemento = 'https://www.sefaz.rs.gov.br/ASP/AAE_ROOT/NFE/SAT-WEB-NFE-NFC_QRCODE_1.asp?';
    let stringOriginal  = string;    
    
    return res(stringComplemento, stringOriginal);
    /**
     * Faz conversão da string original para a string de destino das informações em HTML da nota fiscal
     */
    function res (complemento = '', original = ''){
        return complemento + original.split('?')[1];
    }

}

}

module.exports= {goServer}