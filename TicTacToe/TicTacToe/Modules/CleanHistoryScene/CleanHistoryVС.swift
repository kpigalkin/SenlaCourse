

import UIKit

protocol CleanDisplayLogic: AnyObject {
    func displaySomething(viewModel: Clean.Something.ViewModel, section: Section)
}

class CleanHistoryVC: UIViewController, CleanDisplayLogic {
    var interactor: CleanBusinessLogic?
    var router: (NSObjectProtocol & CleanDataPassing)?
    weak var historyView: HistoryViewDelegate?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {

      // setup in TabBarController
    print("⭕️ setup CleanHistoryVC \n")
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "History"
    print("⭕️ viewDidLoad CleanHistoryVC \n")
  }
  
  // MARK: Do something

    // view, покажи это:
    func displaySomething(viewModel: Clean.Something.ViewModel, section: Section) {
        print("⭕️ displaySomething \n")
        historyView?.appendNewItems(viewModel: viewModel, section: section)
  }
}



