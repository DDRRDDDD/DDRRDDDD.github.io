
const size = 19;

let turn =1;
let map = [];
initMap(map);
const stone = ["https://em-content.zobj.net/thumbs/240/apple/325/black-circle_26ab.png","https://em-content.zobj.net/thumbs/240/apple/325/white-circle_26aa.png","https://em-content.zobj.net/thumbs/240/microsoft/319/black-circle_26ab.png"];

const container = document.querySelector(".container");
const grid = document.createElement("div");
const landing = document.createElement("div");

const h3 = document.querySelector("#current-turn");
const current = document.createElement("img");

grid.setAttribute("class", "box");
landing.setAttribute("class", "stone");

h3.innerHTML = "turn> ";
current.setAttribute("id", "turn");
current.setAttribute("src", stone[turn]);

container.append(grid);
container.append(landing);

h3.append(current);

//바둑판 생성
let pointY = 4;
for(let i = 0; i < size-1; i++){
  let pointX = 4;
  for(let j = 0; j < size-1; j++){
    const space = document.createElement("p");

    if((i+1) % pointY === 0 && (j+1) % pointX === 0){
      const img = document.createElement("img");
      img.setAttribute("id", "dot");
      img.setAttribute("src", stone[2]);
      space.append(img);

      pointX += 6;
    }
    grid.append(space);
  }

  if((i+1) % pointY === 0)
    pointY += 6;
}

for(let i = 0; i < size; i++){
  for(let j = 0; j < size; j++){
    const div = document.createElement("div");
    const id = `${i}x${j}`;

    div.setAttribute("id", id);

    landing.append(div);
  }
}

landing.addEventListener("click", (e) => {
  const id = e.target.getAttribute("id");
  if(id !== null){
    const index = id.split("x");
    const img = document.createElement("img");
  
    img.setAttribute("src", stone[turn%2]);
    e.target.append(img);
  
    current.setAttribute("src", stone[(turn+1) %2]);
    map[index[0]][index[1]] = turn%2;

    checkRow();
    checkColumns();
    checkDiagnal1();
    checkDiagnal2();
    turn++;
  }
});

function initMap(map){
  for(let i = 0; i < size; i++){
    map[i] = [];
  }
}

function checkRow(){
  const player = turn%2;
  for(let i = 0; i < size; i++){
    for(let j = 0; j < size-4; j++){
      let cnt = 0;
      for(let k = 0; k < 5; k++){
        if(map[i][j+k] === player)
        cnt++;
      }
      if(cnt === 5){
        const winner = player === 1 ? 1 : 2;
        return alert(`P${winner} win`);
      }
    }
  }

}
function checkColumns(){
  const player = turn%2;
  for(let i = 0; i < size; i++){
    for(let j = 0; j < size-4; j++){
      let cnt = 0;
      for(let k = 0; k < 5; k++){
        if(map[j+k][i] === player)
          cnt++;
      }
      if(cnt === 5){
        const winner = player === 1 ? 1 : 2;
        return alert(`P${winner} win`);
      }
    }
  }
}
function checkDiagnal1(){
  const player = turn%2;
  for(let i = 0; i < size-4; i++){
    for(let j = 0; j < size-4; j++){
      let cnt = 0;
      for(let k = 0; k < 5; k++){
        if(map[i+k][j+k] === player)
        cnt++;
      }
      if(cnt === 5){
        const winner = player === 1 ? 1 : 2;
        return alert(`P${winner} win`);
      }
    }
  }
}
function checkDiagnal2(){
  const player = turn%2;
  for(let i = 0; i < size-4; i++){
    for(let j = 4; j < size; j++){
      let cnt = 0;
      for(let k = 0; k < 5; k++){
        if(map[i+k][j-k] === player)
        cnt++;
      } 
      if(cnt === 5){
        const winner = player === 1 ? 1 : 2;
        return alert(`P${winner} win`);
      }
    }
  }
}



