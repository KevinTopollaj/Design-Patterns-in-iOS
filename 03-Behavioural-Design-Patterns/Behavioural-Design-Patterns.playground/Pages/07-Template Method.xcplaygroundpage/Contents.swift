import Foundation

// Step 1: Create a template class with a template method
class DocumentProcessorTemplate {

  // Template method
  func processDocument() {
    downloadDocument()
    parseContent()
    saveDocument()
    // Additional common steps can be added here
  }

  // Step 2: Define abstract methods to be implemented by subclasses
  func downloadDocument() {
    fatalError("Subclasses must implement this method")
  }

  func parseContent() {
    fatalError("Subclasses must implement this method")
  }

  func saveDocument() {
    fatalError("Subclasses must implement this method")
  }

}

// @Kevin_Topollaj







// Step 3: Create concrete subclasses implementing the abstract methods
class PDFDocumentProcessor: DocumentProcessorTemplate {

  override func downloadDocument() {
    // Implementation for downloading a PDF document
    print("Downloading PDF document")
  }

  override func parseContent() {
    // Implementation for parsing PDF content
    print("Parsing PDF content")
  }

  override func saveDocument() {
    // Implementation for saving the processed PDF document
    print("Saving processed PDF document")
  }

}

let pdfProcessor = PDFDocumentProcessor()
pdfProcessor.processDocument()
