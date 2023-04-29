// app/javascript/controllers/pagination_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.addEventListener("change", this.pagination.bind(this));
  }

  pagination(event) {
    const perPage = event.target.value;
    const currentPage = this.data.get("page");
    const path = this.data.get("path");
    const url = `${path}?page=${currentPage}&per_page=${perPage}`;

    // 非同期リクエストを送信
    fetch(url, {
      headers: {
        "Accept": "text/javascript"
      }
    }).then(response => response.text())
      .then(script => {
        eval(script);
      });
  }
}
