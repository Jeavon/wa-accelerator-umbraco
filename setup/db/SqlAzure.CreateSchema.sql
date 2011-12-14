/****** Object:  Table [dbo].[umbracoUserType]    Script Date: 03/28/2011 18:16:35 ******/
CREATE TABLE [dbo].[umbracoUserType](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[userTypeAlias] [nvarchar](50) NULL,
	[userTypeName] [nvarchar](255) NOT NULL,
	[userTypeDefaultPermissions] [nvarchar](50) NULL,
 CONSTRAINT [PK_userType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoUserLogins]    Script Date: 03/28/2011 18:16:39 ******/
CREATE TABLE [dbo].[umbracoUserLogins](
	[contextID] [uniqueidentifier] NOT NULL,
	[userID] [int] NOT NULL,
	[timeout] [bigint] NOT NULL
)
GO
CREATE CLUSTERED INDEX [ci_azure_fixup_dbo_umbracoUserLogins] ON [dbo].[umbracoUserLogins] 
(
	[userID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
/****** Object:  Table [dbo].[cmsTaskType]    Script Date: 03/28/2011 18:16:45 ******/
CREATE TABLE [dbo].[cmsTaskType](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsTaskType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_cmsTaskType] UNIQUE NONCLUSTERED 
(
	[alias] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoRelationType]    Script Date: 03/28/2011 18:16:54 ******/
CREATE TABLE [dbo].[umbracoRelationType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dual] [bit] NOT NULL,
	[parentObjectType] [uniqueidentifier] NOT NULL,
	[childObjectType] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoRelationType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoApp]    Script Date: 03/28/2011 18:17:02 ******/
CREATE TABLE [dbo].[umbracoApp](
	[sortOrder] [tinyint] NOT NULL,
	[appAlias] [nvarchar](50) NOT NULL,
	[appIcon] [nvarchar](255) NOT NULL,
	[appName] [nvarchar](255) NOT NULL,
	[appInitWithTreeAlias] [nvarchar](255) NULL,
 CONSTRAINT [PK_umbracoApp] PRIMARY KEY CLUSTERED 
(
	[appAlias] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoNode]    Script Date: 03/28/2011 18:17:16 ******/
CREATE TABLE [dbo].[umbracoNode](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[trashed] [bit] NOT NULL,
	[parentID] [int] NOT NULL,
	[nodeUser] [int] NULL,
	[level] [smallint] NOT NULL,
	[path] [nvarchar](150) NOT NULL,
	[sortOrder] [int] NOT NULL,
	[uniqueID] [uniqueidentifier] NULL,
	[text] [nvarchar](255) NULL,
	[nodeObjectType] [uniqueidentifier] NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_structure] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
CREATE NONCLUSTERED INDEX [IX_umbracoNodeObjectType] ON [dbo].[umbracoNode] 
(
	[nodeObjectType] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
CREATE NONCLUSTERED INDEX [IX_umbracoNodeParentId] ON [dbo].[umbracoNode] 
(
	[parentID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
/****** Object:  Table [dbo].[umbracoLog]    Script Date: 03/28/2011 18:17:27 ******/
CREATE TABLE [dbo].[umbracoLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[NodeId] [int] NOT NULL,
	[Datestamp] [datetime] NOT NULL,
	[logHeader] [nvarchar](50) NOT NULL,
	[logComment] [nvarchar](4000) NULL,
 CONSTRAINT [PK_umbracoLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
CREATE NONCLUSTERED INDEX [IX_umbracoLog] ON [dbo].[umbracoLog] 
(
	[NodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
/****** Object:  Table [dbo].[umbracoLanguage]    Script Date: 03/28/2011 18:17:35 ******/
CREATE TABLE [dbo].[umbracoLanguage](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[languageISOCode] [nvarchar](10) NULL,
	[languageCultureName] [nvarchar](100) NULL,
 CONSTRAINT [PK_language] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_umbracoLanguage] UNIQUE NONCLUSTERED 
(
	[languageISOCode] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsMacro]    Script Date: 03/28/2011 18:18:02 ******/
CREATE TABLE [dbo].[cmsMacro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[macroUseInEditor] [bit] NOT NULL,
	[macroRefreshRate] [int] NOT NULL,
	[macroAlias] [nvarchar](255) NOT NULL,
	[macroName] [nvarchar](255) NULL,
	[macroScriptType] [nvarchar](255) NULL,
	[macroScriptAssembly] [nvarchar](255) NULL,
	[macroXSLT] [nvarchar](255) NULL,
	[macroCacheByPage] [bit] NOT NULL,
	[macroCachePersonalized] [bit] NOT NULL,
	[macroDontRender] [bit] NOT NULL,
	[macroPython] [nvarchar](255) NULL,
 CONSTRAINT [PK_macro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsTags]    Script Date: 03/28/2011 18:18:12 ******/
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmsTags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tag] [varchar](200) NULL,
	[parentId] [int] NULL,
	[group] [varchar](100) NULL,
 CONSTRAINT [PK_cmsTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmsDictionary]    Script Date: 03/28/2011 18:18:19 ******/
CREATE TABLE [dbo].[cmsDictionary](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[parent] [uniqueidentifier] NOT NULL,
	[key] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsDictionary] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_cmsDictionary] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsMacroPropertyType]    Script Date: 03/28/2011 18:18:25 ******/
CREATE TABLE [dbo].[cmsMacroPropertyType](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[macroPropertyTypeAlias] [nvarchar](50) NULL,
	[macroPropertyTypeRenderAssembly] [nvarchar](255) NULL,
	[macroPropertyTypeRenderType] [nvarchar](255) NULL,
	[macroPropertyTypeBaseType] [nvarchar](255) NULL,
 CONSTRAINT [PK_macroPropertyType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsMacroProperty]    Script Date: 03/28/2011 18:18:35 ******/
CREATE TABLE [dbo].[cmsMacroProperty](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[macroPropertyHidden] [bit] NOT NULL,
	[macroPropertyType] [smallint] NOT NULL,
	[macro] [int] NOT NULL,
	[macroPropertySortOrder] [tinyint] NOT NULL,
	[macroPropertyAlias] [nvarchar](50) NOT NULL,
	[macroPropertyName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_macroProperty] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsStylesheetProperty]    Script Date: 03/28/2011 18:18:44 ******/
CREATE TABLE [dbo].[cmsStylesheetProperty](
	[nodeId] [int] NOT NULL,
	[stylesheetPropertyEditor] [bit] NULL,
	[stylesheetPropertyAlias] [nvarchar](50) NULL,
	[stylesheetPropertyValue] [nvarchar](400) NULL,
 CONSTRAINT [PK_cmsStylesheetProperty] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsStylesheet]    Script Date: 03/28/2011 18:18:51 ******/
CREATE TABLE [dbo].[cmsStylesheet](
	[nodeId] [int] NOT NULL,
	[filename] [nvarchar](100) NOT NULL,
	[content] [ntext] NULL,
 CONSTRAINT [PK_cmsStylesheet] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsTagRelationship]    Script Date: 03/28/2011 18:18:58 ******/
CREATE TABLE [dbo].[cmsTagRelationship](
	[nodeId] [int] NOT NULL,
	[tagId] [int] NOT NULL,
 CONSTRAINT [PK_cmsTagRelationship] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[tagId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsContentType]    Script Date: 03/28/2011 18:19:14 ******/
CREATE TABLE [dbo].[cmsContentType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](255) NULL,
	[icon] [nvarchar](255) NULL,
	[thumbnail] [nvarchar](255) NOT NULL,
	[description] [nvarchar](1500) NULL,
	[masterContentType] [int] NULL,
 CONSTRAINT [PK_cmsContentType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_cmsContentType] UNIQUE NONCLUSTERED 
(
	[nodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
CREATE NONCLUSTERED INDEX [IX_Icon] ON [dbo].[cmsContentType] 
(
	[nodeId] ASC,
	[icon] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
/****** Object:  Table [dbo].[cmsContent]    Script Date: 03/28/2011 18:19:23 ******/
CREATE TABLE [dbo].[cmsContent](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[contentType] [int] NOT NULL,
 CONSTRAINT [PK_cmsContent] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_cmsContent] UNIQUE NONCLUSTERED 
(
	[nodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsDataType]    Script Date: 03/28/2011 18:19:31 ******/
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmsDataType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[controlId] [uniqueidentifier] NOT NULL,
	[dbType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_cmsDataType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_cmsDataType] UNIQUE NONCLUSTERED 
(
	[nodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmsLanguageText]    Script Date: 03/28/2011 18:19:46 ******/
CREATE TABLE [dbo].[cmsLanguageText](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[languageId] [int] NOT NULL,
	[UniqueId] [uniqueidentifier] NOT NULL,
	[value] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsLanguageText] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoDomains]    Script Date: 03/28/2011 18:19:52 ******/
CREATE TABLE [dbo].[umbracoDomains](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[domainDefaultLanguage] [int] NULL,
	[domainRootStructureID] [int] NULL,
	[domainName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_domains] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoAppTree]    Script Date: 03/28/2011 18:20:06 ******/
CREATE TABLE [dbo].[umbracoAppTree](
	[treeSilent] [bit] NOT NULL,
	[treeInitialize] [bit] NOT NULL,
	[treeSortOrder] [tinyint] NOT NULL,
	[appAlias] [nvarchar](50) NOT NULL,
	[treeAlias] [nvarchar](150) NOT NULL,
	[treeTitle] [nvarchar](255) NOT NULL,
	[treeIconClosed] [nvarchar](255) NOT NULL,
	[treeIconOpen] [nvarchar](255) NOT NULL,
	[treeHandlerAssembly] [nvarchar](255) NOT NULL,
	[treeHandlerType] [nvarchar](255) NOT NULL,
	[action] [nvarchar](255) NULL,
 CONSTRAINT [PK_umbracoAppTree] PRIMARY KEY CLUSTERED 
(
	[appAlias] ASC,
	[treeAlias] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsTemplate]    Script Date: 03/28/2011 18:20:16 ******/
CREATE TABLE [dbo].[cmsTemplate](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[master] [int] NULL,
	[alias] [nvarchar](100) NULL,
	[design] [ntext] NOT NULL,
 CONSTRAINT [PK_templates] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_cmsTemplate] UNIQUE NONCLUSTERED 
(
	[nodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoRelation]    Script Date: 03/28/2011 18:20:25 ******/
CREATE TABLE [dbo].[umbracoRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentId] [int] NOT NULL,
	[childId] [int] NOT NULL,
	[relType] [int] NOT NULL,
	[datetime] [datetime] NOT NULL,
	[comment] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_umbracoRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoUser]    Script Date: 03/28/2011 18:20:43 ******/
CREATE TABLE [dbo].[umbracoUser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userDisabled] [bit] NOT NULL,
	[userNoConsole] [bit] NOT NULL,
	[userType] [smallint] NOT NULL,
	[startStructureID] [int] NOT NULL,
	[startMediaID] [int] NULL,
	[userName] [nvarchar](255) NOT NULL,
	[userLogin] [nvarchar](125) NOT NULL,
	[userPassword] [nvarchar](125) NOT NULL,
	[userEmail] [nvarchar](255) NOT NULL,
	[userDefaultPermissions] [nvarchar](50) NULL,
	[userLanguage] [nvarchar](10) NULL,
	[defaultToLiveEditing] [bit] NOT NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_umbracoUser] UNIQUE NONCLUSTERED 
(
	[userLogin] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[umbracoUser2NodePermission]    Script Date: 03/28/2011 18:20:52 ******/
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[umbracoUser2NodePermission](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[permission] [char](1) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodePermission] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[permission] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[umbracoUser2NodeNotify]    Script Date: 03/28/2011 18:21:01 ******/
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[umbracoUser2NodeNotify](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[action] [char](1) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodeNotify] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[action] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[umbracoUser2app]    Script Date: 03/28/2011 18:21:08 ******/
CREATE TABLE [dbo].[umbracoUser2app](
	[user] [int] NOT NULL,
	[app] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_user2app] PRIMARY KEY CLUSTERED 
(
	[user] ASC,
	[app] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsTask]    Script Date: 03/28/2011 18:21:27 ******/
CREATE TABLE [dbo].[cmsTask](
	[closed] [bit] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskTypeId] [tinyint] NOT NULL,
	[nodeId] [int] NOT NULL,
	[parentUserId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Comment] [nvarchar](500) NULL,
 CONSTRAINT [PK_cmsTask] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsDocumentType]    Script Date: 03/28/2011 18:21:38 ******/
CREATE TABLE [dbo].[cmsDocumentType](
	[contentTypeNodeId] [int] NOT NULL,
	[templateNodeId] [int] NOT NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK_cmsDocumentType] PRIMARY KEY CLUSTERED 
(
	[contentTypeNodeId] ASC,
	[templateNodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsDocument]    Script Date: 03/28/2011 18:21:53 ******/
CREATE TABLE [dbo].[cmsDocument](
	[nodeId] [int] NOT NULL,
	[published] [bit] NOT NULL,
	[documentUser] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[releaseDate] [datetime] NULL,
	[expireDate] [datetime] NULL,
	[updateDate] [datetime] NOT NULL,
	[templateId] [int] NULL,
	[alias] [nvarchar](255) NULL,
	[newest] [bit] NOT NULL,
 CONSTRAINT [PK_cmsDocument] PRIMARY KEY CLUSTERED 
(
	[versionId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_cmsDocument] UNIQUE NONCLUSTERED 
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsContentXml]    Script Date: 03/28/2011 18:22:02 ******/
CREATE TABLE [dbo].[cmsContentXml](
	[nodeId] [int] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsContentVersion]    Script Date: 03/28/2011 18:22:10 ******/
CREATE TABLE [dbo].[cmsContentVersion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContentId] [int] NOT NULL,
	[VersionId] [uniqueidentifier] NOT NULL,
	[VersionDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [IX_cmsContentVersion] UNIQUE NONCLUSTERED 
(
	[VersionId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsContentTypeAllowedContentType]    Script Date: 03/28/2011 18:22:16 ******/
CREATE TABLE [dbo].[cmsContentTypeAllowedContentType](
	[Id] [int] NOT NULL,
	[AllowedId] [int] NOT NULL,
 CONSTRAINT [PK_cmsContentTypeAllowedContentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[AllowedId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsTab]    Script Date: 03/28/2011 18:22:25 ******/
CREATE TABLE [dbo].[cmsTab](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contenttypeNodeId] [int] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[sortorder] [int] NOT NULL,
 CONSTRAINT [PK_cmsTab] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsDataTypePreValues]    Script Date: 03/28/2011 18:22:32 ******/
CREATE TABLE [dbo].[cmsDataTypePreValues](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datatypeNodeId] [int] NOT NULL,
	[value] [nvarchar](2500) NULL,
	[sortorder] [int] NOT NULL,
	[alias] [nvarchar](50) NULL,
 CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsMember]    Script Date: 03/28/2011 18:22:39 ******/
CREATE TABLE [dbo].[cmsMember](
	[nodeId] [int] NOT NULL,
	[Email] [nvarchar](1000) NOT NULL,
	[LoginName] [nvarchar](1000) NOT NULL,
	[Password] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsMember] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsMemberType]    Script Date: 03/28/2011 18:22:49 ******/
CREATE TABLE [dbo].[cmsMemberType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[NodeId] [int] NOT NULL,
	[propertytypeId] [int] NOT NULL,
	[memberCanEdit] [bit] NOT NULL,
	[viewOnProfile] [bit] NOT NULL,
 CONSTRAINT [PK_cmsMemberType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsPreviewXml]    Script Date: 03/28/2011 18:23:14 ******/
CREATE TABLE [dbo].[cmsPreviewXml](
	[nodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentPreviewXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsMember2MemberGroup]    Script Date: 03/28/2011 18:23:20 ******/
CREATE TABLE [dbo].[cmsMember2MemberGroup](
	[Member] [int] NOT NULL,
	[MemberGroup] [int] NOT NULL,
 CONSTRAINT [PK_cmsMember2MemberGroup] PRIMARY KEY CLUSTERED 
(
	[Member] ASC,
	[MemberGroup] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsPropertyType]    Script Date: 03/28/2011 18:23:33 ******/
CREATE TABLE [dbo].[cmsPropertyType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dataTypeId] [int] NOT NULL,
	[contentTypeId] [int] NOT NULL,
	[tabId] [int] NULL,
	[Alias] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[helpText] [nvarchar](1000) NULL,
	[sortOrder] [int] NOT NULL,
	[mandatory] [bit] NOT NULL,
	[validationRegExp] [nvarchar](255) NULL,
	[Description] [nvarchar](2000) NULL,
 CONSTRAINT [PK_cmsPropertyType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[cmsPropertyData]    Script Date: 03/28/2011 18:23:52 ******/
CREATE TABLE [dbo].[cmsPropertyData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contentNodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NULL,
	[propertytypeid] [int] NOT NULL,
	[dataInt] [int] NULL,
	[dataDate] [datetime] NULL,
	[dataNvarchar] [nvarchar](500) NULL,
	[dataNtext] [ntext] NULL,
 CONSTRAINT [PK_cmsPropertyData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
GO
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData] ON [dbo].[cmsPropertyData] 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_1] ON [dbo].[cmsPropertyData] 
(
	[contentNodeId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_2] ON [dbo].[cmsPropertyData] 
(
	[versionId] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_3] ON [dbo].[cmsPropertyData] 
(
	[propertytypeid] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
/****** Object:  Default [DF_app_sortOrder]    Script Date: 03/28/2011 18:17:03 ******/
ALTER TABLE [dbo].[umbracoApp] ADD  CONSTRAINT [DF_app_sortOrder]  DEFAULT ((0)) FOR [sortOrder]
GO
/****** Object:  Default [DF_umbracoNode_trashed]    Script Date: 03/28/2011 18:17:19 ******/
ALTER TABLE [dbo].[umbracoNode] ADD  CONSTRAINT [DF_umbracoNode_trashed]  DEFAULT ((0)) FOR [trashed]
GO
/****** Object:  Default [DF_umbracoNode_createDate]    Script Date: 03/28/2011 18:17:20 ******/
ALTER TABLE [dbo].[umbracoNode] ADD  CONSTRAINT [DF_umbracoNode_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
/****** Object:  Default [DF_umbracoLog_Datestamp]    Script Date: 03/28/2011 18:17:29 ******/
ALTER TABLE [dbo].[umbracoLog] ADD  CONSTRAINT [DF_umbracoLog_Datestamp]  DEFAULT (getdate()) FOR [Datestamp]
GO
/****** Object:  Default [DF_macro_macroUseInEditor]    Script Date: 03/28/2011 18:18:04 ******/
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_macro_macroUseInEditor]  DEFAULT ((0)) FOR [macroUseInEditor]
GO
/****** Object:  Default [DF_macro_macroRefreshRate]    Script Date: 03/28/2011 18:18:05 ******/
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_macro_macroRefreshRate]  DEFAULT ((0)) FOR [macroRefreshRate]
GO
/****** Object:  Default [DF_cmsMacro_macroCacheByPage]    Script Date: 03/28/2011 18:18:05 ******/
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroCacheByPage]  DEFAULT ((1)) FOR [macroCacheByPage]
GO
/****** Object:  Default [DF_cmsMacro_macroCachePersonalized]    Script Date: 03/28/2011 18:18:06 ******/
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroCachePersonalized]  DEFAULT ((0)) FOR [macroCachePersonalized]
GO
/****** Object:  Default [DF_cmsMacro_macroDontRender]    Script Date: 03/28/2011 18:18:07 ******/
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroDontRender]  DEFAULT ((0)) FOR [macroDontRender]
GO
/****** Object:  Default [DF_macroProperty_macroPropertyHidden]    Script Date: 03/28/2011 18:18:39 ******/
ALTER TABLE [dbo].[cmsMacroProperty] ADD  CONSTRAINT [DF_macroProperty_macroPropertyHidden]  DEFAULT ((0)) FOR [macroPropertyHidden]
GO
/****** Object:  Default [DF_macroProperty_macroPropertySortOrder]    Script Date: 03/28/2011 18:18:39 ******/
ALTER TABLE [dbo].[cmsMacroProperty] ADD  CONSTRAINT [DF_macroProperty_macroPropertySortOrder]  DEFAULT ((0)) FOR [macroPropertySortOrder]
GO
/****** Object:  Default [DF_cmsContentType_thumbnail]    Script Date: 03/28/2011 18:19:16 ******/
ALTER TABLE [dbo].[cmsContentType] ADD  CONSTRAINT [DF_cmsContentType_thumbnail]  DEFAULT ('folder.png') FOR [thumbnail]
GO
/****** Object:  Default [DF_cmsContentType_masterContentType]    Script Date: 03/28/2011 18:19:17 ******/
ALTER TABLE [dbo].[cmsContentType] ADD  CONSTRAINT [DF_cmsContentType_masterContentType]  DEFAULT ((0)) FOR [masterContentType]
GO
/****** Object:  Default [DF_umbracoAppTree_treeSilent]    Script Date: 03/28/2011 18:20:09 ******/
ALTER TABLE [dbo].[umbracoAppTree] ADD  CONSTRAINT [DF_umbracoAppTree_treeSilent]  DEFAULT ((0)) FOR [treeSilent]
GO
/****** Object:  Default [DF_umbracoAppTree_treeInitialize]    Script Date: 03/28/2011 18:20:09 ******/
ALTER TABLE [dbo].[umbracoAppTree] ADD  CONSTRAINT [DF_umbracoAppTree_treeInitialize]  DEFAULT ((1)) FOR [treeInitialize]
GO
/****** Object:  Default [DF_umbracoRelation_datetime]    Script Date: 03/28/2011 18:20:30 ******/
ALTER TABLE [dbo].[umbracoRelation] ADD  CONSTRAINT [DF_umbracoRelation_datetime]  DEFAULT (getdate()) FOR [datetime]
GO
/****** Object:  Default [DF_umbracoUser_userDisabled]    Script Date: 03/28/2011 18:20:46 ******/
ALTER TABLE [dbo].[umbracoUser] ADD  CONSTRAINT [DF_umbracoUser_userDisabled]  DEFAULT ((0)) FOR [userDisabled]
GO
/****** Object:  Default [DF_umbracoUser_userNoConsole]    Script Date: 03/28/2011 18:20:46 ******/
ALTER TABLE [dbo].[umbracoUser] ADD  CONSTRAINT [DF_umbracoUser_userNoConsole]  DEFAULT ((0)) FOR [userNoConsole]
GO
/****** Object:  Default [DF_umbracoUser_defaultToLiveEditing]    Script Date: 03/28/2011 18:20:47 ******/
ALTER TABLE [dbo].[umbracoUser] ADD  CONSTRAINT [DF_umbracoUser_defaultToLiveEditing]  DEFAULT ((0)) FOR [defaultToLiveEditing]
GO
/****** Object:  Default [DF__cmsTask__closed__04E4BC85]    Script Date: 03/28/2011 18:21:33 ******/
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF__cmsTask__closed__04E4BC85]  DEFAULT ((0)) FOR [closed]
GO
/****** Object:  Default [DF__cmsTask__DateTim__05D8E0BE]    Script Date: 03/28/2011 18:21:33 ******/
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF__cmsTask__DateTim__05D8E0BE]  DEFAULT (getdate()) FOR [DateTime]
GO
/****** Object:  Default [DF_cmsDocumentType_IsDefault]    Script Date: 03/28/2011 18:21:42 ******/
ALTER TABLE [dbo].[cmsDocumentType] ADD  CONSTRAINT [DF_cmsDocumentType_IsDefault]  DEFAULT ((0)) FOR [IsDefault]
GO
/****** Object:  Default [DF_cmsDocument_updateDate]    Script Date: 03/28/2011 18:21:58 ******/
ALTER TABLE [dbo].[cmsDocument] ADD  CONSTRAINT [DF_cmsDocument_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
/****** Object:  Default [DF_cmsDocument_newest]    Script Date: 03/28/2011 18:21:59 ******/
ALTER TABLE [dbo].[cmsDocument] ADD  CONSTRAINT [DF_cmsDocument_newest]  DEFAULT ((0)) FOR [newest]
GO
/****** Object:  Default [DF_cmsContentVersion_VersionDate]    Script Date: 03/28/2011 18:22:12 ******/
ALTER TABLE [dbo].[cmsContentVersion] ADD  CONSTRAINT [DF_cmsContentVersion_VersionDate]  DEFAULT (getdate()) FOR [VersionDate]
GO
/****** Object:  Default [DF_cmsMember_Email]    Script Date: 03/28/2011 18:22:42 ******/
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_Email]  DEFAULT ('') FOR [Email]
GO
/****** Object:  Default [DF_cmsMember_LoginName]    Script Date: 03/28/2011 18:22:43 ******/
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_LoginName]  DEFAULT ('') FOR [LoginName]
GO
/****** Object:  Default [DF_cmsMember_Password]    Script Date: 03/28/2011 18:22:44 ******/
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_Password]  DEFAULT ('') FOR [Password]
GO
/****** Object:  Default [DF_cmsMemberType_memberCanEdit]    Script Date: 03/28/2011 18:23:07 ******/
ALTER TABLE [dbo].[cmsMemberType] ADD  CONSTRAINT [DF_cmsMemberType_memberCanEdit]  DEFAULT ((0)) FOR [memberCanEdit]
GO
/****** Object:  Default [DF_cmsMemberType_viewOnProfile]    Script Date: 03/28/2011 18:23:08 ******/
ALTER TABLE [dbo].[cmsMemberType] ADD  CONSTRAINT [DF_cmsMemberType_viewOnProfile]  DEFAULT ((0)) FOR [viewOnProfile]
GO
/****** Object:  Default [DF__cmsProper__sortO__1EA48E88]    Script Date: 03/28/2011 18:23:38 ******/
ALTER TABLE [dbo].[cmsPropertyType] ADD  CONSTRAINT [DF__cmsProper__sortO__1EA48E88]  DEFAULT ((0)) FOR [sortOrder]
GO
/****** Object:  Default [DF__cmsProper__manda__2180FB33]    Script Date: 03/28/2011 18:23:39 ******/
ALTER TABLE [dbo].[cmsPropertyType] ADD  CONSTRAINT [DF__cmsProper__manda__2180FB33]  DEFAULT ((0)) FOR [mandatory]
GO
/****** Object:  ForeignKey [FK_umbracoNode_umbracoNode]    Script Date: 03/28/2011 18:17:18 ******/
ALTER TABLE [dbo].[umbracoNode]  WITH CHECK ADD  CONSTRAINT [FK_umbracoNode_umbracoNode] FOREIGN KEY([parentID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoNode] CHECK CONSTRAINT [FK_umbracoNode_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsMacroProperty_cmsMacro]    Script Date: 03/28/2011 18:18:36 ******/
ALTER TABLE [dbo].[cmsMacroProperty]  WITH CHECK ADD  CONSTRAINT [FK_cmsMacroProperty_cmsMacro] FOREIGN KEY([macro])
REFERENCES [dbo].[cmsMacro] ([id])
GO
ALTER TABLE [dbo].[cmsMacroProperty] CHECK CONSTRAINT [FK_cmsMacroProperty_cmsMacro]
GO
/****** Object:  ForeignKey [FK_umbracoMacroProperty_umbracoMacroPropertyType]    Script Date: 03/28/2011 18:18:37 ******/
ALTER TABLE [dbo].[cmsMacroProperty]  WITH CHECK ADD  CONSTRAINT [FK_umbracoMacroProperty_umbracoMacroPropertyType] FOREIGN KEY([macroPropertyType])
REFERENCES [dbo].[cmsMacroPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsMacroProperty] CHECK CONSTRAINT [FK_umbracoMacroProperty_umbracoMacroPropertyType]
GO
/****** Object:  ForeignKey [FK_cmsStylesheetProperty_umbracoNode]    Script Date: 03/28/2011 18:18:45 ******/
ALTER TABLE [dbo].[cmsStylesheetProperty]  WITH CHECK ADD  CONSTRAINT [FK_cmsStylesheetProperty_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsStylesheetProperty] CHECK CONSTRAINT [FK_cmsStylesheetProperty_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsStylesheet_umbracoNode]    Script Date: 03/28/2011 18:18:52 ******/
ALTER TABLE [dbo].[cmsStylesheet]  WITH CHECK ADD  CONSTRAINT [FK_cmsStylesheet_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsStylesheet] CHECK CONSTRAINT [FK_cmsStylesheet_umbracoNode]
GO
/****** Object:  ForeignKey [cmsTags_cmsTagRelationship]    Script Date: 03/28/2011 18:19:00 ******/
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [cmsTags_cmsTagRelationship] FOREIGN KEY([tagId])
REFERENCES [dbo].[cmsTags] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [cmsTags_cmsTagRelationship]
GO
/****** Object:  ForeignKey [umbracoNode_cmsTagRelationship]    Script Date: 03/28/2011 18:19:01 ******/
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [umbracoNode_cmsTagRelationship] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [umbracoNode_cmsTagRelationship]
GO
/****** Object:  ForeignKey [FK_cmsContentType_umbracoNode]    Script Date: 03/28/2011 18:19:15 ******/
ALTER TABLE [dbo].[cmsContentType]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsContentType_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType] CHECK CONSTRAINT [FK_cmsContentType_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsContent_umbracoNode]    Script Date: 03/28/2011 18:19:25 ******/
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsDataType_umbracoNode]    Script Date: 03/28/2011 18:19:41 ******/
ALTER TABLE [dbo].[cmsDataType]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsDataType_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDataType] CHECK CONSTRAINT [FK_cmsDataType_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsLanguageText_cmsDictionary]    Script Date: 03/28/2011 18:19:47 ******/
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_cmsDictionary] FOREIGN KEY([UniqueId])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_cmsDictionary]
GO
/****** Object:  ForeignKey [FK_umbracoDomains_umbracoNode]    Script Date: 03/28/2011 18:19:54 ******/
ALTER TABLE [dbo].[umbracoDomains]  WITH CHECK ADD  CONSTRAINT [FK_umbracoDomains_umbracoNode] FOREIGN KEY([domainRootStructureID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoDomains] CHECK CONSTRAINT [FK_umbracoDomains_umbracoNode]
GO
/****** Object:  ForeignKey [FK_umbracoAppTree_umbracoApp]    Script Date: 03/28/2011 18:20:07 ******/
ALTER TABLE [dbo].[umbracoAppTree]  WITH NOCHECK ADD  CONSTRAINT [FK_umbracoAppTree_umbracoApp] FOREIGN KEY([appAlias])
REFERENCES [dbo].[umbracoApp] ([appAlias])
GO
ALTER TABLE [dbo].[umbracoAppTree] CHECK CONSTRAINT [FK_umbracoAppTree_umbracoApp]
GO
/****** Object:  ForeignKey [FK_cmsTemplate_cmsTemplate]    Script Date: 03/28/2011 18:20:18 ******/
ALTER TABLE [dbo].[cmsTemplate]  WITH CHECK ADD  CONSTRAINT [FK_cmsTemplate_cmsTemplate] FOREIGN KEY([master])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsTemplate] CHECK CONSTRAINT [FK_cmsTemplate_cmsTemplate]
GO
/****** Object:  ForeignKey [FK_cmsTemplate_umbracoNode]    Script Date: 03/28/2011 18:20:19 ******/
ALTER TABLE [dbo].[cmsTemplate]  WITH CHECK ADD  CONSTRAINT [FK_cmsTemplate_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTemplate] CHECK CONSTRAINT [FK_cmsTemplate_umbracoNode]
GO
/****** Object:  ForeignKey [FK_umbracoRelation_umbracoNode]    Script Date: 03/28/2011 18:20:27 ******/
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode] FOREIGN KEY([parentId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode]
GO
/****** Object:  ForeignKey [FK_umbracoRelation_umbracoNode1]    Script Date: 03/28/2011 18:20:28 ******/
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode1] FOREIGN KEY([childId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode1]
GO
/****** Object:  ForeignKey [FK_umbracoRelation_umbracoRelationType]    Script Date: 03/28/2011 18:20:29 ******/
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoRelationType] FOREIGN KEY([relType])
REFERENCES [dbo].[umbracoRelationType] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoRelationType]
GO
/****** Object:  ForeignKey [FK_user_userType]    Script Date: 03/28/2011 18:20:45 ******/
ALTER TABLE [dbo].[umbracoUser]  WITH NOCHECK ADD  CONSTRAINT [FK_user_userType] FOREIGN KEY([userType])
REFERENCES [dbo].[umbracoUserType] ([id])
GO
ALTER TABLE [dbo].[umbracoUser] CHECK CONSTRAINT [FK_user_userType]
GO
/****** Object:  ForeignKey [FK_umbracoUser2NodePermission_umbracoNode]    Script Date: 03/28/2011 18:20:54 ******/
ALTER TABLE [dbo].[umbracoUser2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodePermission_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission] CHECK CONSTRAINT [FK_umbracoUser2NodePermission_umbracoNode]
GO
/****** Object:  ForeignKey [FK_umbracoUser2NodePermission_umbracoUser]    Script Date: 03/28/2011 18:20:55 ******/
ALTER TABLE [dbo].[umbracoUser2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodePermission_umbracoUser] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission] CHECK CONSTRAINT [FK_umbracoUser2NodePermission_umbracoUser]
GO
/****** Object:  ForeignKey [FK_umbracoUser2NodeNotify_umbracoNode]    Script Date: 03/28/2011 18:21:03 ******/
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode]
GO
/****** Object:  ForeignKey [FK_umbracoUser2NodeNotify_umbracoUser]    Script Date: 03/28/2011 18:21:04 ******/
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser]
GO
/****** Object:  ForeignKey [FK_umbracoUser2app_umbracoApp]    Script Date: 03/28/2011 18:21:09 ******/
ALTER TABLE [dbo].[umbracoUser2app]  WITH NOCHECK ADD  CONSTRAINT [FK_umbracoUser2app_umbracoApp] FOREIGN KEY([app])
REFERENCES [dbo].[umbracoApp] ([appAlias])
GO
ALTER TABLE [dbo].[umbracoUser2app] CHECK CONSTRAINT [FK_umbracoUser2app_umbracoApp]
GO
/****** Object:  ForeignKey [FK_umbracoUser2app_umbracoUser]    Script Date: 03/28/2011 18:21:10 ******/
ALTER TABLE [dbo].[umbracoUser2app]  WITH NOCHECK ADD  CONSTRAINT [FK_umbracoUser2app_umbracoUser] FOREIGN KEY([user])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2app] CHECK CONSTRAINT [FK_umbracoUser2app_umbracoUser]
GO
/****** Object:  ForeignKey [FK_cmsTask_cmsTaskType]    Script Date: 03/28/2011 18:21:28 ******/
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_cmsTaskType] FOREIGN KEY([taskTypeId])
REFERENCES [dbo].[cmsTaskType] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_cmsTaskType]
GO
/****** Object:  ForeignKey [FK_cmsTask_umbracoNode]    Script Date: 03/28/2011 18:21:29 ******/
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsTask_umbracoUser]    Script Date: 03/28/2011 18:21:31 ******/
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser] FOREIGN KEY([parentUserId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser]
GO
/****** Object:  ForeignKey [FK_cmsTask_umbracoUser1]    Script Date: 03/28/2011 18:21:32 ******/
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser1] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser1]
GO
/****** Object:  ForeignKey [FK_cmsDocumentType_cmsContentType]    Script Date: 03/28/2011 18:21:39 ******/
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsContentType] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsContentType]
GO
/****** Object:  ForeignKey [FK_cmsDocumentType_cmsTemplate]    Script Date: 03/28/2011 18:21:40 ******/
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsTemplate] FOREIGN KEY([templateNodeId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsTemplate]
GO
/****** Object:  ForeignKey [FK_cmsDocumentType_umbracoNode]    Script Date: 03/28/2011 18:21:41 ******/
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_umbracoNode] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsDocument_cmsContent]    Script Date: 03/28/2011 18:21:55 ******/
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsContent] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsContent]
GO
/****** Object:  ForeignKey [FK_cmsDocument_cmsTemplate]    Script Date: 03/28/2011 18:21:56 ******/
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsTemplate] FOREIGN KEY([templateId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsTemplate]
GO
/****** Object:  ForeignKey [FK_cmsDocument_umbracoNode]    Script Date: 03/28/2011 18:21:57 ******/
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsContentXml_cmsContent]    Script Date: 03/28/2011 18:22:03 ******/
ALTER TABLE [dbo].[cmsContentXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentXml_cmsContent] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentXml] CHECK CONSTRAINT [FK_cmsContentXml_cmsContent]
GO
/****** Object:  ForeignKey [FK_cmsContentVersion_cmsContent]    Script Date: 03/28/2011 18:22:11 ******/
ALTER TABLE [dbo].[cmsContentVersion]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentVersion_cmsContent] FOREIGN KEY([ContentId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentVersion] CHECK CONSTRAINT [FK_cmsContentVersion_cmsContent]
GO
/****** Object:  ForeignKey [FK_cmsContentTypeAllowedContentType_cmsContentType]    Script Date: 03/28/2011 18:22:17 ******/
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType] FOREIGN KEY([Id])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType]
GO
/****** Object:  ForeignKey [FK_cmsContentTypeAllowedContentType_cmsContentType1]    Script Date: 03/28/2011 18:22:18 ******/
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1] FOREIGN KEY([AllowedId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1]
GO
/****** Object:  ForeignKey [FK_cmsTab_cmsContentType]    Script Date: 03/28/2011 18:22:26 ******/
ALTER TABLE [dbo].[cmsTab]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsTab_cmsContentType] FOREIGN KEY([contenttypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsTab] CHECK CONSTRAINT [FK_cmsTab_cmsContentType]
GO
/****** Object:  ForeignKey [FK_cmsDataTypePreValues_cmsDataType]    Script Date: 03/28/2011 18:22:34 ******/
ALTER TABLE [dbo].[cmsDataTypePreValues]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType] FOREIGN KEY([datatypeNodeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDataTypePreValues] CHECK CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType]
GO
/****** Object:  ForeignKey [FK_cmsMember_cmsContent]    Script Date: 03/28/2011 18:22:40 ******/
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_cmsContent] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_cmsContent]
GO
/****** Object:  ForeignKey [FK_cmsMember_umbracoNode]    Script Date: 03/28/2011 18:22:41 ******/
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsMemberType_cmsContentType]    Script Date: 03/28/2011 18:22:51 ******/
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_cmsContentType] FOREIGN KEY([NodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_cmsContentType]
GO
/****** Object:  ForeignKey [FK_cmsMemberType_umbracoNode]    Script Date: 03/28/2011 18:23:05 ******/
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_umbracoNode] FOREIGN KEY([NodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsPreviewXml_cmsContent]    Script Date: 03/28/2011 18:23:15 ******/
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContent] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContent]
GO
/****** Object:  ForeignKey [FK_cmsPreviewXml_cmsContentVersion]    Script Date: 03/28/2011 18:23:16 ******/
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion] FOREIGN KEY([versionId])
REFERENCES [dbo].[cmsContentVersion] ([VersionId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion]
GO
/****** Object:  ForeignKey [FK_cmsMember2MemberGroup_cmsMember]    Script Date: 03/28/2011 18:23:22 ******/
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember] FOREIGN KEY([Member])
REFERENCES [dbo].[cmsMember] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember]
GO
/****** Object:  ForeignKey [FK_cmsMember2MemberGroup_umbracoNode]    Script Date: 03/28/2011 18:23:23 ******/
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode] FOREIGN KEY([MemberGroup])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode]
GO
/****** Object:  ForeignKey [FK_cmsPropertyType_cmsContentType]    Script Date: 03/28/2011 18:23:35 ******/
ALTER TABLE [dbo].[cmsPropertyType]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsContentType] FOREIGN KEY([contentTypeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsContentType]
GO
/****** Object:  ForeignKey [FK_cmsPropertyType_cmsDataType]    Script Date: 03/28/2011 18:23:36 ******/
ALTER TABLE [dbo].[cmsPropertyType]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsDataType] FOREIGN KEY([dataTypeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsDataType]
GO
/****** Object:  ForeignKey [FK_cmsPropertyType_cmsTab]    Script Date: 03/28/2011 18:23:37 ******/
ALTER TABLE [dbo].[cmsPropertyType]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsTab] FOREIGN KEY([tabId])
REFERENCES [dbo].[cmsTab] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsTab]
GO
/****** Object:  ForeignKey [FK_cmsPropertyData_cmsPropertyType]    Script Date: 03/28/2011 18:23:53 ******/
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_cmsPropertyType] FOREIGN KEY([propertytypeid])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_cmsPropertyType]
GO
/****** Object:  ForeignKey [FK_cmsPropertyData_umbracoNode]    Script Date: 03/28/2011 18:23:54 ******/
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_umbracoNode] FOREIGN KEY([contentNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_umbracoNode]
GO