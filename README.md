# CS 837 - Information Vizualization Code Repository#
**Trevor M. Tomesh - University of Regina**
*Fall 2015* 

##CS 837 - Assignment 1##
*13.10.2015*

Trevor Tomesh
University of Regina - Computer Science
tmtomesh@gmail.com 
Student No. 200343884 

Overview
--------
This submission contains an information visualization program written in Processing 3.0. The program:
+ Reads an external XML file and stores it within an XML structure inside of Processing.
+ Renders the data read as points on a scatter-plot. 
+ Provides the user with interactivity tools to explore the data including:
+ X and Y zoom
+ Individual point selection
+ Mouse-over responsivity in:
  + size of point
  + rendering of point values as text
+ Ability to select / deselect data sets

Goals
-----
1. Read data-file once, store data in internal structure.
2. Render data as scatterplot.
3. Render axes and labels
4. Provide graphical filter tools
5. “Animated” scaling. 
6. Focus on data-set when point is selected.
7. Textual data summary on selection.

Critique
----------
First and foremost, it must be mentioned that this program was written in a bit of a hurry and is far from refined. That said, it does manage to address the user requirements (given the user requirements listed are well addressed by any scatter-plot software).
In addition to just plotting the points, this software colorizes the data sets separately -- which allows for “outliers” within each data set to be differentiated from other data set points. 
The user-interactivity tools, highlighting on mouse-over, set-highlighting on-click and ability to zoom with the scroll wheel gives the user further visualization power. 

Design Decisions
--------------
I have chosen not to label individual ticks as this severely clutters the rendering area

Known Issues / Planned Features
---------------------------------
As of now, there are a number of issues both major and minor with the software: 
1. Panning is not yet implemented -- although it is fully intended that the user will be able to both zoom and pan. 
2. The origin is in the upper left-hand corner rather than the lower left-hand corner. This is because of the way that processing renders its coordinate system. A simple transform could fix this.
3. The user should eventually be able to select the data by clicking and dragging. 
4. Some scaling issues. 
5. Issues with data selection when zoom is active.

##Running the software

###From Source
The source code for this project can be found at: https://github.com/trevortomesh/cs837/tree/master/assignment1
Download the latest version of processing: https://processing.org/download/

1. Either copy and paste the code from the .pde file or open it through the file-menu in processing. 
2. Take care the the .xml file is in the same directory as the sketch. 
3. Press “run”. 

###From executable
Executables are provided for both windows and linux versions of the software (os x pending) 
Within the “assignment1” folder, open “build” and navigate to the folder for your operating system.
Execute your binary. 

**Note: You MUST have the XML file in the same directory as your executable!**

