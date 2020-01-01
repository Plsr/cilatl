import { Controller } from "stimulus";

export default class extends Controller {
  mouseUp() {
    const selection = document.getSelection();
    if (this.isEmpty(selection)) return;

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

    // TODO: Handle case when no selection has been found
    const selectedHTML = this.getSelectionHTML(selection);
    console.log(selectedHTML);
    this.wrapInMarks(selectedHTML);
    console.log(selectedHTML.innerHTML);

    selection.getRangeAt(0).insertNode(selectedHTML);

    // TODO: For child of the selected html, move down the child tree
    // If no more children are found, wrap the contents of the node with
    // a <mark> tag
  }

  wrapInMarks(node) {
    // DEBUG
    console.log("wrapInMarks called");
    console.log(node);

    if (!node.hasChildNodes()) {
      console.log("root node found");

      // root child
      if (node.nodeType !== 3) {
        console.log("non-textual root node");

        return;
      }

      const markWrapper = document.createElement("mark");
      // TODO: Set classname

      node.parentNode.insertBefore(markWrapper, node);
      markWrapper.appendChild(node);
      console.log("changed innerHTML");

      return;
    }

    console.log("going deeper");

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
