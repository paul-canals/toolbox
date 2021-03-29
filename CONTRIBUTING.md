# Contributing Guidelines

## How to contribute to Toolbox

#### **Did you find a bug?**

* **Do not open up a GitHub issue if the bug is a security vulnerability in Toolbox**, and instead to refer to our [security policy](https://github.com/paul-canals/toolbox/blob/master/SECURITY.md).

* **Ensure the bug was not already reported** by searching on GitHub under [Issues](https://github.com/paul-canals/toolbox/issues).

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/paul-canals/toolbox/issues/new/choose). Be sure to include a **title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** demonstrating the expected behavior that is not occurring.

* If possible, use the relevant bug report templates to create the issue:
  * [**Bug report** (Create a report to help us improve) issues](https://github.com/paul-canals/toolbox/issues/new?assignees=&labels=&template=bug_report.md&title=)
  * [**Feature request** (Suggest an idea for this project) issues](https://github.com/paul-canals/toolbox/issues/new?assignees=&labels=&template=feature_request.md&title=)
  * [**Custom issue** for other issues](https://github.com/paul-canals/toolbox/issues/new?assignees=&labels=&template=custom.md&title=)

#### **Did you write a patch that fixes a bug?**

* Open a new GitHub pull request with the patch.

* Ensure the Pull Request description clearly describes the problem and solution. Include the relevant issue number if applicable.

#### **Did you fix whitespace, format code, or make a purely cosmetic patch?**

Changes that are cosmetic in nature and do not add anything substantial to the stability, functionality, or testability of the Toolbox macros will generally not be accepted.
I know you might be thinking, *"sure, it might not be adding much value, but I already wrote the code, so the cost is already paid – so why not just merge it"?* The reason is that there are a lot of hidden cost in addition to writing the code itself:
* Someone need to spend the time to review the patch. However trivial the changes might seem, there might be some subtle reasons the original code are written this way and any tiny changes have the possibility of altering behaviour and introducing bugs. All of these work takes away time and energy that could be spent on actual features and bug fixes
* It pollutes the git history. When someone need to investigate a bug and git blame these lines in the future, they'll hit this "refactor" commit which is not very useful.
* It makes backporting bug fixes harder.

#### **Do you intend to add a new feature or change an existing one?**

* Suggest your change by sending me an email at [paul.canals@gmail.com](mailto:paul.canals@gmail.com), and you may start writing code.

* Do not open a new feature issue on GitHub until you have collected positive feedback from me about the change. The GitHub issues are primarily intended for bug reports and fixes.

#### **Do you have questions about the source code?**

* Ask me any question about how to the SAS&reg; Utility Macros Toolbox through email at [paul.canals@gmail.com](mailto:paul.canals@gmail.com).

&nbsp;

Thanks! :heart:

Paul
