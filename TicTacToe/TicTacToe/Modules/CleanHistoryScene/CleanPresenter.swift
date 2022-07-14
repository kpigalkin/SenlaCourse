

import UIKit

protocol CleanPresentationLogic
{
  func presentSomething(response: Clean.Something.Response)
}

class CleanPresenter: CleanPresentationLogic
{
  weak var viewController: CleanDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Clean.Something.Response)
  {
      print("⭕️ presentSomething \n")

     
      var newItem: HistoryCollectionItem
      var section: Section

      if response.rockPaperItem == nil {
          let item = HistoryCollectionItem(content: .cubeGame(configuration: .init(
            id: response.cubeItem!.id,
            randomCube: response.cubeItem!.randomCube)))
          
          newItem = item
          section = Section.cubeGame
      } else {
          let item = HistoryCollectionItem(content: .rockPaper(configuration: .init(
            id: response.rockPaperItem!.id,
            gameStatus: response.rockPaperItem!.gameStatus,
            computerChose: response.rockPaperItem!.computerChose,
            userChose: response.rockPaperItem!.userChose)))
          
          newItem = item
          section = Section.rockPaper
      }
      
      let viewModel = Clean.Something.ViewModel(
        item: newItem,
        throwInfo: response.throwInfo,
        bestSet: response.bestSet)
      
      viewController?.displaySomething(viewModel: viewModel, section: section)
  }
}
