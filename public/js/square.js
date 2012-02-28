var selectedCells = Array();

$(document).ready(function() {
  
  // for each cell
  for(var r = 0 ; r < 9 ; r++) {
    for(var c = 0 ; c < 9 ; c++) {
      // add a click event handler that will save/remove selections 
      $("#r"+r+"c"+c).click(function(e) {
        cell = $(this)[0];
        text = cell.innerText;
        if(cell.bgColor == "yellow") {
          cell.bgColor = "white";
          // remove selection
          for(var i = 0 ; i < selectedCells.length; i++) {
            if(selectedCells[i] == cell.id) {
              selectedCells.splice(i, 1);
              break;
            }
          }
        } else if(text == "") {
          // set the value
          cell.bgColor = "yellow";
          // add selection
          selectedCells.push(cell.id);
        } else {
          // the cell is already taken
          alert("Cell is already taken " + text);
        }
      });
    }
  }
});

// Add click listener to submit the changes made to the board
function submitSquare(gameId, user) {
  var xmlhttp;
  if (window.XMLHttpRequest) {
    xmlhttp = new XMLHttpRequest(); // code for IE7+, Firefox, Chrome, Opera, Safari
  } else {
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); // code for IE6, IE5
  }

  xmlhttp.open("POST", "/game/submit/" + gameId, true);
  xmlhttp.setRequestHeader("Content-type", "application/text");

  var selectedCellsData = user + "\n";
  for(var i = 0 ; i < selectedCells.length; i++) {
    selectedCellsData += selectedCells[i].charAt(1) + " " + selectedCells[i].charAt(3);
    selectedCellsData += "\n";
  }

  xmlhttp.send( selectedCellsData );

  xmlhttp.onreadystatechange = function(e) {
    if(xmlhttp.status == 200) {
      // change selected cells to green
      for(var i = 0 ; i < selectedCells.length; i++) {
        $("#" + selectedCells[i])[0].bgColor = "green";
        $("#" + selectedCells[i])[0].innerHTML = user;
      }
    } else {
      alert("Unable to process change: " + xmlhttp.status);
    }
  };
}


