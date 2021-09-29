//
//  UnderlineSegmentedControl.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/28/21.
//

import UIKit

final class UnderlineSegmentedControl: UISegmentedControl {
    func removeBorders(backgroundColor: UIColor, titleColor: UIColor, selectedColor: UIColor) {
        let backgroundImage = UIImage.getColoredRectImageWith(color: backgroundColor.cgColor, andSize: self.bounds.size)
                self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
                self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
                self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)

                let deviderImage = UIImage.getColoredRectImageWith(
                    color: backgroundColor.cgColor,
                    andSize: CGSize(width: 1.0,
                                    height: self.bounds.size.height))
                self.setDividerImage(
                    deviderImage,
                    forLeftSegmentState: .selected,
                    rightSegmentState: .normal,
                    barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor], for: .selected)
    }

    func addUnderlineForSelectedSegment(backgroundColor: UIColor, titleColor: UIColor, selectedColor: UIColor){
        removeBorders(backgroundColor: backgroundColor, titleColor: titleColor, selectedColor: selectedColor)
        let underlineWidth: CGFloat = UIScreen.main.bounds.width / CGFloat(self.numberOfSegments)
           let underlineHeight: CGFloat = 2.0
           let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
           let underLineYPosition = self.bounds.size.height - 2.0
           let underlineFrame = CGRect(
            x: underlineXPosition,
            y: underLineYPosition,
            width: underlineWidth,
            height: underlineHeight)
           let underline = UIView(frame: underlineFrame)
           underline.backgroundColor = selectedColor
           underline.tag = 1
           self.addSubview(underline)
       }

       func changeUnderlinePosition(){
           guard let underline = self.viewWithTag(1) else {return}
           let underlineFinalXPosition = (
            self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
           UIView.animate(withDuration: 0.1, animations: {
               underline.frame.origin.x = underlineFinalXPosition
           })
       }
   }
