//
//  ViewController.swift
//  Aufgabe_02
//
//  Created by Simon Herzog on 17.03.21.
//


import Cocoa

class ViewController: NSViewController {
    //Outlets für Button und die zwei Labels
    @IBOutlet weak var catchMeButton: NSButton!
    @IBOutlet weak var labelPoints: NSTextField!
    @IBOutlet weak var labelTime: NSTextField!
    
    //Variable für die Timer-Instanz
    var timer: Timer?
    
    //Action für Klick auf den Fang mich Button
    @IBAction func catchMeClicked(_ sender: Any) {
        //Aktueller Punktestand holen und einer var zuweisen
        var gamePoints = labelPoints.integerValue
        //var um eins erhöhen, weil gefangen und somit +1 Punkt
        gamePoints += 1
        //neuen Punktewert dem Label zuweisen
        labelPoints.integerValue = gamePoints
        
        //Wenn Punktestand bei 10, wird Gewinnmeldung erstellt und die App beendet
        if gamePoints == 10 {
            createMessage(title: "Herzlichen Glückwunsch", text: "Du hast 10 Punkte erreicht und das Spiel gewonnen")
            NSApplication.shared.terminate(self)
        }
        
    }

    //Berechnet aktuelle Zeit und setzt den Button zufällig im Spielfeld
    @objc func gameLogic() {
        //Aktuelle Zeit holen und
        var gametime = labelTime.integerValue
        //Zeit um 1 reduzieren
        gametime -= 1
        //neue Zeit dem Label zuweisen
        labelTime.integerValue = gametime
        
        //Button zufällig auf der x-Achse setzen, dabei wird eine Zufallszahl zwischen 0 (linker Rand des Spielfelds) und 500 (Button ist 100px lang, View 600) generiert
        catchMeButton.frame.origin.x = CGFloat.random(in: 0...500)
        //Button zufällig auf der y-Achse setzen,dabei wird eine Zufallszahl zwischen 40 (unterer Rand plus Bereich für Labels) und 668 (Button ist 32px hoch, View 700) generiert
        catchMeButton.frame.origin.y = CGFloat.random(in: 40...668)
        
        //Wenn Zeit auf 0 geht wird Meldung bzgl. verlorenem Spiel ausgegeben und die App beendet
        if gametime == 0 {
            createMessage(title: "Du hast leider verloren", text: "Die Zeit ist abgelaufen")
            NSApplication.shared.terminate(self)
        }
        
    }
    
    //Funktion die Nachricht erstellt, dabei zwei Strings als Argumente entgegen nimmt
    func createMessage(title: String, text: String){
        let message = NSAlert()
        message.messageText = title
        message.informativeText = text
        //Da bei Klick auf Button das Spiel beendet wird, diesen mit entsprechendem Titel versehen
        message.addButton(withTitle: "Spiel beenden")
        message.runModal()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Beim Start der App wird Timer mit 1 Sekundenintervall gesetzt und dabei (immer wieder) die Methode gameLogic aufgerufen
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameLogic), userInfo: nil, repeats: true)
        
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

