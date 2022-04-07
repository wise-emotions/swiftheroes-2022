# Modern Collection Views by Example
This repository contains the source code for the examples showcased at Swift Heroes 2022.

## List
This example showcases the new APIs to create lists in Collection Views.

### Layout
The layout is created inside the `ListViewController`, a subclass of `UICollectionViewController`. An instance of `UICollectionViewCompositionalLayout` is created by using the `list` method which will need a `UICollectionLayoutListConfiguration` – this type describes the configuration for a list layout.

### Data Source
`ListDataSource` is a subclass of `UICollectionViewDiffableDataSource`, and it's generic on the `ListSection` and `ListItem` types. We will use this as the data source of our collection view.

For this example we only want to display a list of static items, so the `ListItem` cases will have simple `String`s as associated values, which will also be used as titles for the cells.

> Note that sections and items should be unique in diffable data sources.

The `applyInitialSnapshot` method inside our data source creates the initial snapshots that should be applied. Here we create instances of `NSDiffableDataSourceSectionSnapshot`, we append a parent `.header` item. Then we append the `.item` items to the `.header` item. This way we are creating a relationship between a parent `.header` item and children `.item` item, which will enable the expanding and collapsing behaviour on the list.

Then when inside the initialiser we create instances of `CellRegistration` to register and configure the cells. We also initialise the data source and implement the `CellProvider` closures, where we can dequeue the cells by using the `dequeueConfiguredReusableCell` on our collection view.


## App Store
This example showcases the basics of the Compositional Layout APIs.

### Layout
The `AppStoreLayout` class inherits from `UICollectionViewCompositionalLayout` and contains the business logic to create the layout.

Inside the `appGroupSection` method we create an instance of `NSCollectionLayoutItem`, this item that will represent an app. Then we create an instance of `NSCollectionLayoutGroup` by using the `vertical` initialiser method, which creates a group with vertical layout. Here we specify that we want to display 3 items in each group. 

#### Layout Size and Dimensions
For both our item and group we need to specify a `NSCollectionLayoutSize` which tells the layout how to size them.
Dimensions in layout sizes are expressed through the `NSCollectionLayoutDimension` class, which provides these methods:
- `fractionalWidth()` and `fractionalHeight()` which allow us to specify a fraction. These can be used to specify the proportions of the items and groups compared to their containers.
- `absolute()` with which we specify a fixed dimension.
- `estimated()` which will allow for dynamically sized items and groups – we still need to specify an estimated value for the dimension.

#### Orthogonal Scrolling
By default collection views lay out their content on the main layout scroll axis, which, for this example, is set to `.vertical`. Compositional Layout allows us to layout content in sections orthogonally to the main axis, which in this case would be the horizontal axis.

We can also specify different behaviour for the scrolling by setting the `orthogonalScrollingBehavior` property on `NSCollectionLayoutSection`.

## Music
This example showcases the composability of Compositional Layout. Our goal here is to display a list in one section and a grid of items in another one.

### Layout
Inside the `MusicLayout` class we create the layouts for our sections in the `menuSectionLayout` and `recentsSectionLayout` methods. In the initialiser of the class we can initialise the layout by using the `init(sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider, configuration: UICollectionViewCompositionalLayoutConfiguration)` initialiser.

Inside the `sectionProvider` closure we can return a different `NSCollectionLayotuSection` instance depending on the section index argument. We can also specify the `configuration` of our layout to modify different properties, such as the `interSectionSpacing`.

#### Boundary Supplementary Items
`NSCollectionLayoutBoundarySupplementaryItem` allows us to display headers and footers in sections. Just like regular items and groups we need to specify the layout size. We can then create the instance of our supplementary item by specifying the `elementKind` identifier and `alignment`, which determines on which boundary to align the item.

To display the supplementary view we also need to implement the `supplementaryViewProvider` closure in the data source. Just like the `cellProvider` closure, it allows us to dequeue the supplementary view. We can use the new Registration APIs for supplementary views too.

## Custom Layout
In this example we showcase how to create a completely custom layout with Compositional Layout. The main section of this layout will display cells on the horizontal axis. It will also have multiple expandable and collapsible sections.

### Data Source
The data source will use the `OfferSection` and `OfferItem` enums to identify our models – their cases will use identifiers as associated values, as we want the content of the collection view to be dynamic.

Since we are creating a custom layout, we will not get the expanding and collapsing behaviour out of the box. We will add this behaviour inside the `toggleCategoryExpansion` method where we modify our section snapshots with the `expand` and `collapse` method. Since we want this state to be reflected in the UI we also call the `setExpansion` method on our storage, which will modify our model. Lastly we will ask the snapshot to reconfigure the item with the `reconfigureItems` method.

### Layout
The cards in our `offers` section should scale to highlight the card in the center. To modify the scale of the cell we will use the `visibleItemsInvalidationHandler` closure on the `NSCollectionLayoutSection` where we can apply a transform to our items.
> Note that the `visibleItemsInvalidationHandler` is not supported on layouts that use estimated dimensions. An alternative solution that uses `UICollectionViewLayoutAttributes` is provided.
