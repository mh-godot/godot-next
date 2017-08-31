
# godot-next

Godot Node Extensions, AKA Godot NExt, is a repository dedicated to collecting basic node extensions that are currently unavailable in vanilla Godot.

As you might have noticed, Godot Engine's initial node offerings are general purpose and are intentionally not oriented towards particular types of games.

The intent is to create nodes that fulfill a particular function and work out-of-the-box. Users should be able to use your node immediately after adding it to their project.
Ideally, these are single nodes rather than whole systems of nodes (for that, you might be better off building a separate repository for that system).

If you would like to add your own node to the repository, do the following:

1. Fork the repository to your GitHub.

2. Clone the repository and switch to the branch (major.minor engine version) you are adding a node for.

3. Identify a place in the repository folder hierarchy that seems appropriate for your node. Folders should be named in association with a related topic. If you must create new directories, please follow a snake_case naming scheme when creating topical directories.

4. Once you've found a suitable location, create a new directory, this time using UpperCamelCase.

5. Inside the new folder, attach the content necessary for your node. For GDScript, this would be a `.gd` file. For CSharp (when it's available), this would be a `.cs` file (as far as I know).

- Be sure to include in your node a comment at the top saying "Contributors" along with a subsequent comment detailing your GitHub username after a hyphen. For example:
```
    # Contributors
    # - willnationsdev
```
- Please keep the content of your script in the appropriate style for the type of script you are making to maintain consistency. `.gd` files should use snake_case for non-script-type variable names. `.cs` files likewise should use UpperCamelCase for typenames and lowerCamelCase for variable and function names. For example:
```
    # GDScript
    var my_var = null
    var ScriptType = preload("res://script.gd")

    // CSharp
    public int myVar = null;
    public class MyClass {};
```
6. Also inside the new folder, you should have a 16x16 .png image file that appears as consistent as possible with the editor's pre-existing node images. The name of the file should follow the pattern: icon\_(snake\_case\_node\_name).png. For example, for the type MyNode, the proper name would be `icon_my_node.png`.

7. Once you have your script and image file handy, go to the `godot_next_plugin.gd` file and add/remove the custom type using the `add_custom_type` and `remove_custom_type` methods, passing in the preloaded paths to your script and image files.

8. Go to the README.md file and add the name of any added nodes to the list of included nodes along with any hashtags you would like to attach (please keep it to 3 or less). The name of the node should be a relative link to its location in the repository. The name of the node should be a relative link to its location in the repository. If possible, try to find a space nearby other nodes of a similar type.

9. Commit and push all of your changes

    1. the new directory with an UpperCamelCase name.
    2. the script file with an UpperCamelCase name (with contributor credits).
    3. the .png file with a icon\_prefixed\_snake\_case name.
    4. the modified godot-next-plugin.gd file to add and remove your node from the editor.
    5. the modified README.md file to add your node to the description of the repository's content.

10. Submit a pull request to the original repository

If you would like to make edits to an existing node, don't forget to add your name to the list of contributors within that node's script.

If possible, please try to create working scripts for each version of the engine supported by the branches. One way that you as a community member can help is by porting existing nodes from one engine version to another.

If you find any problems with a particular plugin or have suggestions for improving it and would like to launch a discussion, please create an Issue and mention one of the active developers associated with it (you can click on the file and then click on the History button to see a list of commits that have edited the file. Common usernames will give you an idea of who to mention).

That's it! I hope you've got ideas of what you'd like to share with others.

# Nodes

|Linkable Node Name|Description|Tags
|-|-|-|

