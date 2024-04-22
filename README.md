
# News Reader Mini App
### Yahoo News Reader Mini App test

Your job is to implement a simple news reader app. The app will have two screens: a News Stream and Article Detail.

Requirements in order of priority from most important to least:

- **News Stream**: List of news articles, each with a thumbnail image, provider, and title
- **News Stream**: List should be sorted by publish date
- **News Stream**: Each news article cell should be sized appropriate to the content (potentially different sized cells).
- **News Stream**: When scrolling down the news feed, when the bottom is reached a next set of news items should be fetched & displayed (using the pagination field)
- **News Stream**: When tapping on a news article cell in the News Stream, it should open to the Article Detail screen showing the contents of the article.
- **Article Detail**: Display the contents of the selected article, including images. The article style and layout is up to you, but it should be comfortably readable.
- **News Stream**: Pull-to-refresh should refresh existing articles with changes, and bring in any new articles.

Bonus:

- Support offline reading

The exercise is designed to be open ended, feel free to add enhancements (animations, styling, etc.), as long as it is in keeping with the requirements. Please keep track of the approximate time spent on the exercise (it usually takes between 3-6 hours), and return your code to us within 24 hours.

Language used should be Swift, and you can use UIKit or SwiftUI. You are welcome to use 3rd party libraries/SDKs/Cocoapods/SPM, but be prepared to discuss why you chose them and how they work in the context of your app.

--- 

Feel free to reach out if you have any questions or need further clarification!

## App System Desing

<img width="269" alt="Screenshot 2024-04-22 at 9 38 31 AM" src="https://github.com/PedroTrujilloV/NewsReaderMiniApp/assets/3638250/f20f20e6-18bb-47a1-91ba-a7f45a925bfa">
<img width="271" alt="Screenshot 2024-04-22 at 9 39 08 AM" src="https://github.com/PedroTrujilloV/NewsReaderMiniApp/assets/3638250/3d9053c7-b2e4-44a6-a43f-a2e299b9e19f">


To begin, I delineated the functional and non-functional requirements to guide the development process effectively.

#### Functional Requirements:
* **Fetch News Stream:** Retrieve the latest news stream from the backend server.
* **Infinite Scrolling:** Enable users to scroll infinitely for pagination purposes.
* **Pull-to-Refresh:** Allow users to refresh the news stream by pulling down the scroll.
* **View Article Details:** Provide users with the ability to view detailed information about individual articles.
* **Sort Articles By Date:** Implement functionality to sort articles based on their publication date.
#### Non-Functional Requirements:
* **Availability:** Ensure the app remains accessible even without an internet connection.
* **Offline Features:** Incorporate offline capabilities to enable usage without internet connectivity.
* **Usability:** Prioritize intuitive design and readability to enhance user experience.
* **Reliability:** Maintain continuous functionality for fetching news updates without interruption.
* **Performance:** Optimize app performance to prevent freezing or crashing during usage.
* **Development Team:** Solely managed by one developer.
#### Out of Scope:
* **Authentication:** Authentication-related functionalities are not within the scope of this project.
* **Analytics:** Analytics features for tracking user behavior are omitted from the current scope.
* **Image Cache:** Image caching mechanisms are excluded from the current development scope.
* **Security:** While partially considered, comprehensive security measures are not the primary focus.

Based on the functional requirements, we can define the following App Use Cases:

￼<img src="https://github.com/PedroTrujilloV/NewsReaderMiniApp/assets/3638250/ef0d3989-3da9-4d5a-999e-592f13c3389f" alt="Image Description" width="40%">


In this context, a single user possesses their own news stream, which comprises multiple articles. While the complete data model schema includes additional entities like Content and Provider, our focus here is primarily on News Stream and Article for simplicity.

It's important to note that we're excluding any features related to authentication and session management for the sake of clarity. In this context, the user serves as more of an abstract figure or actor and will not be directly represented in the codebase.


￼￼<img src="https://github.com/PedroTrujilloV/NewsReaderMiniApp/assets/3638250/11ea05c7-ec43-495f-9e13-ee1326206ddd" alt="Image Description" width="40%">



After identifying the essential entities required for the application, I move forward to create the corresponding data models that will be utilized within the app. Among these models are:


￼￼<img src="https://github.com/PedroTrujilloV/NewsReaderMiniApp/assets/3638250/902325c7-79e5-416d-a2c9-b03430580a3d" alt="Image Description" width="60%">




To grasp the structure of the app, it's essential to take a step back and examine the bigger picture of the problem at hand. This approach enables me to discern the separation of concerns and identify the components required to maintain this separation. By doing so, I can effectively connect these components in a cohesive manner, allowing them to share information without delving into the intricacies of their dependencies. This approach ensures that the structure remains clean, decoupled, and conducive to readability, scalability, and maintainability.

With that in mind, let's explore the high-level architectural diagram for the application:

￼￼<img src="https://github.com/PedroTrujilloV/NewsReaderMiniApp/assets/3638250/84ed0e2a-40d9-48e2-b83d-5c0981e39eec" alt="Image Description" width="60%">


An image is better than a thousand words,offering a clear depiction of our app's essential components and their interrelationships. Let's delve into each component:
* **API Service:** This component handles API-level logic, executing URL requests to the backend server.
* **Repository:** Serving as the bridge between the API Service and the Persistence Container, the Repository resolves and stores the source of truth. It orchestrates data models and embodies the offline feature logic.
* **Persistence Container:** This container persists entities locally on the device, facilitating offline usage.
* **Domain:** The business logic of the system resides here, encompassing entities and use cases.
    * News Stream Service: In our compact app, this service encapsulates use case actions, making them accessible to the UI layer.
    * Entities: These are the system's core entities.
* **Application:** This section houses the application logic, including view components and architectural patterns such as ViewModels.
    * UI: Here, views and ViewModels work in tandem to format and present articles to the user.
        * ViewModels: Responsible for orchestrating data loading and presenting it to the views.
* **Media Cache:** Acting as a media loader, this component retrieves images, files, and other static content from the Content Delivery Network. It caches this data on the device to prevent redundant queries and facilitates offline image viewing.

##### Third party dependencies:
For Media Caching I used [NetworkImage](https://github.com/gonzalezreal/NetworkImage). This is a package that simplifies loading, caching and persistence of images in your app, providing offline features to this. 

Thanks for viewing!
