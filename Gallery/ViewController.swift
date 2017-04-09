import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!

    let imagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
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
                               constant: 200)
        let widthConstraint =
            NSLayoutConstraint(item: imageView  ,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 200)
        imageView.addConstraint(heightConstraint)
        imageView.addConstraint(widthConstraint)
        imageStackView.addArrangedSubview(imageView)
        imagePickerController.dismiss(animated: true, completion: nil)
        view.layoutIfNeeded()
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }

    @IBAction func browseButtonTapped(_ sender: AnyObject) {
        present(imagePickerController, animated: true, completion: nil)
    }
}
