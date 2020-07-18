

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $uploadedImg[0].style.backgroundImage = 'url(' + e.target.result + ')';
    };

    reader.readAsDataURL(input.files[0]);
    // calling api
    var fileName = input.files[0].name;
    var formdata = new FormData();
    formdata.append("", input.files[0], input.files[0].name);

    var requestOptions = {
      method: 'POST',
      body: formdata,
      redirect: 'follow'
    };

    fetch("https://cors-anywhere.herokuapp.com/http://13.232.214.38:81/predict", requestOptions)
      .then(response => response.json())
      .then(result => {
        document.querySelector('.resultWrapper').innerHTML = ` <div class="result">
        <h1>Results</h1>
        <div class="myTable">
          <table>
            <tr>
              <th>Disease</th>
              <th>Percentage of Having</th>
            </tr>
            <tr>
              <td>${result['1:']}</td>
              <td>${Number(result['2:'])}</td>
            </tr>
            <tr>
              <td>${result['3:']}</td>
              <td>${Number(result['4:'])}</td>
            </tr>
            <tr>
              <td>${result['5:']}</td>
              <td>${Number(result['6:'])}</td>
            </tr>
            <tr>
              <td>${result['7:']}</td>
              <td>${Number(result['8:'])}</td>
            </tr>
          </table>
          <p class="symptoms">Symptoms of ${result['1:']}</p>
          <p class="symptomDescription">${result['Symptoms: ']}</p>
        </div>`
      })
      .catch(error => console.log('error', error));
  }
}

var $form = $("#imageUploadForm"),
  $file = $("#file"),
  $uploadedImg = $("#uploadedImg"),
  $helpText = $("#helpText")
  ;
$file.on('change', function () {
  readURL(this);
  $form.addClass('loading');
});
$uploadedImg.on('webkitAnimationEnd MSAnimationEnd oAnimationEnd animationend', function () {
  $form.addClass('loaded');
});




