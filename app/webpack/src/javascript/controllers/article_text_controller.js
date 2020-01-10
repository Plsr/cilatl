import { Controller } from "stimulus";

// IDEA: Simply do not allow selecting more than one paragraph for the first iteration
// TODO: Display context menu after selection, only hightlight after click
export default class extends Controller {
  mouseUp() {
    // TODO: Move selection handling into its own class
    const selection = document.getSelection();
    if (this.isEmpty(selection)) return;
    if (this.spansMultipleNodes(selection)) return;

    // TODO: Handle case when no selection has been found
    const selectedHTML = this.getSelectionHTML(selection);

    // TODO: Check, if the selection spans more than one node
    this.wrapInMarks(selectedHTML);
    const frag = document
      .createRange()
      .createContextualFragment(selectedHTML.innerHTML);

    selection.getRangeAt(0).insertNode(selectedHTML);
  }

  /**
   * Checks if a selection spand across multiple text nodes.
   *
   * @param {Selection} selection the selection to be checked
   * @return {boolean} True if selection only spans over one text node
   */
  spansMultipleNodes(selection) {
    const anchorNode = selection.anchorNode;
    const focusNode = selection.focusNode;

    return !anchorNode.isSameNode(focusNode);
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
