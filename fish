var canvas = document.getElementById('canvasPeixes')
var imagem = document.getElementById('peixes')
var contexto

class RGBColor {
    constructor(r, g, b) {
        this.red = r
        this.green = g
        this.blue = b
    }
}

class MatrixImage {
    constructor(imageData) {
        this.imageData = imageData
        this.height = imageData.height
        this.width = imageData.width
    }

    getPixel(x, y) {
        let position = y * (this.width * 4) + x * 4

        return new RGBColor(
            this.imageData.data[position], //red
            this.imageData.data[position + 1], //green
            this.imageData.data[position + 2] //blue
        )
    }

    setPixel(x, y, color) {
        let position = y * (this.width * 4) + x * 4
        this.imageData.data[position] = color.red
        this.imageData.data[position + 1] = color.green
        this.imageData.data[position + 2] = color.blue
    }
}

var load = () => {
    contexto = canvas.getContext('2d')
    canvas.width = imagem.width
    canvas.height = imagem.height
    contexto.drawImage(imagem, 0, 0)
}

var canalVermelho = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)
            corVermelha = new RGBColor(px.red, 0, 0)
            peixes.setPixel(i, j, corVermelha)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('vermelho').addEventListener('click', canalVermelho)

var canalVerde = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)
            corVerde = new RGBColor(0, px.green, 0)
            peixes.setPixel(i, j, corVerde)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('verde').addEventListener('click', canalVerde)

var canalAzul = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)
            corAzul = new RGBColor(0, 0, px.blue)
            peixes.setPixel(i, j, corAzul)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('azul').addEventListener('click', canalAzul)

var horizontal = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    let peixes = new MatrixImage(imageData)

    for (var i = 0, fim = canvas.height-1; i < peixes.height / 2; i++, fim--) {
        for (var j = 0; j < peixes.width; j++) {
            var px_comeco = peixes.getPixel(j, i)
            var px_fim = peixes.getPixel(j, fim)

            peixes.setPixel(j, i, px_fim)
            peixes.setPixel(j, fim, px_comeco)
        }
    }
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('horizontal').addEventListener('click', horizontal)

var vertical = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    let peixes = new MatrixImage(imageData)

    // trocar j, i
    for (var i = 0, fim = canvas.width-1; i < peixes.width / 2; i++, fim--) {
        for (var j = 0; j < peixes.height; j++) {
            var px_comeco = peixes.getPixel(i, j)
            var px_fim = peixes.getPixel(fim, j)

            peixes.setPixel(i, j, px_fim)
            peixes.setPixel(fim, j, px_comeco)
        }
    }
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('vertical').addEventListener('click', vertical)

