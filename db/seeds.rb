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
step1 = Step.create!(position: 1, title: "BILAN PROFESSIONNEL")
step2 = Step.create!(position: 2, title: "VALIDATION PROJET PROFESSIONNEL")
step3 = Step.create!(position: 3, title: "CHOIX FORMATION & FINANCEMENT")
step4 = Step.create!(position: 4, title: "INSCRIPTION FORMATION & SELECTION CANDIDAT")
step5 = Step.create!(position: 5, title: "INTEGRATION & SUIVI DE FORMATION")
step6 = Step.create!(position: 6, title: "RECHERCHES OPPORTUNITÉS PRO POST FORMATION")
step7 = Step.create!(position: 7, title: "INTEGRATION EN ENTREPRISE & FORMATION CONTINUE")
step8 = Step.create!(position: 8, title: "Félicitations ! Vous avez finalisé votre reconversion professionnelle !") # Use this step to moving forward into the form
puts "> All the steps are created !"


# articles
rank = Step.first.id
puts "all articles are destroy, but don't panic"
urls_pole = ["https://www.pole-emploi.fr/candidat/votre-projet-professionnel/evaluer-vos-competences/levaluation-des-competences-et-d.html",
        "https://www.pole-emploi.fr/candidat/vos-recherches/bien-vous-organiser/decouvrez-vos-competences-transv.html",
        "https://www.pole-emploi.fr/candidat/votre-projet-professionnel/definir-votre-projet-professionn/le-conseil-en-evolution-professi.html",
        "https://www.pole-emploi.fr/region/occitanie/candidat/formation/une-formation-pour-quoi-faire.html",
        "https://www.pole-emploi.fr/candidat/en-formation/definir-vos-besoins/choisir-votre-formation.html",
        "https://www.pole-emploi.fr/candidat/vos-recherches/bien-vous-organiser/3-idees-pour-enrichir-votre-parc.html",
        "https://www.pole-emploi.fr/employeur/vos-recrutements/integrer-un-nouveau-salarie/entretien-tutorat-parrainage-pri.html",
        "https://www.pole-emploi.fr/candidat/votre-projet-professionnel/evaluer-vos-competences/le-bilan-de-competences.html",
        "https://www.pole-emploi.fr/candidat/votre-projet-professionnel/definir-votre-projet-professionn/realiser-une-immersion-professio.html"
      ]

base = "https://www.pole-emploi.fr"
urls_pole.each_with_index do |url, index|
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
  if rank > Step.last.id
    article.step_id = Step.first.id
  else
    article.step_id = rank
  end
  article.save!
  rank += 1
  sleep 2
end

urls_jungle = ["https://www.welcometothejungle.com/fr/articles/methode-ikigai-trouver-job"]

urls_jungle.each do |url|
  article = Article.new
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  paragraphes = []
  element = html_doc.search('.sc-11unfkk-2')
  puts element
  titre = element.search('h1').text.strip
  article.title = titre
  paragraphe = element.search('.hdl9e2-7').text.strip
  article.content = paragraphe
  article.step_id = Step.first.id
  if element.search('img').attribute('src')
    image = element.search('img').attribute('src').text.strip
    article.image = image
  end
  article.save!
end

urls_workplace = ["https://www.helloworkplace.fr/competences-transversales-communes-a-metiers/"]

urls_workplace.each do |url|
  article = Article.new
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  element = html_doc.search('.post-content')
  puts element
  titre = element.search('h1').text.strip
  article.title = titre
  paragraphe = element.search('.entry-content').text.strip
  article.content = paragraphe
  article.step_id = Step.first.id
  if element.search('img').attribute('src')
    image = element.search('img')[1].attribute('src').text.strip
    article.image = image
  end
  article.save!
end

urls_diplomeo = ["https://diplomeo.com/actualite-dossier_candidature_formation"]

urls_diplomeo.each do |url|
  article = Article.new
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  element = html_doc.search('.container')
  puts element
  titre = element.search('h1').text.strip
  article.title = titre
  paragraphe = element.search('.js-toc').text.strip
  article.content = paragraphe
  article.step_id = Step.all[3].id
  if element.search('source')
    image = element.search('source')[0].attribute('data-srcset').text.strip
    article.image = image
  end
  article.save!
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
me = User.create!(email: "user@test.fr", password: "azerty", name: "Joseph", current_question_id: Question.first.id, step_id: Step.first.id)
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
               "https://www.youtube.com/embed/fzqwEcIaauk",
               "https://www.youtube.com/embed/MLntp09G0-g",
               "https://www.youtube.com/embed/At8euxpGOzY",
               "https://www.youtube.com/embed/TYYnV65gVKs",
               "https://www.youtube.com/embed/Qb1ndnx5K1g",
               "https://www.youtube.com/embed/Bm1yJNJ_rv0",
               "https://www.youtube.com/embed/HPMz1XDpVFw",
               "https://www.youtube.com/embed/i9JrMXTcdbQ",
               "https://www.youtube.com/embed/HYTyJht3pHE",
               "https://www.youtube.com/embed/Vfr9MyihCgU",
               "https://www.youtube.com/embed/yleibzLh_u8",
               "https://www.youtube.com/embed/x0xQCTgCS38",
               "https://www.youtube.com/embed/1kSosmRpr04",
               "https://www.youtube.com/embed/uwJ5NfvtHq8",
               "https://www.youtube.com/embed/AA89w0xKBPU",
               "https://www.youtube.com/embed/H28_WbLvlSQ",
               "https://www.youtube.com/embed/_K1z18A42OE"

              ]
