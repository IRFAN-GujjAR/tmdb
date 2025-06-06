# TMDb App

TMDb is a cross-platform application developed using the Flutter framework that uses the https://www.themoviedb.org API 
to fetch information on movies, TV shows, celebrities, etc.

***Playstore Link***: https://play.google.com/store/apps/details?id=com.irfangujjar.tmdb&hl=en

***Code Structure***
- Clean Architecture

***Security***
- The API key is stored in the Google Cloud Secret Manager, and all the requests are made through Firebase Cloud Functions (written in TypeScript), which prevents hackers from accessing the API key by reverse engineering the APK, as the API key is not embedded in the APK.
- Firebase App Check is enabled, which only allows APK or app bundle signed by the developer's Google Play Signing key to make requests to Firebase Cloud Functions to avoid misuse.

***Cache***
- Flutter Drift sqlite3 library is used for caching data on Movies, TV Shows, Celebrities, Search, and TMDb pages.
  
**App ScreenShots**
                                  
<img src="Images/android/1.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/android/2.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/android/3.png" width="217">

<img src="Images/android/4.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/android/5.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/android/6.png" width="217">

<img src="Images/android/7.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/android/8.png" width="217">


# License

Copyright (c) 2025 Muhammad Irfan Ali

http://www.apache.org/licenses/LICENSE-2.0

Besides the above notice, the following license applies, and this license notice must be included in all works derived from this project.

**You are not allowed to publish this app on Appstore or Playstore.**

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
