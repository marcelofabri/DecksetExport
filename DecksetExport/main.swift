import Foundation

func shell(args: String...) -> Int32 {
    let task = NSTask()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

let arguments = Process.arguments

if count(arguments) == 3 {
    let source = NSURL(fileURLWithPath: arguments[1])!
    let destination = NSURL(fileURLWithPath: arguments[2])!
    
    shell("open", source.path!, "-a", "Deckset")

    if let app = DecksetApp(), document = app.documents.filter({ $0.file.path == source.path }).first {
        if document.exportToPDF(destination) {
            println("Finished saving PDF to \(destination.path!)")
        } else {
            fputs("Unable to save PDF to \(destination.path!)\n", stderr)
            exit(EXIT_FAILURE)
        }
    } else {
        fputs("Unknown error]\n", stderr)
        exit(EXIT_FAILURE)
    }
} else {
    fputs("Usage: ./DecksetExport [source] [destination]\n", stderr)
    exit(EXIT_FAILURE)
}