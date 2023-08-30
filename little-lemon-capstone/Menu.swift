import SwiftUI
import CoreData

struct MenuView: View {
    @State private var menuList: MenuList?
    @Environment(\.managedObjectContext) private var viewContext // Access the managed object context
    @State private var searchText = ""
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    private func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    var body: some View {
        VStack {
            Text("My Restaurant App") // Title
                .font(.largeTitle)
                .padding()
            
            Text("Location: Chicago") // Location
                .font(.headline)
                .padding()
            
            Text("Welcome to our restaurant app! Explore our delicious menu and place your order with ease.") // Description
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            TextField("Search menu", text: $searchText)
                .padding()
            
            // Use the searchText in your filter with NSPredicate
            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List(dishes) { dish in
                    DishRow(dish: dish)
                }
                .listStyle(.plain)
            }}
                           .onAppear {
                               getMenuData()
                           }
        }
        
        // Method to fetch menu data
        func getMenuData() {
            // Clear the database
            PersistenceController.shared.clear()
            
            // Define the server URL
            let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json" // Replace with your actual server URL
            
            // Create a URL object
            guard let url = URL(string: serverURLString) else {
                print("Invalid URL")
                return
            }
            
            // Create a URLRequest
            let request = URLRequest(url: url)
            
            // Create a URLSession task to fetch data
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Check if data is available
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    // Create a JSONDecoder instance
                    let decoder = JSONDecoder()
                    
                    // Decode the received data into a MenuList object
                    if let menuList = try? decoder.decode(MenuList.self, from: data) {
                        
                        // Convert MenuItem objects into Dish objects and save to the database
                        for menuItem in menuList.menu {
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                            dish.image = menuItem.image
                            dish.price = menuItem.price
                        }
                        
                        // Save the data into the database
                        try? viewContext.save()
                    } else {
                        print("Failed to decode data")
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
            task.resume()
        }
        
    }

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


