# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Briana Fedkiw
* *email:* bnfedkiw@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Position lock camera fulfills all basic criteria, sucessfully drawing a cross onto the target and keeping the camera locked on it. Code uses differences between the camera and target position in the horizontal and vertical directions to decide how to move the camera. The camera also operates correctly with hyperspeed.

Although no exports were necessary, I enjoy how the student added exports to change the cross size.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The autoscroll camera follows all basic criteria, especially including the exported fields of box size and autoscroll speed. For actual movement, the camera autoscrolls properly and the player autoscrolls as well. The camera works with any box size and any direction of movement, with the box itself always being drawn accordingly. Hyperspeed does not change camera operation. 

The code itself includes [checks that keep the player within the boundaries of the autoscroll box](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/0584257d9f3d8fca1a0f33fa5425fea1a291995f/Obscura/scripts/camera_controllers/autoscroll_camera.gd#L30-L44). This works as it should.

___
### Stage 3 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera appears to work properly and follow most of the criteria. The camera trails behind the target in any direction and catches up immediately when the player stops, even in hyperspeed. Code succesfully keeps camera within leash distance to the target. The cross for the camera is drawn correctly.

There is a big problem with the exports. For both catchup speed and leash distance, they work properly and if changed, continue to work. However, although follow speed was created as an export, the code itself [hardcodes follow speed to always be 75% of the target speed](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/0584257d9f3d8fca1a0f33fa5425fea1a291995f/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L26). This means if the user sets follow speed themselves, the set value is ignored by the code. So, follow speed ends up always the same.

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera works properly in some areas and follows most of the criteria. The camera does lead in front of the target properly in any direction, and there is a timer that successfully accounts for delay before allowing catchup to happen. Code keeps the camera within leash distance to the target and the cross is drawn properly.

There are two issues in this stage:

1) The exports for leash distance, catchup speed, and delay all work properly with any inputs. However, similar to stage 3, lead speed is defined as an export but then is [hardcoded to 5 times the target speed](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/5ffe1067d8dfa474af8fde57a21f79ff773a2380/Obscura/scripts/camera_controllers/lerp_target.gd#L33). So, even if the user sets the lead speed, nothing appears to change, which breaks the idea of an export.
2) There is weird target snapping happening once the target stops moving. In normal speed, the target very slightly snaps towards the center of the camera, waits for delay, and then the camera catches up to the target. This becomes very apparent in hyperspeed. Once the target stops moving, it snaps a large distance towards the center of the camera before normal delay and catchup occur. This could be something to do with leash distance during catchup or just how the code deals with a player stopping.

___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera works correctly and follows all criteria. All exports are properly dealt with and work the same if they are changed. Within the speedup zone, the camera movement accounts for push ratio, and if it is touching a push box border, it moves at full speed. If in the inner box or going towards the inner box, the camera does not move at all. The borders are drawn correctly.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
* Inconsistent use of the number of blank lines - between each function, there should be two blank lines while within functions only one space should be used to separate logical sections. In the code, this rule is not consistently followed:
[example 1: too little spaces between functions](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/autoscroll_camera.gd#L15),
[example 2: too many spaces between functions](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L60-L62),
[example 3: more than one space in logical sections](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/lerp_target.gd#L63-L65)
  
* [Did not format multiline statements for readability](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/speedup_push.gd#L33-L59) - for conditional statements with multiple expressions, they should be wrapped over multiple lines

* Missing comment space - some comments are missing a space between the hashtag and description: [example 1](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L46), [example 2](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/position_lock.gd#L27)

* Missing prepended underscore - private variables need an underscore in front of their name: [example 1](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/lerp_target.gd#L14-L15), [example 2](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L8-L11)

* [Incorrect code order](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/lerp_target.gd#L9-L15) - the onready variable should be after the private ones

#### Style Guide Exemplars ####
* Overall, kept one statement per line to increase code readability: [example 1](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/camera_controller_base.gd#L30-L35), [example 2](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/position_lock.gd#L29-L35)

* [Use of english terms for boolean operators](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/speedup_push.gd#L33-L59) - replaced && with "and" to increase readability

* Snake case - variables use snake case in their naming: [example 1](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/position_lock.gd#L29), [example 2](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/lerp_target.gd#L47)


# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
* Comments that were left hanging - code becomes more cluttered when there are comments sitting around that do not help describe what is happening: [example 1](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/lerp_target.gd#L22), [example 2](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/9eea5306f415ae8e54d861c0eb720a00595de31f/Obscura/scripts/camera_controllers/speedup_push.gd#L34)

* Comments could be more descriptive [like this example](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/372c07de978909c080eed14191064df278b65ba9/Obscura/scripts/camera_controllers/lerp_target.gd#L46) - a lot of the comments throughout the code are one word and do not add a lot of useful explanation

* [Unused variable](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/372c07de978909c080eed14191064df278b65ba9/Obscura/scripts/camera_controllers/lerp_target.gd#L51) - left a variable in the code that was not used anywhere else other than its declaration

* [Variable names slightly too similar in naming](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/372c07de978909c080eed14191064df278b65ba9/Obscura/scripts/camera_controllers/speedup_push.gd#L29-L30) - As someone who coded the same exercise, I was able to understand the variable names but some greater differentiation between the two could make them clearer. For example saying one is for the push zone and the other is for the speedup zone.

#### Best Practices Exemplars ####
* Good amount of commits on the project, helps keep track of your work

* Printing when [drawing logic is on or off](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/372c07de978909c080eed14191064df278b65ba9/Obscura/scripts/camera_controllers/camera_controller_base.gd#L30-L35) and printing [current camera](https://github.com/ensemble-ai/exercise-2-camera-control-quiet98k/blob/372c07de978909c080eed14191064df278b65ba9/Obscura/scripts/camera_selector.gd#L25) - the output terminal tells you which camera you are on and if the drawing logic is on. This can help new time users understand what is happening on their screen.
