

import UIKit

protocol CleanBusinessLogic {
    func sendItemToPresenter(request: Clean.Something.Request)
}
protocol CleanDataStore {
//  var section: Section { get set }
}

class CleanInteractor: CleanBusinessLogic, CleanDataStore {
   
    var presenter: CleanPresentationLogic?
    
    
    // MARK: Do something
   
    func parsingGeneralInfo() -> (throwInfo: HistoryCollectionItem, bestSet: HistoryCollectionItem){
        print("⭕️ parsingGeneralInfo \n")

        let throwInfo = HistoryCollectionItem(content: .throwInfo(configuration: .init(
            id: GameLogic.throwInfo.id,
            data: GameLogic.throwInfo.data)))
        let bestSet = HistoryCollectionItem(content: .bestSet(configuration: .init(
            id: GameLogic.bestSet.id,
            bestSet: GameLogic.bestSet.bestSet)))
        
        print("bestSet - \(bestSet)")
        return (throwInfo, bestSet)
    }
    // Парсим с геймлогика и отправляем Response в презентер где приводим в человеческий вид
     func sendItemToPresenter(request: Clean.Something.Request) {
         
         print("⭕️ sendItemToPresenter \n")

         let generalInfo = parsingGeneralInfo()
         let response = Clean.Something.Response(
             cubeItem: request.cubeItem,
             rockPaperItem: request.rockPaperItem,
             throwInfo: generalInfo.throwInfo,
             bestSet: generalInfo.bestSet)
         
         presenter?.presentSomething(response: response)
     }
}




