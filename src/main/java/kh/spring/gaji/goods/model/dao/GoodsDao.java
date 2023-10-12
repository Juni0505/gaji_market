package kh.spring.gaji.goods.model.dao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.spring.gaji.goods.model.dto.GoodsDto;
import kh.spring.gaji.goods.model.dto.GoodsInfoDto;
import kh.spring.gaji.goods.model.dto.GoodsListDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class GoodsDao  {

    @Autowired
    private SqlSession sqlSession;

    public int getTotalCnt(int priceFloor,int priceCeiling,int category,int dongId,String searchWord) {
    	Map<String,Object> map=new HashMap<String,Object>();
    	  map.put("priceFloor", priceFloor);
          map.put("priceCeiling", priceCeiling);
          map.put("category", category);
          map.put("dongId", dongId);
          map.put("searchWord", searchWord);
    	return sqlSession.selectOne("goods.getTotalCnt",map);
    }
    
    public int getAveragePrice(int priceFloor,int priceCeiling,int category,int dongId,String searchWord) {
    	Map<String,Object> map=new HashMap<String,Object>();
  	    map.put("priceFloor", priceFloor);
        map.put("priceCeiling", priceCeiling);
        map.put("category", category);
        map.put("dongId", dongId);
        map.put("searchWord", searchWord);
        if(sqlSession.selectOne("goods.getAveragePrice",map)==null)
        	return 0;
        return sqlSession.selectOne("goods.getAveragePrice",map);
    }
    
    public int getTopPrice(int priceFloor,int priceCeiling,int category,int dongId,String searchWord) {
    	Map<String,Object> map=new HashMap<String,Object>();
  	  	map.put("priceFloor", priceFloor);
        map.put("priceCeiling", priceCeiling);
        map.put("category", category);
        map.put("dongId", dongId);
        map.put("searchWord", searchWord);
        if(sqlSession.selectOne("goods.getTopPrice",map)==null)
        	return 0;
        return sqlSession.selectOne("goods.getTopPrice",map);
    }
    
    public int getBottomPrice(int priceFloor,int priceCeiling,int category,int dongId,String searchWord) {
    	Map<String,Object> map=new HashMap<String,Object>();
  	  	map.put("priceFloor", priceFloor);
        map.put("priceCeiling", priceCeiling);
        map.put("category", category);
        map.put("dongId", dongId);
        map.put("searchWord", searchWord);
        if(sqlSession.selectOne("goods.getBottomPrice",map)==null)
        	return 0;
        return sqlSession.selectOne("goods.getBottomPrice",map);
    }
    
    public List<GoodsListDto> getGoodsList(int currentPage, int PAGESIZE, int sort, int priceFloor, int priceCeiling,
	int category, int dongId, String searchWord,int totalCnt){
    	Map<String,Object> map=new HashMap<String,Object>();
    	int startRownum = 0;
		int endRownum = 0;
		startRownum = (currentPage-1)*PAGESIZE +1;
		endRownum = ((currentPage*PAGESIZE) > totalCnt) ? totalCnt: (currentPage*PAGESIZE);
  	  	map.put("priceFloor", priceFloor);
        map.put("priceCeiling", priceCeiling);
        map.put("category", category);
        map.put("dongId", dongId);
        map.put("searchWord", searchWord);
        map.put("startRownum",startRownum);
		map.put("endRownum",endRownum);
		map.put("sort", sort);
		return sqlSession.selectList("goods.getGoodsList",map);
    }
    
    public int insertGoods(GoodsDto goodsDto) {// 24P 상품글 등록 
        return sqlSession.insert("goods.insertGoods", goodsDto);
    }

    public GoodsInfoDto getGoodsInfo(int goodsId) {// 상품글 상세조회  
        return sqlSession.selectOne("goods.getGoodsInfo", goodsId);
    }

    public int updateStatus(Map<String, Object> map) { //23P 상품상태변경 
        return sqlSession.update("goods.updateStatus", map);
    }

    public int updateGoods(GoodsDto goodsDto) {
        return sqlSession.update("goods.updateGoods", goodsDto);//25P 상품글 수정
    }
    
    public int deleteGoods(int goodsId) {
        return sqlSession.update("goods.deleteGoods", goodsId); // 상품삭제 
    }
}