miniatures = ["https://zupimages.net/up/20/26/d9ds.png",
              "https://zupimages.net/up/20/26/rx3y.png",
              "https://zupimages.net/up/20/26/4vif.png",
              "https://zupimages.net/up/20/26/t4n3.png",
              "https://zupimages.net/up/20/26/dg41.png",
              "https://zupimages.net/up/20/26/2yy2.png",
              "https://zupimages.net/up/20/26/e8ub.png",
              "https://www.youtube.com/embed/T2CyOc9fCxQ",
              "https://www.youtube.com/embed/qRMpEPdM74c",
              "https://zupimages.net/up/20/27/3glx.png",
              "https://zupimages.net/up/20/27/cuup.png",
              "https://zupimages.net/up/20/27/xkye.png",
              "https://zupimages.net/up/20/27/dmx0.png",
              "https://zupimages.net/up/20/27/s682.png",
              "https://zupimages.net/up/20/27/mvl4.png",
              "https://zupimages.net/up/20/27/sk3c.png",
              "https://zupimages.net/up/20/27/lbcl.png",
              "http://img.youtube.com/vi/i9JrMXTcdbQ/0.jpg",
              "https://zupimages.net/up/20/27/zbz8.png",
              "https://zupimages.net/up/20/27/hac1.png",
              "https://zupimages.net/up/20/27/b7oq.png",
              "https://zupimages.net/up/20/27/19sd.png",
              "https://zupimages.net/up/20/27/jdv6.png",
              "http://img.youtube.com/vi/uwJ5NfvtHq8/0.jpg",
              "https://zupimages.net/up/20/27/r4bi.png",
              "https://zupimages.net/up/20/27/0kcm.png",
              "http://img.youtube.com/vi/_K1z18A42OE/0.jpg"
             ]
             titles = ["BILAN PROFESSIONNEL",
                       "VALIDATION PROJET PROFESSIONNEL",
                       "CHOIX FORMATION & FINANCEMENT",
                       "INSCRIPTION FORMATION & SELECTION CANDIDAT",
                       "INTEGRATION & SUIVI DE FORMATION",
                       "RECHERCHES OPPORTUNITÉS PRO POST FORMATION",
                       "INTEGRATION EN ENTREPRISE & FORMATION CONTINUE",
                       "le constat (faire le point sur son parcours pro)",
                       "se recentrer sur ses centres d intérêts/hobbies",
                       "identifier des métiers en adéquation avec ses appétences",
                       "se renseigner sur le marché et ses evolutions",
                       "faire une immersion en milieu pro",
                       "définir une grille de selection de formations professionnelles avec critères spécifiques (qualité, coût, durée, débouchés pros, reconnaissance dans le secteur...)",
                       "se renseigner auprès des organismes publiques pour recenser les possibilités de financement, (Pôle Emploi, Région, etc..)",
                       "préparer le dossier d admission",
                       "s'approprier une méthodologie d'apprentissage",
                       "mettre en place un planning de mise à niveau pour pallier ses lacunes",
                       "faire un bilan pour définir ses forces et faiblesse",
                       "faire des relances efficaces",
                       "préparer votre entretien d'embauche",
                       "apprendre à synthétiser les infos dans la candidature",
                       "prendre contact avec les entreprises et faire la différence en récoltant de l'info",
                       "définir le périmètre de recherches des opportunités pros à l'aide d'un dashboard",
                       "continuer à s'auto-former pour rester performant",
                       "s'intégrer aux équipes et participer à la vie de l'entreprise"
                     ]
steps = [1, 2, 3, 4, 5, 6, 7, 1, 1, 1, 2, 2, 3, 3, 4, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7]
youtube_url.each_with_index do |url, index|
  video = Video.new
  video.url = url
  puts video.url
  puts index #0
  puts steps[index] #1
  puts Step.all[steps[index]-1].id
  video.picture = miniatures[index]
  video.step_id = Step.all[steps[index]-1].id
  video.title = titles[index]
  video.save!
  rank += 1
end
puts "Now the video db is fill"



# coaching:
puts "please wait, we fill the coach db"

coaches_url = ["data:image/jpeg;base64,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",
               "https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
               "https://img.chefdentreprise.com/Img/BREVE/2020/2/346510/Tribune-femme-est-avenir-tech-F.jpg",
               "https://images.unsplash.com/photo-1496345875659-11f7dd282d1d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60"
              ]

coaches_url.each_with_index do |photo, index|
  coach = Coach.new
  if [2, 3, 4, 6].include?(index)
    coach.email = Faker::Name.male_first_name
  else
    coach.email = Faker::Name.female_first_name
  end
  coach.photo_url = photo
  coach.price_cents = Faker::Number.between(from: 5000, to: 30000)
  puts coach.email
  coach.save!
end
puts ">The coach db is fill"