var cinzas = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)
            cinza = (px.red + px.green + px.blue)/3
            cor = new RGBColor(cinza, cinza, cinza)
            peixes.setPixel(i, j, cor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('cinzas').addEventListener('click', cinzas)

var limiar = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)

    var limite_cinza = 100
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)
            cinza = (px.red + px.green + px.blue)/3
            if (cinza > limite_cinza) {
                cor = new RGBColor(255, 255, 255)
            } else {
                cor = new RGBColor(0, 0, 0)
            }
            peixes.setPixel(i, j, cor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('binario').addEventListener('click', limiar)

var media = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 1; i < peixes.width-1; i++) {
        for (var j = 1; j < peixes.height-1; j++) {
            pixels = [
                peixes.getPixel(i, j - 1), 
                peixes.getPixel(i, j + 1), 
                peixes.getPixel(i + 1, j), 
                peixes.getPixel(i - 1, j),
                peixes.getPixel(i, j)
            ]

            soma_r = 0
            soma_g = 0
            soma_b = 0

            for (var pos = 0; pos < 5; pos++) {
                soma_r += pixels[pos].red
                soma_g += pixels[pos].green
                soma_b += pixels[pos].blue
            }

            red = soma_r/5
            green = soma_g/5
            blue = soma_b/5

            cor = new RGBColor(red, green, blue)
            peixes.setPixel(i, j, cor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('media').addEventListener('click', media)

var mediana = () => {
    cinzas()
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 1; i < peixes.width-1; i++) {
        for (var j = 1; j < peixes.height-1; j++) {
            pixels = [
                peixes.getPixel(i, j - 1).red, 
                peixes.getPixel(i, j + 1).red, 
                peixes.getPixel(i + 1, j).red, 
                peixes.getPixel(i - 1, j).red,
                peixes.getPixel(i, j).red
            ]

            ordenado = pixels.sort()
            cinza = ordenado[2]

            cor = new RGBColor(cinza, cinza, cinza)
            peixes.setPixel(i, j, cor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('mediana').addEventListener('click', mediana)

var filtroGausiano = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 1; i < peixes.width-1; i++) {
        for (var j = 1; j < peixes.height-1; j++) {
            novaCor = new RGBColor(0, 0, 0)

            px_01 = peixes.getPixel(i, j)
            px_01.red *= 0.1
            px_01.green *= 0.1
            px_01.blue *= 0.1
            novaCor.red += px_01.red
            novaCor.green += px_01.green
            novaCor.blue += px_01.blue
            
            peso_03 = [
                peixes.getPixel(i+1, j+1),
                peixes.getPixel(i-1, j-1),
                peixes.getPixel(i+1, j-1),
                peixes.getPixel(i-1, j+1)
            ]

            peso_01 = [
                peixes.getPixel(i, j+1),
                peixes.getPixel(i, j-1),
                peixes.getPixel(i+1, j),
                peixes.getPixel(i-1, j)
            ]

            for (var pos=0; pos <4; pos++){
                peso_03[pos].red *= 0.3
                peso_03[pos].green *= 0.3
                peso_03[pos].blue *= 0.3

                peso_01[pos].red *= 0.1
                peso_01[pos].green *= 0.1
                peso_01[pos].blue *= 0.1

                novaCor.red += peso_03[pos].red + peso_01[pos].red
                novaCor.green += peso_03[pos].green + peso_01[pos].green
                novaCor.blue += peso_03[pos].blue + peso_01[pos].blue
            }

            novaCor.red /= 1.7
            novaCor.green /= 1.7
            novaCor.blue /= 1.7

            peixes.setPixel(i, j, novaCor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('gausiano').addEventListener('click', filtroGausiano)

function ajuste(cor){
    if(cor > 255) {
        return 255
    } else if (cor < 0) {
        return 0
    }
    return cor
}

// Algorithms for Adjusting Brightness and Contrast of an Image -> the IE Blog
var brilho = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)

            vermelho = ajuste(px.red + 50)
            verde = ajuste(px.green + 50)
            azul = ajuste(px.blue + 50)

            cor = new RGBColor(vermelho, verde, azul)
            peixes.setPixel(i, j, cor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('brilho').addEventListener('click', brilho)

var brilhoMenos = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)

            vermelho = ajuste(px.red - 50)
            verde = ajuste(px.green - 50)
            azul = ajuste(px.blue - 50)

            cor = new RGBColor(vermelho, verde, azul)
            peixes.setPixel(i, j, cor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('brilhoMenos').addEventListener('click', brilhoMenos)

var contraste = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)

    const fator_corecao = (259 * (50 + 255)) / (255 * (259 - 50))

    console.log(fator_corecao)
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)

            vermelho = ajuste(fator_corecao * (px.red - 128) + 128)
            verde = ajuste(fator_corecao * (px.green - 128) + 128)
            azul = ajuste(fator_corecao * (px.blue - 128) + 128)

            cor = new RGBColor(vermelho, verde, azul)
            peixes.setPixel(i, j, cor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('contraste').addEventListener('click', contraste)

var contrasteMenos = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)

    const fator_corecao = (259 * (-10 + 255)) / (255 * (259 + 10))

    console.log(fator_corecao)
    
    for (var i = 0; i < peixes.width; i++) {
        for (var j = 0; j < peixes.height; j++) {
            px = peixes.getPixel(i, j)

            vermelho = ajuste(fator_corecao * (px.red - 128) + 128)
            verde = ajuste(fator_corecao * (px.green - 128) + 128)
            azul = ajuste(fator_corecao * (px.blue - 128) + 128)

            cor = new RGBColor(vermelho, verde, azul)
            peixes.setPixel(i, j, cor)
        }
    }
    
    contexto.putImageData(peixes.imageData, 0, 0)
}
document.getElementById('contrasteMenos').addEventListener('click', contrasteMenos)

var noventaGraus = () => {
    imageData = contexto.getImageData(0, 0, canvas.width, canvas.height)
    peixes = new MatrixImage(imageData)

    imageData = contexto.getImageData(0, 0, canvas.height, canvas.width)
    peixes2 = new MatrixImage(imageData)

    for (var i = 0, j_peixes2 = 0; i < peixes.width; i++, j_peixes2++) {
        for (var j = 0, i_peixes2 = peixes.height - 1; j < peixes.height; j++, i_peixes2--) {
            px = peixes.getPixel(i_peixes2, j_peixes2)
            peixes2.setPixel(i, j, px)
        }
    }
    contexto.putImageData(peixes2.imageData, 0, 0)
}
document.getElementById('noventaGraus').addEventListener('click', noventaGraus)
document.getElementById('load').addEventListener('click', load)
