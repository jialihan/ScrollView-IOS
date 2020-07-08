

[]
#### Add ScrollView to StoryBoard
set 4 anchor constraints to scrollView related to our main view
Here use whole screen as example, you can adjust distance on your own.
```
scrollView.top = self.view.top
scrollView.leading = self.view.leading
scrollView.trailing = self.view.trailing
scrollView.bottom = self.view.bottom
```
#### Add StackView inside ScrollView
1. pay attention to the layer: `stack view is inside scroll view`
2. set stack view 4 anchor to scrollview: take `100% whole `of scroll view's `contentLayout Guide`. here is the content layout because we have multiple stack view to expand to taken the content layout space.
    ```
    stackView.top = contentLayout.top
    stackView.leading = contentLayout.leading
    stackView.trailing = contentLayout.trailing
    stackView.bottom = contentLayout.bottom
    ```
3. Important!!!!!!
   if you want to set height/width because we usually want to use `vertical or horizontal` scrollview. Then we could to `bound`  stack view's `width/height constraints` equal to scrow view's `Frame Layout`.
    ```
    // horizontal scrollview: height is the same
    stackView.height = frame layout.height
    // vertical scrollview: width is the same
    stackView.width = frame layout.width
    ```
    
4. Add subview inside the stackview
4.1) add multiple `UIView inside the  Stack view`.
4.2) for each page/slide view, we can set its own layout. cool?! really.
    here element's constraints only need to set with this uiview is enought. upper layer won't be affected.
For example: add button, label to subview(UIView in stack view)
    ```
    // use subview to represent the UIView: more clear
    button.top = subview.top + 100
    label.leading = subview.leading + 20
    ...
    ```
  #### Add Page Control
  page control is the same level of scroll view, it's a element in our root view. Page control's contraints should also set to our root view.
  
  1. you can create a reference outlet for page control:
      ```
        `@IBOutlet weak var pageControl: UIPageControl!
      ```
  2. sometimes we might need to bring page control to top level in our root view.
      ```
      view.bringSubviewToFront(pageControl)
      ```
