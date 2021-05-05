function applyStyleAssemblyPIC(){
	var elementsPre = window.document.querySelectorAll("pre.code");
	
	var diretives      = ["#INCLUDE", "LIST", "__CONFIG", "#DEFINE", "ORG", "END"];
	var quantDiretives = diretives.length;
	
	var instructions = ["ADDWF", "ANDWF", "CLRF", "CLRW", "COMF", "DECF", "DECFSZ", "INCF", 
						"INCFSZ", "IORWF", "MOVF", "MOVWF", "NOP", "RLF", "RRF", "SUBWF", "SWAPF", 
						"XORWF", "BCF", "BSF", "BTFSC", "BTFSS", "ADDLW", "ANDLW", "CALL", 
						"CLRWDT", "GOTO", "IORLW", "MOVLW", "RETFIE", "RETLW", "RETURN", "SLEEP", 
						"SUBLW", "XORLW"];
	var quantInstructions = instructions.length;
	
	var m = elementsPre.length;
	for( var i=0; i<m; i++ ){
		var elementPre = elementsPre[i];
		var n = elementPre.children.length;
		for( var j=0; j<n; j++ ){
			var elementCode = elementPre.children[j];
			
			if( elementCode.innerText.indexOf(';') >= 0 ){
				elementCode.innerHTML = applyComment( elementCode.innerHTML );
			}
			
			/*
			if( elementCode.innerText.indexOf('#') >= 0 ){
				elementCode.innerHTML = applyDefines( elementCode.innerHTML );
			}
			
			if( elementCode.innerText.indexOf('LIST') >= 0 ){
				elementCode.innerHTML = applyList( elementCode.innerHTML );
			}
			
			if( elementCode.innerText.indexOf('__CONFIG') >= 0 ){
				elementCode.innerHTML = applyConfig( elementCode.innerHTML );
			}
			
			if( elementCode.innerText.indexOf('ORG') >= 0 ){
				elementCode.innerHTML = applyOrg( elementCode.innerHTML );
			}
			*/
			
			var position = -1;
			for( var k=0; k<quantDiretives; k++ ){
				position = elementCode.innerText.trim().indexOf( diretives[k] );
				if( position == 0 ){
					elementCode.innerHTML = applyDiretive( elementCode.innerHTML, diretives[k] );
				}
			}
			
			position = -1;
			for( var k=0; k<quantInstructions; k++ ){
				position = elementCode.innerText.trim().indexOf( instructions[k] );
				if( position == 0 ){
					elementCode.innerHTML = applyInstruction( elementCode.innerHTML, instructions[k] );
				}
			}
		}
	}
	var a = 9;
	var b = 7;
}

function applyComment( text ){
	var n = text.indexOf(';');
	return text.substr(0,n) + '<span class="comment">' + text.substr(n) + '</span>';
}

function applyDiretive( text, diretive ){
	return text.replace( diretive, '<span class="diretive">' + diretive + '</span>' );
}

function applyInstruction( text, instruction ){
	var n = text.indexOf(instruction);
	return text.replace( instruction, '<span class="instruction">' + instruction + '</span>' );
}

/*
function applyDefines( text ){
	var n = text.indexOf('#');
	return text.substr(0,n) + '<span class="defines">' + text.substr(n) + '</span>';
}

function applyList( text ){
	var n = text.indexOf('LIST');
	return text.substr(0,n) + '<span class="list">' + text.substr(n) + '</span>';
}

function applyConfig( text ){
	var n = text.indexOf('__CONFIG');
	return text.substr(0,n) + '<span class="config">' + text.substr(n) + '</span>';
}

function applyOrg( text ){
	var n = text.indexOf('ORG');
	return text.substr(0,n) + '<span class="org">' + text.substr(n) + '</span>';
}
*/



window.onload = applyStyleAssemblyPIC;