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
step1 = Step.create!(position: 1, title: "BILAN PROFESSIONNEL", background: "https://res.cloudinary.com/ded9yhg1e/image/upload/v1593548475/bg1_vlh7jv.jpg")
step2 = Step.create!(position: 2, title: "VALIDATION PROJET PROFESSIONNEL", background: "https://res.cloudinary.com/ded9yhg1e/image/upload/v1593548474/bg2_kvxzna.jpg")
step3 = Step.create!(position: 3, title: "CHOIX FORMATION & FINANCEMENT", background: "https://res.cloudinary.com/ded9yhg1e/image/upload/v1593548495/bg3_n43dnh.jpg")
step4 = Step.create!(position: 4, title: "INSCRIPTION FORMATION & SELECTION CANDIDAT", background: "https://res.cloudinary.com/ded9yhg1e/image/upload/v1593548361/bg4_xa7p5c.jpg")
step5 = Step.create!(position: 5, title: "INTEGRATION & SUIVI DE FORMATION", background: "https://res.cloudinary.com/ded9yhg1e/image/upload/v1593588308/felicia-buitenwerf-Qs_Zkak27Jk-unsplash_f9wzor.jpg")
step6 = Step.create!(position: 6, title: "RECHERCHES OPPORTUNITÉS PRO POST FORMATION", background: "https://res.cloudinary.com/ded9yhg1e/image/upload/v1593548427/bg6_i9lqsy.jpg")
step7 = Step.create!(position: 7, title: "INTEGRATION EN ENTREPRISE & FORMATION CONTINUE", background: "https://res.cloudinary.com/ded9yhg1e/image/upload/v1593548430/bg7_uffm0s.jpg")
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

coaches_url = ["https://res.cloudinary.com/ded9yhg1e/image/upload/v1593590820/bruce-mars-8YG31Xn4dSw-unsplash_uyliuy.jpg",
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
