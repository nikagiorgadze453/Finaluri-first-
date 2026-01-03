import UIKit
class searchViewController: UIViewController, UITextFieldDelegate {
    
    var searchbar = UITextField()
    var filterbutton = UIButton()
    var scrollview = UIScrollView()
    var contentview = UIView()
    var resultsStackview = UIStackView()
    var emptyview = UIView()
    var emptyLabel = UILabel()
    var emptySubLabel = UILabel()
    var sortmenuview = UIView()
    var sortStackview = UIStackView()
    var viewModel = SearchViewModdel()
    var showingSortMenu: Bool = false
    var searchtitlelabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        searchtitle()
        Searchbarsetup()
        Scrollviewsetup()
        Resultstackviewsetup()
        Emptyviewsetup()
        Sortmenusetup()
    }
    func Searchbarsetup() {
        searchbar.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        searchbar.textColor = .white
        searchbar.attributedPlaceholder = NSAttributedString(string: "Search movies...",attributes: [.foregroundColor: UIColor.gray])
        searchbar.layer.cornerRadius = 10
        searchbar.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        searchbar.leftViewMode = .always
        searchbar.delegate = self
        searchbar.returnKeyType = .search
        searchbar.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(searchbar)
           filterbutton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
           filterbutton.tintColor = .white
           filterbutton.addTarget(self, action: #selector(filtertapped), for: .touchUpInside)
           filterbutton.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(filterbutton)
           NSLayoutConstraint.activate([
               searchbar.topAnchor.constraint(equalTo: searchtitlelabel.topAnchor, constant: 30),
               searchbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               searchbar.trailingAnchor.constraint(equalTo: filterbutton.leadingAnchor, constant: -12),
               searchbar.heightAnchor.constraint(equalToConstant: 50),
               
               filterbutton.centerYAnchor.constraint(equalTo: searchbar.centerYAnchor),
               filterbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               filterbutton.widthAnchor.constraint(equalToConstant: 40),
               filterbutton.heightAnchor.constraint(equalToConstant: 40)
           ])
       }
       func Scrollviewsetup() {
           scrollview.translatesAutoresizingMaskIntoConstraints = false
           contentview.translatesAutoresizingMaskIntoConstraints = false
           
           view.addSubview(scrollview)
           scrollview.addSubview(contentview)
           
           NSLayoutConstraint.activate([
               scrollview.topAnchor.constraint(equalTo: searchbar.bottomAnchor, constant: 16),
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
       func Resultstackviewsetup() {
           resultsStackview.axis = .vertical
           resultsStackview.spacing = 16
           resultsStackview.translatesAutoresizingMaskIntoConstraints = false
           contentview.addSubview(resultsStackview)
           
           NSLayoutConstraint.activate([
               resultsStackview.topAnchor.constraint(equalTo: contentview.topAnchor, constant: 16),
               resultsStackview.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 16),
               resultsStackview.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: -16),
               resultsStackview.bottomAnchor.constraint(equalTo: contentview.bottomAnchor, constant: -16)
           ])
       }
       
       func Emptyviewsetup() {
           emptyview.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(emptyview)
           emptyLabel.text = "Oh No Isn't This So\nEmbarrassing?"
           emptyLabel.textColor = .white
           emptyLabel.font = UIFont.boldSystemFont(ofSize: 18)
           emptyLabel.textAlignment = .center
           emptyLabel.numberOfLines = 2
           emptyLabel.translatesAutoresizingMaskIntoConstraints = false
           emptyview.addSubview(emptyLabel)
           
           emptySubLabel.text = "I cannot find any movie with this name."
           emptySubLabel.textColor = .lightGray
           emptySubLabel.font = UIFont.systemFont(ofSize: 14)
           emptySubLabel.textAlignment = .center
           emptySubLabel.numberOfLines = 2
           emptySubLabel.translatesAutoresizingMaskIntoConstraints = false
           emptyview.addSubview(emptySubLabel)
           
           NSLayoutConstraint.activate([
               emptyview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               emptyview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               emptyview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
               emptyview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
               
               emptyLabel.topAnchor.constraint(equalTo: emptyview.topAnchor),
               emptyLabel.leadingAnchor.constraint(equalTo: emptyview.leadingAnchor),
               emptyLabel.trailingAnchor.constraint(equalTo: emptyview.trailingAnchor),
               
               emptySubLabel.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 8),
               emptySubLabel.leadingAnchor.constraint(equalTo: emptyview.leadingAnchor),
               emptySubLabel.trailingAnchor.constraint(equalTo: emptyview.trailingAnchor),
               emptySubLabel.bottomAnchor.constraint(equalTo: emptyview.bottomAnchor)
           ])
           
           emptyview.isHidden = true
       }
       
       func Sortmenusetup() {
           sortmenuview.backgroundColor = UIColor.white.withAlphaComponent(0.1)
           sortmenuview.layer.cornerRadius = 12
           sortmenuview.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(sortmenuview)
           
           sortStackview.axis = .vertical
           sortStackview.spacing = 0
           sortStackview.translatesAutoresizingMaskIntoConstraints = false
           sortmenuview.addSubview(sortStackview)
           
           let options = ["Name", "Genre", "Year"]
           for (index, option) in options.enumerated() {
               let button = UIButton()
               button.setTitle(option, for: .normal)
               button.setTitleColor(.white, for: .normal)
               button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
               button.contentHorizontalAlignment = .left
               button.tag = index
               button.addTarget(self, action: #selector(sortoptiontapped), for: .touchUpInside)
               sortStackview.addArrangedSubview(button)
           }
           NSLayoutConstraint.activate([
               sortmenuview.topAnchor.constraint(equalTo: searchbar.bottomAnchor, constant: 8),
               sortmenuview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               sortmenuview.widthAnchor.constraint(equalToConstant: 150),
               
               sortStackview.topAnchor.constraint(equalTo: sortmenuview.topAnchor, constant: 8),
               sortStackview.leadingAnchor.constraint(equalTo: sortmenuview.leadingAnchor),
               sortStackview.trailingAnchor.constraint(equalTo: sortmenuview.trailingAnchor),
               sortStackview.bottomAnchor.constraint(equalTo: sortmenuview.bottomAnchor, constant: -8)
           ])
           sortmenuview.isHidden = true
       }
       @objc func filtertapped() {
           showingSortMenu.toggle()
           sortmenuview.isHidden = !showingSortMenu
       }
       @objc func sortoptiontapped(_ sender: UIButton) {
           let options = ["Name", "Genre", "Year"]
           viewModel.sorttype = options[sender.tag]
           sortmenuview.isHidden = true
           showingSortMenu = false
           viewModel.sortMovies()
           Updateui()
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           if let query = textField.text, !query.isEmpty {
               Searchmovies(query: query)
           }
           return true
       }
       func Searchmovies(query: String) {
           viewModel.searchMovies(query: query) {
               self.Updateui()
           }
       }
       func Updateui() {
           resultsStackview.arrangedSubviews.forEach { $0.removeFromSuperview() }
           
           if viewModel.movies.isEmpty {
               emptyview.isHidden = false
               scrollview.isHidden = true
           } else {
               emptyview.isHidden = true
               scrollview.isHidden = false
               viewModel.sortMovies()
               
               for movie in viewModel.movies {
                   let resultview = Createresultview(movie: movie)
                   resultsStackview.addArrangedSubview(resultview)
               }
           }
       }
       
       func Createresultview(movie: movieDetail) -> UIView {
           let containerview = UIView()
           containerview.translatesAutoresizingMaskIntoConstraints = false
           
           let posterimage = UIImageView()
           posterimage.contentMode = .scaleAspectFill
           posterimage.clipsToBounds = true
           posterimage.layer.cornerRadius = 8
           posterimage.backgroundColor = .darkGray
           posterimage.translatesAutoresizingMaskIntoConstraints = false
           containerview.addSubview(posterimage)
           
           let titlelabel = UILabel()
           titlelabel.text = movie.Title
           titlelabel.textColor = .white
           titlelabel.font = UIFont.boldSystemFont(ofSize: 16)
           titlelabel.numberOfLines = 2
           titlelabel.translatesAutoresizingMaskIntoConstraints = false
           containerview.addSubview(titlelabel)
           let ratinglabel = UILabel()
           if let rating = movie.imdbRating {
               ratinglabel.text = "⭐️ \(rating)"
           }
           ratinglabel.textColor = .systemOrange
           ratinglabel.font = UIFont.systemFont(ofSize: 14)
           ratinglabel.translatesAutoresizingMaskIntoConstraints = false
           containerview.addSubview(ratinglabel)
           let infostackview = UIStackView()
           infostackview.axis = .vertical
           infostackview.spacing = 4
           infostackview.translatesAutoresizingMaskIntoConstraints = false
           containerview.addSubview(infostackview)
           if let genre = movie.Genre {
               let genrelabel = UILabel()
               genrelabel.text = "🎭 \(genre.components(separatedBy: ",").first ?? genre)"
               genrelabel.textColor = .lightGray
               genrelabel.font = UIFont.systemFont(ofSize: 12)
               infostackview.addArrangedSubview(genrelabel)
           }
           let yearlabel = UILabel()
           yearlabel.text = "📅 \(movie.Year)"
           yearlabel.textColor = .lightGray
           yearlabel.font = UIFont.systemFont(ofSize: 12)
           infostackview.addArrangedSubview(yearlabel)
           if let runtime = movie.Runtime {
               let runtimelabel = UILabel()
               runtimelabel.text = "⏱ \(runtime)"
               runtimelabel.textColor = .lightGray
               runtimelabel.font = UIFont.systemFont(ofSize: 12)
               infostackview.addArrangedSubview(runtimelabel)
           }
           NSLayoutConstraint.activate([
               containerview.heightAnchor.constraint(equalToConstant: 140),
               
               posterimage.topAnchor.constraint(equalTo: containerview.topAnchor),
               posterimage.leadingAnchor.constraint(equalTo: containerview.leadingAnchor),
               posterimage.widthAnchor.constraint(equalToConstant: 95),
               posterimage.heightAnchor.constraint(equalToConstant: 140),
               
               titlelabel.topAnchor.constraint(equalTo: containerview.topAnchor, constant: 8),
               titlelabel.leadingAnchor.constraint(equalTo: posterimage.trailingAnchor, constant: 12),
               titlelabel.trailingAnchor.constraint(equalTo: containerview.trailingAnchor),

               ratinglabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 8),
               ratinglabel.leadingAnchor.constraint(equalTo: posterimage.trailingAnchor, constant: 12),
               infostackview.topAnchor.constraint(equalTo: ratinglabel.bottomAnchor, constant: 8),
               infostackview.leadingAnchor.constraint(equalTo: posterimage.trailingAnchor, constant: 12),
               infostackview.trailingAnchor.constraint(equalTo: containerview.trailingAnchor)
           ])
           loadImage(from: movie.Poster, into: posterimage)
           let tapgesture = UITapGestureRecognizer(target: self, action: #selector(resulttapped))
           containerview.addGestureRecognizer(tapgesture)
           containerview.tag = viewModel.movies.firstIndex(where: { $0.imdbID == movie.imdbID }) ?? 0
           return containerview
       }
       @objc func resulttapped(_ sender: UITapGestureRecognizer) {
           guard let tappedView = sender.view else { return }
           let index = tappedView.tag
           let movie = viewModel.movies[index]
           let detailsVC = DetailsViewController(movieID: movie.imdbID)
           navigationController?.pushViewController(detailsVC, animated: true)
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
    func searchtitle(){
        searchtitlelabel.text = "Search"
        searchtitlelabel.textColor = .white
        searchtitlelabel.font = UIFont.boldSystemFont(ofSize: 20)
        searchtitlelabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchtitlelabel)
        NSLayoutConstraint.activate([
            searchtitlelabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchtitlelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
