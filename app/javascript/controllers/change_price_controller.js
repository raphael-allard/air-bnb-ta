import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['price', 'startDate']

  update() {    
    const dates = this.startDateTarget.value;
    const regex = /\d{4}-\d{2}-\d{2}/g;
    const found = dates.match(regex);
    
    const startDate = new Date(found[0]);
    const endDate = new Date(found[1]);
    
    const difference = Math.abs(endDate - startDate);
    const days = (difference / (1000 * 3600 * 24)) + 1;
    
    const price = parseInt(this.priceTarget.dataset.price, 10);
    const newPrice = price * days;

    if (!isNaN(endDate)) { this.priceTarget.innerText = newPrice; }
  }
}
