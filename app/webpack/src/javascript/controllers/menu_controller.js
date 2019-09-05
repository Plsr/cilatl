import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [ "navbarMenu", "navbarBurger" ]

  toggle() {
    this.navbarMenuTarget.classList.toggle('is-active')
    this.navbarBurgerTarget.classList.toggle('is-active')
  }
}
