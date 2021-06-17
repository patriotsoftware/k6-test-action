import http from "k6/http";
import { sleep } from "k6";

const BASE_URL = "https://www.google.com";

export default function () {
  http.get(BASE_URL);
  sleep(1);
}