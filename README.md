# DependencyInversion31layer

This repository is a demonstration of an iOS app architecture that follows the Dependency Inversion principle and adheres to the SOLID principles. It is designed to showcase a 3+1 layer architecture for building iOS applications. Additionally, it includes the capability to conduct UITests and XCTest for testing purposes.

## Overview

The primary goal of this project is to illustrate a well-structured and maintainable iOS app architecture. It accomplishes this by:

1. **Dependency Inversion Principle**: This architecture adheres to the Dependency Inversion Principle, which encourages the use of abstractions (protocols) and dependency injection to decouple high-level modules from low-level modules.

2. **SOLID Principles**: The codebase is organized in a way that promotes adherence to the SOLID principles, which are a set of five design principles that aim to make software more maintainable and flexible.

3. **3+1 Layer Architecture**: The app is structured into three primary layers - Presentation, Domain, and Data, with an additional layer for Dependency Injection. This separation helps maintain clear responsibilities and ensures modularity.

4. **Network Data Loading**: The app demonstrates how to load data from an API endpoint and decode JSON responses, providing a practical example of working with network requests and data parsing.

5. **Error Handling**: Proper error handling mechanisms are implemented throughout the layers of the app to ensure graceful degradation in case of failures.

6. **Testing**: The project includes test targets for both UITests and XCTest, making it easy to write and run automated tests to verify the functionality of the app.

## Project Structure

The project structure is organized as follows:

- **Presentation Layer**: This layer contains the user interface components, view controllers, and presentation logic. It is responsible for displaying data to the user.

- **Domain Layer**: The domain layer defines the business logic and use cases of the application. It is independent of any UI-related code and serves as the core of the application.

- **Data Layer**: This layer deals with data retrieval and storage. It includes networking code, data models, and data storage implementations.

- **Dependency Injection**: The Dependency Injection layer handles the setup and management of dependencies in the application. It ensures that the app adheres to the Dependency Inversion Principle.

- **UITest**: The UITest target contains automated UI tests that verify the app's functionality from a user's perspective.

- **XCTest**: The XCTest target contains unit tests that focus on testing individual components of the app in isolation.

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/DependencyInversion31layer.git
   ```

2. Open the Xcode project (`DependencyInversion31layer.xcodeproj`) in Xcode.

3. Build and run the project on the simulator or a physical device.

4. Explore the code and the app's architecture to gain a better understanding of how it's structured.

5. To run UITests or XCTest, select the respective target and execute the tests.

## Dependencies

The project has minimal external dependencies and uses Swift Package Manager for managing packages. The primary dependencies include:

- **Alamofire**: Used for making network requests.

Ensure that you have Xcode and Swift Package Manager set up properly to fetch these dependencies when building the project.

## Contributing

If you would like to contribute to this project, please follow these steps:

1. Fork the repository.

2. Create a new branch for your feature or bug fix.

3. Make your changes and commit them with clear and concise commit messages.

4. Push your changes to your fork.

5. Create a pull request against the main repository.

6. Wait for review and approval from project maintainers.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or need further assistance, feel free to reach out to Gianluca at Gianlucapo.apps@gmail.com.

Thank you for your interest in this project! We hope it serves as a helpful resource for understanding iOS app architecture with Dependency Inversion and SOLID principles.
