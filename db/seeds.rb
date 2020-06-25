require 'open-uri'
require 'nokogiri'

Article.destroy_all
Video.destroy_all
Coach.destroy_all
Answer.destroy_all
Choice.destroy_all
User.destroy_all
Question.destroy_all
Step.destroy_all

# steps
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

# articles
rank = Step.first.id
puts "all articles are destroy, but don't panic"
urls = ["https://www.pole-emploi.fr/candidat/votre-projet-professionnel/evaluer-vos-competences/levaluation-des-competences-et-d.html",
        "https://www.pole-emploi.fr/candidat/vos-recherches/bien-vous-organiser/decouvrez-vos-competences-transv.html",
        "https://www.pole-emploi.fr/candidat/votre-projet-professionnel/definir-votre-projet-professionn/le-conseil-en-evolution-professi.html",
        "https://www.pole-emploi.fr/region/occitanie/candidat/formation/une-formation-pour-quoi-faire.html",
        "https://www.pole-emploi.fr/candidat/en-formation/definir-vos-besoins/choisir-votre-formation.html",
        "https://www.pole-emploi.fr/candidat/vos-recherches/bien-vous-organiser/3-idees-pour-enrichir-votre-parc.html",
        "https://www.pole-emploi.fr/employeur/vos-recrutements/integrer-un-nouveau-salarie/entretien-tutorat-parrainage-pri.html"
      ]
base = "https://www.pole-emploi.fr"
urls.each do |url|
  article = Article.new
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  paragraphes = []
  element = html_doc.search('.container')[2]
  titre = element.search('h1').text.strip
  puts titre
  article.title = titre
  element.search('p').each do |paragraphe|
    paragraphes << paragraphe.text.strip if paragraphe.text.strip.size > 100
  end
  paragraphes.shift
  puts paragraphes
  article.content = paragraphes.join(" ")
  if element.search('img').attribute('src')
    image = element.search('img').attribute('src').text.strip
    if image[0] == "/"
      url_image = base + image
    else
      url_image = image
    end
    puts url_image
    article.image = url_image
  end
  puts rank
  article.step_id = rank
  article.save!
  rank += 1
  sleep 2
end
puts "Now the article db is fill"

# questions
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
# Choices of the question 1
choice1 = Choice.create!(value: true, question_id: question1.id, next_question_id: question2.id, step_id: step8.id)
choice2 = Choice.create!(value: false, question_id: question1.id, next_question_id: question2.id, step_id: step8.id)

# Choices of the question 2
choice7 = Choice.create!(value: true, question_id: question2.id, next_question_id: question3.id, step_id: step8.id)
choice8 = Choice.create!(value: false, question_id: question2.id, next_question_id: nil, step_id: step1.id)

# Choices of the question 3
choice9 = Choice.create!(value: true, question_id: question3.id, next_question_id: question4.id, step_id: step8.id)
choice10 = Choice.create!(value: false, question_id: question3.id, next_question_id: nil, step_id: step2.id)

# Choices of the question 4
choice11 = Choice.create!(value: true, question_id: question4.id, next_question_id: question5.id, step_id: step8.id)
choice12 = Choice.create!(value: false, question_id: question4.id, next_question_id: nil, step_id: step3.id)

# Choices of the question 5
choice13 = Choice.create!(value: true, question_id: question5.id, next_question_id: question6.id, step_id: step8.id)
choice14 = Choice.create!(value: false, question_id: question5.id, next_question_id: question7.id, step_id: step8.id)

# Choices of the question 6
choice15 = Choice.create!(value: true, question_id: question6.id, next_question_id: question7.id, step_id: step8.id)
choice16 = Choice.create!(value: false, question_id: question6.id, next_question_id: nil, step_id: step5.id)

# Choices of the question 7
choice17 = Choice.create!(value: true, question_id: question7.id, next_question_id: question8.id, step_id: step8.id)
choice18 = Choice.create!(value: false, question_id: question7.id, next_question_id: nil, step_id: step4.id)

# Choices of the question 8
choice19 = Choice.create!(value: true, question_id: question8.id, next_question_id: question9.id, step_id: step8.id)
choice20 = Choice.create!(value: false, question_id: question8.id, next_question_id: nil, step_id: step6.id)

# Choices of the question 9
choice21 = Choice.create!(value: true, question_id: question9.id, next_question_id: question10.id, step_id: step8.id)
choice22 = Choice.create!(value: false, question_id: question9.id, next_question_id: nil, step_id: step6.id)

# Choices of the question 10
choice23 = Choice.create!(value: true, question_id: question10.id, next_question_id: nil, step_id: step8.id)
choice24 = Choice.create!(value: false, question_id: question10.id, next_question_id: nil, step_id: step7.id)
puts "> All the choices are created !"

#users
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
me = User.create!(email: "user@test.fr", password: "azerty", name: "Yohann", current_question_id: Question.first.id, step_id: Step.first.id)
puts "> All the users are created !"

# video youtube:
rank = Step.first.id
puts "all videos are destroy, but don't panic"
youtube_url = ["https://www.youtube.com/embed/jpPL_5dHGSA",
               "https://www.youtube.com/embed/PMnTR-8XVHg",
               "https://www.youtube.com/embed/v5um5glCEzg",
               "https://www.youtube.com/embed/hkVFPpElRjk",
               "https://www.youtube.com/embed/WUKzm250bU8",
               "https://www.youtube.com/embed/91EZeR5tbos?list=PLi6L3Jci2WszzB8Nmr_rKoT7UDyQAt4VX",
               "https://www.youtube.com/embed/fzqwEcIaauk" 
              ]
miniatures = ["https://zupimages.net/up/20/26/d9ds.png",
              "https://zupimages.net/up/20/26/rx3y.png",
              "https://zupimages.net/up/20/26/4vif.png",
              "https://zupimages.net/up/20/26/t4n3.png",
              "https://zupimages.net/up/20/26/dg41.png",
              "https://zupimages.net/up/20/26/2yy2.png",
              "https://zupimages.net/up/20/26/e8ub.png" 
             ]
youtube_url.each_with_index do |url, index|
  video = Video.new
  video.url = url
  video.step_id = rank
  puts video.url
  video.picture = miniatures[index]
  video.save!
  rank += 1
end
puts "Now the video db is fill"

# coaching:
puts "please wait, we fill the coach db"

coaches_url = ["https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1496345875659-11f7dd282d1d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60"
              ]

coaches_url.each do |photo|
  coach = Coach.new
  coach.email = Faker::Name.first_name.downcase + "@upya.fr"
  coach.photo_url = photo
  coach.price_cents = Faker::Number.between(from: 5000, to: 30000)
  puts coach.email
  coach.save!
end
puts ">The coach db is fill"
