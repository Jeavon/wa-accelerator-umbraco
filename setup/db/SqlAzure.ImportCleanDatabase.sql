/****** Object:  Table [dbo].[umbracoUserType]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[umbracoUserType] ON
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (1, N'admin', N'Administrators', N'CADMOSKTPIURZ:5F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (2, N'writer', N'Writer', N'CAH:F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (3, N'editor', N'Editors', N'CADMOSKTPUZ:5F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (4, N'translator', N'Translator', N'AF')
SET IDENTITY_INSERT [dbo].[umbracoUserType] OFF
/****** Object:  Table [dbo].[umbracoUserLogins]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsTaskType]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[cmsTaskType] ON
INSERT [dbo].[cmsTaskType] ([id], [alias]) VALUES (1, N'toTranslate')
SET IDENTITY_INSERT [dbo].[cmsTaskType] OFF
/****** Object:  Table [dbo].[umbracoRelationType]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[umbracoRelationType] ON
INSERT [dbo].[umbracoRelationType] ([id], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (1, 1, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Document On Copy', N'relateDocumentOnCopy')
SET IDENTITY_INSERT [dbo].[umbracoRelationType] OFF
/****** Object:  Table [dbo].[umbracoApp]    Script Date: 03/28/2011 19:04:37 ******/
INSERT [dbo].[umbracoApp] ([sortOrder], [appAlias], [appIcon], [appName], [appInitWithTreeAlias]) VALUES (0, N'content', N'.traycontent', N'Indhold', N'content')
INSERT [dbo].[umbracoApp] ([sortOrder], [appAlias], [appIcon], [appName], [appInitWithTreeAlias]) VALUES (7, N'developer', N'.traydeveloper', N'Developer', NULL)
INSERT [dbo].[umbracoApp] ([sortOrder], [appAlias], [appIcon], [appName], [appInitWithTreeAlias]) VALUES (1, N'media', N'.traymedia', N'Mediearkiv', NULL)
INSERT [dbo].[umbracoApp] ([sortOrder], [appAlias], [appIcon], [appName], [appInitWithTreeAlias]) VALUES (8, N'member', N'.traymember', N'Medlemmer', NULL)
INSERT [dbo].[umbracoApp] ([sortOrder], [appAlias], [appIcon], [appName], [appInitWithTreeAlias]) VALUES (6, N'settings', N'.traysettings', N'Indstillinger', NULL)
INSERT [dbo].[umbracoApp] ([sortOrder], [appAlias], [appIcon], [appName], [appInitWithTreeAlias]) VALUES (5, N'translation', N'.traytranslation', N'Translation', NULL)
INSERT [dbo].[umbracoApp] ([sortOrder], [appAlias], [appIcon], [appName], [appInitWithTreeAlias]) VALUES (5, N'users', N'.trayusers', N'Brugere', NULL)
/****** Object:  Table [dbo].[umbracoNode]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[umbracoNode] ON
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-1, 0, -1, 0, 0, N'-1', 0, N'916724a5-173d-4619-b97e-b9de133dd6f5', N'SYSTEM DATA: umbraco master root', N'ea7d8624-4cfe-4578-a871-24aa946bf34d', CAST(0x0000957200E73750 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-92, 0, -1, 0, 11, N'-1,-92', 37, N'f0bc4bfb-b499-40d6-ba86-058885a5178c', N'Label', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000957200E73750 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-90, 0, -1, 0, 11, N'-1,-90', 35, N'84c6b441-31df-4ffe-b67e-67d5bc3ae65a', N'Upload', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000957200E73750 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-89, 0, -1, 0, 11, N'-1,-89', 34, N'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3', N'Textbox multiple', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000957200E73750 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-88, 0, -1, 0, 11, N'-1,-88', 33, N'0cc0eba1-9960-42c9-bf9b-60e150b429ae', N'Textstring', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000957200E73750 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-87, 0, -1, 0, 11, N'-1,-87', 32, N'ca90c950-0aff-4e72-b976-a30b1ac57dad', N'Richtext editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000957200E73750 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-51, 0, -1, 0, 11, N'-1,-51', 4, N'2e6d3631-066e-44b8-aec4-96f09099b2b5', N'Numeric', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000957200E73750 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-49, 0, -1, 0, 11, N'-1,-49', 2, N'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49', N'True/false', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000957200E73750 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-43, 0, -1, 0, 1, N'-1,-43', 2, N'fbaf13a8-4036-41f2-93a3-974f678c312a', N'Checkbox list', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000958100E9C10E AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-42, 0, -1, 0, 1, N'-1,-42', 2, N'0b6a45e7-44ba-430d-9da5-4e46060b9e03', N'Dropdown', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000958100E9BAC4 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-41, 0, -1, 0, 1, N'-1,-41', 2, N'5046194e-4237-453c-a547-15db3a07c4e1', N'Date Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000958100E9B543 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-40, 0, -1, 0, 1, N'-1,-40', 2, N'bb5f57c9-ce2b-4bb9-b697-4caca783a805', N'Radiobox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000958100E9AF58 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-39, 0, -1, 0, 1, N'-1,-39', 2, N'f38f0ac7-1d27-439c-9f3f-089cd8825a53', N'Dropdown multiple', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000958100E9A9C0 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-38, 0, -1, 0, 1, N'-1,-38', 2, N'fd9f1447-6c61-4a7c-9595-5aa39147d318', N'Folder Browser', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000958100E9A102 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-37, 0, -1, 0, 1, N'-1,-37', 2, N'0225af17-b302-49cb-9176-b9f35cab9c17', N'Approved Color', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000958100E99976 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-36, 0, -1, 0, 1, N'-1,-36', 2, N'e4d66c0f-b935-4200-81f0-025f7256b89a', N'Date Picker with time', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000958100E99096 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-21, 0, -1, 0, 0, N'-1,-21', 0, N'bf7c7cbc-952f-4518-97a2-69e9c7b33842', N'Recycle Bin', N'cf3d8e34-1c1c-41e9-ae56-878b57b32113', CAST(0x00009EB4012699AF AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-20, 0, -1, 0, 0, N'-1,-20', 0, N'0f582a79-1e41-4cf0-bfa0-76340651891a', N'Recycle Bin', N'01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8', CAST(0x00009EB401269951 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1031, 0, -1, 1, 1, N'-1,1031', 2, N'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d', N'Folder', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(0x000095B00003C1CF AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1032, 0, -1, 1, 1, N'-1,1032', 2, N'cc07b313-0843-4aa8-bbda-871c8da728c8', N'Image', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(0x000095B00003C551 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1033, 0, -1, 1, 1, N'-1,1033', 2, N'4c52d8ab-54e6-40cd-999c-7a5f24903e4d', N'File', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(0x000095B00003C837 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1034, 0, -1, 0, 1, N'-1,1034', 2, N'a6857c73-d6e9-480c-b6e6-f15f6ad11125', N'Content Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D84A29 AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1035, 0, -1, 0, 1, N'-1,1035', 2, N'93929b9a-93a2-4e2a-b239-d99334440a59', N'Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D8524B AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1036, 0, -1, 0, 1, N'-1,1036', 2, N'2b24165f-9782-4aa3-b459-1de4a4d21f60', N'Member Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D8571E AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1038, 0, -1, 0, 1, N'-1,1038', 2, N'1251c96c-185c-4e9b-93f4-b48205573cbd', N'Simple Editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D868AF AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1039, 0, -1, 0, 1, N'-1,1039', 2, N'06f349a9-c949-4b6a-8660-59c10451af42', N'Ultimate Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D868AF AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1040, 0, -1, 0, 1, N'-1,1040', 2, N'21e798da-e06e-4eda-a511-ed257f78d4fa', N'Related Links', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D868AF AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1041, 0, -1, 0, 1, N'-1,1041', 2, N'b6b73142-b9c1-4bf8-a16d-e1c23320b549', N'Tags', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D868AF AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1042, 0, -1, 0, 1, N'-1,1042', 2, N'0a452bd5-83f9-4bc3-8403-1286e13fb77e', N'Macro Container', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D868AF AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1043, 0, -1, 0, 1, N'-1,1043', 2, N'1df9f033-e6d4-451f-b8d2-e0cbc50a836f', N'Image Cropper', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(0x0000973E00D868AF AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoNode] OFF
/****** Object:  Table [dbo].[umbracoLog]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[umbracoLog] ON
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1, 0, -1, CAST(0x00009EB401269AD4 AS DateTime), N'Debug', N'Republishing starting')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (2, 0, -1, CAST(0x00009EB401269AE2 AS DateTime), N'Debug', N'Xml Pages loaded')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (3, 0, -1, CAST(0x00009EB401269AE3 AS DateTime), N'Debug', N'Done republishing Xml Index')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (4, 0, -1, CAST(0x00009EB401269AEC AS DateTime), N'Debug', N'Xml saved in 00:00:00.0067511')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (5, 0, -1, CAST(0x00009EB401269AED AS DateTime), N'Debug', N'Xml saved in 00:00:00.0168532')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (6, 0, -1, CAST(0x00009EB401269AEF AS DateTime), N'System', N'Loading content from database...')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (7, 0, -1, CAST(0x00009EB40127C1C9 AS DateTime), N'Debug', N'CurrentVersion different from configStatus: ''4.7.0'',''''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (8, 0, -1, CAST(0x00009EB40127C1DB AS DateTime), N'System', N'Application started at 3/28/2011 5:56:49 PM')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (9, 0, -1, CAST(0x00009EB40127C1EA AS DateTime), N'Debug', N'CurrentVersion different from configStatus: ''4.7.0'',''''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (10, 0, -1, CAST(0x00009EB40127C4D3 AS DateTime), N'System', N'Loading content from disk cache...')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (11, 0, -1, CAST(0x00009EB40127C4E9 AS DateTime), N'Debug', N'CurrentVersion different from configStatus: ''4.7.0'',''''')
SET IDENTITY_INSERT [dbo].[umbracoLog] OFF
/****** Object:  Table [dbo].[umbracoLanguage]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[umbracoLanguage] ON
INSERT [dbo].[umbracoLanguage] ([id], [languageISOCode], [languageCultureName]) VALUES (1, N'en-US', N'en-US')
SET IDENTITY_INSERT [dbo].[umbracoLanguage] OFF
/****** Object:  Table [dbo].[cmsMacro]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsTags]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsDictionary]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsMacroPropertyType]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[cmsMacroPropertyType] ON
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (3, N'mediaCurrent', N'umbraco.macroRenderings', N'media', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (4, N'contentSubs', N'umbraco.macroRenderings', N'content', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (5, N'contentRandom', N'umbraco.macroRenderings', N'content', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (6, N'contentPicker', N'umbraco.macroRenderings', N'content', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (13, N'number', N'umbraco.macroRenderings', N'numeric', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (14, N'bool', N'umbraco.macroRenderings', N'yesNo', N'Boolean')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (16, N'text', N'umbraco.macroRenderings', N'text', N'String')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (17, N'contentTree', N'umbraco.macroRenderings', N'content', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (18, N'contentType', N'umbraco.macroRenderings', N'contentTypeSingle', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (19, N'contentTypeMultiple', N'umbraco.macroRenderings', N'contentTypeMultiple', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (20, N'contentAll', N'umbraco.macroRenderings', N'content', N'Int32')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (21, N'tabPicker', N'umbraco.macroRenderings', N'tabPicker', N'String')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (22, N'tabPickerMultiple', N'umbraco.macroRenderings', N'tabPickerMultiple', N'String')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (23, N'propertyTypePicker', N'umbraco.macroRenderings', N'propertyTypePicker', N'String')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (24, N'propertyTypePickerMultiple', N'umbraco.macroRenderings', N'propertyTypePickerMultiple', N'String')
INSERT [dbo].[cmsMacroPropertyType] ([id], [macroPropertyTypeAlias], [macroPropertyTypeRenderAssembly], [macroPropertyTypeRenderType], [macroPropertyTypeBaseType]) VALUES (25, N'textMultiLine', N'umbraco.macroRenderings', N'textMultiple', N'String')
SET IDENTITY_INSERT [dbo].[cmsMacroPropertyType] OFF
/****** Object:  Table [dbo].[cmsMacroProperty]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsStylesheetProperty]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsStylesheet]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsTagRelationship]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsContentType]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[cmsContentType] ON
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [masterContentType]) VALUES (532, 1031, N'Folder', N'folder.gif', N'folder.png', NULL, NULL)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [masterContentType]) VALUES (533, 1032, N'Image', N'mediaPhoto.gif', N'folder.png', NULL, NULL)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [masterContentType]) VALUES (534, 1033, N'File', N'mediaMulti.gif', N'folder.png', NULL, NULL)
SET IDENTITY_INSERT [dbo].[cmsContentType] OFF
/****** Object:  Table [dbo].[cmsContent]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsDataType]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[cmsDataType] ON
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (4, -49, N'38b352c1-e9f8-4fd8-9324-9a2eab06d97a', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (6, -51, N'1413afcb-d19a-4173-8e9a-68288d2a73b8', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (8, -87, N'5e9b75ae-face-41c8-b47e-5f4b0fd82f83', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (9, -88, N'ec15c1e5-9d90-422a-aa52-4f7622c63bea', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (10, -89, N'67db8357-ef57-493e-91ac-936d305e0f2a', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (11, -90, N'5032a6e6-69e3-491d-bb28-cd31cd11086c', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (13, -92, N'6c738306-4c17-4d88-b9bd-6546f3771597', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (14, -36, N'b6fb1622-afa5-4bbf-a3cc-d9672a442222', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (15, -37, N'f8d60f68-ec59-4974-b43b-c46eb5677985', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (16, -38, N'cccd4ae9-f399-4ed2-8038-2e88d19e810c', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (17, -39, N'928639ed-9c73-4028-920c-1e55dbb68783', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (18, -40, N'a52c7c1c-c330-476e-8605-d63d3b84b6a6', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (19, -41, N'23e93522-3200-44e2-9f29-e61a6fcbb79a', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (20, -42, N'a74ea9c9-8e18-4d2a-8cf6-73c6206c5da6', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (21, -43, N'b4471851-82b6-4c75-afa4-39fa9c6a75e9', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (31, 1034, N'158aa029-24ed-4948-939e-c3da209e5fba', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (32, 1035, N'ead69342-f06d-4253-83ac-28000225583b', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (33, 1036, N'39f533e4-0551-4505-a64b-e0425c5ce775', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (35, 1038, N'60b7dabf-99cd-41eb-b8e9-4d2e669bbde9', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (36, 1039, N'cdbf0b5d-5cb2-445f-bc12-fcaaec07cf2c', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (37, 1040, N'71b8ad1a-8dc2-425c-b6b8-faa158075e63', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (38, 1041, N'4023e540-92f5-11dd-ad8b-0800200c9a66', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (39, 1042, N'474fcff8-9d2d-11de-abc6-ad7a56d89593', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [controlId], [dbType]) VALUES (40, 1043, N'7a2d436c-34c2-410f-898f-4a23b3d79f54', N'Ntext')
SET IDENTITY_INSERT [dbo].[cmsDataType] OFF
/****** Object:  Table [dbo].[cmsLanguageText]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[umbracoDomains]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[umbracoAppTree]    Script Date: 03/28/2011 19:04:37 ******/
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (1, 1, 0, N'content', N'content', N'Indhold', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadContent', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 0, 0, N'content', N'contentRecycleBin', N'RecycleBin', N'folder.gif', N'folder_o.gif', N'umbraco', N'cms.presentation.Trees.ContentRecycleBin', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 0, N'developer', N'cacheBrowser', N'CacheBrowser', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadCache', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 0, 0, N'developer', N'CacheItem', N'Cachebrowser', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadCacheItem', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 1, N'developer', N'datatype', N'Datatyper', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadDataTypes', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 2, N'developer', N'macros', N'Macros', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadMacros', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 3, N'developer', N'packager', N'Packages', N'folder.gif', N'folder_o.gif', N'umbraco', N'loadPackager', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 0, 1, N'developer', N'packagerPackages', N'Packager Packages', N'folder.gif', N'folder_o.gif', N'umbraco', N'loadPackages', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 4, N'developer', N'python', N'Python Files', N'folder.gif', N'folder_o.gif', N'umbraco', N'loadPython', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 5, N'developer', N'xslt', N'XSLT Files', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadXslt', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 0, N'media', N'media', N'Medier', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadMedia', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 0, 0, N'media', N'mediaRecycleBin', N'RecycleBin', N'folder.gif', N'folder_o.gif', N'umbraco', N'cms.presentation.Trees.MediaRecycleBin', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 0, N'member', N'member', N'Medlemmer', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadMembers', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 1, N'member', N'memberGroup', N'MemberGroups', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadMemberGroups', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 2, N'member', N'memberType', N'Medlemstyper', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadMemberTypes', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 3, N'settings', N'dictionary', N'Dictionary', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadDictionary', N'openDictionary()')
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 4, N'settings', N'languages', N'Languages', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadLanguages', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 5, N'settings', N'mediaTypes', N'Medietyper', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadMediaTypes', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 6, N'settings', N'nodeTypes', N'Dokumenttyper', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadNodeTypes', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 2, N'settings', N'scripts', N'Scripts', N'folder.gif', N'folder_o.gif', N'umbraco', N'loadScripts', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 0, 0, N'settings', N'stylesheetProperty', N'Stylesheet Property', N'', N'', N'umbraco', N'loadStylesheetProperty', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 0, N'settings', N'stylesheets', N'Stylesheets', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadStylesheets', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 1, N'settings', N'templates', N'Templates', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadTemplates', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 1, N'translation', N'openTasks', N'Tasks assigned to you', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadOpenTasks', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 2, N'translation', N'yourTasks', N'Tasks created by you', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadYourTasks', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 2, N'users', N'userPermissions', N'User Permissions', N'folder.gif', N'folder_o.gif', N'umbraco', N'cms.presentation.Trees.UserPermissions', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 0, N'users', N'users', N'Brugere', N'.sprTreeFolder', N'.sprTreeFolder_o', N'umbraco', N'loadUsers', NULL)
INSERT [dbo].[umbracoAppTree] ([treeSilent], [treeInitialize], [treeSortOrder], [appAlias], [treeAlias], [treeTitle], [treeIconClosed], [treeIconOpen], [treeHandlerAssembly], [treeHandlerType], [action]) VALUES (0, 1, 1, N'users', N'userTypes', N'User Types', N'folder.gif', N'folder_o.gif', N'umbraco', N'cms.presentation.Trees.UserTypes', NULL)
/****** Object:  Table [dbo].[cmsTemplate]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[umbracoRelation]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[umbracoUser]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[umbracoUser] ON
INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userType], [startStructureID], [startMediaID], [userName], [userLogin], [userPassword], [userEmail], [userDefaultPermissions], [userLanguage], [defaultToLiveEditing]) VALUES (0, 0, 0, 1, -1, -1, N'Administrator', N'admin', N'default', N'', NULL, N'en', 0)
SET IDENTITY_INSERT [dbo].[umbracoUser] OFF
/****** Object:  Table [dbo].[umbracoUser2NodePermission]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[umbracoUser2NodeNotify]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[umbracoUser2app]    Script Date: 03/28/2011 19:04:37 ******/
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'content')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'developer')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'media')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'member')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'settings')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'users')
/****** Object:  Table [dbo].[cmsTask]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsDocumentType]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsDocument]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsContentXml]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsContentVersion]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsContentTypeAllowedContentType]    Script Date: 03/28/2011 19:04:37 ******/
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId]) VALUES (1031, 1031)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId]) VALUES (1031, 1032)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId]) VALUES (1031, 1033)
/****** Object:  Table [dbo].[cmsTab]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[cmsTab] ON
INSERT [dbo].[cmsTab] ([id], [contenttypeNodeId], [text], [sortorder]) VALUES (3, 1032, N'Image', 1)
INSERT [dbo].[cmsTab] ([id], [contenttypeNodeId], [text], [sortorder]) VALUES (4, 1033, N'File', 1)
INSERT [dbo].[cmsTab] ([id], [contenttypeNodeId], [text], [sortorder]) VALUES (5, 1031, N'Contents', 1)
SET IDENTITY_INSERT [dbo].[cmsTab] OFF
/****** Object:  Table [dbo].[cmsDataTypePreValues]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] ON
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (3, -87, N',code,undo,redo,cut,copy,mcepasteword,stylepicker,bold,italic,bullist,numlist,outdent,indent,mcelink,unlink,mceinsertanchor,mceimage,umbracomacro,mceinserttable,mcecharmap,|1|1,2,3,|0|500,400|1049,|', 0, N'')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (4, 1041, N'default', 0, N'group')
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] OFF
/****** Object:  Table [dbo].[cmsMember]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsMemberType]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsPreviewXml]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsMember2MemberGroup]    Script Date: 03/28/2011 19:04:37 ******/
/****** Object:  Table [dbo].[cmsPropertyType]    Script Date: 03/28/2011 19:04:37 ******/
SET IDENTITY_INSERT [dbo].[cmsPropertyType] ON
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (6, -90, 1032, 3, N'umbracoFile', N'Upload image', NULL, 0, 0, NULL, NULL)
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (7, -92, 1032, 3, N'umbracoWidth', N'Width', NULL, 0, 0, NULL, NULL)
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (8, -92, 1032, 3, N'umbracoHeight', N'Height', NULL, 0, 0, NULL, NULL)
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (9, -92, 1032, 3, N'umbracoBytes', N'Size', NULL, 0, 0, NULL, NULL)
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (10, -92, 1032, 3, N'umbracoExtension', N'Type', NULL, 0, 0, NULL, NULL)
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (24, -90, 1033, 4, N'umbracoFile', N'Upload file', NULL, 0, 0, NULL, NULL)
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (25, -92, 1033, 4, N'umbracoExtension', N'Type', NULL, 0, 0, NULL, NULL)
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (26, -92, 1033, 4, N'umbracoBytes', N'Size', NULL, 0, 0, NULL, NULL)
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [tabId], [Alias], [Name], [helpText], [sortOrder], [mandatory], [validationRegExp], [Description]) VALUES (27, -38, 1031, 5, N'contents', N'Contents:', NULL, 0, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[cmsPropertyType] OFF
/****** Object:  Table [dbo].[cmsPropertyData]    Script Date: 03/28/2011 19:04:37 ******/