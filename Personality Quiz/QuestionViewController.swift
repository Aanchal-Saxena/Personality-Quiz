//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Batch-2 on 15/04/24.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    
    @IBOutlet var rangedSlider: UISlider!
    
    
    @IBOutlet var multiSwitch1: UISwitch!
    
    @IBOutlet var multiSwitch2: UISwitch!
    
    @IBOutlet var multiSwitch3: UISwitch!
    
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleButton1: UIButton!
    
    @IBOutlet var singleButton2: UIButton!
    
    
    @IBOutlet var singleButton3: UIButton!
    
    @IBOutlet var singleButton4: UIButton!
    
    
    
    @IBOutlet var multipleLabel1: UILabel!
    
    @IBOutlet var multipleLabel2: UILabel!
    
    
    @IBOutlet var multipleLabel3: UILabel!
    
    
    @IBOutlet var multipleLabel4: UILabel!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    
    @IBOutlet var rangedLabel1: UILabel!
    
    @IBOutlet var rangedLabel2: UILabel!
    
    
    
    
    @IBOutlet var singleStackView: UIStackView!
    
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    var questions: [Question] =
    [
        Question(text: "Which food do you like the most?", type: .single,
                 answers: [
                    Answer(text: "Maggie", type: .unicorn),
                    Answer(text: "Chocolate Waffles", type: .chick),
                    Answer(text: "Butter Chicken", type: .dog),
                    Answer(text: "Ice Cream", type: .penguin)
                 ]
                ),
        
        
        Question(text: "Which activities do you enjoy?", type: .multiple,
                 answers: [
                    Answer(text: "Flying", type: .unicorn),
                    Answer(text: "Shopping", type: .chick),
                    Answer(text: "Gossiping", type: .dog),
                    Answer(text: "Sleeping", type: .penguin)
                 ]
                ),
        
        Question(text: "Which much do you enjoy reading?", type: .ranged,
                 answers: [
                    Answer(text: "A little bit", type: .unicorn),
                    Answer(text: "I hate it!!", type: .chick),
                    Answer(text: "Reading? What reading...😶", type: .dog),
                    Answer(text: "Love it, can read 24/7", type: .penguin)
                 ]
                ),
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender
        {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
   @IBAction func multipleAnswerButtonPressed()
    {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn{
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn{
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn{
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn{
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
                
                
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    @IBAction func rangedanswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion()
    {
        questionIndex += 1
        
        if questionIndex < questions.count
        {
            updateUI()
        }
        else{
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
                func updateUI()
                {
                    singleStackView.isHidden = true
                    multipleStackView.isHidden = true
                    rangedStackView.isHidden = true
                    
                    navigationItem.title = "Question #\(questionIndex + 1)"
                    
                    let currentQuestion = questions[questionIndex]
                    
                    let currentAnswers = currentQuestion.answers
                    
                    let totalProgress = Float(questionIndex) / Float(questions.count)
                    
                    questionLabel.text = currentQuestion.text
                    questionProgressView.setProgress(totalProgress, animated: true)
                    
                    switch currentQuestion.type
                    {
                    case .single:
                        updateSingleStack(using: currentAnswers)
                    case .multiple:
                        updateMultipleStack(using: currentAnswers)
                    case .ranged:
                        updateRangedStack(using: currentAnswers)
                    }
                }
                
                func updateSingleStack(using answers: [Answer])
                {
                    singleStackView.isHidden = false
                    
                    singleButton1.setTitle(answers[0].text, for: .normal)
                    singleButton2.setTitle(answers[1].text, for: .normal)
                    singleButton3.setTitle(answers[2].text, for: .normal)
                    singleButton4.setTitle(answers[3].text, for: .normal)
                }
                
                func updateMultipleStack(using answers: [Answer])
                {
                    multipleStackView.isHidden = false
                    
                    multiSwitch1.isOn = false
                    multiSwitch2.isOn = false
                    multiSwitch3.isOn = false
                    multiSwitch4.isOn = false
                    multipleLabel1.text = answers[0].text
                    multipleLabel2.text = answers[1].text
                    multipleLabel3.text = answers[2].text
                    multipleLabel4.text = answers[3].text
                }
                
                func updateRangedStack(using answers: [Answer])
                {
                    rangedStackView.isHidden = false
                    rangedSlider.setValue(0.5, animated: false)
                    rangedLabel1.text = answers.first?.text
                    rangedLabel2.text = answers.last?.text
                }
                
                /*
                 // MARK: - Navigation
                 
                 // In a storyboard-based application, you will often want to do a little preparation before navigation
                 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                 // Get the new view controller using segue.destination.
                 // Pass the selected object to the new view controller.
                 }
                 */
                
            }

