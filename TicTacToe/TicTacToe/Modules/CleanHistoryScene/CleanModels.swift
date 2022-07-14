

import UIKit

enum Clean
{
  // MARK: Use cases
  
  enum Something {
      
      struct Request {
          let cubeItem: HistoryOfCubeGame?
          let rockPaperItem: HistoryOfRockPaper?
      }
      struct Response {
          let cubeItem: HistoryOfCubeGame?
          let rockPaperItem: HistoryOfRockPaper?
          let throwInfo: HistoryCollectionItem
          let bestSet: HistoryCollectionItem
      }
      struct ViewModel {
          let item: HistoryCollectionItem
          let throwInfo: HistoryCollectionItem
          let bestSet: HistoryCollectionItem
      }
  }
}
