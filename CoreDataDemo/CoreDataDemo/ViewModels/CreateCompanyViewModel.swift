//
//  CreateCompanyViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/18/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation
import CoreData

class CreateCompanyViewModel{
  
  var company: Company?
  
  //MARK: Interface
  
  var navigationTitle: String{
    return company != nil ? "Edit Company" : "Create Company"
  }
  
  var successMessage: String{
    return company != nil ? "Compañía actualizada de manera exitosa" : "Compañía creada de manera exitosa"
  }
  
  var companyName: String?{
    return company?.name
  }
  
  var companyFounded: Date{
    return company != nil ? company!.founded! : Date()
  }
  
  var imageData: Data?{
    return company?.imageData
  }
  
}

extension CreateCompanyViewModel{
  
  func saveCompany(name: String, founded: Date, imageData: Data){
    if company == nil{
      createCompany(name: name, founded: founded, imageData: imageData)
    }else{
      updateCompany(name: name, founded: founded, imageData: imageData)
    }
  }
  
  private func createCompany(name: String, founded: Date, imageData: Data){
    let context = CoreDataManager.shared.viewContext
    let company = Company(context: context)
    company.name = name
    company.founded = founded
    company.imageData = imageData
    
    do{
      try context.save()
    }catch let err{
      print("Can't save the company \(err.localizedDescription)")
    }
  }
  
  private func updateCompany(name: String, founded: Date, imageData: Data){
    company?.name = name
    company?.founded = founded
    company?.imageData = imageData
    
    let context = CoreDataManager.shared.viewContext
    
    do{
      try context.save()
    }catch let err{
      print("Can't save the company \(err.localizedDescription)")
    }
  }
  
}
