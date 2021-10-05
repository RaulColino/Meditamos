# Data Layer

## Role in Clean Architecture

* Services: API and DB adpters.

Other implementations have separated code in Repository Implementations and DataSources. Repository Implementations just calls local or remote DataSources
methods. But in our case the decision of taking data from a remote or local datasource is made by the bussiness logic of the usecases:

Services = Repository Implementations + DataSources

There are local Services or remote Services. The Usecases makes use of those services requiring 
the data in the format they need. Usecases only know there are local and remote Services but they
dont know about the technology or implementation. Services must adapt the data (Models) from the API,DB,etc.
to data Usecases understand (Entities). Services must adapt Entities to Models as well to send data to the
API,DB,etc.

## Local Database: ObjectBox

We aren't using objectbox sync. Without sync objectbox supports Android 4.0.3 (API level or minimum SDK 15).

If using objectbox sync one must bump the minimum android sdk
version to at least 21 (android 5.0).

<br/>

> To generate ObjectBox binding code for your entities, make sure to run *pub run build_runner build* after making any changes to the entity classes. 

<br/>

### Warning

For XCode/iOS only: increase the deployment target to iOS 11 and, under Architectures, replace ${ARCHS_STANDARD} with arm64 (or $ARCHS_STANDARD_64_BIT). See FAQ for details.
### References
[ObjectBox](https://docs.objectbox.io/)


## Remote API: Sanity