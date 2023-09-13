////
////  EsempioDI.swift
////  DependencyInversion31layer
////
////  Created by Gianluca Posca on 11/09/23.
////
//
//import Foundation
//
////dipendere:
//
//class A {
//    var b: B
//
//    init() {
//        b = B()
//    }
//
//    func start() {
//        b.doSomething()
//    }
//}
//
//class B {
//    func doSomething() {
//    }
//}
//
////dependency Injection:
//
//class A1 {
//    var b: B1
//
//    init(b: B1) {
//        self.b = b
//    }
//
//    func start() {
//        b.doSomething()
//    }
//}
//
//class B1 {
//    func doSomething() {
//    }
//}
//
////dependency Inversion:
//protocol BInterface {
//    func doSomething()
//}
//class A2 {
//    var b: BInterface
//
//    init(b: BInterface) {
//        self.b = b
//    }
//
//    func start() {
//        b.doSomething()
//    }
//}
//class B2: BInterface {
//    func doSomething() {
//    }
//}
//class C2: BInterface {
//    func doSomething() {
//    }
//}
//
//
///// 3 + 1 layer
///// +1 App Layer: the entry point of the app which contains dependency injection
///// 1 Presentation Layer: we put our UI here (Views & View Models)
///// 2 Domain Layer: contains business logic
///// 3 Data Layer: gets data from remote or local data sources
//
/////Domain Layer: doesn’t depend on any other layer.
/////Presentation Layer & Data Layer both depend on Domain Layer
/////Presentation Layer & Data Layer don’t depend on each other
/////App Layer depends on all of them (which means A sees every thing inside B)
//
//
///// MARK:  Domain Layer contiene:
/////Interactor: contains business logic for each specific feature. It is also called Use Case
//public protocol PostInteractorInterface {
//    func getPosts(handler: @escaping ([PostEntity]) -> ())
//}
//
//public class PostInteractor: PostInteractorInterface {
//    let postDomainRepo: PostDomainRepoInterface
//
//    public init(postDomainRepo: PostDomainRepoInterface) {
//        self.postDomainRepo = postDomainRepo
//    }
//
//    public func getPosts(handler: @escaping ([PostEntity]) -> ()) {
//        postDomainRepo.getPosts { (PostDomainModelArray) in
//            handler(PostDomainModelArray)
//        }
//    }
//}
/////PostInteractor uses an injected postDomainRepo object which conforms to PostDomainRepoInterface to get data.
/////getPosts() method doesn’t contain actual business logic, just calling another method for the sake of simplicity. But this is where you apply your business logic. For example you can check if a post contains racist words to ban the post — or feature it if you are racist. Or you can check if you have added any of these posts to your favorites and apply a star to it.
//
/////Entity: a model contains data for the interactor. Data model that suits the business logic.
//public struct PostEntity: Identifiable {
//    public let id: Int?
//
//    public init(id: Int?) {
//        self.id = id
//    }
//}
//
/////Domain Repo Interface: this interface/protocol is an abstraction of how the interactor gets data from data layer
//public protocol PostDomainRepoInterface {
//    func getPosts(handler: @escaping ([PostEntity]) -> ())
//}
//
//
///// MARK:  Presentation Layer contiene:
/////presentation layer contains a View and a ViewModel for each screen, and considers the Entity from Domain layer as a Model
//import SwiftUI
/////PostView: represents a screen, contains UI components and navigation, shouldn’t contain any sort of logic
//public struct PostView: View {
//
//    var appDI: AppDIInterface2
//    @ObservedObject public var postVM: PostVM
//
//    @State var detailsIsPresented: Bool = false
//
//    public init(appDI: AppDIInterface2, postVM: PostVM) {
//        self.appDI = appDI
//        self.postVM = postVM
//    }
//
//    public var body: some View {
//        NavigationView {
//            List {
//                ForEach(postVM.posts) { post in
//                    VStack{
//                        Text("post.title ?? ")
//                            .font(.largeTitle)
//                            .multilineTextAlignment(.center)
//                    }
//                }.onTapGesture {
//                    self.detailsIsPresented = true
//                }
//            }
//            .sheet(isPresented: $detailsIsPresented, content: {
//                PostDetailsView(postDetailsVM: self.appDI.postDetailsDependencies())
//            })
//            .navigationBarTitle("Posts")
//        }
//        .onAppear {
//            self.postVM.getPosts()
//        }
//    }
//}
//
/////PostVM: Post View Model is responsible for converting the Entity in such a way that data is easily managed and presented. It handles all of the view’s display logic.
/////postInteractor is injected to the the PostVM in the init method as an abstraction, so we can mock it in unit testing.
//public class PostVM: ObservableObject {
//
//    @Published var posts: [PostEntity] = []
//
//    private var postInteractor: PostInteractorInterface
//
//    public init(postInteractor: PostInteractorInterface) {
//        self.postInteractor = postInteractor
//    }
//
//    func getPosts() {
//
//        self.postInteractor.getPosts { [weak self] (postArray) in
//            DispatchQueue.main.async {
//                self?.posts = postArray
//            }
//        }
//    }
//}
//
/////As the diagram indicates, PostVM has a reference to PostInteractor in the domain layer to get the Entity.
//
//
///// MARK:  Data Layer contiene:
/////data layer depends on domain layer, it is the protocol PostDomainRepoInterface
/////add 4 swift files to it: Model.swift, DataRepo.swift, RemoteDataSource.swift and LocalDataSource.swift
/////the interactor in the domain layer depends on the abstraction PostDomainRepoInterface.
/////DataRepo that implements this abstraction, so that data and domain are loosely coupled.
//
//public class PostDataRepo: PostDomainRepoInterface {
//
//    let postRemoteDataSource: PostRemoteDataSourceInterface
//    let postLocalDataSource: PostLocalDataSourceInterface?
//    let coder: JSONDecoder
//
//    public init(postRemoteDataSource: PostRemoteDataSourceInterface,
//                postLocalDataSource: PostLocalDataSourceInterface? = nil,
//                coder: JSONDecoder = JSONDecoder()) {
//
//        self.postRemoteDataSource = postRemoteDataSource
//        self.postLocalDataSource = postLocalDataSource
//
//        self.coder = coder
//    }
//
//
//    public func getPosts(handler: @escaping ([PostEntity]) -> ()) {
//
//        postRemoteDataSource.getPosts { (postModels) in
//
//            var postEntities = [PostEntity]()
//            for postModel in postModels {
//                postEntities.append(postModel.dotPostEntity())
//            }
//
//            handler(postEntities)
//        }
//    }
//}
//
//public protocol PostRemoteDataSourceInterface {
//
//    init(urlString: String, coder: JSONDecoder)
//
//    func getPosts(handler: @escaping ([PostModel]) -> ())
//}
//
//
//public class PostRemoteDataSource: PostRemoteDataSourceInterface {
//
//    let urlString: String
//    let coder: JSONDecoder
//
//    required public init(urlString: String, coder: JSONDecoder = JSONDecoder()) {
//        self.urlString = urlString
//        self.coder = coder
//    }
//
//    public func getPosts(handler: @escaping ([PostModel]) -> ()) {
//
//        guard let url = URL(string: urlString) else {
//            return handler([])
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, urlResponse, error) in
//            do {
//                guard let data = data else {
//                    return handler([])
//                }
//
//                guard let postModels = try self?.coder.decode([PostModel].self, from: data) else {
//                    return handler([])
//                }
//
//                handler(postModels)
//            } catch {
//                handler([])
//            }
//
//        }
//        task.resume()
//    }
//}
//
//public struct PostModel: Codable {
//
//    public let userId: Int?
//    public let id: Int?
//    public let title: String?
//    public let body: String
//
//
//    // DOT: Data Object Transfer
//    public func dotPostEntity() -> PostEntity {
//        return PostEntity(id: id)
//    }
//}
//
/////We are not doing the local data source
//public protocol PostLocalDataSourceInterface {
//    func getCachedPosts(handler: @escaping ([PostEntity]) -> ())
//}
//
/////The pattern of data repo and data source is a well known design pattern called: Repository Pattern.
//
//
///// MARK:  App Layer contiene:
/////app layer is the entry point of the app. It contains the Dependency Injection Container & the Environment.
//
/////Environment contains things like base url, end points, certificates, etc.
//class AppEnvironment {
//    let baseURL = "https://jsonplaceholder.typicode.com/posts"
//}
//
/////AppDI folder group prepares all dependencies for each feature separately.
//
/////each feature like Post has a separate DI and the AppDI access all of them.
//class PostDI {
//
//    let appEnvironment: AppEnvironment
//
//    init(appEnvironment: AppEnvironment) {
//        self.appEnvironment = appEnvironment
//    }
//
//    func postDependencies() -> PostVM {
//
//        // Data Layer
//        let baseURL = appEnvironment.baseURL
//
//        // Data Source
//        let postRemoteDataSource = PostRemoteDataSource(urlString: baseURL)
//
//        // Data Repo
//        let postDataRepo = PostDataRepo(postRemoteDataSource: postRemoteDataSource)
//
//        // Domain Layer
//        let postInteractor = PostInteractor(postDomainRepo: postDataRepo)
//
//        // Presentation
//        let postVM = PostVM(postInteractor: postInteractor)
//
//        return postVM
//    }
//}
//
/////we import all our 3 layers.
/////VM is the only dependency we need for View. So postDependencies() method returns PostVM.
/////To create VM, it needs Interactor which needs DataRepo which needs RemoteDataSource.
//
//public protocol AppDIInterface {
//    func postDependencies() -> PostVM
//}
//
//class AppDI: AppDIInterface {
//
//    static let shared = AppDI(appEnvironment: AppEnvironment())
//
//    let appEnvironment: AppEnvironment
//
//    init(appEnvironment: AppEnvironment) {
//        self.appEnvironment = appEnvironment
//    }
//
//    func postDependencies() -> PostVM {
//
//        let postDI: PostDI = PostDI(appEnvironment: appEnvironment)
//
//        let postVM = postDI.postDependencies()
//
//        return postVM
//    }
//
//}
//
/////creo il tutto con:
//let post = PostView(appDI: AppDI2.shared, postVM: AppDI2.shared.postDependencies())
//
//
/////Aggiungere una feature
/////So we need to add 10 or 9 files:
//
/////In presentation layer: PostDetailsView & PostDetailsVM
//struct PostDetailsView: View {
//
//    @ObservedObject public var postDetailsVM: PostDetailsVM
//
//    public init(postDetailsVM: PostDetailsVM) {
//
//        self.postDetailsVM = postDetailsVM
//    }
//
//    var body: some View {
//        Text(postDetailsVM.details)
//    }
//}
//
//
//public class PostDetailsVM: ObservableObject {
//
//    @Published var details = "My details"
//
//    // So we can initialize it from the app layer
//    public init() { }
//}
//
//class PostDetailsDI {
//    let appEnvironment: AppEnvironment
//
//    init(appEnvironment: AppEnvironment) {
//        self.appEnvironment = appEnvironment
//    }
//
//    func postDetailsDependencies() -> PostDetailsVM{
//        // Presentation
//        let postDetailsVM = PostDetailsVM()
//        return postDetailsVM
//    }
//}
//
/////In domain layer: PostDetailsInteractor, PostDetailsEntity, PostDetailsDomianRepo
/////In data layer: PostDetailsDataRepo, PostDetailsModel, PostDetailsRemoteDataSource, PostDetailsLocalDataSource if we need it
/////In app layer: PostDetailsDI
//
/////modifichiamo AppDIInterface2 per far avere una func
//public protocol AppDIInterface2 {
//    func postDependencies() -> PostVM
//    func postDetailsDependencies() -> PostDetailsVM
//}
//
/////a AppDI aggiungiamo questa funzione:
//class AppDI2: AppDIInterface2 {
//
//    static let shared = AppDI2(appEnvironment: AppEnvironment())
//
//    let appEnvironment: AppEnvironment
//
//    init(appEnvironment: AppEnvironment) {
//        self.appEnvironment = appEnvironment
//    }
//
//    func postDependencies() -> PostVM {
//
//        let postDI: PostDI = PostDI(appEnvironment: appEnvironment)
//
//        let postVM = postDI.postDependencies()
//
//        return postVM
//    }
//
//    ///questa
//    func postDetailsDependencies() -> PostDetailsVM {
//
//        let postDetailsDI: PostDetailsDI = PostDetailsDI(appEnvironment: appEnvironment)
//
//        let postDetailsVM = postDetailsDI.postDetailsDependencies()
//
//        return postDetailsVM
//    }
//
//}
