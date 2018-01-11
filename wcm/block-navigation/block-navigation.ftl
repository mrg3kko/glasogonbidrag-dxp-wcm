<#setting locale = locale>

<#-- Define services -->
<#assign expandoValueLocalService = serviceLocator.findService("com.liferay.expando.kernel.service.ExpandoValueLocalService") />
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService") />

<#-- Define some variables -->
<#assign scopeGroupId = getterUtil.getLong(request['theme-display']['scope-group-id']) />
<#assign scopePlid = getterUtil.getLong(request['theme-display']['plid']) />
<#assign isPrivateLayout = false />

<#assign scopeLayout = "" />

<#if scopePlid ? has_content>
	<#assign scopeLayout = layoutLocalService.getLayout(scopePlid)! />
	<#assign isPrivateLayout = scopeLayout.isPrivateLayout() />
</#if>


<#if navigationItems.siblings?size gt 0>
	<nav class="block-navigation">
    <ul>
  		<#list navigationItems.siblings as navigationItem>

        <#assign linkUrl = navigationItem.externalLink.data />
        <#assign linkText = navigationItem.externalLink.linkText.data />
        <#assign iconClass = "" />
        <#if navigationItem.externalLink.iconClass.data?has_content>
          <#assign iconClass = navigationItem.externalLink.iconClass.data />
        </#if>

        <#if linkUrl == "">
          <#if navigationItem.data ? has_content>
            <#assign linkUrl = navigationItem.getFriendlyUrl() />
            <#assign linkText = navigationItem.getName() />
            <#assign iconClass = "" />

						<#assign linkLayout = getLayout(navigationItem) />


						<#if linkLayout ? has_content>
							<#-- linkText should be avaiable through navigationItem.getName() but this seems not to be working -->
							<#assign linkText = linkLayout.getName(locale) />


							<#assign iconClass = "" />
					    <#assign iconClassExpando  = expandoValueLocalService.getValue(companyId, "com.liferay.portal.kernel.model.Layout", "CUSTOM_FIELDS", "icon-class", linkLayout.getPlid())! />
					    <#if iconClassExpando?has_content>
					      <#assign iconClass = iconClass + "block-nav-icon block-nav-icon-" + iconClassExpando.getData() />
					    </#if>

						</#if>

          </#if>
        </#if>

        <#assign linkTarget = "" />
        <#if navigationItem.linkTarget.data == "_BLANK">
          <#assign linkTarget = "_BLANK" />
        </#if>

        <#--
				-->
		    <#assign hotkey = getMainNavHotkey(navigationItem) />
				<#if hotkey?has_content>
					<#assign linkText = linkText + " (" + hotkey + ")" />
				</#if>


        <li class="${iconClass}">
          <a href="${linkUrl}" target="${linkTarget}">
            <div>${linkText}</div>
          </a>
        </li>

      </#list>
    </ul>
	</nav>
</#if>

<#function getLayout linkToPage>

	<#local linkInfo = [] />
	<#local layout = "" />

	<#if linkToPage.data?has_content>
		<#local linkData = linkToPage.data?split("@") />
		<#local linkLayoutId =  getterUtil.getLong(linkData[0]) />

		<#local linkLayoutIsPrivate =  false />
		<#if linkData[1] == "private-group">
  		<#local linkLayoutIsPrivate = true />
  	</#if>

		<#local linkLayoutGroupId = getterUtil.getLong(linkData[2]) />

		<#local layout = layoutLocalService.getLayout(linkLayoutGroupId, linkLayoutIsPrivate, linkLayoutId) />

	</#if>

	<#return layout />

</#function>

<#function getMainNavHotkey linkToPage>

	<#local hotkey = "" />

	<#if linkToPage.data?has_content>
		<#local linkData = linkToPage.data?split("@") />

		<#local linkLayoutId =  getterUtil.getLong(linkData[0]) />

		<#local linkLayoutIsPrivate =  false />
  	<#if linkData[1] == "private-group">
  		<#local linkLayoutIsPrivate = true />
  	</#if>

		<#local linkLayoutGroupId = getterUtil.getLong(linkData[2]) />

		<#local linkLayout = layoutLocalService.getLayout(linkLayoutGroupId, linkLayoutIsPrivate, linkLayoutId) />

		<#local hotkeyExpando  = expandoValueLocalService.getValue(companyId, "com.liferay.portal.kernel.model.Layout", "CUSTOM_FIELDS", "hotkey", linkLayout.getPlid())! />a

		<#if hotkeyExpando?has_content>
			<#local hotkey = hotkeyExpando.getData() />
		</#if>

	</#if>

	<#return hotkey />
</#function>
