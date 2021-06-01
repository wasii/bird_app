import UIKit

class AllBirdDetailsViewController: BaseViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var birdPictures: [ChartView] = []
    var pageControllIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.makeTopCornersRounded(roundView: self.mainView)
        birdPictures = createChartView()
        scrollView.delegate = self
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
    }
    
    override func viewDidLayoutSubviews() {
        setupSlideScrollView(chartViews: birdPictures)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    private func createChartView() -> [ChartView] {
        birdPictures = [ChartView]()
        for i in 0..<3 {
            let picture:ChartView = Bundle.main.loadNibNamed("ChartView", owner: self, options: nil)?.first as! ChartView
            picture.image.image = UIImage(named: "bird\(i)")
            birdPictures.append(picture)
        }
        
        return birdPictures
    }
    func setupSlideScrollView(chartViews: [ChartView]) {
        for v in scrollView.subviews {
            v.removeFromSuperview()
        }
        scrollView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height)
        scrollView.contentSize = CGSize(width: imageView.frame.width * CGFloat(chartViews.count), height: imageView.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        for i in 0 ..< chartViews.count {
            chartViews[i].frame = CGRect(x: imageView.frame.width * CGFloat(i),
                                         y: 0,
                                         width: imageView.frame.width,
                                         height: imageView.frame.height)
            scrollView.addSubview(chartViews[i])
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        self.pageControllIndex = Int(pageIndex)
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
