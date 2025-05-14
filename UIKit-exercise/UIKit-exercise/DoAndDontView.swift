//
//  DoAndDontView.swift
//  UIKit-exercise
//
//  Created by Tamar Cohen on 14/05/2025.
//

import UIKit
import SnapKit

class DoAndDontView: UIViewController {

  private let containerView = UIView()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Add your best pics"
    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.numberOfLines = 0
    return label
  }()

  private let bodyLabel: UILabel = {
    let label = UILabel()
    label.text = """
          Select 10–15 photos that show only your face. Include a mix of angles, expressions, lighting, and locations.
          
          Pro tip: Choose pictures with how you normally do your makeup and hair for most accurate results.
          """
    label.font = UIFont.systemFont(ofSize: 14)
    label.numberOfLines = 0
    label.textColor = .darkGray
    return label
  }()

  private let goodImageContainer = UIStackView()
  private let badImageContainer = UIStackView()
  private let goodImageViews: [UIImageView] = (0..<3).map { _ in UIImageView() }
  private let badImageViews: [UIImageView] = (0..<3).map { _ in UIImageView() }
  private let checkmarks: [UIImageView] = (0..<3).map { _ in UIImageView() }
  private let crossmarks: [UIImageView] = (0..<3).map { _ in UIImageView() }

  private let uploadButton = UIButton(type: .system)



  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupText()
    setupGoodImageRow()
    setupBadImageRow()
    setupUploadButton()
  }


  private func setupText() {
    view.addSubview(containerView)

    containerView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
      make.left.equalToSuperview().offset(9)
      make.width.equalTo(375)
      make.height.equalTo(156)
    }

    containerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.left.right.equalToSuperview().inset(24)
      make.width.equalTo(327)
      make.height.equalTo(40)
    }

    containerView.addSubview(bodyLabel)
    bodyLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.left.right.equalToSuperview().inset(24)
    }
  }

  private func setupGoodImageRow() {
    view.addSubview(goodImageContainer)

    goodImageContainer.axis = .horizontal
    goodImageContainer.alignment = .fill
    goodImageContainer.distribution = .equalSpacing
    goodImageContainer.spacing = 12
    goodImageContainer.snp.makeConstraints { make in
      make.top.equalTo(containerView.snp.bottom).offset(42)
      make.centerX.equalToSuperview()
      make.width.equalTo(305)
      make.height.equalTo(161)
    }

    for (index, imageView) in goodImageViews.enumerated() {
      let container = UIView()
      container.clipsToBounds = false
      imageView.backgroundColor = .lightGray // placeholder

      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = 12.6
      container.addSubview(imageView)

      imageView.snp.makeConstraints { make in
        make.top.left.right.equalToSuperview()
        make.width.equalTo(94)
        make.height.equalTo(148)
      }

      // ✅ Add checkmark overlay
      let check = checkmarks[index]
      check.image = UIImage(systemName: "checkmark.circle.fill")

      check.tintColor = .systemGreen
      check.clipsToBounds = true
      container.addSubview(check)

      check.snp.makeConstraints { make in
        make.centerX.equalTo(imageView)
        make.bottom.equalToSuperview().inset(4)
        make.width.height.equalTo(16.86)
      }

      goodImageContainer.addArrangedSubview(container)
    }
  }

  private func setupBadImageRow() {
    view.addSubview(badImageContainer)

    badImageContainer.axis = .horizontal
    badImageContainer.alignment = .fill
    badImageContainer.distribution = .equalSpacing
    badImageContainer.spacing = 12
    badImageContainer.snp.makeConstraints { make in
      make.top.equalTo(containerView.snp.bottom).offset(230)
      make.centerX.equalToSuperview()
      make.width.equalTo(305)
      make.height.equalTo(161)
    }

    for (index, imageView) in badImageViews.enumerated() {
      let container = UIView()
      container.clipsToBounds = false
      imageView.backgroundColor = .lightGray // placeholder

      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = 12.6
      container.addSubview(imageView)

      imageView.snp.makeConstraints { make in
        make.top.left.right.equalToSuperview()
        make.width.equalTo(94)
        make.height.equalTo(148)
      }

      let cross = crossmarks[index]
      cross.image = UIImage(systemName: "xmark.circle.fill")

      cross.tintColor = .systemRed
      cross.clipsToBounds = true
      container.addSubview(cross)

      cross.snp.makeConstraints { make in
        make.centerX.equalTo(imageView)
        make.bottom.equalToSuperview().inset(4)
        make.bottom.equalToSuperview()
        make.width.height.equalTo(16.86)
      }

      badImageContainer.addArrangedSubview(container)
    }
  }

  private func setupUploadButton() {
      view.addSubview(uploadButton)
      uploadButton.setTitle("Upload photos", for: .normal)
      uploadButton.setTitleColor(.white, for: .normal)
      uploadButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
      uploadButton.backgroundColor = UIColor(red: 35/255, green: 56/255, blue: 83/255, alpha: 1)
      uploadButton.layer.cornerRadius = 24

      uploadButton.snp.makeConstraints { make in
//          make.top.equalToSuperview().offset(32)
          make.centerX.equalToSuperview()
          make.height.equalTo(48)
          make.width.equalTo(361)
          make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
      }
  }

}
