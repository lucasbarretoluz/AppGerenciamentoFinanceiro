const puppeteer = require('puppeteer');


var urlteste= 'https://www.sefaz.rs.gov.br/ASP/AAE_ROOT/NFE/SAT-WEB-NFE-NFC_QRCODE_1.asp?p=43211275315333008860655230001792041048579172|2|1|1|803DFEA471112C3C22896A4807CA3C924AA492C3';


/** 
 * 08/01/2022
 * encapsular informações de itens e indentificadores da nota em apenas um obejto
*/


//inciaCaptura(urlteste);

/**FUNÇÃO QUE INICIA A CONEXÃO PARA REALIZAR A COLETA DE DADOS */
async function inciaCaptura(url){											//alterado para função normal;
	console.log('-coleta inciada-');
    const browser = await puppeteer.launch({headless:true});
    const page = await browser.newPage();
    await page.goto(url);


	const infoNota = await scrapeInfo(page);
	//console.log(infoNota);

	const itens  = await scrapeItens(page);
	//console.log(itens);

	const resultado = {
		infoNota:infoNota, 
		infoItens: itens};

	const json = JSON.stringify(resultado);	
	console.log('-coleta finalizada-');						    	//converte objeto para string
	return json;															//retorna json;
	//console.log(json);

}

/**
 * FUNÇÃO QUE RETORNA A LISTA COM OS ITENS DA COMPRA
 */
async function scrapeItens(page){
	try {   
		 	var result = await page.evaluate(()=>{
			var itens = [];

			  recuperaItemCompra();  
				
				/**
				 * Pega a informações dos itens na pagina atráves da class NFCDetalhe_Item 
				 * e joga dentro da array: itens[]
				 */
				async  function recuperaItemCompra(){
				var x = 0;
				var obj;
				var parada = true;

				while(parada){
					//pega o texto do elemento selecionado
					obj = document.getElementsByClassName('NFCDetalhe_Item');
					//Pega somente o texto da div, ignorando o resto da informações
					var res = obj[x].innerText;
					//converte o texto em String e atribui a variavel resultado
					var resultado = res.toString();
					//console.log(resultado);
					itens.push(resultado);
					
					//para o laço caso acabe os elementos do obj
					if(obj===null){
						parada = false;
					}
					x++;		
				}				
		    }
			return itens;
        });	
	} catch (error){console.log(error + 'Falha');}

	var objeto = {};
    var info = ['codigo', 'descricao', 'qtde', 'tipo', 'vUnit', 'vTotal']; 
	var contInfo = 0;
	var cont = 1;

	/**
	 * Variavel que guarda as informações do objeto em formato Json
	 */
	var json;
	
	//pega ultima posição do Array
	var posicaoArray = 0;
	for (var i = 0; i <= result.length; i++){
		var x = result[i];
			if (x === 'Valor total R$'){
				posicaoArray = i;
				break;
			}
	}

	/**
	 * varivale que pega a quantidade de itens da nota
	 */
    var qtd_itens = (posicaoArray-5)/6;	
	
	for(var i=1; i<= qtd_itens; i++){		//cria itens dentro do obejto;
		objeto[`item${i}`] = {};
	}

	for(var i = 0; i <= 4; i++){			//retira primeiras 5 posições do array
		result.shift(); 
	}

	//Inseri as informações do array dentro de cada item do objeto
	try{	 
		for(var i = 0; i <= result.length; i++){
		var newInfo = info[contInfo];
		var newValue = result[i];
		objeto[`item${cont}`][newInfo] = newValue;
		contInfo ++;
		if(contInfo === 6){
			contInfo = 0;
			cont++;
		} 
	}}catch(error){console.log('');}//Aqui a gente finque não tem problema.


return objeto;

}

async function scrapeInfo(page){
	try{
		var result  = await page.evaluate(()=>{
		var result1= [];
		const vetorNF = vetor();	
		result1[0] = getCNPJ();
		result1[1] = getLocal();																												
		result1[2] = getNumeroNota();
		result1[3] = getData();
		result1[4] = getCPF();
		result1[5] = getValTotal(vetorNF);
		result1[6] = getDescontos(vetorNF);
		result1[7] = getFormaPagamento(vetorNF);
							
		function getLocal(){
			//faz requisição ao HTML
			var x = document.getElementsByClassName('NFCCabecalho_SubTitulo');
			// Converte o result em formato de texto, ignoradno o resto do html na div
			var y = x[0].innerText;
			return y;
		}		
		function getCNPJ(){
			var x = document.getElementsByClassName('NFCCabecalho_SubTitulo1');
			var y = x[0].innerText;
			return y;
		}
		function getNumeroNota(){
			var x = document.getElementsByClassName('NFCCabecalho_SubTitulo');
			var y = x[2].innerText;
			var resultado = (y.toString()).split(' ')[2];
			return resultado;
		}
		function getData(){
			var x = document.getElementsByClassName('NFCCabecalho_SubTitulo');
			var y = x[2].innerText;
			var resultado = (y.toString()).split(' ')[8] + ' ' + (y.toString()).split(' ')[9] ;
			return resultado;
		}
		function getCPF(){
			var x = document.getElementsByClassName('NFCCabecalho_SubTitulo');
			var y = x[8].innerText;
			var resultado = (y.toString());
			return resultado;
		}
		function getValTotal(posicao = 0){
			//o vetor desta busca é diferente para cada nota
			var x = document.getElementsByClassName('NFCDetalhe_Item');
			var y = x[posicao+1].innerText;
			var resultado = (y.toString());
			return resultado;
		}
		function getDescontos(posicao = 0){
			//o vetor desta busca é diferente para cada nota
			var x = document.getElementsByClassName('NFCDetalhe_Item');
			var y = x[posicao+3].innerText;
			var resultado = (y.toString());
			return resultado;
		}
		function getFormaPagamento(posicao = 0){
			//o vetor desta busca é diferente para cada nota 
			var x = document.getElementsByClassName('NFCDetalhe_Item');
			var y = x[posicao+6].innerText;
			var resultado = (y.toString());
			return resultado;
		}
		/**Esta função serve somente para pegar a posição correta do vetor
 		* de pesquisa do valtotal, descontos e forma de pagamento;
 		* Esta função estriamente necessária, pois a posição destes vetores muda conforme a nota fiscal.
 		*/	
		function vetor(){
			var string  = 'Valor total R$';
			var x = document.getElementsByClassName('NFCDetalhe_Item');
			console.log('O codigo rodou até aqui');
						
			for(var i = 0; i <= x.length; i++){
				//console.log(x[i].innerText);
				if(string === x[i].innerText.toString()){
					//console.log(xyz[i].innerText);
					//console.log(i);
					return i;
				}
			}
		}
	return result1;
	});

	/*
	console.log(result[0]);		
	console.log(result[1]);
	console.log(result[2]);
	console.log(result[3]);
	console.log(result[4]);
	console.log(result[5]);
	console.log(result[6]);
	console.log(result[7]);
	*/

	//cria obejto de informações da nota 
	const objeto = {
		cnpj: result[0],
		local: result[1],
		numero: result [2],
		data: result[3],
		cpf: result[4],
		vTotal: result[5],
		descontos: result[6],
		pagamento: result[7]
	}

	return objeto;

	}catch(error){console.log('erro');}
}

module.exports= { inciaCaptura, scrapeItens}