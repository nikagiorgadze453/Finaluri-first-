import UIKit

class FavoritesViewController: UIViewController {
    var scrollview = UIScrollView()
    var contentview = UIView()
    var mainstackview = UIStackView()
    var emptyview = UIView()
    var emptyLabel = UILabel()
    var emptySubLabel = UILabel()
    var viewModel = favoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Favourites"
        Scrollviewsetup()
        Stackviewsetup()
        Emptyviewsetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           Favoritesload()
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
       func Stackviewsetup() {
           mainstackview.axis = .vertical
           mainstackview.spacing = 20
           mainstackview.translatesAutoresizingMaskIntoConstraints = false
           contentview.addSubview(mainstackview)
           NSLayoutConstraint.activate([
               mainstackview.topAnchor.constraint(equalTo: contentview.topAnchor, constant: 20),
               mainstackview.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 16),
               mainstackview.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: -16),
               mainstackview.bottomAnchor.constraint(equalTo: contentview.bottomAnchor, constant: -20)
           ])
       }
       func Emptyviewsetup() {
           emptyview.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(emptyview)
           emptyLabel.text = "No Favourites Yet"
           emptyLabel.textColor = .white
           emptyLabel.font = UIFont.boldSystemFont(ofSize: 18)
           emptyLabel.textAlignment = .center
           emptyLabel.translatesAutoresizingMaskIntoConstraints = false
           emptyview.addSubview(emptyLabel)
           emptySubLabel.text = "All moves marked as favourite will be\nadded here"
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
       func Favoritesload() {
           viewModel.fetchFavoriteMovies {
               self.Updateui()
           }
       }
       func Updateui() {
           mainstackview.arrangedSubviews.forEach { $0.removeFromSuperview() }
           
           if viewModel.movies.isEmpty {
               emptyview.isHidden = false
               scrollview.isHidden = true
           } else {
               emptyview.isHidden = true
               scrollview.isHidden = false
               
               var row: UIStackView?
               for (index, movie) in viewModel.movies.enumerated() {
                   if index % 3 == 0 {
                       row = UIStackView()
                       row?.axis = .horizontal
                       row?.distribution = .fillEqually
                       row?.spacing = 12
                       mainstackview.addArrangedSubview(row!)
                   }
                   let movieView = Movieviewfunc(movie: movie)
                   row?.addArrangedSubview(movieView)
               }
           }
       }
       func Movieviewfunc(movie: movie) -> UIView {
           let containerview = UIView()
           let imageview = UIImageView()
           imageview.contentMode = .scaleAspectFill
           imageview.clipsToBounds = true
           imageview.layer.cornerRadius = 8
           imageview.backgroundColor = .darkGray
           imageview.translatesAutoresizingMaskIntoConstraints = false
           
           let titlelabel = UILabel()
           titlelabel.text = movie.Title
           titlelabel.textColor = .white
           titlelabel.font = UIFont.systemFont(ofSize: 12)
           titlelabel.textAlignment = .center
           titlelabel.numberOfLines = 2
           titlelabel.translatesAutoresizingMaskIntoConstraints = false
           
           containerview.addSubview(imageview)
           containerview.addSubview(titlelabel)
           
           NSLayoutConstraint.activate([
               imageview.topAnchor.constraint(equalTo: containerview.topAnchor),
               imageview.leadingAnchor.constraint(equalTo: containerview.leadingAnchor),
               imageview.trailingAnchor.constraint(equalTo: containerview.trailingAnchor),
               imageview.heightAnchor.constraint(equalToConstant: 160),
               titlelabel.topAnchor.constraint(equalTo: imageview.bottomAnchor, constant: 8),
               titlelabel.leadingAnchor.constraint(equalTo: containerview.leadingAnchor),
               titlelabel.trailingAnchor.constraint(equalTo: containerview.trailingAnchor),
               titlelabel.bottomAnchor.constraint(equalTo: containerview.bottomAnchor)
           ])
           
           loadImage(from: movie.Poster, into: imageview)
           
           let tapgesture = UITapGestureRecognizer(target: self, action: #selector(movietapped))
           containerview.addGestureRecognizer(tapgesture)
           containerview.tag = viewModel.movies.firstIndex(where: { $0.imdbID == movie.imdbID }) ?? 0
           
           return containerview
       }
       @objc func movietapped(_ sender: UITapGestureRecognizer) {
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
}
