<#setting locale = locale>

<#-- Define services -->

<#-- Define some variables -->

<#if navigationItems.siblings?size gt 0>
	<nav class="gb-tabs">
    <ul class="tabs-list">
  		<#list navigationItems.siblings as navigationItem>

				<#assign linkUrl = "" />
				<#assign linkText = "" />
				<#assign isCurrentLayout = false />

				<#if navigationItem.data ? has_content>
					<#assign linkUrl = navigationItem.getFriendlyUrl() />
					<#assign linkText = navigationItem.getName() />
					<#assign iconClass = "" />
				</#if>

				<#if navigationItem.linkText.data != "">
					<#assign linkText = navigationItem.linkText.data />
				</#if>

				<#if isCurrentLayout>
					<li class="active">
						<span class="tab">
							${linkText}
						</span>
					</li>
				<#else>
					<li>
						<a class="tab" href="${linkUrl}">
	            ${linkText}
	          </a>
					</li>
				</#if>

      </#list>
    </ul>
	</nav>
</#if>
