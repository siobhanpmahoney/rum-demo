/*
 * Unless explicitly stated otherwise all files in this repository are licensed under the Apache License Version 2.0.
 * This product includes software developed at Datadog (https://www.datadoghq.com/).
 * Copyright 2019-2020 Datadog, Inc.
 */

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
    }

    @IBAction func didTapLoadRandomImage(_ sender: Any) {
        activityIndicatorView.isHidden = false
        imageView.image = nil

        let urlString = "https://cataas.com/cat?avoid_caching=\(Int.random(in: 0..<9999))" // randomize query so requests are not cached
        let url = URL(string: urlString)!

        // Define network task with its completion handler:
        let downloadTask = urlSession.dataTask(with: url) { [weak self] data, response, error in
            var image: UIImage?

            if let responseData = data {
                image = UIImage(data: responseData)
            } else if let networkError = error {
                print("🔥 Network request failed with error: \(networkError)")
            }

            // Switch to the main thread for updating UI:
            DispatchQueue.main.async {
                self?.activityIndicatorView.isHidden = true
                self?.imageView.image = image
            }
        }

        // Start the network task:
        downloadTask.resume()
    }

    @IBAction func didTapDismiss(_ sender: Any) {
        dismiss(animated: true)
    }
}
