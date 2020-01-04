import { Controller } from "stimulus";

// IDEA: Simply do not allow selecting more than one paragraph for the first iteration
export default class extends Controller {
  mouseUp() {
    const selection = document.getSelection();
    if (this.isEmpty(selection)) return;

    console.log(selection)

    // TODO: Get selection text
    // TODO: Mark selected text in frontend
    // TODO: Get selection position in document (i.e. is this the first instancte
    // this exact text has been selected?)
    // TODO: Display menu above selection
    const anchorNode = selection.anchorNode.textContent;
    const focusNode = selection.focusNode.textContent;

    // The offset to the start of the selection
    const anchorOffset = selection.anchorOffset;

    // The offset to the end of the selection
    const focusOffset = selection.focusOffset;

    const adaptionNeeded = this.selectionNeedsAdaption(selection)
    console.log(adaptionNeeded)

    // TODO: Find out, if the end, the beginning or both need adaption

    // TODO: Handle case when no selection has been found
    const selectedHTML = this.getSelectionHTML(selection);
    console.log(selectedHTML)
    console.log(typeof selectedHTML);
    //this.wrapInMarks(selectedHTML);
    const frag = document.createRange().createContextualFragment(selectedHTML.innerHTML)
    console.log(frag)
    console.log(typeof selectedHTML.innerHTML);
    console.log(selectedHTML)

    // TODO
    // For the beginning and the end of the selection, check if it
    // starts at the beginning of the node.
    // If not, we want to remove the opening tags of the first child.
    // The same procedure would be needed for the end of the selection, if
    // the selection end in a different child than it began in.
    // All of the above only has to happen if the selection spreads over
    // multiple nodes
    selection.getRangeAt(0).insertNode(selectedHTML);
  }

  // TODO: Better name
  selectionNeedsAdaption(selection) {
    const anchorNode = selection.anchorNode
    const focusNode = selection.focusNode

    if (anchorNode.isSameNode(focusNode)) {
      return false
    }

    if (selection.anchorOffset === 0 && selection.focusOffset === focusNode.length) {
      return false
    }

    return true
  }

  // TODO: Remove wrapping span
  wrapInMarks(node) {
    if (!node.hasChildNodes()) {
      if (node.nodeType !== 3) {
        return;
      }
      // TODO: Set classname
      const markWrapper = document.createElement("mark");
      node.parentNode.insertBefore(markWrapper, node);
      markWrapper.appendChild(node);
      return;
    }

    node.childNodes.forEach(childNode => this.wrapInMarks(childNode));
  }

  /**
   *  From a given selection, extract the selected html
   *
   *  TODO: Adapt docs
   *  @param {Selection} selection
   *  @return {String} selected html
   */
  getSelectionHTML(selection) {
    // TODO: Check if there are ranges available
    const selectedText = selection.getRangeAt(0).extractContents();
    const span = document.createElement("span");
    span.appendChild(selectedText);
    return span;
  }

  /**
   * Check if a given selection is empty or only whitespace
   * @param {Selection} selection
   * @return {boolean} True if selection is empy or just whitespace
   */
  isEmpty(selection) {
    if (selection.isCollapsed) return true;
    return selection.addRange.toString() && !selection.toString().trim();
  }
}
