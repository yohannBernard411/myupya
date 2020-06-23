require 'open-uri'
require 'nokogiri'

step_fill = true
article_fill = true
video_fill = true
coach_fill = true

if step_fill
  puts "> Creating all the steps !"
  step1 = Step.create!(position: 1)
  step2 = Step.create!(position: 2)
  step3 = Step.create!(position: 3)
  step4 = Step.create!(position: 4)
  step5 = Step.create!(position: 5)
  step6 = Step.create!(position: 6)
  step7 = Step.create!(position: 7)
  puts "> All the steps are created !"
end

# articles
if article_fill
  rank = 1
  puts "please wait, we fill the article db"
  Article.destroy_all
  puts "all articles are destroy, but don't panic"
  urls = ["https://www.pole-emploi.fr/candidat/votre-projet-professionnel/evaluer-vos-competences/levaluation-des-competences-et-d.html",
          "https://www.pole-emploi.fr/candidat/votre-projet-professionnel/definir-votre-projet-professionn/le-conseil-en-evolution-professi.html",
          "https://www.pole-emploi.fr/candidat/en-formation/definir-vos-besoins/choisir-votre-formation.html",
          "https://www.pole-emploi.fr/region/occitanie/candidat/formation/une-formation-pour-quoi-faire.html",
          "https://www.pole-emploi.fr/candidat/vos-recherches/bien-vous-organiser/3-idees-pour-enrichir-votre-parc.html",
          "https://www.pole-emploi.fr/region/auvergne-rhone-alpes/evenements/1-semaine-pour-1-emploi/employeurs-pourquoi-et-comment-p.html",
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
    puts paragraphes
    article.content = paragraphes.join(" ")
    if element.search('img').attribute('src')
      image = element.search('img').attribute('src') 
      url_image = base + image
      puts url_image
      article.image = url_image
    end
    puts rank
    article.step_id = rank
    article.save!
    rank += 1
  end
  puts "Now the article db is fill"
end

# video youtube:
if video_fill
  rank =1
  puts "please wait, we fill the video db"
  Video.destroy_all
  puts "all videos are destroy, but don't panic"
  youtube_url = ["https://www.youtube.com/embed/jpPL_5dHGSA",
                "https://www.youtube.com/embed/PMnTR-8XVHg",
                "https://www.youtube.com/embed/v5um5glCEzg",
                "https://www.youtube.com/embed/hkVFPpElRjk",
                "https://www.youtube.com/embed/WUKzm250bU8",
                "https://www.youtube.com/embed/91EZeR5tbos?list=PLi6L3Jci2WszzB8Nmr_rKoT7UDyQAt4VX",
                "https://www.youtube.com/embed/fzqwEcIaauk"]
  youtube_url.each do |url|
    video = Video.new
    video.url = url
    video.step_id = rank
    puts video.url
    video.save!
    rank += 1
  end
  puts "Now the video db is fill"
end

# coaching:
if coach_fill
  puts "please wait, we fill the coach db"
  Coach.destroy_all
  puts "all coachs are destroy, but don't panic"
  7.times do
    coach = Coach.new
    coach.email = Faker::Name.first_name + "@upya.fr"
    puts coach.email
    coach.save!
  end
  puts "Now the coach db is fill"
end