import React, {useState} from 'react'

const Main = () => {
    const [input, setInput] = useState("")
    const [genres, setGenres] = useState([])


    function handleSubmit() {
        const headers = {
            "Accept": "application/json",
            "Content-Type": "application/json"
          }
          const options = {
            method: "POST",
            headers,
            body: JSON.stringify({
                message: input
            })
        }
        fetch('/generate', options)
        .then(res => res.json())
        .then(data => setGenres(data.spotify_genres))
    }

  return (
    <div className="App">
        <label>Type in mood here, or Sentence</label>
        <br>
        </br>
        <input onChange={(e) => setInput(e.target.value)} type='text'></input>
        <button onClick={handleSubmit}>Search</button>
        <br></br>
        <div>
            {genres.map(g => <h1>{g}</h1>)}
        </div>
    </div>
  )
}

export default Main