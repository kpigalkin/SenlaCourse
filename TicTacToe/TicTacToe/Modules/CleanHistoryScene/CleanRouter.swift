

import UIKit

protocol CleanDataPassing {
  var dataStore: CleanDataStore? { get }
}
protocol RockPaperDelegate: AnyObject {
    func sendRockPaperItem(_ item: HistoryOfRockPaper)
}
protocol CubeGameDelegate: AnyObject {
    func sendCubeGameItem(_ item: HistoryOfCubeGame)
}

class CleanRouter: NSObject, CleanDataPassing {
    
  weak var viewController: CleanHistoryVC?
  var dataStore: CleanDataStore?

    override init() {
        super.init()
        print("⭕️ CleanRouter inited")
    }
  // MARK: Passing data

    func passRockPaperToInteractor(_ item: HistoryOfRockPaper) {
        print("⭕️ passRockPaperToInteractor CleanRouter\n")
        let request = Clean.Something.Request(
            cubeItem: nil,
            rockPaperItem: item)
        viewController?.interactor?.sendItemToPresenter(request: request)
    }
    
    func passCubeGameToInteractor(_ item: HistoryOfCubeGame) {
        print("⭕️ passCubeGameToInteractor CleanRouter\n")
        let request = Clean.Something.Request(
            cubeItem: item,
            rockPaperItem: nil)
        viewController?.interactor?.sendItemToPresenter(request: request)
    }
}


  // MARK: Getting data

extension CleanRouter: RockPaperDelegate, CubeGameDelegate {
    
    // Вызываем метод для трансфера данных в Interactor
    func sendRockPaperItem(_ item: HistoryOfRockPaper) {
        print("⭕️ sendRockPaperItem CleanRouter\n")
        passRockPaperToInteractor(item)
    }
    func sendCubeGameItem(_ item: HistoryOfCubeGame) {
        print("⭕️ sendCubeGameItem CleanRouter\n")
        passCubeGameToInteractor(item)
    }
}



