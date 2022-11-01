//
//  AnimationViewController.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit

class AnimationViewController: UIViewController {
    
    // MARK: - Properties
    var location = CGPoint(x: 0, y: 0)
    
    // MARK: - Views
    private let logoImageView = UIImageView()
    private let fadeButton = UIButton()
    private var imageView = UIImageView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        view.backgroundColor = UIColor(named: "view")
        styleNavigationBar()
        style()
        layout()
        activateFadeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateImage()
        animateBorderColorPulse()
    }
}

// MARK: - Animation
extension AnimationViewController {
    @objc private func didPressFade(_ sender: Any) {
        let imageHide = logoImageView.alpha == 1
        
        if imageHide {
            UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.logoImageView.alpha = 0.0
            }, completion: nil)
            fadeButton.setTitle("FADE IN", for: .normal)
           
        } else {
            UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.logoImageView.alpha = 1.0
            }, completion: nil)
            fadeButton.setTitle("FADE OUT", for: .normal)
        }
    }
    
    private func activateFadeButton() {
        fadeButton.addTarget(self, action: #selector(didPressFade), for: .primaryActionTriggered)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        location = touch.location(in: self.view)
        logoImageView.center = location
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        location = touch.location(in: self.view)
        logoImageView.center = location
    }
    
    private func boundsKeyFrameAnimation() -> CAKeyframeAnimation {
        let bounce = CAKeyframeAnimation(keyPath: "position")
        bounce.duration = 3
        bounce.values = [
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 - 45, y: UIScreen.main.bounds.height/2 + 45)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 - 50, y: UIScreen.main.bounds.height/2 - 50)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 + 45, y: UIScreen.main.bounds.height/2 - 45)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 + 50, y: UIScreen.main.bounds.height/2 + 50)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 - 45, y: UIScreen.main.bounds.height/2 + 45)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width + 200, y: UIScreen.main.bounds.height + 200))
        ]
        bounce.keyTimes =  [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        return bounce
    }
    
    private func animateBorderColorPulse() {
        let colorFade = CABasicAnimation(keyPath: "borderColor")
        colorFade.fromValue = UIColor.red.cgColor
        colorFade.toValue = UIColor.cyan.cgColor
        colorFade.duration = 1
        colorFade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        colorFade.speed = 1
        colorFade.repeatCount = .infinity
        colorFade.autoreverses = true
        
        fadeButton.layer.add(colorFade, forKey: nil)
    }
    
    private func animateImage() {
        imageView.layer.add(boundsKeyFrameAnimation(), forKey: "bounce")
    }
}

// MARK: - Helper Methods
extension AnimationViewController {
    private func style() {
        // rapptrImageView
        logoImageView.image = UIImage(named: "ic_logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "person")
        
        // fadeButton
        fadeButton.setTitle("FADE OUT", for: .normal)
        fadeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        fadeButton.tintColor = UIColor(named: "view")
        fadeButton.backgroundColor = UIColor(named: "button")
        fadeButton.layer.borderWidth = 3
        fadeButton.layer.borderColor = UIColor.white.cgColor
        fadeButton.clipsToBounds = true
        fadeButton.layer.cornerRadius = 8
        fadeButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        view.addSubview(logoImageView)
        view.addSubview(imageView)
        view.addSubview(fadeButton)
        
        NSLayoutConstraint.activate([
            // rapptrImageView
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 30),
            logoImageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 8),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // imageView
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 20),
            imageView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 20),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            // fadeButton
            view.bottomAnchor.constraint(equalTo: fadeButton.bottomAnchor, constant: 30),
            fadeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: fadeButton.trailingAnchor, constant: 30),
            fadeButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
