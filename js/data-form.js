function handleSubmit(event) {
    event.preventDefault();

    const formData = new FormData(event.target);
    const data = {};
    formData.forEach((value, key) => {
      data[key] = value;
    });

    fetch("Php/index.php", {
      method: "POST",
      body: JSON.stringify(data),
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then((response) => response.json())
      .then((result) => {
        console.log(result);

        window.location.href =
          "https://docs.google.com/forms/d/e/1FAIpQLScAyvTcCYkgsl9wE7qn8zPrgPHWa_T0RlJ_0_GNr25O6bkn8w/viewform?usp=sf_link";
      })
      .catch((error) => console.error("Error:", error));
  }