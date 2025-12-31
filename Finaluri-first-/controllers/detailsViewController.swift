import UIKit

class DetailsViewController: UIViewController {
    
    var scrollview = UIScrollView()
    var contentview = UIView()
    var smallposterimageview = UIImageView()
    var bannerimageview = UIImageView()
    var ratingbadge = UILabel()
    var titlelabel = UILabel()
    var infocontainer = UIView()
    var infostackview = UIStackView()
    var abouttitlelabel = UILabel()
    var favoritebutton = UIButton()
    var plotlabel = UILabel()
    var viewModel = detailsViewModel()
    var movieID: String
    
    init(movieID: String) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true 
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        Scrollviewsetup()
        Uisetup()
        Detailsload()
        Favoritebuttonsetup()
    }
    
    func Scrollviewsetup() {
        view.addSubview(scrollview)
        scrollview.addSubview(contentview)
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        contentview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: view.topAnchor),
            scrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentview.topAnchor.constraint(equalTo: scrollview.topAnchor),
            contentview.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            contentview.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            contentview.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            contentview.widthAnchor.constraint(equalTo: scrollview.widthAnchor)
        ])
    }
    func Uisetup() {
        bannerimageview.contentMode = .scaleAspectFill
        bannerimageview.clipsToBounds = true
        bannerimageview.backgroundColor = .darkGray
        bannerimageview.translatesAutoresizingMaskIntoConstraints = false
        contentview.addSubview(bannerimageview)
        smallposterimageview.contentMode = .scaleAspectFill
        smallposterimageview.clipsToBounds = true
        smallposterimageview.layer.cornerRadius = 8
        smallposterimageview.backgroundColor = .darkGray
        smallposterimageview.translatesAutoresizingMaskIntoConstraints = false
        contentview.addSubview(smallposterimageview)
    
        ratingbadge.textColor = .systemOrange
        ratingbadge.font = UIFont.boldSystemFont(ofSize: 14)
        ratingbadge.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        ratingbadge.layer.cornerRadius = 6
        ratingbadge.clipsToBounds = true
        ratingbadge.textAlignment = .center
        ratingbadge.translatesAutoresizingMaskIntoConstraints = false
        bannerimageview.addSubview(ratingbadge)
        
        titlelabel.textColor = .white
        titlelabel.font = UIFont.boldSystemFont(ofSize: 18)
        titlelabel.numberOfLines = 0
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        contentview.addSubview(titlelabel)
        
        infocontainer.layer.cornerRadius = 8
        infocontainer.translatesAutoresizingMaskIntoConstraints = false
        contentview.addSubview(infocontainer)
        
        infostackview.axis = .horizontal
        infostackview.spacing = 16
        infostackview.distribution = .equalSpacing
        infostackview.translatesAutoresizingMaskIntoConstraints = false
        infocontainer.addSubview(infostackview)
        abouttitlelabel.text = "About Movie"
        abouttitlelabel.textColor = .white
        abouttitlelabel.font = UIFont.boldSystemFont(ofSize: 18)
        abouttitlelabel.translatesAutoresizingMaskIntoConstraints = false
        contentview.addSubview(abouttitlelabel)
        favoritebutton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoritebutton.tintColor = .systemRed
        favoritebutton.translatesAutoresizingMaskIntoConstraints = false
        contentview.addSubview(favoritebutton)
        plotlabel.textColor = .lightGray
        plotlabel.font = UIFont.systemFont(ofSize: 14)
        plotlabel.numberOfLines = 0
        plotlabel.translatesAutoresizingMaskIntoConstraints = false
        contentview.addSubview(plotlabel)
    
        NSLayoutConstraint.activate([
            
            bannerimageview.topAnchor.constraint(equalTo: contentview.topAnchor),
            bannerimageview.leadingAnchor.constraint(equalTo: contentview.leadingAnchor),
            bannerimageview.trailingAnchor.constraint(equalTo: contentview.trailingAnchor),
            bannerimageview.heightAnchor.constraint(equalToConstant: 200),
            
            smallposterimageview.topAnchor.constraint(equalTo: contentview.topAnchor, constant: 20),
            smallposterimageview.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 20),
            smallposterimageview.widthAnchor.constraint(equalToConstant: 95),
            smallposterimageview.heightAnchor.constraint(equalToConstant: 120),
            
            ratingbadge.trailingAnchor.constraint(equalTo: smallposterimageview.trailingAnchor, constant: -8),
            ratingbadge.bottomAnchor.constraint(equalTo: smallposterimageview.bottomAnchor, constant: -8),
            ratingbadge.widthAnchor.constraint(equalToConstant: 45),
            ratingbadge.heightAnchor.constraint(equalToConstant: 24),
            
            titlelabel.topAnchor.constraint(equalTo: smallposterimageview.bottomAnchor, constant: 16),
            titlelabel.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 20),
            titlelabel.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: -20),
            
            infocontainer.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 16),
            infocontainer.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 20),
            infocontainer.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: -20),
            infocontainer.heightAnchor.constraint(equalToConstant: 44),
            
            infostackview.centerYAnchor.constraint(equalTo: infocontainer.centerYAnchor),
            infostackview.leadingAnchor.constraint(equalTo: infocontainer.leadingAnchor, constant: 16),
            infostackview.trailingAnchor.constraint(equalTo: infocontainer.trailingAnchor, constant: -16),
            
            abouttitlelabel.topAnchor.constraint(equalTo: infocontainer.bottomAnchor, constant: 24),
            abouttitlelabel.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 20),
            
            favoritebutton.centerYAnchor.constraint(equalTo: abouttitlelabel.centerYAnchor),
            favoritebutton.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: -20),
            
            plotlabel.topAnchor.constraint(equalTo: abouttitlelabel.bottomAnchor, constant: 12),
            plotlabel.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 20),
            plotlabel.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: -20),
            plotlabel.bottomAnchor.constraint(equalTo: contentview.bottomAnchor, constant: -40)
        ])
    }
    func Detailsload() {
        viewModel.fetchMovieDetails(imdbID: movieID) {
            self.Updateui()
        }
    }
    func Updateui() {
        guard let detail = viewModel.movieDetail else { return }
        title = detail.Title
        titlelabel.text = detail.Title
        plotlabel.text = detail.Plot
        
        if let rating = detail.imdbRating {
            ratingbadge.text = "⭐️ \(rating)"
        }
        infostackview.arrangedSubviews.forEach { $0.removeFromSuperview() }
        Infolabelcreate(icon: "🗓️", text: detail.Year)
        if let runtime = detail.Runtime {
            Infolabelcreate(icon: "⏲️", text: runtime)
        }
        if let genre = detail.Genre {
            let genreText = genre.components(separatedBy: ",").first ?? genre
            Infolabelcreate(icon: "🎞️", text: genreText)
        }
        
        loadImage(from: detail.Poster, into: smallposterimageview)
        loadImage(from: detail.Poster, into: bannerimageview)
    }
    func Infolabelcreate(icon: String, text: String) {
        let label = UILabel()
        label.text = "\(icon) \(text)"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        infostackview.addArrangedSubview(label)
    }
    func loadImage(from urlString: String, into imageview: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    imageview.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    func Favoritebuttonsetup() {
        favoritebutton.addTarget(self, action: #selector(favoritetapped), for: .touchUpInside)
        Updateheartbutton()
    }

    func Updateheartbutton() {
        let isfavorite = FavoritesManager.shared.isfavorite(movieID: movieID)
        
        if isfavorite {
            favoritebutton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoritebutton.tintColor = .systemRed
        } else {
            favoritebutton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoritebutton.tintColor = .white
        }
    }

    @objc func favoritetapped() {
        let isfavorite = FavoritesManager.shared.isfavorite(movieID: movieID)
        
        if isfavorite {
            FavoritesManager.shared.removefavorite(movieID: movieID)
        } else {
            FavoritesManager.shared.savefavorite(movieID: movieID)
        }
        
        Updateheartbutton()
    }
}
    
