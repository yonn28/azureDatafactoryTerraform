# [Feature or Story Design Title](http://link-to-feature-or-story-work-item)

## Overview/Problem Statement

* Describe the feature/story with a high-level summary.
* Consider additional background and justification, for posterity and historical context.
* List any assumptions that were made for this design.

## Goals/In-Scope

* List the goals that the feature/story will help us achieve that are most relevant for the design review discussion.  
* This should include acceptance criteria required to meet definition of done.

## Non-goals / Out-of-Scope

* List the non-goals for the feature/story.
* This contains work that is beyond the scope of what the feature/component/service is intended for.

## Proposed Design

* Briefly describe the high-level architecture for the feature/story.
* Relevant diagrams (e.g. sequence, component, context, deployment) should be included here.
* Images must be added on the `design-reviews/assets` folder.

### About diagrams

If you have a preference to create diagrams using text and code on the document instead of creating them as images, we recommend the use of [mermaid](https://mermaid-js.github.io/mermaid/#/). Example:

::: mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
:::

## Technology

* Describe the relevant OS, Web server, presentation layer, persistence layer, caching, eventing/messaging/jobs, etc. – whatever is applicable to the overall technology solution and how are they going to be used.
* Describe the usage of any libraries of OSS components.
* Briefly list the languages(s) and platform(s) that comprise the stack.

## Non-Functional Requirements

* What are the primary performance and scalability concerns for this feature/story?
* Are there specific latency, availability, and RTO/RPO objectives that must be met?
* Are there specific bottlenecks or potential problem areas? For example, are operations CPU or I/O (network, disk) bound?
* How large are the data sets and how fast do they grow?
* What is the expected usage pattern of the service? For example, will there be peaks and valleys of intense concurrent usage?
* Are there specific cost constraints? (e.g. $ per transaction/device/user)

## Dependencies

* Does this feature/story need to be sequenced after another feature/story assigned to the same team and why?
* Is the feature/story dependent on another team completing other work?
* Will the team need to wait for that work to be completed or could the work proceed in parallel?

## Risks & Mitigation

* Does the team need assistance from subject matter experts?
* What security and privacy concerns does this milestone/epic have?
* Is all sensitive information and secrets treated in a safe and secure manner?

## Open Questions

* List any open questions/concerns here.

## Additional References

* List any additional references here including links to backlog items, work items or other documents.
