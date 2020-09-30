class LevelsService {
	static const _levels = [
		['us','gb','ca','au','fr','nz','it','jp','ru','br','kr','ie','se','gr','cn','fi','il','no','de','nl',],
		['ch','jm','za','es','dk','mx','tr','in','be','is','ar','cy','sa','pl','np','vn','al','ge','lb','ke',],
		['bd','at','pk','uy','kp','hr','ci','bg','eg','ir','hu','my','pt','mk','iq','bt','cz','cl','sk','mt',],
		['dz','pa','ve','cu','kh','bb','tn','ee','ro','si','ba','rs','sy','lk','id','cm','co','sm','th','ua',],
		['sg','do','kz','ng','mc','qa','tt','ma','ph','lu','sz','pg','pe','lv','az','ao','hn','af','by','lr',],
		['sc','ec','ae','bh','pw','to','li','uz','kw','tm','la','mg','fj','so','ne','jo','ly','cd','ye','ug',],
		['cr','bn','om','py','mn','ag','me','bs','gh','ad','am','lt','md','ki','zw','mm','bf','mv','ni','tz',],
		['mr','et','mz','bw','sv','mw','ht','td','bz','km','sn','ga','ss','fm','mh','kg','tj','bi','nr','sd',],
		['ws','dm','tg','gt','gy','tl','er','lc','cv','na','ls','zm','cg','cf','gd','rw','dj','ml','tv','vu',],
		['bj','kn','sl','vc','sr','gq','mu','st','gn','bo','gm','sb','gw',],
	];

	/// Retuns the number of levels
	int get numberLevels => _levels.length;

	/// Retuns the countries for a given level index (beginning at zero)
	List<String> countryIdsForLevel(int level){
		if(level >= 0 && level < _levels.length) {
			return _levels[level];
		}
		
		return null;
	}
}
