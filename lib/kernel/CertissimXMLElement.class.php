<?php
/**
 * 2007-2014 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
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
 *  @copyright 2007-2014 PrestaShop SA
 *  @license   http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

/**
 * Class XML
 * 
 * @author ESPIAU Nicolas <nicolas.espiau at fia-net.com>
 */
class CertissimXMLElement extends CertissimMother
{

	protected $encoding = 'UTF-8';
	protected $name = '';
	protected $value = '';
	protected $attributes = array();
	protected $children = array();

	public function __construct($data = null)
	{
		if (is_null($data))
		{
			$name = preg_replace('#^(certissim-)?(.*)$#', '$2', CertissimTools::normalizeName(get_class($this)));
			$this->setName($name);
		}

		//if $data is a valid string
		if (is_string($data))
		{
			//drops spaces at the beginning of the string
			$data = preg_replace('#^[ \r\n]*#', '', $data);
			//checks the XML validity
			if (!CertissimTools::isXMLstring($data))
			{
				$msg = "La chaine \"$data\" n'est pas valide";
				CertissimLogger::insertLog(get_class($this).' - __construct()', $msg);
				throw new Exception($msg);
			}
			//convert string into SimpleXMLElement
			$data = new SimpleXMLElement($data);
		}

		//if $data is SimpleXMLElement
		if (CertissimTools::isSimpleXMLElement($data))
		{
			$string = (string)$data;

			$this->name = $data->getName();
			$this->value = $string;
			foreach ($data->attributes() as $attname => $attvalue)
				$this->attributes[$attname] = $attvalue;
			foreach ($data->children() as $simplexmlelementchild)
			{
				$child = new CertissimXMLElement($simplexmlelementchild);
				$this->addChild($child);
			}
		}
	}

	/**
	 * adds an attribute to the current object
	 * 
	 * @param string $name nom de l'attribut
	 * @param string $value valeur de l'attribut
	 */
	public function addAttribute($name, $value)
	{
		$this->attributes[$name] = $value;
	}

	/**
	 * returns the value of the current element's attribute named $name
	 *
	 * @param string $name nom de l'attribut
	 * @return string
	 */
	public function getAttribute($name)
	{
		return (isset($this->attributes[$name]) ? $this->attributes[$name] : null);
	}

	/**
	 * returns an array containing all the children of the current element that are namde $name
	 *
	 * @param string $name
	 * @return array
	 */
	public function getChildrenByName($name)
	{
		$children = array();

		foreach ($this->getChildren() as $child)
		{
			if ($child->getName() == $name)
				array_push($children, $child);

			$children = array_merge($children, $child->getChildrenByName($name));
		}

		return $children;
	}
	/**
	 * returns the first child with the name $name
	 * 
	 * @param string $name
	 * @return CertissimXMLElement
	 */
	public function getChildByName($name)
	{
		$children = $this->getChildrenByName($name);
		return array_pop($children);
	}

	/**
	 * returns an array containing all the children of the current element that are named $name
	 *
	 * @param <type> $name
	 * @param <type> $attributename
	 * @param <type> $attributevalue
	 * @return <type> 
	 */
	public function getChildrenByNameAndAttribute($name, $attributename, $attributevalue = null)
	{
		$children = $this->getChildrenByName($name);

		foreach ($children as $key => $child)
			if (is_null($child->getAttribute($attributename)) || (!is_null($attributevalue) && $child->getAttribute($attributename) != $attributevalue))
				unset($children[$key]);

		return $children;
	}
	/**
	 * returns the first child with the name $name and attribute $attributename set to $attribute value
	 * 
	 * @param string $name
	 * @param string $attributename name of the wanted attribute
	 * @param string|null $attributevalue name of the wanted value, null if we're only looking for the attribute presence
	 * @return CertissimXMLElement
	 */
	public function getChildByNameAndAttribute($name, $attributename, $attributevalue = null)
	{
		$children = $this->getChildrenByNameAndAttribute($name, $attributename, $attributevalue);
		return array_pop($children);
	}

	/**
	 * appends a child to the children and returns the child CertissimXMLElement object
	 * 
	 * @param mixed $input CertissimXMLElement, string or SimpleXMLElement
	 * @param string $value value of the child
	 * @param array $attributes attributes of the child
	 * @return XMLElement 
	 */
	public function addChild($input, $value = null, $attributes = array())
	{
		$input = $this->createChild($input, $value, $attributes);

		$this->children[] = $input;

		return $input;
	}

	/**
	 * stacks a child to the children and returns the child CertissimXMLElement object
	 * 
	 * @param mixed $input CertissimXMLElement, string or SimpleXMLElement
	 * @param string $value value of the child
	 * @param array $attributes attributes of the child
	 * @return XMLElement 
	 */
	public function stackChild($input, $value = null, $attributes = array())
	{
		$input = $this->createChild($input, $value, $attributes);

		array_unshift($this->children, $input);

		return $input;
	}

