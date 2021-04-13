//
//  PlayingPageViewController.swift
//  kidsApp
//
//  Created by Betty Pan on 2021/4/7.
//

import UIKit

class PlayingPageViewController: UIViewController {
    @IBOutlet var numberImageViews: [UIImageView]!
    @IBOutlet weak var numberOfQuestionLabel: UILabel!
    @IBOutlet var multichoiceBtns: [UIButton]!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var xLabel: UILabel!
    var questionIndex = 0
    var answer = 0
    var optionsArray = [String]()
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartBtn.isHidden = true
        updateQuestionIndex()
        setQuestion()
        setOptions()
       
    }
    
    func updateQuestionIndex() {
        questionIndex += 1
        numberOfQuestionLabel.text = "\(questionIndex)/10"
    }
    
    func setQuestion() {
        let num1 = Int.random(in: 1...9)
        let num2 = Int.random(in: 1...9)
        numberImageViews[0].image = UIImage(named: "F\(num1)")
        numberImageViews[1].image = UIImage(named: "F\(num2)")
        answer = num1 * num2
    }
    
    func setOptions() {
        optionsArray = [
            String(answer),
            String(Int.random(in: 2...99)),
            String(Int.random(in: 2...99)),
            String(Int.random(in: 2...99))
        ]
        optionsArray.shuffle()
        
        for (i,_) in multichoiceBtns.enumerated() {
            multichoiceBtns[i].setTitle(optionsArray[i], for: .normal)
        }
    }
    
    func jumpToResultView() {
        performSegue(withIdentifier: "resultViewController", sender: nil)
    }
    
    func initGame() {
        score = 0
        questionIndex = 0
    }
    
    func alertForBackToMainPage() {
        let alertController = UIAlertController(title: "Are you leaving?", message: "", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
            self.initGame()
        }
        let noAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func jumpOutRestartBtn() {
        for i in multichoiceBtns {
            restartBtn.isHidden = false
            i.setTitle("", for: .normal)
            i.isEnabled = false
        }
        for i in numberImageViews {
            i.image = UIImage(named: "")
        }
        xLabel.isHidden = true
    }
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        if sender.currentTitle == String(answer) {
            score += 10
        }
        if questionIndex >= 10 {
            jumpToResultView()
            jumpOutRestartBtn()
            
        }else{
            setQuestion();setOptions()
            updateQuestionIndex()
        }
        
    }
    
    @IBAction func backToMainPage(_ sender: Any) {
        alertForBackToMainPage()
    }
    
    @IBAction func restart(_ sender: Any) {
        restartBtn.isHidden = true
        initGame()
        updateQuestionIndex()
        setQuestion()
        setOptions()
        for i in multichoiceBtns {
            i.isEnabled = true
        }
        xLabel.isHidden = false
    }
    
    @IBSegueAction func scoreToResultView(_ coder: NSCoder) -> ResultViewController? {
        ResultViewController(coder: coder, score: score)
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


