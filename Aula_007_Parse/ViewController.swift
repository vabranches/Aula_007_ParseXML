import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    //MARK: Propriedades
    var arrayPessoas : [Dictionary<String,String>]=[]
    var dicAluno = [String : String]()
    var tagAtual = ""
    var conteudoTag = ""
    
    //MARK: Outlets
    @IBOutlet weak var minhaTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let caminhoArquivo = Bundle.main.path(forResource: "dados", ofType: "xml")
        let urlArquivo = URL(fileURLWithPath: caminhoArquivo!)
        let meuXMLParse = XMLParser(contentsOf: urlArquivo)
        
        meuXMLParse?.delegate = self
        meuXMLParse?.parse()
        
        

    }

    //MARK: Métodos de XMLParseDelegate
    func parserDidStartDocument(_ parser: XMLParser) {
        print("Interpretacao do documento XML iniciada\n")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Interpretacao do documento XML finalizada")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        tagAtual = elementName
        
        if elementName=="nome" || elementName=="idade"{
            conteudoTag = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName=="nome"{
            dicAluno["nome"]=conteudoTag
            conteudoTag=""
            tagAtual=""
        }
        
        if elementName=="idade"{
            dicAluno["idade"]=conteudoTag
            conteudoTag=""
            tagAtual=""
        }
        
        if elementName=="aluno"{
            arrayPessoas += [dicAluno]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if tagAtual=="nome" || tagAtual=="idade" {
            conteudoTag = string
        }
    }
    
    //MARK: Actions
    @IBAction func exibirDados(_ sender: UIButton) {
        for lista in arrayPessoas{
            minhaTextView.text! += "\(lista)\n"
        }
    }


}

