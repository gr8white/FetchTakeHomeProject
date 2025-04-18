### Summary: Include screen shots or a video of your app highlighting its features
<img src="https://github.com/user-attachments/assets/12bed128-6309-48f0-ae10-7a6882fbb31c" width="250"/> <img src="https://github.com/user-attachments/assets/ec6619c5-da17-4e70-978b-3eb4b8ef6460" width="250"/> <img src="https://github.com/user-attachments/assets/09e7ecb4-b67a-4f81-b7f2-d4d2dfed39fe" width="250"/>
![Simulator Screen Recording - iPhone 16 Pro Max - 2025-04-18 at 02 39 19](https://github.com/user-attachments/assets/6f327465-abc3-481d-9b71-b93d2a83fff1)
![Simulator Screen Recording - iPhone 16 Pro Max - 2025-04-18 at 02 42 58](https://github.com/user-attachments/assets/3c9599af-0f26-40da-a91a-96749a09225b)


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
- Networking Foundation: Networking was priority number one when I reading the description for the take home project. I knew that at the end of the day the foundation that my project was built would create a smooth UX/UI in later commits as well as allow this project to show signs of scalability.
- UI: My main goals with UI were to prioritize reusability and scalability and to also take an approach that didn't use ViewModels. I have been studying and practicing this architectural approach for the past month or so and it has been great for learning about EnvironmentObjects and building production quality apps the way Apple intended.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent around 4-5 hours actually working on this project. I spent about 30 minutes rereading the project description to make sure that no details were skipped and the priorities were focused on. Before I began coding I created this brief gameplan to make sure that I met the requirements and added the features that I thought would be interesting, challenging and showcase my skills. This list also coincides with my commits:
- Phase 1 - Foundation
    - [ ]  Establish recipe model
    - [ ]  Network store
    - [ ]  Image caching
- Phase 2 - UI
    - [ ]  Show list of recipes (empty state and malformed data)
    - [ ]  Navigation to recipe details
    - [ ]  loading state
- Phase 3 - Features
    - [ ]  Refresh and filter list
    - [ ]  youtube video window
    - [ ]  show source url in sheet
- Phase 4 - Testing
    - [ ]  Logic testing in XCTests

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
None that I know of.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I built the fetchData function to be reusable with any type of JSON link because that is always how I've build asynchronous URL requests in the test projects I've worked on. Hopefully this isn't looked at as a con because I do still think it aids in the components overall reusability. While it is generic, I could reuse that NetworkingStore again in another project with a few more details added here and there. Likewise with the testing that i wrote for the store. Because the functions are so generic in their usability the matching tests were simply testing for valid and invalid json.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I think that this project was a great exhibition of my skillset as a self taught iOS developer. While there are some areas that I could probably use some work, I hope that my attention to detail and archetectural approach show that I am all about execution and delivery.


Looking forward to hearing some feedback from you all soon! 👍
