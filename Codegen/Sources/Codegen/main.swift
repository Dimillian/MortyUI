import Foundation
import Darwin
import ApolloCodegenLib
import ArgumentParser

struct GraphQLHelper: ParsableCommand {
    
    public static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage your Apollo schema.json and codegen")
    
    @Argument(help: "For now you can use 'download' to download & update the schema.json, or 'codegen' to update the API.swift")
    var action: String
    func run() throws {
        let parentFolderOfScriptFile = FileFinder.findParentFolder()
        
        let sourceRootURL = parentFolderOfScriptFile
            .apollo.parentFolderURL()
            .apollo.parentFolderURL()
            .apollo.parentFolderURL()
        
        let targetRootURL = sourceRootURL
            .apollo.childFolderURL(folderName: "MortyUI")
        let endpoint = URL(string: "https://rickandmortyapi.com/graphql")!
        
        let graphQLFolder = sourceRootURL
            .apollo
            .childFolderURL(folderName: "MortyUI/GraphQL")
        let schemaDownloadOptions = ApolloSchemaOptions(endpointURL: endpoint,
                                                        outputFolderURL: graphQLFolder)
        
        switch action {
        case "download":
            do {
                try ApolloSchemaDownloader.run(with: graphQLFolder,
                                               options: schemaDownloadOptions)
            } catch {
                GraphQLHelper.exit(withError: nil)
            }
            
        case "codegen":
            let codegenOptions = ApolloCodegenOptions(targetRootURL: graphQLFolder)
            
            do {
                try ApolloCodegen.run(from: targetRootURL,
                                      with: graphQLFolder,
                                      options: codegenOptions)
            } catch {
                GraphQLHelper.exit(withError: nil)
            }
        default:
            GraphQLHelper.exit(withError: nil)
        }
    }
}

GraphQLHelper.main()