	/**
	 * normalizes $input into a CertissimXMLElement object with children
	 * use cases:
	 * createChild(XMLElement) --> won't do anything
	 * createChild(simpleXMLElement)
	 * createChild("<element a='1' b='2'>valeur</element>")
	 * createChild("element","valeur", array('a'=>1, 'b'=>2))
	 * 
	 * @param mixed $input
	 * @param string $value
	 * @param string $attributes
	 * @return XMLElement
	 */
	private function createChild($input, $value = null, $attributes = array())
	{
		if (is_string($input) && !CertissimTools::isXMLstring($input))
		{
			$str = "<$input";
			foreach ($attributes as $name => $val)
				$str .= " $name='$val'";

			$str .= '>';

			if (!is_null($value))
				$str .= $value;

			$str .= "</$input>";
			$input = new SimpleXMLElement($str);
		}

		if (is_string($input) || CertissimTools::isSimpleXMLElement($input))
			$input = new CertissimXMLElement($input);

		if (!CertissimTools::isXMLElement($input))
		{
			$msg = "Le paramètre entré n'est pas pris en compte par la classe XMLElement";
			CertissimLogger::insertLog(get_class($this).' - createChild()', $msg);
			throw new Exception($msg);
		}

		return $input;
	}

	/**
	 * returns true if the current object has no value and no child, false otherwise
	 *
	 * @return bool 
	 */
	public function isEmpty()
	{
		return ($this->getValue() == '' || is_null($this->getValue())) && ($this->countChildren() == 0);
	}

	/**
	 * returns the current object child count
	 *
	 * @return int
	 */
	public function countChildren()
	{
		return count($this->children);
	}

	/**
	 * returns the current object as a SimpleXMLElement object
	 * 
	 * @param boolean $recursive allow to add children into the result
	 * @return SimpleXMLElement 
	 */
	public function toSimpleXMLElement($recursive = false)
	{
		$simplexlmelementobject = new SimpleXMLElement('<'.$this->getName().'>'.$this->getValue().'</'.$this->getName().'>');

		foreach ($this->getAttributes() as $name => $value)
			$simplexlmelementobject->addAttribute($name, $value);

		if ($recursive)
			$this->attachChildren($simplexlmelementobject);

		return $simplexlmelementobject;
	}

	/**
	 * attaches all the children and their children of the current object to the object given in parameter
	 * 
	 * @param SimpleXMLElement $simplexmlelement
	 */
	public function attachChildren($simplexmlelement)
	{
		foreach ($this->getChildren() as $child)
		{
			$simplexmlelement_child = $simplexmlelement->addChild($child->getName(), $child->getValue());

			foreach ($child->getAttributes() as $name => $value)
				$simplexmlelement_child->addAttribute($name, $value);

			$child->attachChildren($simplexmlelement_child);
		}
	}

	/**
	 * Adds CDATA sections
	 * 
	 */
	public function addCdataSections()
	{
		if ($this->countChildren() == 0 && $this->getValue() != '')
		{
			$value = $this->getValue();
			$cdatavalue = preg_replace('#^(<!\[CDATA\[)?(.+)(\]\]>)?$#', '<![CDATA[$2]]>', $value);
			$this->setValue($cdatavalue);
		}
		else
			foreach ($this->getChildren() as $child)
				$child->addCdataSections();
	}

	/**
	 * returns the current object as a string
	 * 
	 * @param bool $withcdatas add CDATA sections or not
	 * @return type
	 */
	public function getXML($withcdatas = false)
	{
		if ($withcdatas)
			$this->addCdataSections();
		$ret = preg_replace('#^.*(<\?xml.+)(\?>)#is', '$1 encoding="'.$this->getEncoding().'"$2', $this->toSimpleXMLElement(true)->asXML());
		$ret = html_entity_decode($ret, ENT_NOQUOTES, $this->getEncoding());
		$ret = preg_replace('#[\r\n'.chr(10).chr(13).']#', '', $ret);
		$ret = preg_replace('#>( )+<#', '><', $ret);

		return ($ret);
	}

	public function __toString()
	{
		return $this->getXML();
	}

	/**
	 * saves the XML string into a file
	 *
	 * @param string $filename file path
	 * @return string
	 */
	public function saveInFile($filename)
	{
		return $this->toSimpleXMLElement(true)->asXML($filename);
	}

	/**
	 *
	 * @param string $name
	 * @param array $params
	 * @return mixed 
	 */
	public function __call($name, array $params)
	{
		if (preg_match('#^get(.+)$#', $name, $out))
			return $this->__get(Tools::strtolower($out[1]));

		if (preg_match('#^set(.+)$#', $name, $out))
			return $this->__set(Tools::strtolower($out[1]), $params[0]);

		if (preg_match('#^child(.+)$#', $name, $out))
		{
			$elementname = Tools::strtolower($out[1]);

			$empty_allowed = (isset($params[2]) ? $params[2] : false);

			if (isset($params[0]) && CertissimTools::isXMLElement($params[0]))
			{
				$childname = preg_replace('#^(certissim-)?(.*)$#', '$2', $params[0]->getName());
				if ($childname != $elementname)
					throw new Exception('Le nom de la balise ne correspond pas : '.$elementname.' attendu, '.$childname.' trouvé.');

				if (!$params[0]->isEmpty() || $empty_allowed)
					return $this->addChild($params[0]);

				return false;
			}

			$child = new CertissimXMLElement("<$elementname></$elementname>");
			if (isset($params[1]))
				foreach ($params[1] as $att => $value)
					$child->addAttribute($att, $value);

			if ((!isset($params[0]) || is_null($params[0])))
			{
				if ($empty_allowed)
					return $this->addChild($child);

				return false;
			}

			if (is_string($params[0]) || is_int($params[0]))
				if (CertissimTools::isXMLstring($params[0]))
				{
					$granchild = $this->createChild($params[0]);
					$child->addChild($granchild);
				}
				else
					$child->setValue($params[0]);

			if (!$child->isEmpty() || $empty_allowed)
				return $this->addChild($child);

			return false;
		}
	}

}
