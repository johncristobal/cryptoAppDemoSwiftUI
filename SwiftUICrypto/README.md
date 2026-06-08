#  Crypto app demo

============================
### Intro

Assets
- Recuerda que los colores ya se definen desde aqui - Any, Dark
- Creamos theme strcut para acceder a colores mas rapido 

Preview
    #Preview(traits: .sizeThatFitsLayout) {
ahora podemos colocar info dentro del preview
- con este podemos hcaer que el preview solo este en la vista, no tooooda la pantalla

Model
- ojo, no pongas nomvre de 'Model', solo Coin para prod
- crea modelos desde json usando AI Xcode
- crea variables en tiempo real, accede al valor al momento
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }

Protocols:
* Identifable - incluye un id obligatorio para identifcar en vista
* Codable - cuidado con los nombres, el underscore se busca match con enum
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"


============================

- API crytp page
jimenezalexis060@...
https://www.coingecko.com/en/developers/dashboard


