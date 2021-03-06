//
//  PWSwitch.swift
//  Pods
//
//  Created by Nikita on 30/08/16.
//

import Foundation
import UIKit

private extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

@IBDesignable
open class PWSwitch: UIControl {
    
    var backLayer: CALayer!
    var thumbLayer: CALayer!
    var labelOff: UILabel!
    var labelOn: UILabel!
    
    open var on = false
    
    /// UIAppearance compatible property
    @IBInspectable open dynamic var trackOffBorderColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._trackOffBorderColor }
        set {
            self._trackOffBorderColor = newValue
            self.backLayer.borderColor = _trackOffBorderColor?.cgColor
        }
    }
    fileprivate var _trackOffBorderColor: UIColor?
    
    @IBInspectable open dynamic var trackOffPushBorderColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._trackOffPushBorderColor }
        set {
            self._trackOffPushBorderColor = newValue
        }
    }
    fileprivate var _trackOffPushBorderColor: UIColor?
    
    
    @IBInspectable open dynamic var trackOffFillColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._trackOffFillColor }
        set {
            self._trackOffFillColor = newValue
            self.backLayer.backgroundColor = _trackOffFillColor?.cgColor
        }
    }
    fileprivate var _trackOffFillColor: UIColor?
    
    @IBInspectable open dynamic var thumbOffBorderColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._thumbOffBorderColor }
        set {
            self._thumbOffBorderColor = newValue
            self.thumbLayer.borderColor = _thumbOffBorderColor?.cgColor
        }
    }
    fileprivate var _thumbOffBorderColor: UIColor?
    
    @IBInspectable open dynamic var thumbOffPushBorderColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._thumbOffPushBorderColor }
        set {
            self._thumbOffPushBorderColor = newValue
        }
    }
    fileprivate var _thumbOffPushBorderColor: UIColor?
    
    @IBInspectable open dynamic var thumbOffFillColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._thumbOffFillColor }
        set {
            self._thumbOffFillColor = newValue
            self.thumbLayer.backgroundColor = _thumbOffFillColor?.cgColor
        }
    }
    fileprivate var _thumbOffFillColor: UIColor?
    
    @IBInspectable open dynamic var trackOnFillColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._trackOnFillColor }
        set {
            self._trackOnFillColor = newValue
        }
    }
    fileprivate var _trackOnFillColor: UIColor?
    
    @IBInspectable open dynamic var trackOnBorderColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._trackOnBorderColor }
        set {
            self._trackOnBorderColor = newValue
        }
    }
    fileprivate var _trackOnBorderColor: UIColor?
    
    
    @IBInspectable open dynamic var thumbOnBorderColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._thumbOnBorderColor }
        set {
            self._thumbOnBorderColor = newValue
        }
    }
    fileprivate var _thumbOnBorderColor: UIColor?
    
    
    @IBInspectable open dynamic var thumbOnFillColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._thumbOnFillColor }
        set {
            self._thumbOnFillColor = newValue
        }
    }
    fileprivate var _thumbOnFillColor: UIColor?
    
    
    @IBInspectable open dynamic var thumbDiameter: CGFloat { // UI_APPEARANCE_SELECTOR
        get { return self._thumbDiameter }
        set {
            self._thumbDiameter = newValue
            
            self.thumbLayer.frame = getThumbOffRect()
            self.thumbLayer.cornerRadius = thumbDiameter / 2
        }
    }
    fileprivate var _thumbDiameter: CGFloat
    
    @IBInspectable open dynamic var cornerRadius: CGFloat { // UI_APPEARANCE_SELECTOR
        get { return self._cornerRadius }
        set {
            self._cornerRadius = newValue
            self.backLayer.cornerRadius = _cornerRadius
        }
    }
    fileprivate var _cornerRadius: CGFloat
    
    @IBInspectable open dynamic var thumbCornerRadius: CGFloat { // UI_APPEARANCE_SELECTOR
        get { return self._thumbCornerRadius }
        set {
            self._thumbCornerRadius = newValue
            self.thumbLayer.cornerRadius = _thumbCornerRadius
        }
    }
    fileprivate var _thumbCornerRadius: CGFloat
    
    @IBInspectable open dynamic var shouldFillOnPush: Bool { // UI_APPEARANCE_SELECTOR
        get { return self._shouldFillOnPush }
        set {
            self._shouldFillOnPush = newValue
        }
    }
    fileprivate var _shouldFillOnPush: Bool
    
    @IBInspectable open dynamic var trackInset: CGFloat { // UI_APPEARANCE_SELECTOR
        get { return self._trackInset }
        set {
            self._trackInset = newValue
        }
    }
    fileprivate var _trackInset: CGFloat
    
    
    @IBInspectable open dynamic var thumbShadowColor: UIColor? { // UI_APPEARANCE_SELECTOR
        get { return self._thumbShadowColor }
        set {
            self._thumbShadowColor = newValue
            
            self.thumbLayer.shadowColor = _thumbShadowColor?.cgColor
        }
    }
    fileprivate var _thumbShadowColor: UIColor?
    
    @IBInspectable open dynamic var shadowStrength: CGFloat { // UI_APPEARANCE_SELECTOR
        get { return self._shadowStrength }
        set {
            self._shadowStrength = newValue
            
            self.thumbLayer.shadowOffset = CGSize(width: 0, height: 1.5 * _shadowStrength)
            self.thumbLayer.shadowRadius = 0.6 * (_shadowStrength * 2)
        }
    }
    fileprivate var _shadowStrength: CGFloat
    
    @IBInspectable open dynamic var thumbWidth: CGFloat { // UI_APPEARANCE_SELECTOR
        get { return self._thumbWidth }
        set {
            self._thumbWidth = newValue
            self.thumbLayer.frame = getThumbOffRect()
        }
    }
    fileprivate var _thumbWidth: CGFloat
    
    @IBInspectable open dynamic var showLabel: Bool { // UI_APPEARANCE_SELECTOR
        get { return self._showLabel }
        set {
            self._showLabel = newValue
            self.labelOff.isHidden = !newValue
            self.labelOn.isHidden = !newValue
        }
    }
    fileprivate var _showLabel: Bool
    
    @IBInspectable open dynamic var offText: String { // UI_APPEARANCE_SELECTOR
        get { return self._offText }
        set {
            self._offText = newValue
            self.labelOff.text = newValue
            self.labelOff.frame = CGRect(x: 0, y: 0, width: _offText.width(withConstrainedHeight: 40, font: _labelFont), height: 40)
        }
    }
    fileprivate var _offText: String
    
    @IBInspectable open dynamic var offLabelColorForOff: UIColor { // UI_APPEARANCE_SELECTOR
        get { return self._offLabelColorForOff }
        set {
            self._offLabelColorForOff = newValue
        }
    }
    fileprivate var _offLabelColorForOff: UIColor
    
    @IBInspectable open dynamic var offLabelColorForOn: UIColor { // UI_APPEARANCE_SELECTOR
        get { return self._offLabelColorForOn }
        set {
            self._offLabelColorForOn = newValue
        }
    }
    fileprivate var _offLabelColorForOn: UIColor
    
    @IBInspectable open dynamic var onText: String { // UI_APPEARANCE_SELECTOR
        get { return self._onText }
        set {
            self._onText = newValue
            self.labelOn.text = newValue
            self.labelOn.frame = CGRect(x: 0, y: 0, width: _onText.width(withConstrainedHeight: 40, font: _labelFont), height: 40)
        }
    }
    fileprivate var _onText: String
    
    @IBInspectable open dynamic var onLabelColorForOff: UIColor {
        get { return self._onLabelColorForOff }
        set {
            self._onLabelColorForOff = newValue
        }
    }
    fileprivate var _onLabelColorForOff: UIColor
    
    @IBInspectable open dynamic var onLabelColorForOn: UIColor {
        get { return self._onLabelColorForOn }
        set {
            self._onLabelColorForOn = newValue
        }
    }
    fileprivate var _onLabelColorForOn: UIColor
    
    
    @IBInspectable open dynamic var labelFont: UIFont { // UI_APPEARANCE_SELECTOR
        get { return self._labelFont }
        set {
            self._labelFont = newValue
            self.labelOn.frame = CGRect(x: 0, y: 0, width: _offText.width(withConstrainedHeight: 40, font: _labelFont), height: 40)
            self.labelOff.frame = CGRect(x: 0, y: 0, width: _onText.width(withConstrainedHeight: 40, font: _labelFont), height: 40)
        }
    }
    fileprivate var _labelFont: UIFont
    
    let thumbDelta:CGFloat = 0
    
    let scale = UIScreen.main.scale
    
    override public init(frame: CGRect) {
        self._thumbDiameter = 14
        self._cornerRadius = 20
        self._thumbCornerRadius = 7
        self._shouldFillOnPush = true
        self._trackInset = 0
        self._shadowStrength = 1
        self._thumbWidth = 10
        self._onText = ""
        self._onLabelColorForOn = .black
        self._onLabelColorForOff = .black
        self._offText = ""
        self._offLabelColorForOn = .black
        self._offLabelColorForOff = .black
        self._labelFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)!
        self._showLabel = false
        
        super.init(frame: frame)
        
        baseInit()
    }
    
    required public init(coder aDecoder: NSCoder) {
        self._thumbDiameter = 14
        self._cornerRadius = 20
        self._thumbCornerRadius = 7
        self._shouldFillOnPush = true
        self._trackInset = 0
        self._shadowStrength = 1
        self._thumbWidth = 14
        self._onText = ""
        self._onLabelColorForOn = .black
        self._onLabelColorForOff = .black
        self._offText = ""
        self._offLabelColorForOn = .black
        self._offLabelColorForOff = .black
        self._labelFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)!
        self._showLabel = false
        
        super.init(coder: aDecoder)!
        
        baseInit()
    }
    
    public init() {
        self._thumbDiameter = 14
        self._cornerRadius = 20
        self._thumbCornerRadius = 7
        self._shouldFillOnPush = true
        self._trackInset = 0
        self._shadowStrength = 1
        self._thumbWidth = 14
        self._onText = ""
        self._onLabelColorForOn = .black
        self._onLabelColorForOff = .black
        self._offText = ""
        self._offLabelColorForOn = .black
        self._offLabelColorForOff = .black
        self._labelFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)!
        self._showLabel = false
        
        super.init(frame: CGRect.zero)
        
        baseInit()
    }
    
    fileprivate func baseInit() {
        clipsToBounds = false
        
        //init default style
        self._trackOffBorderColor = UIColorFromRGB(0xB1BBC3)
        self._trackOffPushBorderColor = UIColorFromRGB(0xE0E4E9)
        self._trackOffFillColor = UIColor.clear
        self._trackOnBorderColor = UIColorFromRGB(0xFFB831)
        self._trackOnFillColor = UIColor.clear
        self._thumbOffBorderColor = UIColorFromRGB(0xB1BBC3)
        self._thumbOffPushBorderColor = UIColorFromRGB(0xB1BBC3)
        self._thumbOnBorderColor = UIColorFromRGB(0xF0AA26)
        self._thumbOffFillColor = UIColorFromRGB(0xFFFFFF)
        self._thumbOnFillColor = UIColorFromRGB(0xFFFFFF)
        self._thumbShadowColor = UIColorFromRGB(0x919CA6).withAlphaComponent(0.26)
        self._thumbWidth = 14
        
        backLayer = CALayer()
        backLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 26)
        backLayer.cornerRadius = _cornerRadius
        backLayer.borderWidth = 1
        backLayer.borderColor = _trackOffBorderColor?.cgColor
        backLayer.backgroundColor = _trackOffFillColor?.cgColor
        layer.addSublayer(backLayer)
        
        thumbLayer = CALayer()
        thumbLayer.frame = getThumbOffRect()
        thumbLayer.cornerRadius = _thumbCornerRadius
        thumbLayer.backgroundColor = _thumbOffFillColor?.cgColor
        thumbLayer.borderWidth = 1
        thumbLayer.shadowOffset = CGSize(width: 0, height: 1.5 * _shadowStrength)
        thumbLayer.shadowRadius = 0.6 * (_shadowStrength * 2)
        thumbLayer.shadowColor = _thumbShadowColor?.cgColor
        thumbLayer.shadowOpacity = 1
        thumbLayer.borderColor = _thumbOffBorderColor?.cgColor
        
        labelOff = UILabel(frame: CGRect(x: 0, y: 0, width: _offText.width(withConstrainedHeight: 40, font: _labelFont), height: 26))
        labelOff.text = _offText
        labelOff.textColor = _offLabelColorForOff
        labelOff.font = _labelFont
        labelOff.center = CGPoint(x: getThumbOffRect().midX, y: getThumbOffRect().midY)
        labelOff.isHidden = !_showLabel
        
        labelOn = UILabel(frame: CGRect(x: 0, y: 0, width: _onText.width(withConstrainedHeight: 40, font: _labelFont), height: 26))
        labelOn.text = _onText
        labelOn.textColor = _onLabelColorForOff
        labelOn.font = _labelFont
        labelOn.center = CGPoint(x: getThumbOnRect().midX, y: getThumbOnRect().midY)
        labelOn.isHidden = !_showLabel
        layer.addSublayer(thumbLayer)
        
        self.addSubview(labelOff)
        self.addSubview(labelOn)
    }
    
    override open var intrinsicContentSize : CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.733, height: 40)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        backLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        labelOff.center = CGPoint(x: getThumbOffRect().midX, y: getThumbOffRect().midY)
        labelOn.center = CGPoint(x: getThumbOnRect().midX, y: getThumbOnRect().midY)
        
        if (on) {
            thumbLayer.frame = getThumbOnRect()
            
            if (shouldFillOnPush) {
                backLayer.borderWidth = frame.height / 2
            }
            
        } else {
            thumbLayer.frame = getThumbOffRect()
        }
    }
    
    fileprivate func getThumbOffRect() -> CGRect {
        if showLabel {
            return CGRect(x: 0, y: (frame.height - thumbDiameter)/2.0, width: thumbWidth, height: thumbDiameter)
        }
        return CGRect(x: (frame.height - thumbDiameter)/2.0, y: (frame.height - thumbDiameter)/2.0, width: thumbDiameter, height: thumbDiameter)
    }
    
    fileprivate func getThumbOffPushRect() -> CGRect {
        if showLabel {
            return CGRect(x: (frame.height - thumbDiameter)/2.0, y: (frame.height - thumbDiameter)/2.0, width: thumbWidth, height: thumbDiameter)
        }
        return CGRect(x: (frame.height - thumbDiameter)/2.0, y: (frame.height - thumbDiameter)/2.0, width: thumbDiameter + thumbDelta, height: thumbDiameter)
    }
    
    fileprivate func getThumbOnRect() -> CGRect {
        if showLabel {
            return CGRect(x: frame.width - thumbWidth, y: (frame.height - thumbDiameter)/2.0, width: thumbWidth, height: thumbDiameter)
        }
        return CGRect(x: frame.width - thumbDiameter - ((frame.height - thumbDiameter)/2.0), y: (frame.height - thumbDiameter)/2.0, width: thumbDiameter, height: thumbDiameter)
    }
    
    fileprivate func getThumbOffPos() -> CGPoint {
        if showLabel {
            return CGPoint(x: frame.origin.x + 2, y: frame.height/2.0)
        }
        return CGPoint(x: frame.height/2.0, y: frame.height/2.0)
    }
    
    fileprivate func getThumbOffPushPos() -> CGPoint {
        if showLabel {
            return CGPoint(x: frame.origin.x - 2, y: frame.height/2.0)
        }
        return CGPoint(x: frame.height/2.0 + thumbDelta - 3, y: frame.height/2.0)
    }
    
    fileprivate func getThumbOnPos() -> CGPoint {
        if showLabel {
            return CGPoint(x:frame.origin.x + frame.width - thumbWidth + 2, y: frame.height/2.0)
        }
        return CGPoint(x: frame.width - frame.height/2.0, y: frame.height/2.0)
    }
    
    fileprivate func getThumbOnPushPos() -> CGPoint {
        if showLabel {
            return CGPoint(x: frame.origin.x + frame.width - thumbWidth + 6, y: frame.height/2.0)
        }
        return CGPoint(x: (frame.width - frame.height/2.0) - thumbDelta + 3, y: frame.height/2.0)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if (on) {
            let thumbBoundsAnimation = CABasicAnimation(keyPath: "bounds")
            thumbBoundsAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
            thumbBoundsAnimation.fromValue = NSValue(cgRect: getThumbOffRect())
            thumbBoundsAnimation.toValue = NSValue(cgRect: getThumbOffPushRect())
            thumbBoundsAnimation.fillMode = kCAFillModeForwards
            thumbBoundsAnimation.duration = 0.25
            thumbBoundsAnimation.isRemovedOnCompletion = false
            
            let thumbPosAnimation = CABasicAnimation(keyPath: "position")
            thumbPosAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
            thumbPosAnimation.fromValue = NSValue(cgPoint: getThumbOnPos())
            thumbPosAnimation.toValue = NSValue(cgPoint: getThumbOnPushPos())
            thumbPosAnimation.fillMode = kCAFillModeForwards
            thumbPosAnimation.duration = 0.25
            thumbPosAnimation.isRemovedOnCompletion = false
            
            let thumbBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
            thumbBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
            thumbBorderColorAnimation.fromValue = thumbOnBorderColor?.cgColor
            thumbBorderColorAnimation.toValue = thumbOnBorderColor?.cgColor
            thumbBorderColorAnimation.fillMode = kCAFillModeForwards
            thumbBorderColorAnimation.duration = 0.25
            thumbBorderColorAnimation.isRemovedOnCompletion = false
            
            let thumbFillColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
            thumbFillColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
            thumbFillColorAnimation.fromValue = thumbOnFillColor?.cgColor
            thumbFillColorAnimation.toValue = thumbOnFillColor?.cgColor
            thumbFillColorAnimation.fillMode = kCAFillModeForwards
            thumbFillColorAnimation.duration = 0.25
            thumbFillColorAnimation.isRemovedOnCompletion = false
            
            let animThumbGroup = CAAnimationGroup()
            animThumbGroup.duration = 0.25
            animThumbGroup.fillMode = kCAFillModeForwards
            animThumbGroup.isRemovedOnCompletion = false
            animThumbGroup.animations = [thumbBoundsAnimation, thumbPosAnimation, thumbBorderColorAnimation, thumbFillColorAnimation]
            
            thumbLayer.removeAllAnimations()
            thumbLayer.add(animThumbGroup, forKey: "thumbAnimation")
            
        } else {
            let bgBorderAnimation = CABasicAnimation(keyPath: "borderWidth")
            bgBorderAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
            bgBorderAnimation.fromValue = 1
            bgBorderAnimation.toValue = frame.height / 2
            bgBorderAnimation.fillMode = kCAFillModeForwards
            bgBorderAnimation.duration = 0.25
            bgBorderAnimation.isRemovedOnCompletion = false
            
            let bgBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
            bgBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
            bgBorderColorAnimation.fromValue = trackOffBorderColor?.cgColor
            bgBorderColorAnimation.toValue = trackOffPushBorderColor?.cgColor
            bgBorderColorAnimation.fillMode = kCAFillModeForwards
            bgBorderColorAnimation.duration = 0.25
            bgBorderColorAnimation.isRemovedOnCompletion = false
            
            let animGroup = CAAnimationGroup()
            animGroup.duration = 0.25
            animGroup.fillMode = kCAFillModeForwards
            animGroup.isRemovedOnCompletion = false
            animGroup.animations = [bgBorderColorAnimation]
            
            if (shouldFillOnPush) {
                animGroup.animations?.append(bgBorderAnimation)
            }
            
            backLayer.add(animGroup, forKey: "bgAnimation")
            
            let thumbBoundsAnimation = CABasicAnimation(keyPath: "bounds")
            thumbBoundsAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
            thumbBoundsAnimation.fromValue = NSValue(cgRect: getThumbOffRect())
            thumbBoundsAnimation.toValue = NSValue(cgRect: getThumbOffPushRect())
            thumbBoundsAnimation.fillMode = kCAFillModeForwards
            thumbBoundsAnimation.duration = 0.25
            thumbBoundsAnimation.isRemovedOnCompletion = false
            
            let thumbPosAnimation = CABasicAnimation(keyPath: "position")
            thumbPosAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
            thumbPosAnimation.fromValue = NSValue(cgPoint: getThumbOffPos())
            thumbPosAnimation.toValue = NSValue(cgPoint: getThumbOffPushPos())
            thumbPosAnimation.fillMode = kCAFillModeForwards
            thumbPosAnimation.duration = 0.25
            thumbPosAnimation.isRemovedOnCompletion = false
            
            let thumbBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
            thumbBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
            thumbBorderColorAnimation.fromValue = thumbOffBorderColor?.cgColor
            thumbBorderColorAnimation.toValue = thumbOffPushBorderColor?.cgColor
            thumbBorderColorAnimation.fillMode = kCAFillModeForwards
            thumbBorderColorAnimation.duration = 0.25
            thumbBorderColorAnimation.isRemovedOnCompletion = false
            
            let animThumbGroup = CAAnimationGroup()
            animThumbGroup.duration = 0.25
            animThumbGroup.fillMode = kCAFillModeForwards
            animThumbGroup.isRemovedOnCompletion = false
            animThumbGroup.animations = [thumbBoundsAnimation, thumbPosAnimation, thumbBorderColorAnimation]
            
            thumbLayer.add(animThumbGroup, forKey: "thumbAnimation")
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touchPoint = touches.first?.location(in: self)
        if (self.bounds.contains(touchPoint!)) {
            if (on) {
                onToOffAnim()
            } else {
                offToOnAnim()
            }
            
            self.on = !self.on
            
            self.sendActions(for: UIControlEvents.valueChanged)
            
        } else {
            if (on) {
                let thumbBoundsAnimation = CABasicAnimation(keyPath: "bounds")
                thumbBoundsAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
                thumbBoundsAnimation.fromValue = NSValue(cgRect: getThumbOffPushRect())
                thumbBoundsAnimation.toValue = NSValue(cgRect: getThumbOffRect())
                thumbBoundsAnimation.fillMode = kCAFillModeForwards
                thumbBoundsAnimation.duration = 0.25
                thumbBoundsAnimation.isRemovedOnCompletion = false
                
                let thumbPosAnimation = CABasicAnimation(keyPath: "position")
                thumbPosAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
                thumbPosAnimation.fromValue = NSValue(cgPoint: getThumbOnPushPos())
                thumbPosAnimation.toValue = NSValue(cgPoint: getThumbOnPos())
                thumbPosAnimation.fillMode = kCAFillModeForwards
                thumbPosAnimation.duration = 0.25
                thumbPosAnimation.isRemovedOnCompletion = false
                
                
                let thumbBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
                thumbBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
                thumbBorderColorAnimation.fromValue = thumbOnBorderColor?.cgColor
                thumbBorderColorAnimation.toValue = thumbOnBorderColor?.cgColor
                thumbBorderColorAnimation.fillMode = kCAFillModeForwards
                thumbBorderColorAnimation.duration = 0.25
                thumbBorderColorAnimation.isRemovedOnCompletion = false
                
                let thumbFillColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
                thumbFillColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
                thumbFillColorAnimation.fromValue = thumbOnFillColor?.cgColor
                thumbFillColorAnimation.toValue = thumbOnFillColor?.cgColor
                thumbFillColorAnimation.fillMode = kCAFillModeForwards
                thumbFillColorAnimation.duration = 0.25
                thumbFillColorAnimation.isRemovedOnCompletion = false
                
                let animThumbGroup = CAAnimationGroup()
                animThumbGroup.duration = 0.25
                animThumbGroup.fillMode = kCAFillModeForwards
                animThumbGroup.isRemovedOnCompletion = false
                animThumbGroup.animations = [thumbBoundsAnimation, thumbPosAnimation, thumbBorderColorAnimation, thumbFillColorAnimation]
                
                thumbLayer.removeAllAnimations()
                thumbLayer.add(animThumbGroup, forKey: "thumbAnimation")
                labelOn.textColor = _onLabelColorForOn
                labelOff.textColor = _offLabelColorForOn
            } else {
                let bgBorderAnimation = CABasicAnimation(keyPath: "borderWidth")
                bgBorderAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
                bgBorderAnimation.fromValue = frame.height / 2
                bgBorderAnimation.toValue = 1
                bgBorderAnimation.fillMode = kCAFillModeForwards
                bgBorderAnimation.duration = 0.25
                bgBorderAnimation.isRemovedOnCompletion = false
                
                let bgBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
                bgBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
                bgBorderColorAnimation.fromValue = trackOffPushBorderColor?.cgColor
                bgBorderColorAnimation.toValue = trackOffBorderColor?.cgColor
                bgBorderColorAnimation.fillMode = kCAFillModeForwards
                bgBorderColorAnimation.duration = 0.25
                bgBorderColorAnimation.isRemovedOnCompletion = false
                
                let animGroup = CAAnimationGroup()
                animGroup.duration = 0.25
                animGroup.fillMode = kCAFillModeForwards
                animGroup.isRemovedOnCompletion = false
                animGroup.animations = [bgBorderColorAnimation]
                
                if (shouldFillOnPush) {
                    animGroup.animations?.append(bgBorderAnimation)
                }
                
                backLayer.removeAllAnimations()
                backLayer.add(animGroup, forKey: "bgAnimation")
                
                let thumbBoundsAnimation = CABasicAnimation(keyPath: "bounds")
                thumbBoundsAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
                thumbBoundsAnimation.fromValue = NSValue(cgRect: getThumbOffPushRect())
                thumbBoundsAnimation.toValue = NSValue(cgRect: getThumbOffRect())
                thumbBoundsAnimation.fillMode = kCAFillModeForwards
                thumbBoundsAnimation.duration = 0.25
                thumbBoundsAnimation.isRemovedOnCompletion = false
                
                let thumbPosAnimation = CABasicAnimation(keyPath: "position")
                thumbPosAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
                thumbPosAnimation.fromValue = NSValue(cgPoint: getThumbOffPushPos())
                thumbPosAnimation.toValue = NSValue(cgPoint: getThumbOffPos())
                thumbPosAnimation.fillMode = kCAFillModeForwards
                thumbPosAnimation.duration = 0.25
                thumbPosAnimation.isRemovedOnCompletion = false
                
                let thumbBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
                thumbBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
                thumbBorderColorAnimation.fromValue = thumbOffPushBorderColor?.cgColor
                thumbBorderColorAnimation.toValue = thumbOffBorderColor?.cgColor
                thumbBorderColorAnimation.fillMode = kCAFillModeForwards
                thumbBorderColorAnimation.duration = 0.25
                thumbBorderColorAnimation.isRemovedOnCompletion = false
                
                let animThumbGroup = CAAnimationGroup()
                animThumbGroup.duration = 0.25
                animThumbGroup.fillMode = kCAFillModeForwards
                animThumbGroup.isRemovedOnCompletion = false
                animThumbGroup.animations = [thumbBoundsAnimation, thumbPosAnimation, thumbBorderColorAnimation]
                
                thumbLayer.removeAllAnimations()
                thumbLayer.add(animThumbGroup, forKey: "thumbAnimation")
                labelOn.textColor = _onLabelColorForOff
                labelOff.textColor = _offLabelColorForOff
            }
        }
    }
    
    fileprivate func onToOffAnim() {
        let bgBorderAnimation = CABasicAnimation(keyPath: "borderWidth")
        bgBorderAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        bgBorderAnimation.fromValue = frame.height / 2
        bgBorderAnimation.toValue = 1
        bgBorderAnimation.fillMode = kCAFillModeForwards
        bgBorderAnimation.duration = 0.25
        bgBorderAnimation.isRemovedOnCompletion = false
        
        let bgBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        bgBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        bgBorderColorAnimation.fromValue = trackOnBorderColor?.cgColor
        bgBorderColorAnimation.toValue = trackOffBorderColor?.cgColor
        bgBorderColorAnimation.fillMode = kCAFillModeForwards
        bgBorderColorAnimation.duration = 0.25
        bgBorderColorAnimation.isRemovedOnCompletion = false
        
        let bgFillColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        bgFillColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        bgFillColorAnimation.fromValue = trackOnFillColor?.cgColor
        bgFillColorAnimation.toValue = trackOffFillColor?.cgColor
        bgFillColorAnimation.fillMode = kCAFillModeForwards
        bgFillColorAnimation.duration = 0.25
        bgFillColorAnimation.isRemovedOnCompletion = false
        
        let animGroup = CAAnimationGroup()
        animGroup.duration = 0.25
        animGroup.fillMode = kCAFillModeForwards
        animGroup.isRemovedOnCompletion = false
        animGroup.animations = [bgBorderColorAnimation, bgFillColorAnimation]
        
        if (shouldFillOnPush) {
            animGroup.animations?.append(bgBorderAnimation)
        }
        
        backLayer.removeAllAnimations()
        backLayer.add(animGroup, forKey: "bgAnimation")
        
        let thumbBoundsAnimation = CABasicAnimation(keyPath: "bounds")
        thumbBoundsAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        thumbBoundsAnimation.fromValue = NSValue(cgRect: getThumbOnRect())
        thumbBoundsAnimation.toValue = NSValue(cgRect: getThumbOffRect())
        thumbBoundsAnimation.fillMode = kCAFillModeForwards
        thumbBoundsAnimation.duration = 0.25
        thumbBoundsAnimation.isRemovedOnCompletion = false
        
        let thumbPosAnimation = CABasicAnimation(keyPath: "position")
        thumbPosAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        thumbPosAnimation.fromValue = NSValue(cgPoint: getThumbOnPushPos())
        thumbPosAnimation.toValue = NSValue(cgPoint: getThumbOffPos())
        thumbPosAnimation.fillMode = kCAFillModeForwards
        thumbPosAnimation.duration = 0.25
        thumbPosAnimation.isRemovedOnCompletion = false
        
        let thumbBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        thumbBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        thumbBorderColorAnimation.fromValue = thumbOnBorderColor?.cgColor
        thumbBorderColorAnimation.toValue = thumbOffBorderColor?.cgColor
        thumbBorderColorAnimation.fillMode = kCAFillModeForwards
        thumbBorderColorAnimation.duration = 0.25
        thumbBorderColorAnimation.isRemovedOnCompletion = false
        
        let thumbFillColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        thumbFillColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        thumbFillColorAnimation.fromValue = thumbOnFillColor?.cgColor
        thumbFillColorAnimation.toValue = thumbOffFillColor?.cgColor
        thumbFillColorAnimation.fillMode = kCAFillModeForwards
        thumbFillColorAnimation.duration = 0.25
        thumbFillColorAnimation.isRemovedOnCompletion = false
        
        let animThumbGroup = CAAnimationGroup()
        animThumbGroup.duration = 0.25
        animThumbGroup.fillMode = kCAFillModeForwards
        animThumbGroup.isRemovedOnCompletion = false
        animThumbGroup.animations = [thumbBoundsAnimation, thumbPosAnimation, thumbBorderColorAnimation, thumbFillColorAnimation]
        
        thumbLayer.removeAllAnimations()
        thumbLayer.add(animThumbGroup, forKey: "thumbAnimation")
        
        labelOn.textColor = _onLabelColorForOff
        labelOff.textColor = _offLabelColorForOff
        labelOff.center = CGPoint(x: getThumbOffRect().midX, y: getThumbOffRect().midY)
        labelOn.center = CGPoint(x: getThumbOnRect().midX, y: getThumbOnRect().midY)
    }
    
    fileprivate func offToOnAnim() {
        let bgBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        bgBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        bgBorderColorAnimation.fromValue = trackOffPushBorderColor?.cgColor
        bgBorderColorAnimation.toValue = trackOnBorderColor?.cgColor
        bgBorderColorAnimation.fillMode = kCAFillModeForwards
        bgBorderColorAnimation.duration = 0.25
        bgBorderColorAnimation.isRemovedOnCompletion = false
        
        let bgFillColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        bgFillColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        bgFillColorAnimation.fromValue = trackOffFillColor?.cgColor
        bgFillColorAnimation.toValue = trackOnFillColor?.cgColor
        bgFillColorAnimation.fillMode = kCAFillModeForwards
        bgFillColorAnimation.duration = 0.25
        bgFillColorAnimation.isRemovedOnCompletion = false
        
        let animTrackGroup = CAAnimationGroup()
        animTrackGroup.duration = 0.25
        animTrackGroup.fillMode = kCAFillModeForwards
        animTrackGroup.isRemovedOnCompletion = false
        animTrackGroup.animations = [bgBorderColorAnimation, bgFillColorAnimation]
        
        backLayer.add(animTrackGroup, forKey: "bgOffToOnAnimation")
        
        let thumbBoundsAnimation = CABasicAnimation(keyPath: "bounds")
        thumbBoundsAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        thumbBoundsAnimation.fromValue = NSValue(cgRect: getThumbOffRect())
        thumbBoundsAnimation.toValue = NSValue(cgRect: getThumbOnRect())
        thumbBoundsAnimation.fillMode = kCAFillModeForwards
        thumbBoundsAnimation.duration = 0.25
        thumbBoundsAnimation.isRemovedOnCompletion = false
        
        let thumbPosAnimation = CABasicAnimation(keyPath: "position")
        thumbPosAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        thumbPosAnimation.fromValue = NSValue(cgPoint: getThumbOffPushPos())
        thumbPosAnimation.toValue = NSValue(cgPoint: getThumbOnPos())
        thumbPosAnimation.fillMode = kCAFillModeForwards
        thumbPosAnimation.duration = 0.25
        thumbPosAnimation.isRemovedOnCompletion = false
        
        let thumbBorderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        thumbBorderColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        thumbBorderColorAnimation.fromValue = thumbOffPushBorderColor?.cgColor
        thumbBorderColorAnimation.toValue = thumbOnBorderColor?.cgColor
        thumbBorderColorAnimation.fillMode = kCAFillModeForwards
        thumbBorderColorAnimation.duration = 0.25
        thumbBorderColorAnimation.isRemovedOnCompletion = false
        
        let thumbFillColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        thumbFillColorAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        thumbFillColorAnimation.fromValue = thumbOffFillColor?.cgColor
        thumbFillColorAnimation.toValue = thumbOnFillColor?.cgColor
        thumbFillColorAnimation.fillMode = kCAFillModeForwards
        thumbFillColorAnimation.duration = 0.25
        thumbFillColorAnimation.isRemovedOnCompletion = false
        
        let animThumbGroup = CAAnimationGroup()
        animThumbGroup.duration = 0.25
        animThumbGroup.fillMode = kCAFillModeForwards
        animThumbGroup.isRemovedOnCompletion = false
        animThumbGroup.animations = [thumbBoundsAnimation, thumbPosAnimation, thumbBorderColorAnimation, thumbFillColorAnimation]
        
        thumbLayer.removeAllAnimations()
        thumbLayer.add(animThumbGroup, forKey: "thumbAnimation")
        
        labelOn.textColor = _onLabelColorForOn
        labelOff.textColor = _offLabelColorForOn
        labelOff.center = CGPoint(x: getThumbOffRect().midX, y: getThumbOffRect().midY)
        labelOn.center = CGPoint(x: getThumbOnRect().midX, y: getThumbOnRect().midY)
    }
    
    open func setOn(_ on: Bool, animated :Bool) {
        self.on = on
        if (animated) {
            if (on) {
                self.offToOnAnim()
            } else {
                self.onToOffAnim()
            }
        } else {
            if (on) {
                if (self.shouldFillOnPush) {
                    self.backLayer.borderWidth = self.frame.height / 2
                }
                
                self.thumbLayer.position = self.getThumbOnPos()
                self.thumbLayer.borderColor = self.thumbOnBorderColor?.cgColor
                self.thumbLayer.backgroundColor = self.thumbOnFillColor?.cgColor
                self.labelOn.textColor = self._onLabelColorForOn
                self.labelOff.textColor = self._offLabelColorForOn
                self.backLayer.borderColor = self.trackOnBorderColor?.cgColor
                self.backLayer.backgroundColor = self.trackOnFillColor?.cgColor
            } else {
                if (self.shouldFillOnPush) {
                    self.backLayer.borderWidth = 1
                }
                
                self.thumbLayer.position = self.getThumbOffPos()
                self.thumbLayer.borderColor = self.thumbOffBorderColor?.cgColor
                self.thumbLayer.backgroundColor = self.thumbOffFillColor?.cgColor
                self.labelOn.textColor = self._onLabelColorForOff
                self.labelOff.textColor = self._offLabelColorForOff
                self.backLayer.borderColor = self.trackOffBorderColor?.cgColor
                self.backLayer.backgroundColor = self.trackOffFillColor?.cgColor
            }
        }
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
    //helper func
    fileprivate func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
