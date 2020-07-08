//
//  ScrollViewController.swift
//  ScrollView
//
//  Created by Han Jiali on 6/19/20.
//  Copyright © 2020 Han Jiali. All rights reserved.
//

import UIKit

struct SlideData: Decodable {
    var imgName:String?
    var headline:String?
    var text:String?
}

struct SlidesData: Decodable {
    var slides: [SlideData]
}


class ScrollViewController: UIViewController, UIScrollViewDelegate {

  var slideView: SlideView { return self.view as! SlideView }
        var slides: [SlideData] = []
        var slideViews: [SlideView] = []
        
        // scrollview
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        
        // pagecontrol
        let pageControl:UIPageControl = UIPageControl(frame: CGRect(x: 20, y: 400, width: 100, height: 12))
            

        
        var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        let screenSize: CGRect = UIScreen.main.bounds
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemPink
            slides = loadJson(filename: "slidesData")
            print(slides[0])
            buildSlideViews()

            buildScrollView()
            buildPageControl()
        }

        func buildPageControl() {
            pageControl.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)

            pageControl.addTarget(self, action: #selector(self.onPageChangeAction(_:)), for: .valueChanged)
            pageControl.numberOfPages = slides.count
            pageControl.currentPage = 0
            pageControl.tintColor = .darkGray
            pageControl.pageIndicatorTintColor = .darkGray
            pageControl.currentPageIndicatorTintColor =  .red
            // constraints
            self.view.addSubview(pageControl)
            self.view.bringSubviewToFront(pageControl)

        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageNumber = round(self.scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
        }

        @objc func onPageChangeAction(_ sender: UIPageControl) {
             print("currentPage:", sender.currentPage)
            let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            // customize pagecontroll
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
            pageControl.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0).isActive = true
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant:-100).isActive = true // add to scrollview not view
        }
        
        func buildScrollView() {
            
            let numOfScreens:Int = Int(slideViews.count)
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.frame.size = self.view.frame.size
            scrollView.backgroundColor = .white
            let w = slideViews[0].frame.size.width * 3.0
            let h = slideViews[0].frame.size.height
            scrollView.contentSize = CGSize(width: w, height: h)
            
            // set up scroll view
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(scrollView)
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

            
            let first:SlideView = slideViews[0]
            let second:SlideView = slideViews[1]
            let last:SlideView = slideViews[2]
            scrollView.addSubview(first)
            scrollView.addSubview(second)
            scrollView.addSubview(last)
            
            // first
            first.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
            first.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0).isActive = true

            first.bottomAnchor.constraint(equalTo:self.scrollView.bottomAnchor, constant: 0).isActive = true
            first.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
           
            
            // second
            second.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
            second.leadingAnchor.constraint(equalTo: first.trailingAnchor, constant: 0).isActive = true
            second.bottomAnchor.constraint(equalTo:self.scrollView.bottomAnchor, constant: 0).isActive = true
            second.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true

            
            // last
            last.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
            last.leadingAnchor.constraint(equalTo: second.trailingAnchor, constant: 0).isActive = true
            last.bottomAnchor.constraint(equalTo:self.scrollView.bottomAnchor, constant: 0).isActive = true
            last.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
            last.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: 0).isActive = true
            
            
        }
        


        func loadJson(filename fileName: String) -> [SlideData] {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(SlidesData.self, from: data)
                    return jsonData.slides
                } catch {
                   fatalError("fail to load json file")
                }
            }
            return []
        }
        
        func buildSlideViews() {
    //        let screenSize: CGRect = UIScreen.main.bounds
            for i in 0 ..< slides.count {
    //            let tmpView  =  SlideView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
                
                let tmpView = SlideView(frame: UIScreen.main.bounds)
                tmpView.translatesAutoresizingMaskIntoConstraints  = false
                guard let imgName = slides[i].imgName else {return}
                guard let img:UIImage = UIImage(named: imgName) else {return}
                tmpView.imageView.image =  imageByCroppingImage(image: img, size:CGSize(width: 335, height: 294))
                tmpView.headline.text = slides[i].headline
                tmpView.text.text  = slides[i].text
           
                slideViews.append(tmpView)
            }
           
        }
        func imageByCroppingImage(image: UIImage, size: CGSize) -> UIImage? {
       
            var newCropWidth:CGFloat = 0
            var newCropHeight:CGFloat = 0

            //=== To crop more efficently =====//
              if(image.size.width < image.size.height){
                     if (image.size.width < size.width) {
                             newCropWidth = size.width
                      }
                      else {
                             newCropWidth = image.size.width
                      }
                      newCropHeight = (newCropWidth * size.height)/size.width
                } else {
                      if (image.size.height < size.height) {
                            newCropHeight = size.height
                      }
                      else {
                            newCropHeight = image.size.height
                      }
                    newCropWidth = (newCropHeight * size.width)/size.height
             
            }
            let x:CGFloat = image.size.width/2.0 - newCropWidth/2.0
            let y:CGFloat = image.size.height/2.0 - newCropHeight/2.0

            let cropRect = CGRect(x: x, y: y, width: newCropWidth, height: newCropHeight);
            if let imageRef = image.cgImage!.cropping(to: cropRect) {
                return UIImage(cgImage: imageRef, scale: 0, orientation: image.imageOrientation)
            }

            return nil;
        }

    }


