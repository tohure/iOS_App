//
//  DetalleMultimediaNoticiaVC.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 25/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//


import UIKit

class DetalleMultimediaNoticiaVC: UIViewController {
    
    var currentShownEvent : Noticia!
    
    override func viewDidLoad() {
       //
        print(currentShownEvent.desarrollo)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}