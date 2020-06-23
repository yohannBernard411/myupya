# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "> Destroy is comming !"

User.destroy_all
Choice.destroy_all
Question.destroy_all
Step.destroy_all

puts "> Destroy is finish !"

puts "> Creating all the steps !"

step1 = Step.create!(position: 1)
step2 = Step.create!(position: 2)
step3 = Step.create!(position: 3)
step4 = Step.create!(position: 4)
step5 = Step.create!(position: 5)
step6 = Step.create!(position: 6)
step7 = Step.create!(position: 7)
step8 = Step.create!(position: 8) # Use this step to moving forward into the form

puts "> All the steps are created !"

puts "> Creating all the questions !"


question1 = Question.create!(title: "Êtes-vous toujours en poste à ce jour ?")
question2 = Question.create!(title: "Avez-vous fait le point sur votre parcours professionnel ?")
question3 = Question.create!(title: "Avez-vous défini votre projet professionnel ?")
question4 = Question.create!(title: "Avez-vous sélectionné une formation et défini son financement ?")
question5 = Question.create!(title: "Êtes-vous inscrit à une formation ?")
question6 = Question.create!(title: "Avez-vous défini un plan d'apprentissage pour maximiser l'acquisition de compétences ?")
question7 = Question.create!(title: "Avez-vous déjà finalisé votre formation ?")
question8 = Question.create!(title: "Avez-vous identifié des opportunités professionnelles post-formation ?")
question9 = Question.create!(title: "Avez-vous une promesse d'embauche ?")
question10 = Question.create!(title: "Savez-vous comment bien vous intégrer dans votre future entreprise & poursuivre votre formation continue ?")

puts "> All the questions are created !"

puts "> Creating all the choices !"

# t.boolean "value"
# t.bigint "question_id", null: false
# t.integer "next_question_id"
# t.bigint "step_id", null: false

# Choices of the question 1
choice1 = Choice.create!(value: true, question_id: question1.id, next_question_id: question2.id, step_id: step8.id)
choice2 = Choice.create!(value: false, question_id: question1.id, next_question_id: question2.id, step_id: step8.id)

# Choices of the question 2
choice7 = Choice.create!(value: true, question_id: question2.id, next_question_id: question3.id, step_id: step8.id)
choice8 = Choice.create!(value: false, question_id: question2.id, next_question_id: question1.id, step_id: step1.id)

# Choices of the question 3
choice9 = Choice.create!(value: true, question_id: question3.id, next_question_id: question4.id, step_id: step8.id)
choice10 = Choice.create!(value: false, question_id: question3.id, next_question_id: question1.id, step_id: step2.id)

# Choices of the question 4
choice11 = Choice.create!(value: true, question_id: question4.id, next_question_id: question5.id, step_id: step8.id)
choice12 = Choice.create!(value: false, question_id: question4.id, next_question_id: question1.id, step_id: step3.id)

# Choices of the question 5
choice13 = Choice.create!(value: true, question_id: question5.id, next_question_id: question6.id, step_id: step8.id)
choice14 = Choice.create!(value: false, question_id: question5.id, next_question_id: question7.id, step_id: step8.id)

# Choices of the question 6
choice15 = Choice.create!(value: true, question_id: question6.id, next_question_id: question7.id, step_id: step8.id)
choice16 = Choice.create!(value: false, question_id: question6.id, next_question_id: question1.id, step_id: step5.id)

# Choices of the question 7
choice17 = Choice.create!(value: true, question_id: question7.id, next_question_id: question8.id, step_id: step8.id)
choice18 = Choice.create!(value: false, question_id: question7.id, next_question_id: question1.id, step_id: step4.id)

# Choices of the question 8
choice19 = Choice.create!(value: true, question_id: question8.id, next_question_id: question9.id, step_id: step8.id)
choice20 = Choice.create!(value: false, question_id: question8.id, next_question_id: question1.id, step_id: step6.id)

# Choices of the question 9
choice21 = Choice.create!(value: true, question_id: question9.id, next_question_id: question10.id, step_id: step8.id)
choice22 = Choice.create!(value: false, question_id: question9.id, next_question_id: question1.id, step_id: step6.id)

# Choices of the question 10
choice23 = Choice.create!(value: true, question_id: question10.id, next_question_id: question1.id, step_id: step8.id)
choice24 = Choice.create!(value: false, question_id: question10.id, next_question_id: question1.id, step_id: step7.id)

puts "> All the choices are created !"

puts "> Creating all the users !"

user1 = User.create!(email: "bob@user.com", password: "azerty", name: "Bob", current_question_id: question1.id, step_id: step1.id)
user2 = User.create!(email: "john@user.com", password: "azerty", name: "John", current_question_id: question1.id, step_id: step1.id)
user3 = User.create!(email: "manu@user.com", password: "azerty", name: "Manu", current_question_id: question1.id, step_id: step1.id)
user4 = User.create!(email: "clara@user.com", password: "azerty", name: "Clara", current_question_id: question1.id, step_id: step1.id)
user5 = User.create!(email: "anna@user.com", password: "azerty", name: "Anna", current_question_id: question1.id, step_id: step1.id)
user6 = User.create!(email: "tchickita@user.com", password: "azerty", name: "Tchickita", current_question_id: question1.id, step_id: step1.id)
user7 = User.create!(email: "paul@user.com", password: "azerty", name: "Paul", current_question_id: question1.id, step_id: step1.id)
user8 = User.create!(email: "george@user.com", password: "azerty", name: "George", current_question_id: question1.id, step_id: step1.id)
user9 = User.create!(email: "pablo@user.com", password: "azerty", name: "Pablo", current_question_id: question1.id, step_id: step1.id)
user10 = User.create!(email: "gustavo@user.com", password: "azerty", name: "Gustavo", current_question_id: question1.id, step_id: step1.id)

puts "> All the users are created !"



















