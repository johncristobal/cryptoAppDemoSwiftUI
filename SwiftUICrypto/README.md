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
### Views tips
1. 
Preview("Light", traits: .sizeThatFitsLayout) {
    View
        .preferredColorScheme(.light)
}

Preview("Dark", traits: .sizeThatFitsLayout) {
    View
        .preferredColorScheme(.dark)
}

- Buyenisimo para agregar dos previews, agrega tabs y se ven con lo que digamos
    - shcem, device, size, etc

2. extension de view para mejhor lectura
Ver codigo, como agrega el leftColumn, centerCOllumn, etc en extensiones
    
============================
### View model
    }
    .environmentObject(vm)
    
pasas el viewmodel en el environment, 

    struct HomeView: View {
        @EnvironmentObject private var vm: HomeViewModel
            
Donde quieras, lo puedes obtener y jalar la data

### transition
    if !showPortafolio {
        allCoinsList
            .transition(.move(edge: .leading))
    }
mira como al agregar transition, y la vista desaparece, hace animacion que se vaya a un lado, *INTERESANTE*


### API
    URLSession.shared.dataTaskPublisher
        .subscribe(on: DispatchQueue.global(qos: .default))
        .tryMap { (output) -> Data in
- Mira nada mas, una nueva foram de llamar url session, pero con combine
- suscribe a background
- trymap para obtenr error

        .receive(on: DispatchQueue.main)
        .decode(type: [CoinModel].self, decoder: JSONDecoder())
        .sink { (completion) in ... receiveValue: { [weak self] value in

- recibe en main
- decode modelo lista
- sink para terminar operacion
    - completion con error en caso de
    - receiveValue para obtener data
    
*INTERESANTE*
    @Published var allCoins: [CoinModel] = []
    . . .
    dataService.$allCoins
        .sink { [weak self] coins in  

- @Published, son parte decombine, y se pueden suscribir como tal y obtener data
- NetwirkinManager
    - separamops el publisher en diferentes metodos, para mejor lectura 
============================

- API crytp page
jimenezalexis060@...
https://www.coingecko.com/en/developers/dashboard


