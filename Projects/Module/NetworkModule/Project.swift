//
//  Project.swift
//  CleanArchitecture-iosManifests
//
//  Created by Chaekyeong Lee on 1/29/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.configure(
    moduleType: .module(name: "NetworkModule"),
    product: .framework,
    interfaceDependencies: [
        .Modules.thirdPartyLibrary
    ]
)
