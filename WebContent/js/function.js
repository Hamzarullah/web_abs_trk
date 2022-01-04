function terbilang(bilangan) {
        bilangan = parseFloat(removeCommas(bilangan));
	if(isNaN(bilangan)){
		return "";
	}else{
		bilangan = String(bilangan);
		var angka = new Array('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');
		var kata = new Array('','Satu','Dua','Tiga','Empat','Lima','Enam','Tujuh','Delapan','Sembilan');
		var tingkat = new Array('','Ribu','Juta','Milyar','Triliun');
		

		var panjang_bilangan = bilangan.length;

	/* pengujian panjang bilangan */
	if (panjang_bilangan > 15) {
		kaLimat = "Diluar Batas";
		return kaLimat;
	}

	/* mengambil angka-angka yang ada dalam bilangan, dimasukkan ke dalam array */
	for (i = 1; i <= panjang_bilangan; i++) {
		angka[i] = bilangan.substr(-(i),1);
	}
	i = 1;
	j = 0;
	kaLimat = "";


	/* mulai proses iterasi terhadap array angka */
	while (i <= panjang_bilangan) {
		subkaLimat = "";
		kata1 = "";
		kata2 = "";
		kata3 = "";

		/* untuk Ratusan */
		if (angka[i+2] != "0") {
			if (angka[i+2] == "1") {
				kata1 = "Seratus";
			}else{ kata1 = kata[angka[i+2]] + " Ratus";}
		}

		/* untuk Puluhan atau Belasan */
		if (angka[i+1] != "0") {
			if (angka[i+1] == "1") {
				if (angka[i] == "0") {
					kata2 = "Sepuluh";
				}else if(angka[i] == "1") {kata2 = "Sebelas";}
				else {kata2 = kata[angka[i]] + " Belas";}
			} else {kata2 = kata[angka[i+1]] + " Puluh";}
		}


		/* untuk Satuan */
		if (angka[i] != "0") {
			if (angka[i+1] != "1") {
				kata3 = kata[angka[i]];
			}
		}


		/* pengujian angka apakah tidak nol semua, lalu ditambahkan tingkat */
		if ((angka[i] != "0") || (angka[i+1] != "0") || (angka[i+2] != "0")) {
                        kata2_3=" ";
                        if(kata2!=="" && kata3!==""){
                            kata2_3=kata2.trim() +" "+kata3.trim();
                        }else if(kata2!=="" && kata3===""){
                            kata2_3=" "+kata2+" ";
                        }else if(kata2==="" && kata3!==""){
                            kata2_3=" "+kata3+" ";
                        }
                        
                        
//			subkaLimat = kata1+" "+kata2.trim() +" "+kata3.trim()+" "+tingkat[j]+" ";
			subkaLimat = kata1 + kata2_3 + tingkat[j]+" ";
		}

		/* gabungkan variabe sub kaLimat (untuk Satu blok 3 angka) ke variabel kaLimat */
		kaLimat = subkaLimat + kaLimat;
		i = i + 3;
		j = j + 1;
	}


	/* mengganti Satu Ribu jadi Seribu jika diperlukan */
	if ((angka[5] == "0") && (angka[6] == "0")) {
		kaLimat = kaLimat.replace("Satu Ribu","Seribu");
	}

		return kaLimat + "Rupiah";


	}
}

function removeCommas(str) {
        return str.replace(/,/g, "");
}

function formatNumber( num, fixed ) { 
    var decimalPart;

    var array = Math.floor(num).toString().split('');
    var index = -3; 
    while ( array.length + index > 0 ) { 
        array.splice( index, 0, ',' );              
        index -= 4;
    }

    if(fixed > 0){
        decimalPart = num.toFixed(fixed).split(".")[1];
        return array.join('') + "." + decimalPart; 
    }
    return array.join(''); 
};
function formatNumber2( num, fixed ) { 
    var decimalPart;
    var array;
    var signMinus="";
    
    if(num<0.00){
        if(Math.ceil(num)===0){
            signMinus="-";
        }
        array = Math.ceil(num).toString().split('');
    }else{
        array = Math.floor(num).toString().split('');
        signMinus="";
    }
            
    var index = -3; 
    while ( array.length + index > 0 ) { 
        array.splice( index, 0, ',' );              
        index -= 4;
    }

    if(fixed > 0){
        decimalPart = num.toFixed(fixed).split(".")[1];
        return signMinus+array.join('') + "." + decimalPart; 
    }
    return signMinus+array.join(''); 
};

function numericFilter(txb) {
    txb.value = txb.value.replace(/[^\0-9]/ig, "");
}