{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2016 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<br />
<div class='panel'>
<fieldset {if version_compare($smarty.const._PS_VERSION_,'1.5','<')}style="width: 400px"{/if}>
  <legend><img src='{$logo_path|escape:'htmlall':'UTF-8'}'/>{l s='Certissim Validation' mod='fianetfraud'}</legend>
  <p>
    {l s='An error has been encounterd while analysing the order: ' mod='fianetfraud'}{$error|escape:'htmlall':'UTF-8'}
  </p>
  <p>
    <a href="{$url_vcd|strval|escape:'htmlall':'UTF-8'}" target="_blank">{l s='You may fix it there.' mod='fianetfraud'}</a>
  </p>
  <p>
    {l s='You have already fixed this order?' mod='fianetfraud'}
    <a href="{$url_update|strval|escape:'htmlall':'UTF-8'}">{l s='Checkout the score.' mod='fianetfraud'}</a>
  </p>
</fieldset>
</div>