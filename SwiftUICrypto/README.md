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
### View model Image
inits en views
- para inicializar viewmodels con un dato, wrappedValue
    @StateObject var vm: CoinImageViewModel
    
    init (coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }

subscriber de la image
- en el trymap, buscamos que el data sea imagen, es lo que recibimos en sink
    imageSubscription = NetworkingManager.download(url: url)
        .tryMap({ data -> UIImage? in
            return UIImage(data: data)
        })

una vez mas, conectamos a published
dentro de view model, subscribimos al imagen de service
    self.dataService.$image
        .sink { [weak self] (_) in

mostramos view, llamamos vista con coin, y listo
    CoinImageView(coin: coin)

============================
### SAVE images local manger file
Recuerda, cuando son imagnes, podemos cargar, guardar y cargar de local
FileManager para obtrenr carpetas y archivos
    FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).firss
Para crear directorios
    FileManager.default.createDirectory

============================
### Search
Recuerda
    .overlay(
        Image(systemName: "xmark.circle.fill")
- para colocar items encima de un view

- para cerrar teclado
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

- OJO con los preview y multiples

- search and combine
    // combinamos publishers, cuando cambien uno, se ejecuta
    // deboucce para esperar 0.5, tecleeos rapidos
    // usamos funcion para limpireza de codigo
    $searchText
        .combineLatest(dataService.$allCoins)
        .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        .map(filterCoins)

OJO Enviroment
- recuerda que puedes acceder al environment data que se haya inyectado desde el inicio (ver archivo main)
    struct HomeStatsView: View {
        @EnvironmentObject private var vm: HomeViewModel

============================
Portafolio
- Mostrar sheets con isPresented
    .sheet(isPresented: $showPortafolioView) {
        PortafolioView()
            .environmentObject(vm)
    }

- cambiar tema titels desde main view
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
============================
Database core data
- para guardr en base de datos
    let container: NSPersistentContainer

- datamodel
    - Portafoliocontainer para crear entity y atributos
    - let request = NSFetchRequest<PortafolioEntity>(entityName: entityName) para hacer busqueda
    - container.viewContext. save, delete para actualizr db

- combinelatest, para obtener coinmodel con el id de la base de datos
    $allCoins
        .combineLatest(portafolioService.$portafolio)
        .map { (coins, portafolio) -> [CoinModel] in

- map con funcion 
S puede enviuar la funcion sin params, ya todo esta en el metodo
  marketataService.$marketData
            .combineLatest($portafolioCoins)
            .map(appendMarketData)
        
============================
sort
- dos formas de usar las funciones
    return coins.sorted { coin1, coin2 -> Bool in
        return coin1.rank < coin2.rank
    }
o
    return coins.sorted(by: {$0.rank < $1.rank })
    
- animaciones with y de un published
- checa el rotationEffect y el withAnimation para *girar* elemento 
    HStack {
        Text("Coin")
        Image(systemName: "chevron.down")
            .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1 : 0)
            .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
    }
    .onTapGesture {
        withAnimation(.default) {
            vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
        }
    }

============================
Navigation

============================

- API crytp page
jimenezalexis060@...
https://www.coingecko.com/en/developers/dashboard


