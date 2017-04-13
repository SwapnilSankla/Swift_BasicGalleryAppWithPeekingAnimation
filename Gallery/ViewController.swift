import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var visiblePage: UILabel!
    let imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        scrollView.delegate = self
    
        present(imagePickerController, animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let uiImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        let imageView = UIImageView(image: uiImage)
        let heightConstraint =
            NSLayoutConstraint(item: imageView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 300)
        let screenWidth = UIScreen.main.bounds.maxX
        let widthConstant: CGFloat = imageStackView.arrangedSubviews.count == 0 ? screenWidth - 65 : screenWidth - 90
        let widthConstraint =
            NSLayoutConstraint(item: imageView  ,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: widthConstant)
        imageView.addConstraint(heightConstraint)
        imageView.addConstraint(widthConstraint)
        imageStackView.addArrangedSubview(imageView)
        imagePickerController.dismiss(animated: true, completion: nil)
        view.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: imageStackView.frame.maxX, height: 200)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 2, animations: {
            self.visiblePage.alpha = 0
        })
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 2, animations: {
            self.visiblePage.alpha = 0
        })
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setScrollOffset(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setScrollOffset(scrollView)
    }

    @IBAction func browseButtonTapped(_ sender: AnyObject) {
        present(imagePickerController, animated: true, completion: nil)
    }

    private func setScrollOffset(_ scrollView: UIScrollView) {
        let visiblePageNumber = Int(scrollView.contentOffset.x / (scrollView.frame.maxX))
        let scrollViewContentOffsetX = Int(scrollView.contentOffset.x)
        let minXOfVisiblePage = Int(imageStackView.arrangedSubviews[visiblePageNumber].frame.minX)
        let maxXOfVisiblePage = Int(imageStackView.arrangedSubviews[visiblePageNumber].frame.maxX)
        let midXOfVisiblePage = Int((maxXOfVisiblePage + minXOfVisiblePage) / 2)
        let stackViewSpacing = Int(imageStackView.spacing)
        if scrollViewContentOffsetX < midXOfVisiblePage {
            let margin = visiblePageNumber != 0 ? stackViewSpacing + 15 : 0
            scrollView.setContentOffset(CGPoint(x: minXOfVisiblePage - margin, y:0), animated: true)
            visiblePage.text = String(visiblePageNumber)
        } else {
            scrollView.setContentOffset(CGPoint(x: maxXOfVisiblePage - stackViewSpacing, y:0), animated: true)
            visiblePage.text = String(visiblePageNumber + 1)
        }
        self.visiblePage.alpha = 1
    }
}
